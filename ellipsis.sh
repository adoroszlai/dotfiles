#!/usr/bin/env bash

path.in_pkg() {
    echo "$PKG_PATH/$(path.strip_dot "$(basename "$1")")"
}

path.relative_to_package() {
    echo "${1/${PKG_PATH}\//}"
}

git.add() {
    git --git-dir=${PKG_PATH}/.git add "$(path.relative_to_package "$1")"
}

git.remove() {
    git --git-dir=${PKG_PATH}/.git rm "$(path.relative_to_package "$1")"
}

pkg.add() {
    hooks.add "$1"
    git.add "$(path.in_pkg "$1")"
}

pkg.remove() {
    git.remove "$(path.in_pkg "$1")"
    hooks.remove "$1"
}

# vim: et ts=4 sts=4 sw=4
