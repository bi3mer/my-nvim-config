#!/usr/bin/env bash
set -euo pipefail

case "$(uname -s)" in
  Darwin)
    brew install neovim
    brew install --cask basictex skim
    export PATH="/Library/TeX/texbin:$PATH"
    sudo tlmgr update --self
    sudo tlmgr install latexmk biblatex biblatex-ieee biber logreq csquotes
    ;;
  Linux)
    sudo apt-get update
    sudo apt-get install -y git latexmk texlive-latex-extra texlive-bibtex-extra biber zathura
    sudo snap install nvim --classic
    ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac
