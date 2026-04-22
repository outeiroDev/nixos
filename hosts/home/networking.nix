{ config, ... }:

{
  networking = {
    hostName = "home";
    domain = "outeiro.dev";

    wg-quick.interfaces = {
      sensesbit = {
        autostart = true;
        address = [
          "10.8.0.11/24"
        ];
        privateKeyFile = config.age.secrets.wg-private-key.path;

        peers = [
          {
            publicKey = "6M2dHabm58GWGiZioJvD9rJfn/0Cr00ybn8RUwaCcSs=";
            presharedKeyFile = config.age.secrets.wg-preshared-key.path;
            allowedIPs = [
              "188.245.45.202/32"
              "10.50.0.0/16"
              "10.8.0.0/24"
            ];
            persistentKeepalive = 0;
            endpoint = "188.245.80.102:51820";
          }
        ];
      };
    };
  };
}
