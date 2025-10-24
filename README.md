# ThelastbobreekArch Setup 🚀

Скрипт автоматической установки моего окружения Arch Linux.

## 📦 Step 1 — Установка базовых пакетов

```bash
sudo pacman -S wofi kitty freetype2 zsh git hyprlock hyprpaper waybar ttf-font-awesome otf-font-awesome ttf-jetbrains-mono obsidian pavucontrol feh ranger thunar meson nwg-look papirus-icon-theme fastfetch file powerline-fonts inetutils ttf-font-awesome otf-font-awesome ttf-jetbrains-mono neovim code ttf-dejavu bluez bluez-utils blueman telegram-desktop vlc fastfetch

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S hyprshot wlogout
```

---

## 📁 Step 2 — Добавление репозиториев

```bash
cd ~/Documents

git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
git clone https://github.com/itRoy-pentest/RoyHyprland.git
```

---

## ⚙️ Step 3 — Копирование конфигов

```bash
cd RoyHyprland
cp -r kitty waybar wlogout wofi hypr fastfetch ~/.config

cd Graphite-gtk-theme
./install.sh
```

---

## 💻 Step 4 — Настройка Zsh и тем

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

nvim ~/.zshrc

# Внутри файла ~/.zshrc:
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source ~/.zshrc
chsh
/bin/zsh

reboot
```

---

## 🧠 Описание

Этот репозиторий устанавливает полностью готовое окружение Arch Linux с Hyprland, Waybar, Wofi, Kitty и Zsh (Oh My Zsh + Powerlevel10k).  
Идеален для быстрого развёртывания нового рабочего окружения.

---

## 🐧 Репозиторий

[GitHub: 42BOBREEK/ThelastbobreekArch](https://github.com/42BOBREEK/ThelastbobreekArch)
