# Instructions to install Hyprland

> [!INFO]
> You must have a valid arch linux install with Hyprland installed via Pacman
> Make sure you have a separate sudo-capable user aside from root

## 1: Inital Config

1. Start hyprland by running `Hyprland`
2. Open the terminal with `$mainMod + Q`
3. Change shell to zsh
4. Install Neovim
5. Enter the `~/.config/hypr/hyprland.conf` file and adjust monitor scale &
   $mainMod if required
6. Install yay
7. Use yay to install wofi
8. wofi can now be run using `$mainMod + R` to open any installed programme
9. Install a lightweight tools like `librewolf-bin`(browser) and `thunar` (file manager)
10. Go to the [hyprland.conf on official github](https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf)
11. Copy the downloaded file to replace the `~/.config/hypr/hyprland.conf`.
    Re-apply any changes made to the monitors or the $mainMod
12. To your `~/.zprofile` add the lines under [Autostart X on login](https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login).
    Careful to not copy it directly, use the modified version from below
    ```bash
        # Pasting this means that you auto-start hyprland once you login
        if [ -z `$DISPLAY` ] && [ "$XDG_VTNR" = 1 ]; then
            exec Hyprland
        fi
    ```
13. Install the following packages with yay to prepare for future ricing
    - `swaync`: Notification Daemon
    - `pipewire`: Audio & Screensharing
    - `xdg-desktop-portal-hyprland`: Manages various desktop elements
    - `polkit-gnome`: Opens a password floating window when root privileges required
    - `qt5-wayland`: qt5 gui framework
    - `qt6-wayland`: qt6 gui framework
    - `nwg-look`: Change gtk-theme and font-rendering
    - `swww`: Solution to your Wayland Wallpaper Woes (with neat animations)
    - `waybar`: Status bar
    - `hyprpanel`: A richer but heavier status bar
    - `udiskie`: Auto-mount USB drives
    - `python-pywal16`: Theming programmes and UI components based on the wallpaper
    - `matugen-bin`: Similar to python-pywal, but with material design
    - `hypridle`: Idle screen
    - `hyprlock`: Lock screen
    - **Final Command:**
      ```bash
          yay -S --needed swaync pipewire xdg-desktop-portal-hyprland \
          polkit-gnome qt5-wayland qt6-wayland nwg-look swww waybar \
          hyprpanel udiskie python-pywal16 matugen-bin hypridle hyprlock
      ```

## 2: Customizing the Environment

### 2.1: Change Wallpaper

1. Download some cool wallpapes and place them in a directory of your choice
   like `~/Pictures/Wallpapers`
2. To the `~/.config/hypr/hyprland.conf` add the line `exec-once = swww-daemon &`
   to autostart the swww daemon and fork it to bg
3. Either re-login to autostart swww-daemon, or manually run `swww-daemon & disown`
4. Pick a picture and set it as the wallpaper using `swww img <path_to_picture>`

### 2.2: Status Bar

1. Add waybar to the exec-once section of `hyprland.conf` with an &
2. Either re-login to autostart waybar or manually run `waybar & disown`

### 2.3: Change GTK/QT theme

#### 2.3.1: GTK Apps

1. Option 1: Go to [Gnome-Look](hhtps://gnome-look.org) for gtk3 and gtk4 themes
   - Try to find a gtk4 theme you like.
2. Option 2: Directly search for the [graphite gtk4](https://github.com/vinceliuice/Graphite-gtk-theme) theme and download it.

   - Install the theme using the provided shell script
   - ```bash
       ./install.sh -t all -l --tweaks black rimless
     ```
   - Use nwg-look to set the theme (like Graphite Dark)

3. Option 3: Download [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) , and unofficial gtk3 port of libadwaita

#### 2.3.1: GTK Apps

1. Install the [graphite kde theme](https://github.com/vinceliuice/Graphite-kde-theme)
   - Use the provided install script
   - ```bash
       ./install.sh --rimless
     ```
   - Use nwg-look to set the theme (like Graphite-rimlessDark)

### 2.4: Change Decoration Settings

### 2.5: Change terminal prompt

1. OhMyZsh is a decent Zsh Theme/plugin manager
2. I think trying out something newer might be interesting (like Antidote)
3. Sad to see P10k on life support mode, but I'd rather use it than Starship
