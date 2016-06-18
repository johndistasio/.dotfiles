#!/bin/bash

dotfiles=~/.dotfiles

github="https://github.com"

git clone --recursive ${github}/sorin-ionescu/prezto.git ~/.zprezto

git clone ${github}/rbenv/rbenv.git ~/.rbenv \
    && git clone ${github}/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# TODO: Install dotfiles.
