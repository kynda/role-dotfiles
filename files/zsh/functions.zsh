# Convenient function to allow local overrides for all sourced files
function load_file {
    [ -e ~/.zsh/${1} ] && . ~/.zsh/${1} || true
    [ -e ~/.zsh.local/${1} ] && . ~/.zsh.local/${1} || true
}

function man {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

function dkr-container-name {
    local dir="${PWD##*/}"
    dir="${dir/./}"

    local app=${1:-app}
    __container="$(echo "${dir}")_${app}"
}

function dkr-down {
    docker-compose stop $1
}

function dkr-up {
    docker-compose up --remove-orphans -d $1 && \
        dkr-logs $1
}

function dkr-bash {
    dkr-container-name ${1}

    dkr-exec "${__container}_1" bash
}

function dkr-zsh {
    dkr-container-name ${1}

    dkr-exec "${__container}_1" zsh
}

function dkr-logs {
    docker-compose logs -f --tail ${2:-100} $1 | grep -iE --color=auto '(exception|fatal|error|warning|info|trigger_error)|$'
}

function dkr-reup {
    read -q "reply?Are you sure you'd like to restart ${1:-everything}? "
    echo

    if [[ $reply =~ ^[Yy]$ ]]
    then
        dkr-down $1 && dkr-up $1
    else
        echo "Aborting!"
    fi
}

function dkr-clean {
    dkr-container-name ${1}

    dkr-down $1 && \
        docker-compose rm -f $1 && \
        docker rmi "${__container}"
}

function dkr-proxy {
    mkdir -p ~/.config/nginx-proxy/{html,vhost.d,htpasswd,certs}
    touch ~/.config/nginx-proxy/proxy.conf

    docker stop proxy && \
        docker rm proxy

    docker pull jwilder/nginx-proxy && \
        dkr-run --name proxy -d \
            -p 80:80 \
            -p 443:443 \
            -v /var/run/docker.sock:/tmp/docker.sock:ro \
            -v ~/.config/nginx-proxy/html:/usr/share/nginx/html:rw \
            -v ~/.config/nginx-proxy/proxy.conf:/etc/nginx/conf.d/custom-proxy.conf:ro \
            -v ~/.config/nginx-proxy/vhost.d/:/etc/nginx/vhost.d:rw \
            -v ~/.config/nginx-proxy/htpasswd/:/etc/nginx/htpasswd:ro \
            -v ~/.config/nginx-proxy/certs:/etc/nginx/certs:ro \
            --log-opt max-size=5M \
            --net bridge \
            --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy=true \
            jwilder/nginx-proxy

    docker stop ssl && \
        docker rm ssl

    docker pull jrcs/letsencrypt-nginx-proxy-companion && \
        dkr-run --name ssl -d \
            -e "ACME_CA_URI=https://acme-v01.api.letsencrypt.org/directory" \
            -v /var/run/docker.sock:/var/run/docker.sock:ro \
            -v ~/.config/nginx-proxy/certs:/etc/nginx/certs:rw \
            --volumes-from proxy \
            jrcs/letsencrypt-nginx-proxy-companion
}

_tmuxinator() {
  local commands projects
  commands=(${(f)"$(tmuxinator commands zsh)"})
  projects=(${(f)"$(tmuxinator completions start)"})

  if (( CURRENT == 2 )); then
    _describe -t commands "tmuxinator subcommands" commands
    _describe -t projects "tmuxinator projects" projects
  elif (( CURRENT == 3)); then
    case $words[2] in
      copy|debug|delete|open|start)
        _arguments '*:projects:($projects)'
      ;;
    esac
  fi

  return
}

alias mux="tmuxinator"
