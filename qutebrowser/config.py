c.backend = 'webkit'

c.editor.command = ['urxvt', '-name', 'editor', '-e', 'nvim', '{}']

#c.content.developer_extras = True
c.downloads.position = 'bottom'
c.downloads.location.directory = '~/Downloads'

c.scrolling.bar = True

c.window.title_format = '{perc}{title}{title_sep}qutebrowser{private}'

c.completion.web_history_max_items = 100

c.input.partial_timeout = 2000

c.tabs.background = True
c.tabs.title.format = '{index}: {title}{private}'

c.content.user_stylesheets = 'scrollbar.css'
c.content.plugins = True
c.content.geolocation = True
#c.content.cookies.accept = 'no-unknown-3rdparty'
c.content.host_blocking.enabled = False

c.hints.chars = 'asdfghjklqwertyuiopzxcvbnm'
c.hints.next_regexes += [r'\bmore$$\b', r'\bдальше\b', r'\bnachher\b', r'\bвпер(е|ё)д\b']
c.hints.prev_regexes += [r'\bназад\b', r'\bvorher\b']

c.url.default_page = 'DEFAULT'
c.url.start_pages = ['DEFAULT']
c.url.searchengines = {
    'kinopoisk': 'http://www.kinopoisk.ru/index.php?first=no&what=&kp_query={}',
    'google': 'https://www.google.com/search?q={}',
    'youtube': 'https://www.youtube.com/results?search_query={}',
    'goosh': 'https://goosh.org/#{}',
    'multitran': 'http://www.multitran.com/m.exe?s={}&l1=1&l2=2',
    'wikipedia': 'https://ru.wikipedia.org/wiki/{}',
    'enwikipedia': 'https://en.wikipedia.org/wiki/{}',
    'duckduckgo': 'https://duckduckgo.com/?q={}',
    'cppreference': 'http://cppreference.com/?search={}',
    'github': 'https://github.com/search?q={}',
    'cmake': 'https://cmake.org/cmake/help/latest/search.html?q={}',
    'DEFAULT': 'https://www.google.com/search?q={}',
}

c.aliases['private'] = 'set content.private_browsing true'
c.aliases['noprivate'] = 'set content.private_browsing false'
c.aliases['noproxy'] = 'set content.proxy system'
c.aliases['tor'] = 'set content.proxy socks://localhost:9050'

config.bind('O', 'set-cmd-text :open {url:pretty}')
config.bind('t', 'set-cmd-text -s :open -t')
config.bind('D', 'tab-prev ;; tab-close')
config.bind('gj', 'tab-focus')
config.bind('gt', 'tab-next')
config.bind('<Ctrl-Tab>', 'tab-next')
config.bind('gT', 'tab-prev')
config.bind('<Ctrl-Shift-Tab>', 'tab-prev')
config.bind('Th', 'back -t')
config.bind('Tl', 'forward -t')
config.bind('gD', 'download')
config.bind('gd', 'download-open')
config.bind('gv', 'set-cmd-text -s :buffer')
config.bind(';m', 'hint links spawn mpv --load-unsafe-playlists {hint-url}')
config.bind(';M', 'hint links spawn torsocks mpv --load-unsafe-playlists {hint-url}')
config.bind(';p', 'hint links spawn google-chrome-stable --incognito {hint-url}')
config.bind(';P', 'spawn google-chrome-stable --incognito {url}')
