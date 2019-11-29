#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install() {
    # ZSH
    print_in_purple "\n   zsh\n\n"
    install_package "zsh" "zsh"
    print_in_purple "\n   oh-my-zsh\n\n"
    ZSH="$HOME/.oh-my-zsh"
    if [[ ! -d $ZSH ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        print_in_yellow "\n   using local version of oh-my-zsh\n"
    fi
    print_in_green "\n   Password default shell:"
    chsh -s $(which zsh)
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    ZSH_THEME_TO_INSTALL="$ZSH_CUSTOM/themes/spaceship-prompt"
    ZSH_THEME_TO_SYMLINK="$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    print_in_purple "\n   theme.oh-my-zsh\n\n"
    # print_in_yellow "\n   installing theme $ZSH_THEME_TO_INSTALL"
    if [[ ! -d $ZSH_THEME_TO_INSTALL ]]; then
        execute "git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_THEME_TO_INSTALL"
        ln -s "$ZSH_THEME_TO_INSTALL/spaceship.zsh-theme" "$ZSH_THEME_TO_SYMLINK"
    else
        print_in_yellow "\n   using local version of theme from $ZSH_THEME_TO_INSTALL\n\n"
    fi
    print_in_purple "\n   plugin.zsh-syntax-highlighting\n\n"
    install_package "zsh-syntax-highlighting" "zsh-syntax-highlighting"

    print_in_purple "\n   plugin.zsh-autosuggestions\n\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n install-zsh\n"
    seek_confirmation "   Warning: Are you sure you want to zsh? (current installation: $ZSH)"

    if is_confirmed; then
        install
    else
        e_warning "   Skipped [install-zsh] installation step."
    fi
}

main
