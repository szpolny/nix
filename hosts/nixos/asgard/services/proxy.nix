{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      traefik = {
        image = "traefik";
        ports = [
          "8080:8080"
          "80:80"
        ];
        cmd = [
          "--api.insecure=true"
          "--providers.docker=true"
          "--providers.docker.exposedbydefault=false"
          "--entrypoints.web.address=:80"
        ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.api.rule" = "Host(`traefik.asgard`)";
          "traefik.http.routers.api.service" = "api@internal";
          "traefik.http.services.api.loadbalancer.server.port" = "8080";
        };
        autoStart = true;
      };
    };
  };
}
