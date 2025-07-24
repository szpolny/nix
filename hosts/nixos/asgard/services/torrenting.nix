{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      gluetun = {
        image = "qmcgaw/gluetun:latest";
        environment = {
          VPN_SERVICE_PROVIDER = "mullvad";
          VPN_TYPE = "openvpn";
          TZ = "Europe/Warsaw";
        };
        environmentFiles = [
          "/etc/gluetun/env"
        ];
        capabilities = {
          NET_ADMIN = true;
        };
        volumes = [
          "/etc/gluetun:/gluetun"
        ];
        ports = [
          "8888:8080" # qBittorrent Web UI
          "29206:29206" # qBittorrent Torrenting Port
          "29206:29206/udp" # qBittorrent Torrenting Port
        ];
        autoStart = true;
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.gluetun.entrypoints" = "web";
          "traefik.http.routers.gluetun.rule" = "Host(`qbittorrent.asgard`)";
          "traefik.http.routers.gluetun.service" = "gluetun";
          "traefik.http.services.gluetun.loadbalancer.server.port" = "8080";
        };
      };
      qbittorrent = {
        dependsOn = ["gluetun"];
        image = "lscr.io/linuxserver/qbittorrent:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Warsaw";
          WEBUI_PORT = "8080";
          TORRENTING_PORT = "29206";
        };
        volumes = [
          "/etc/qbittorrent:/config"
          "/media/downloads:/downloads"
        ];
        autoStart = true;
        extraOptions = ["--network=container:gluetun"];
      };
    };
  };
}
