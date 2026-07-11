{ pkgs, lib, ... }:

{
  networking.firewall.extraCommands = ''
    ip46tables -t mangle -I POSTROUTING -p tcp -m multiport --dports 443,80 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
  '';

  systemd.packages = [
    (pkgs.runCommand "machines" {
      preferLocalBuild = true;
      allowSubstitutes = false;
    } ''
      mkdir -p $out/etc/systemd/system/
      ln -s ${pkgs.zapret2}/lib/systemd/system/nfqws2@.service $out/etc/systemd/system/nfqws2@pgts.service
    '')
  ];

  # DOMAINS="youtube.com" IPVS=4 ENABLE_HTTP3=0 ENABLE_HTTP=0 ENABLE_HTTPS_TLS12=0 ENABLE_HTTPS_TLS13=1 REPEATS=1 SCANLEVEL=quick TEST=standard SKIP_DNSCHECK=1 CURL_HTTPS_GET=1 blockcheck2
  environment = let
    fast-check-nfqws2 = pkgs.writeShellApplication {
      name = "fast-check-nfqws2.sh";
      text = ''
        nfqws2 --debug --qnum 200 --lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-lib.lua" --lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-antidpi.lua" "$@"
      '';
    };

  in {
    systemPackages = [ pkgs.zapret2 fast-check-nfqws2 ];
    etc."zapret2/pgts.conf".text = ''
      --qnum 200
      --lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-lib.lua"
      --lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-antidpi.lua"

      --hostlist-domains=youtube.com,googlevideo.com,ytimg.com,youtu.be,doubleclick.net,ggpht.com,yt3.googleusercontent.com
      --payload=tls_client_hello
      --lua-desync=multidisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1

      --new=megaplay
      --hostlist-domains=megaplay.buzz,anikototv.to,iwara.tv,pornhub.org,phncdn.com,vidwish.live,instagram.com,cdninstagram.com
      --payload=tls_client_hello
      --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1

      --new=cloudfront
      --hostlist-domains=cloudfront.net,x.com,twimg.com,twitter.com
      --payload=tls_client_hello
      --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1

      --new=playgoogle
      --hostlist-domains=play.google.com
      --payload=tls_client_hello
      --lua-desync=tcpseg:pos=0,midsld:ip_id=rnd:repeats=1

      --new=facebook
      --hostlist-domains=facebook.com
      --payload=tls_client_hello
      --lua-desync=multidisorder:pos=1,midsld

      --new=fbcdn
      --hostlist-domains=fbcdn.net
      --payload=tls_client_hello
      --lua-desync=tcpseg:pos=0,-1:seqovl=1
      --lua-desync=drop
    '';
  };
}
