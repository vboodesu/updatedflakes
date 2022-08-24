{ config, pkgs, inputs,... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vboob";
  home.homeDirectory = "/home/vboob";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

imports = [
#./i3.nix
#./sxhkd.nix
#./bspwm.nix
];

home.packages = with pkgs; [
   #alacritty 
  #osu-stable 
   polkit
   picom
   kitty
#   neofetch
   pipewire
   pipewire-media-session
   dbus
   pavucontrol
   xorg.xinit
   pciutils
   gparted
   steam
   mesa
   libGL
   #discord
#   libGL_driver
   woeusb
   git
   obs-studio
   gnome.nautilus
   dmenu
    mpv
#   inputs.nix-gaming.packages.x86_64-linux.osu-stable
    ntfs3g
    nordic
    lxappearance
    polybar
    meson  
    ninja  
    picom
    nitrogen  
    gruvbox-dark-gtk 
   minecraft  
  xorg.xf86videofbdev
   droidcam 
   dolphin
   pcmanfm
   legendary-gl
   git-crypt
   gnupg
   lutris
   winetricks
   eww 
   rofi 
   feh 
   killall
   scrot 
   playerctl 
   gamemode 
   pfetch 
   heroic
   librewolf 
   networkmanagerapplet 
   fish 
   spotify 
   betterdiscordctl
   htop
   river
#python310Packages.bootstrapped-pip
#python39Packages.fake_factory
python39Packages.factory_boy
alacritty
doas
gcc
gnumake
gcc-unwrapped
binutils
cmake
wayland
xwayland
#firefox
gnome.gnome-disk-utility
virt-manager
#polkit_gnome
gnome3.gnome-tweaks
teams
swtpm
sfml
csfml
];

nixpkgs = {
  config = {
    allowUnfree = true;
  };
};

programs.neovim = { 
enable = true;
vimAlias = true;
viAlias = true;
extraConfig = ''
 set mouse=a
colorscheme nord
let g:airline_theme='base16'
set number
  set linespace=2
 set softtabstop=2 
 set linespace=2
 set expandtab
    '';
    
plugins = with pkgs.vimPlugins; [
nvim-web-devicons  
vim-nix
vim-airline
gruvbox
nord-nvim
vim-fish
nerdtree
vim-airline-themes
vim-plug
tabnine-vim
 ];
};

# Kitty
home.file = { 
   ".config/kitty/kitty.conf".text = '' 
    include ./nord.conf

# font_family      Input Mono 
font_family      Sarasa Mono CL Nerd Font
italic_font      auto 
bold_font        auto 
bold_italic_font auto 

# Font size (in pts) 
font_size        14.0 
     
window_padding_width 25
window_padding_height 25

 '';
 };
}
