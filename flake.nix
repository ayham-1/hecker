{
    description = "hecker";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.05";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system : let 
      pkgs = import nixpkgs { system = "x86_64-linux";
      config.allowUnfree = true; };
    in {
        packages = {
            default = pkgs.stdenv.mkDerivation {
                    name = "hecker";
                    src = ./.;

                    nativeBuildInputs = with pkgs; [
                        clang
                        cmake
                        pkg-config
                        ninja
                        gdb
                        valgrind
                        renderdoc
                        toybox
                        netcat
                        openvpn

                        metasploit
                        jadx
                        nmap
                        john
                        sqlite
                        python312
                        exploitdb
                        wireshark
                        dirb
                        burpsuite

                        man
                        man-pages
                        man-pages-posix
                    ];

                    buildInputs = with pkgs; [
                    ];
                    shellHook = ''
                        export PS1='[\#][$?] \[\e[2m\]\t \[\e[0;1;3m\]hecker\[\e[0m\]> '
                        alias ide="nix run github:ayham-1/ide"
                    '';
            };
        };
    });
}
