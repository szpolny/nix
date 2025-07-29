{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers = {
    backend = "docker";
  };

  system.activationScripts.createNetwork = let
    docker = config.virtualisation.oci-containers.backend;
    dockerBin = "${pkgs.${docker}}/bin/${docker}";
  in ''
    ${dockerBin} network inspect proxy >/dev/null 2>&1 || ${dockerBin} network create proxy
  '';

  imports = [
    ./pihole.nix
    ./media.nix
    ./proxy.nix
    ./torrenting.nix
    ./homepage.nix
    ./cloudflare.nix
    ./vpn.nix
  ];
}
