{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # python
    python3
    pipenv

    # dev tools
    (lib.hiPrio gcc)
    (lib.lowPrio clang)
    binutils
    clang-tools
    cmake
    dbeaver
    gdb
    gnumake
    gnupg
    jq
    linuxPackages.perf
    postman
    qgis
    skim
    sops
    tig
    universal-ctags

    # window manager & friends / dotfiles stuff
    alacritty
    autorandr
    enpass
    i3status-rust
    libnotify
    nitrogen
    picom
    rofi
    xdo

    # Fonts
    font-awesome
    font-awesome_4
    powerline
    powerline-fonts
    terminus_font
    gnome.gnome-font-viewer

    # CLI utils
    bat
    file
    htop
    magic-wormhole
    man-pages
    ncdu
    ripgrep
    sshfs
    time
    tree
    unzip
    xclip
    xorg.xkill
    zip

    # Communication
    discord
    slack

    # networking
    aria2
    rsync

    # desktop
    evince
    firefox
    chromium

    # audio / video
    pavucontrol
    spotify
    vlc
    kdenlive
    kazam
    playerctl

    # image processing
    feh
    gimp
    inkscape
    scrot
    xcolor

    # 3d graphics
    blender

    # system config
    arandr
    neofetch

    # sncf
    jdk17
    jetbrains.idea-community
  ];


  home.sessionVariables = {
    EDITOR = "nvim";
    SSH_KEY_PATH = "~/.ssh/rsa_id";
    GIT_EDITOR = "nvim";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  };

  services.dropbox.enable = true;

  fonts.fontconfig.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    documentation.dev.enable = true;
    xdg.portal.enable = false;
  };

  programs.direnv = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
    ];
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history.extended = true;
    initExtra = ''
      source ${./configs/zsh/aliases.sh}
      source ${./configs/zsh/p10k.zsh}
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    oh-my-zsh = {
      enable = true;
    };
  };


  programs.git = {
    enable = true;
    userEmail = "florian.amsallem@epita.fr";
    userName = "Florian Amsallem";
    ignores = [ "*.o" "*.a" "*.so" "*.pyc" "tags" ".envrc" ];
    includes = [ { path = "~/.config/home-manager/configs/gitconfig"; } ];
    lfs = { enable = true; };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./configs/init.vim;

    plugins = with pkgs.vimPlugins; [
      # Auto completion for c++
      deoplete-nvim
      deoplete-clang
      # Auto completion for rust
      vim-racer
      # Auto format
      neoformat
      # Linter
      neomake
      #Integration of git
      vim-fugitive
      # Better buffer view
      vim-airline
      vim-airline-themes
      # Automatic closing braces and brackets
      delimitMate
      # Snippets
      vim-snippets
      ultisnips
      # Rust syntax highlighting
      rust-vim
      # Support nix files
      vim-nix
    ];
  };

  programs.vscode = {
        enable = true;
        package = pkgs.vscode;
    };

  # Link config files
  home.file.".config/i3/config".source = ./configs/i3/config;
  home.file.".config/i3/status.toml".source = ./configs/i3/status.toml;
  home.file.".config/i3/status_vert.toml".source = ./configs/i3/status_vert.toml;
  home.file.".config/alacritty/alacritty.yml".source = ./configs/alacritty/alacritty.yml;
  home.file.".config/picom/picom.conf".source = ./configs/picom.conf;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "flomonster";
  home.homeDirectory = "/home/flomonster";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
