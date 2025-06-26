config.load_autoconfig(False)

c.colors.statusbar.command.private.bg = "black"
c.completion.web_history.max_items = 100
c.content.blocking.enabled = False
c.content.geolocation = True
c.content.plugins = True
c.content.user_stylesheets = "scrollbar.css"
c.downloads.location.directory = "~/Downloads"
c.downloads.position = "bottom"
c.editor.command = ["alacritty", "--class", "editor", "-e", "nvim", "{}"]
c.hints.chars = "asdfghjklqwertyuiopzxcvbnm"
c.hints.next_regexes = ["\\bДальше\\b", "\\bВпер(е|ё)д\\b", "\\bСледующая\\b"]
c.hints.prev_regexes = ["\\bНазад\\b"]
c.input.partial_timeout = 2000

c.tabs.background = True
c.tabs.show = "always"
c.tabs.title.format = "{index}: {current_title}{private}"

c.url.start_pages = "https://nixos.org"
c.window.title_format = "{perc}{current_title}{title_sep}qutebrowser{private}"
c.session.lazy_restore = True
c.auto_save.session = True
c.scrolling.bar = "always"

c.aliases['defproxy'] = "set content.proxy system"
c.aliases['noproxy'] = "set content.proxy none"
c.aliases['play'] = "spawn alacritty --class popup -e iplay -b {url}"
c.aliases['tor'] = "set content.proxy socks://localhost:9050"

c.url.searchengines['DEFAULT'] = "https://www.google.com/search?q={}"
c.url.searchengines['cmake'] = "https://cmake.org/cmake/help/latest/search.html?q={}"
c.url.searchengines['cppreference'] = "https://duckduckgo.com/?sites=cppreference.com&q={}"
c.url.searchengines['enwikipedia'] = "https://en.wikipedia.org/wiki/{}"
c.url.searchengines['github'] = "https://github.com/search?q={}"
c.url.searchengines['google'] = "https://www.google.com/search?q={}"
c.url.searchengines['goosh'] = "https://goosh.org/#{}"
c.url.searchengines['translate'] = "https://translate.yandex.ru/?text={}"
c.url.searchengines['wikipedia'] = "https://ru.wikipedia.org/wiki/{}"
c.url.searchengines['youtube'] = "https://www.youtube.com/results?search_query={}"
c.url.searchengines['ya'] = "https://ya.ru/search/?text={}"
c.url.searchengines['duck'] = "https://duckduckgo.com/?q={}"
c.url.searchengines['rutube'] = "https://rutube.ru/search/?query={}"

config.bind(";M", "hint links spawn torsocks mpv --load-unsafe-playlists {hint-url}", mode="normal")
config.bind(";P", "spawn google-chrome-stable --incognito {url}", mode="normal")
config.bind(";b", "cmd-set-text -s :tab-select", mode="normal")
config.bind(";l", "hint links spawn alacritty --class popup -e iplay -b {hint-url}", mode="normal")
config.bind(";m", "hint links spawn mpv --load-unsafe-playlists {hint-url}", mode="normal")
config.bind(";p", "hint all spawn google-chrome-stable --incognito {hint-url}", mode="normal")
config.bind("<Ctrl-Shift-Tab>", "tab-prev", mode="normal")
config.bind("<Ctrl-Tab>", "tab-next", mode="normal")
config.bind("D", "tab-prev ;; tab-close", mode="normal")
config.bind("O", "cmd-set-text :open {url:pretty}", mode="normal")
config.bind("T", "cmd-set-text -s :open -t {url:pretty}", mode="normal")
config.bind("gD", "download", mode="normal")
config.bind("gT", "tab-prev", mode="normal")
config.bind("gd", "download-open", mode="normal")
config.bind("gt", "tab-next", mode="normal")
config.bind("t", "cmd-set-text -s :open -t", mode="normal")
config.bind(",p", "spawn --userscript ~/.config/qutebrowser/qute-pass.sh")
config.bind(",d", "spawn --userscript ~/.config/qutebrowser/qute-pass.sh -d")
config.bind(",a", "spawn --userscript ~/.config/qutebrowser/qute-pass.sh -a")
