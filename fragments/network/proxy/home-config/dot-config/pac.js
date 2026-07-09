function FindProxyForURL(url, host) {
    var proxyList = [
        "facebook.com",
        "t.me",
        "telegram.org",
        "reactor.cc",
        "reactor.com",
    ];

    for (var i = 0; i < proxyList.length; ++i) {
        if (shExpMatch(host, "*" + proxyList[i])) {
            console.warn("PROXY", host, "matcher", "*" + proxyList[i]);
            return "PROXY localhost:11080";
        }
    }

    return "DIRECT";
}
