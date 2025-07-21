{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      pihole = {
        image = "pihole/pihole:latest";
        ports = [
          "53:53/tcp"
          "53:53/udp"
          "83:80/tcp"
          "443:443/tcp"
        ];
        environment = {
          TZ = "Europe/Warsaw";
          FTLCONF_dns_listeningMode = "all";
        };
        volumes = [
          "/etc/pihole:/etc/pihole"
        ];
        capabilities = {
          NET_ADMIN = true;
          SYS_TIME = true;
          SYS_NICE = true;
        };
        labels = {
          "traefik.http.routers.pihole.rule" = "Host(`pi.hole`)";
          "traefik.http.services.pihole.loadbalancer.server.port" = "80";
        };
        autoStart = true;
      };
    };
  };
}
