#!/bin/sh

VSCODE_EXTENSIONS_PATH="vscode_extensions.txt"


help(){
    printf "Dotfile installer and vscode extension tools\n\n";
    printf "Syntax: ./dotfiles.sh [l|load|s|save|i|install]\n\n";
    printf "Options:\n\n";
    printf "\tl|load      loads the vscode extensions from: %s\n" $VSCODE_EXTENSIONS_PATH;
    printf "\ts|save      saves the current vscode extensions into: %s\n" $VSCODE_EXTENSIONS_PATH;
    printf "\ti|install   installs the current dotfiles\n";
    printf "\n";
}


exit_abnormal(){
    help;
    exit 1;
}


load(){
    while read extension; do
        code --install-extension $extension --force
    done < $VSCODE_EXTENSIONS_PATH;
    return;
}


save(){
    printf "Saving extensions to: %s" $VSCODE_EXTENSIONS_PATH;
    code --list-extensions > $VSCODE_EXTENSIONS_PATH;
    return;
}


install(){
    DOTFOLDERS=(
        "fish"
        "nvim"
        "vscode"
        "tmux"
    )
    printf "Stowing Folders: \n"
    for folder in "${DOTFOLDERS[@]}"
    do
        printf "\t%s\n" $folder
        stow --target $HOME $folder --override=man --override=info --adopt
    done
    printf "done"
    return;
}


while getopts lhsi-: OPT; do
    if [ "$OPT" = "-" ]; then
        OPT="${OPTARG%%=*}"
        OPTARG="${OPTARG#$OPT}"
        OPTARG="${OPTARG#=}"
    fi
    case "$OPT" in
        l | load    ) load ;;
        h | help    ) help ;;
        s | save    ) save ;;
        i | install ) install;;
        ??*         ) exit_abnormal ;;
        ?           ) exit_abnormal ;;
    esac
    exit 0;
done

exit 1;
