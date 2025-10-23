#!/bin/bash

echo "=== Сохраняем конфиги ==="
cp ~/.zshrc ~/BackupArch/dotfiles/
cp -r ~/.config/kitty ~/BackupArch/dotfiles/
cp -r ~/.config/hypr ~/BackupArch/dotfiles/
cp -r ~/.config/nvim ~/BackupArch/dotfiles/
cp -r ~/.config/waybar ~/BackupArch/dotfiles/

echo "=== Сохраняем списки пакетов ==="
pacman -Qqe > ~/BackupArch/packages/pacman.txt
yay -Qqe > ~/BackupArch/packages/aur.txt

echo "✅ Резервное копирование завершено!"

