{...}: {
  virtualisation.oci-containers = {
    containers = {
      jellyfin = {
        image = "lscr.io/linuxserver/jellyfin:latest";
        ports = [
          "8096:8096/tcp"
          "8920:8920/tcp"
          "7359:7359/udp"
          "1900:1900/udp"
        ];
        networks = [
          "proxy"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Warsaw";
        };
        volumes = [
          "/etc/jellyfin:/config"
          "/media/tv:/media/tv"
          "/media/movies:/media/movies"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.jellyfin.rule" = "Host(`jellyfin.asgard`)";
          "traefik.http.services.jellyfin.loadbalancer.server.port" = "8096";
        };
        extraOptions = [
          "--device=nvidia.com/gpu=all"
        ];
        autoStart = true;
      };
      radarr = {
        image = "lscr.io/linuxserver/radarr:latest";
        ports = [
          "7878:7878/tcp"
        ];
        networks = [
          "proxy"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Warsaw";
        };
        volumes = [
          "/etc/radarr:/config"
          "/media/movies:/movies"
          "/media/downloads:/downloads"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.radarr.rule" = "Host(`radarr.asgard`)";
        };
        autoStart = true;
      };
      sonarr = {
        image = "lscr.io/linuxserver/sonarr:latest";
        ports = [
          "8989:8989/tcp"
        ];
        networks = [
          "proxy"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Warsaw";
        };
        volumes = [
          "/etc/sonarr:/config"
          "/media/tv:/tv"
          "/media/downloads:/downloads"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.sonarr.rule" = "Host(`sonarr.asgard`)";
        };
        autoStart = true;
      };
      prowlarr = {
        image = "lscr.io/linuxserver/prowlarr:latest";
        ports = [
          "9696:9696/tcp"
        ];
        networks = [
          "proxy"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Warsaw";
        };
        volumes = [
          "/etc/prowlarr:/config"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.prowlarr.rule" = "Host(`prowlarr.asgard`)";
        };
        autoStart = true;
      };
      bazarr = {
        image = "lscr.io/linuxserver/bazarr:latest";
        ports = [
          "6767:6767"
        ];
        networks = [
          "proxy"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Warsaw";
        };
        volumes = [
          "/etc/bazarr:/config"
          "/media/tv:/tv"
          "/media/movies:/movies"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.bazarr.rule" = "Host(`bazarr.asgard`)";
        };
        autoStart = true;
      };
    };
  };
}
