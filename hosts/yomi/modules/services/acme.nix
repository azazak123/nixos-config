{ config, lib, pkgs, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "azazaka2002@gmail.com";
    certs."azazak123.dedyn.io" = {
      domain = "*.azazak123.dedyn.io";
      extraDomainNames = [ "azazak123.dedyn.io" ];
      dnsProvider = "desec";
      dnsPropagationCheck = true;
      environmentFile = "/etc/nixos/secrets/acme-desec-env";
      group = "nginx";
    };
  };
}
