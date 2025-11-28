{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {};
in {
  home.packages = with pkgs; [
    # python
    python3
    uv

    # dev tools
    (lib.hiPrio gcc)
    (lib.lowPrio clang)
    binutils
    clang-tools
    cmake
    gdb
    gh
    gnumake
    gnupg
    jq
    linuxPackages.perf
    neofetch
    postman
    qgis
    skim
    sops
    tig
    tldr
    universal-ctags


    # window manager & friends / dotfiles stuff
    alacritty
    enpass
    i3status-rust
    libnotify
    picom
    rofi
    swaybg

    # Fonts
    font-awesome
    font-awesome_4
    powerline
    powerline-fonts
    terminus_font
    gnome-font-viewer
    ibm-plex

    # CLI utils
    ansible
    awscli2
    bat
    btop
    duf
    file
    imagemagick
    k9s
    maestral # Dropbox
    magic-wormhole
    man-pages
    ncdu
    oxker
    restic
    ripgrep
    seafile-client
    sshfs
    time
    tree
    unzip
    xclip
    xorg.xkill
    zip

    # Communication
    discord
    element-desktop
    signal-desktop
    slack

    # networking
    aria2
    rsync
    vpnc-scripts

    # desktop
    chromium
    evince
    firefox

    # audio / video
    pamixer
    pavucontrol
    playerctl
    slurp # select zone
    spotify
    vlc
    wf-recorder

    # image processing
    feh
    gimp
    sway-contrib.grimshot
    inkscape
    xcolor

    # 3d graphics
    (blender.override {
      cudaSupport = true;
    })

    # sncf
    jdk17
    jetbrains.idea-community
    gp-saml-gui
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    SSH_KEY_PATH = "~/.ssh/rsa_id";
    GIT_EDITOR = "nvim";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  };

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
    autosuggestion.enable = true;
    history.extended = true;
    initExtra = ''
      source ${./configs/zsh/aliases.sh}
      source ${./configs/zsh/p10k.zsh}
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      PATH=$PATH:/home/flomonster/.cargo/bin/
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

  # Enable fzf for command line fuzzy finder
  programs.fzf.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      email = "florian.amsallem@gmail.com";
      name = "Florian Amsallem";
    };
    ignores = ["*.o" "*.a" "*.so" "*.pyc" "tags" ".envrc" ".direnv"];
    includes = [{path = "~/.config/home-manager/configs/gitconfig";}];
    lfs = {enable = true;};
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
  home.file.".config/sway" = {
    source = ./configs/sway;
    recursive = true;
  };
  home.file.".config/alacritty/alacritty.toml".source = ./configs/alacritty/alacritty.toml;
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
  home.stateVersion = "23.11";
}
