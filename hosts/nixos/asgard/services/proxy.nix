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
          "--providers.docker.network=proxy"
          "--entrypoints.web.address=:80"
        ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
        autoStart = true;
      };
    };
  };
}
