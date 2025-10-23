#!/bin/bash
set -e

BACKUP_DIR="$HOME/BackupArch"
DOTFILES="$BACKUP_DIR/dotfiles"
PACKAGES="$BACKUP_DIR/packages"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
CONFIG_BACKUP="$HOME/.config_backup_$TIMESTAMP"

mkdir -p "$CONFIG_BACKUP"

echo "=== Установка пакетов pacman ==="
if [ -f "$PACKAGES/pacman.txt" ]; then
    sudo pacman -Syu --needed - < "$PACKAGES/pacman.txt"
fi

echo "=== Установка пакетов AUR ==="
if [ -f "$PACKAGES/aur.txt" ]; then
    if ! command -v yay >/dev/null 2>&1; then
        echo "⚠️  yay не найден. Устанавливаю yay..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si
        cd ~
        rm -rf /tmp/yay
    fi
    yay -S --needed - < "$PACKAGES/aur.txt"
fi

echo "=== Копирование конфигов ==="
copy_config() {
    src="$1"
    dest="$2"
    if [ -e "$dest" ]; then
        echo "Бэкапим $dest в $CONFIG_BACKUP"
        mv "$dest" "$CONFIG_BACKUP/"
    fi
    cp -r "$src" "$dest"
    echo "Установлен: $dest"
}

# Основные конфиги
[ -d "$DOTFILES" ] || { echo "Ошибка: папка $DOTFILES не найдена!"; exit 1; }

# Список конфигов для копирования
declare -A CONFIGS=(
    [".zshrc"]="$HOME/.zshrc"
    ["kitty"]="$HOME/.config/kitty"
    ["hypr"]="$HOME/.config/hypr"
    ["vim"]="$HOME/.vimrc"
    ["waybar"]="$HOME/.config/waybar"
    ["wlogout"]="$HOME/.config/wlogout"
    ["wofi"]="$HOME/.config/wofi"
    ["fastfetch"]="$HOME/.config/fastfetch"
)

for src in "${!CONFIGS[@]}"; do
    copy_config "$DOTFILES/$src" "${CONFIGS[$src]}"
done

echo "=== Установка GTK темы и иконок ==="
if [ -d "$DOTFILES/Graphite-gtk-theme" ]; then
    cd "$DOTFILES/Graphite-gtk-theme"
    ./install.sh
fi
if [ -d "$DOTFILES/Papirus-icon-theme" ]; then
    mkdir -p ~/.icons
    cp -r "$DOTFILES/Papirus-icon-theme" ~/.icons/
fi

echo "=== Установка Oh My Zsh и плагинов ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ -d "$DOTFILES/powerlevel10k" ]; then
    copy_config "$DOTFILES/powerlevel10k" "$ZSH_CUSTOM/themes/powerlevel10k"
fi

for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    if [ -d "$DOTFILES/$plugin" ]; then
        copy_config "$DOTFILES/$plugin" "$ZSH_CUSTOM/plugins/$plugin"
    fi
done

echo "=== Настройка завершена! ==="
echo "Бэкап старых конфигов: $CONFIG_BACKUP"
echo "Перезапусти терминал или выполните 'source ~/.zshrc' для применения Zsh"
