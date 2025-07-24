{...}: {
  imports = [
    ./pihole.nix
    ./media.nix
    ./proxy.nix
    ./torrenting.nix
    ./homepage.nix
    ./cloudflare.nix
  ];
}
