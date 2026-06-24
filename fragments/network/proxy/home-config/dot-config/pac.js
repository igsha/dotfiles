function FindProxyForURL(url, host) {
    var proxyList = [
        "youtube.com",
        "yutu.be",
        "doubleclick.net",
        "ytimg.com",
        "googlevideo.com",
        "ggpht.com",
        "instagram.com",
        "facebook.com",
        "wara.tv",
        "t.me",
        "telegram.org",
    ];

    for (var i = 0; i < proxyList.length; ++i) {
        if (shExpMatch(host, "*" + proxyList[i])) {
            console.warn("PROXY", host, "matcher", "*" + proxyList[i]);
            return "PROXY localhost:11080";
        }
    }

    return "DIRECT";
}
