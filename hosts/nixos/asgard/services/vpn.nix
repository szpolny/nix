{
  pkgs,
  config,
  ...
}: {
  services.tailscale.enable = true;

  systemd.services.tailscale-autoconnect = {
    description = "Tailscale Autoconnect";

    after = ["network-pre.target" "tailscale.service" "onepassword-secrets.service"];
    wants = ["network-pre.target" "tailscale.service" "onepassword-secrets.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig.Type = "oneshot";

    script = ''      # wait for tailscaled to settle
          sleep 2

          # check if we are already authenticated to tailscale
          status="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
          if [ $status = "Running" ]; then # if so, then do nothing
            exit 0
          fi

          # otherwise authenticate with tailscale
          ${pkgs.tailscale}/bin/tailscale up -authkey $(cat ${config.services.onepassword-secrets.secretPaths.tailscalePassword})
    '';
  };
}
