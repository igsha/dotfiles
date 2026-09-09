{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arp-scan
    wget links2 httpie
    mtr nethogs ngrep nmap bind iftop wireshark-cli tcpdump
    samba cifs-utils
  ];
}
