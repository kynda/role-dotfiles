Dotfiles
===============================================================================

Everyone has their own take on how Vim, ZSH, and Tmux should be configured.
Well, here’s an Ansible role to turn the terminal into an IDE.

This is a hard fork of [Keelerm84][]'s  Dotfiles, but structured as an Ansible
role that can be included into a playbook to push out to all of your
environments.

Tools
-------------------------------------------------------------------------------

These dotfiles provide tooling for the following:

### ZSH

Basic aliases and the wonderful agnoster theme.

### VIM/NeoVIM

Basic set of plugins to get you set up for PHP and web development. Batteries
include tooling for interactive debugging, managing SQL databases, auto-complete
and linting.

### TMUX

The ultimate multiplexer. Great for maintaining long-running or multiple
sessions through the work day.

Usage
-------------------------------------------------------------------------------

In order to make use of the role you need to define three variables somewhere in
your playbook.

- home: The location of the home directory on your system. Typically either
  `/home/username` or `Users/username` depending on if you are on Linux or OSX.
- user: The username these dotfiles will go under
- group: The group the user belongs to

[Keelerm84]: https://github.com/keelerm84/dotfiles
