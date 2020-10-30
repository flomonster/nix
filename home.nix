{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # rust stuff
    rustup

    # sysadmin
    docker-compose

    # dev tools
    (lib.hiPrio gcc)
    (lib.lowPrio clang)
    binutils
    clang-tools
    cmake
    universal-ctags
    gdb
    gnumake
    jq

    # window manager & friends / dotfiles stuff
    alacritty
    font-awesome-ttf
    i3status-rust
    nitrogen
    picom
    powerline-fonts
    rofi
    terminus_font
    xdo

    # CLI utils
    htop
    manpages
    time
    tree
    unzip
    xorg.xkill
    zip

    # emails
    thunderbird-bin

    # networking
    aria2
    rsync

    # desktop
    evince
    firefox

    # audio / video
    pavucontrol
    spotify
    vlc

    # image processing
    feh
    gimp
    scrot

    # 3d graphics
    blender

    # system config
    arandr
  ];

  fonts.fontconfig.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    documentation.dev.enable = true;
    xdg.portal.enable = false;
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
    ignores = [ "*.o" "*.a" "*.so" "*.pyc" "tags" ];
    includes = [ { path = "~/.config/nixpkgs/configs/gitconfig"; } ];
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
    ];
  };

  # Link config files
  home.file.".config/i3/config".source = ./configs/i3/config;
  home.file.".config/i3status-rust/config.toml".source = ./configs/i3/status.toml;
  home.file.".config/alacritty/alacritty.yml".source = ./configs/alacritty/alacritty.yml;
  home.file.".config/picom/picom.conf".source = ./configs/picom.conf;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
