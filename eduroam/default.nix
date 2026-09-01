{ config, lib, ... }:
{
  options.assr.eduroam = {
    enable = lib.mkEnableOption "GT eduroam NetworkManager connection";
    client-cert = lib.mkOption {
      description = "Client (your) certificate (P12 format); must be wpa_supplicant:wpa_supplicant 0400.";
      type = lib.types.path;
    };
    env = lib.mkOption {
      description = "Environment file that sets $EDUROAM_PRIVATE_KEY_PASSWORD with passphrase; should be readable by root only";
      type = lib.types.path;
    };
  };

  config =
    let
      cfg = config.assr.eduroam;
    in
    lib.mkIf config.assr.eduroam.enable {
      systemd.services.wpa_supplicant.serviceConfig.BindReadOnlyPaths = cfg.client-cert;
      networking.networkmanager.ensureProfiles.environmentFiles = [
        cfg.env
      ];
      networking.networkmanager.ensureProfiles.profiles.eduroam = {
        "802-1x" = {
          ca-cert = "${./usertrustrsaca.cer}";
          client-cert = cfg.client-cert;
          domain-suffix-match = "lawn.gatech.edu";
          eap = "tls;";
          identity = "kshibata6@gatech.edu";
          private-key = cfg.client-cert;
          private-key-password = "$EDUROAM_PRIVATE_KEY_PASSWORD";
        };
        connection = {
          id = "eduroam (GT)";
          type = "wifi";
          uuid = "a22a03f6-ddb5-455c-80f2-024cfc52266a";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };
        proxy = { };
        wifi = {
          mode = "infrastructure";
          ssid = "eduroam";
        };
        wifi-security = {
          key-mgmt = "wpa-eap";
        };
      };
    };
}
