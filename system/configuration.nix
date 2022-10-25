# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
      ./single-gpu-passthrough.nix
      ./pipewireLowLatency.nix
      ./gamemode.nix
       ./kernel.nix
   ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
   networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
   time.timeZone = "Asia/Dubai";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp60s0.useDHCP = true;
  networking.interfaces.wlp61s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.windowManager.awesome.enable=true;
  #services.xserver.windowManager.i3.package = pkgs.i3-gaps; 
  #services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
#  windowManager.bspwm.sxhkd.configFile = builtins.getEnv "HOME" + "/.config/sxhkd/sxhkdrc";
 # windowManager.bspwm.configFile = builtins.getEnv "HOME" + "/.config/bspwm/bspwmrc";
 #services.xserver.windowManager.river.enable = true;

# Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

# Polkit
security.polkit.enable = true;


# Not strictly required but pipewire will use rtkit if it is present
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  # Compatibility shims, adjust according to your needs
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
  lowLatency.enable = true;
  
    # defaults (no need to be set unless modified)
    lowLatency = {
      quantum = 64;
      rate = 48000;
    };
  }; 


# Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
services.xserver.libinput.mouse.accelProfile = "flat";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vboob = {
  isNormalUser = true;
   initialPassword = "password101";
   extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = [
   pkgs.vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  inputs.webcord.packages.${pkgs.system}.default
  pkgs.neofetch
  pkgs.kde-gruvbox
  pkgs.vscode
  pkgs.anki
  pkgs.lunar-client
  pkgs.minecraft
  pkgs.wget
  pkgs.geany
  pkgs.polkit_gnome
  pkgs.swtpm
  #inputs.nix-gaming.packages.${pkgs.system}.osu-stable
  pkgs.librewolf 
  pkgs.firefox
  pkgs.git
  pkgs.discord
#inputs.nix-gaming.packages.${pkgs.system}.osu-stable  
  ];

programs.steam.enable = true;  

# Nvidia
#  hardware.nvidia.modesetting.enable = true;
#  services.xserver.videoDrivers = [ "nvidia" ];

# Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;

 nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

# Enable OpenTabletDriver
hardware.opentabletdriver.enable = true;

services.xserver.windowManager.dwm.enable = true;


# Fonts!
  fonts.fonts = with pkgs; [
    material-icons
    jetbrains-mono
    fantasque-sans-mono
    font-awesome_5
    fira-code
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    font-awesome
    libertine
    victor-mono
    emacs-all-the-icons-fonts
    # font-fonts
    monoid
    kochi-substitute # Japanese
    material-icons
  ];

 
  services.xserver.dpi = 96;
  environment.variables = {
    GDK_SCALE = "0.5";
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  programs.java = {
    enable = true;
  };
  
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.optimus_prime = {
    enable = true;

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
  };  
  
nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

virtualisation.libvirtd.enable = true;
nixpkgs.config.firefox.enableGnomeExtensions = true;
#services.gnome3.chrome-gnome-shell.enable = true;
services.gnome.chrome-gnome-shell.enable = true;
}

