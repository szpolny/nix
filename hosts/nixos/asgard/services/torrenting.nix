{config, ...}: let
  secretPath = config.services.onepassword-secrets.secretPaths.mullvad;
in {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      gluetun = {
        image = "qmcgaw/gluetun:latest";
        environment = {
          VPN_SERVICE_PROVIDER = "mullvad";
          VPN_TYPE = "wireguard";
          WIREGUARD_ADDRESSES = "10.72.111.58/32";
        };
        extraOptions = ["-e WIREGUARD_PRIVATE_KEY=\"$(cat ${secretPath})\""];
        volumes = [
          "/etc/gluetun:/gluetun"
        ];
        ports = [
          "8888:8080" # qBittorrent Web UI
          "29206:29206" # qBittorrent Torrenting Port
          "29206:29206/udp" # qBittorrent Torrenting Port
        ];
        autoStart = true;
      };
      qbittorrent = {
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
