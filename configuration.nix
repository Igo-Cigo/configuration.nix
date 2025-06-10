# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Sarajevo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bs_BA.UTF-8";
    LC_IDENTIFICATION = "bs_BA.UTF-8";
    LC_MEASUREMENT = "bs_BA.UTF-8";
    LC_MONETARY = "bs_BA.UTF-8";
    LC_NAME = "bs_BA.UTF-8";
    LC_NUMERIC = "bs_BA.UTF-8";
    LC_PAPER = "bs_BA.UTF-8";
    LC_TELEPHONE = "bs_BA.UTF-8";
    LC_TIME = "bs_BA.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.igor = {
    isNormalUser = true;
    description = "Igor Lubura";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;

  # Enable Bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Packages
  programs = {
	hyprland.enable = true;
	hyprland.withUWSM = true;
	thunar.enable = true;
#	firefox.enable = true;
	zsh.enable = true;
	steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;	
	};
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	brave
	ghostty
	wget
#	xfce.thunar
	fastfetch
	waybar
	mesa
	wofi
	mako
	gvfs
	pavucontrol
	mpd
	power-profiles-daemon
	waypaper
	brightnessctl
	git
	htop
	playerctl
	blueman
	vscode
	nixfmt-rfc-style
	nixd
	swww
	discord
	zinit
	fzf
	lxappearance
	hyprcursor
	xfce.tumbler
	protonup-qt
	lutris
  ];

  fonts.packages = with pkgs; [
	noto-fonts
	nerd-fonts.fira-code
	noto-fonts-color-emoji
	nerd-fonts.jetbrains-mono
	nerd-fonts.ubuntu
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services = {
	xserver.enable = true;
	displayManager.sddm.enable = true;
	power-profiles-daemon.enable = true;
	blueman.enable = true;
	xserver.desktopManager.gnome.enable = true;
	tumbler.enable = true;
  };

# GNOME configuration
environment.gnome.excludePackages = with pkgs; [
	orca
	evince
	geary
	baobab
	epiphany
	gnome-console
];

environment.variables = {
	GSK_RENDERER = "gl";
	NIXOS_OZONE_WL=1;
#	VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
};
#  environment.shellAliases = {
#	"editnixconf" = "sudo nano /etc/nixos/configuration.nix";
#	"editnixhome" = "nano .config/home-manager/home.nix";
#  };

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
  system.stateVersion = "25.05"; # Did you read the comment?

}

