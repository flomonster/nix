{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # python
    python3
    pipenv

    # sysadmin
    docker-compose

    # dev tools
    (lib.hiPrio gcc)
    (lib.lowPrio clang)
    binutils
    clang-tools
    cmake
    dbeaver
    gdb
    gnumake
    jq
    linuxPackages.perf
    postman
    qgis
    rustup
    tig
    universal-ctags

    # window manager & friends / dotfiles stuff
    alacritty
    autorandr
    enpass
    font-awesome
    font-awesome_4
    i3status-rust
    nitrogen
    picom
    powerline
    powerline-fonts
    rofi
    terminus_font
    xdo

    # CLI utils
    file
    htop
    magic-wormhole
    manpages
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

    # 3d graphics
    blender

    # system config
    arandr

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
    includes = [ { path = "~/.config/nixpkgs/configs/gitconfig"; } ];
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
      # Tag management
      vim-gutentags
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
