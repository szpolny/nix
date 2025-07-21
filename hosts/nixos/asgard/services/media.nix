{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      jellyfin = {
        image = "lscr.io/linuxserver/jellyfin:latest";
        ports = [
          "8096:8096/tcp"
          "8920:8920/tcp"
          "7359:7359/udp"
          "1900:1900/udp"
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
          "traefik.http.routers.jellyfin.rule" = "Host(`jellyfin.asgard`)";
        };
        autoStart = true;
      };
      sonarr = {
        image = "lscr.io/linuxserver/sonarr:latest";
        ports = [
          "8989:8989/tcp"
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
          "traefik.http.routers.sonarr.rule" = "Host(`sonarr.asgard`)";
        };
        autoStart = true;
      };
      prowlarr = {
        image = "lscr.io/linuxserver/prowlarr:latest";
        ports = [
          "9696:9696/tcp"
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
          "traefik.http.routers.prowlarr.rule" = "Host(`prowlarr.asgard`)";
        };
        autoStart = true;
      };
    };
  };
}
