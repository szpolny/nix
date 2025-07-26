{...}: {
  virtualisation.oci-containers = {
    containers = {
      homarr = {
        image = "ghcr.io/homarr-labs/homarr:latest";
        environmentFiles = [
          "/etc/homarr/env"
        ];
        networks = [
          "proxy"
        ];
        ports = [
          "7575:7575"
        ];
        volumes = [
          "/etc/homarr:/appdata"
          "/var/run/docker.sock:/var/run/docker.sock:ro"
        ];
        autoStart = true;
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.homarr.rule" = "Host(`home.asgard`)";
        };
      };
    };
  };
}
