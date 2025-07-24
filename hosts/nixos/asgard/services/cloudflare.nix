{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      cloudflared = {
        image = "cloudflare/cloudflared:latest";
        environmentFiles = [
          "/etc/cloudflared/env"
        ];
        extraOptions = [
          "--network=host"
        ];
        cmd = [
          "tunnel"
          "--no-autoupdate"
          "run"
        ];
      };
    };
  };
}
