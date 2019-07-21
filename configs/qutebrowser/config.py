import os

#c.qt.force_software_rendering = True
c.editor.command = [os.environ['TERMINAL'], '-c', 'editor', '-e', 'nvim', '{}']

c.downloads.position = 'bottom'
c.downloads.location.directory = '~/Downloads'

c.scrolling.bar = 'always'

c.window.title_format = '{perc}{title}{title_sep}qutebrowser{private}'

c.completion.web_history.max_items = 100

c.input.partial_timeout = 2000

c.tabs.background = True
c.tabs.title.format = '{index}: {title}{private}'

c.content.user_stylesheets = 'scrollbar.css'
c.content.plugins = True
c.content.geolocation = True
#c.content.cookies.accept = 'no-unknown-3rdparty'
c.content.host_blocking.enabled = False

config.set('auto_save.session', True)
c.session.lazy_restore = True

c.hints.chars = 'asdfghjklqwertyuiopzxcvbnm'
c.hints.next_regexes = [r'\bДальше\b', r'\bВпер(е|ё)д\b', r'\bСледующая\b']
c.hints.prev_regexes = [r'\bНазад\b']

c.url.default_page = 'DEFAULT'
c.url.start_pages = ['https://nixos.org']
c.url.searchengines = {
    'google': 'https://www.google.com/search?q={}',
    'youtube': 'https://www.youtube.com/results?search_query={}',
    'goosh': 'https://goosh.org/#{}',
    'translate': 'https://translate.yandex.ru/?text={}',
    'wikipedia': 'https://ru.wikipedia.org/wiki/{}',
    'enwikipedia': 'https://en.wikipedia.org/wiki/{}',
    'cppreference': 'http://cppreference.com/?search={}',
    'github': 'https://github.com/search?q={}',
    'cmake': 'https://cmake.org/cmake/help/latest/search.html?q={}',
    'DEFAULT': 'https://www.google.com/search?q={}',
}

c.aliases['defproxy'] = 'set content.proxy system'
c.aliases['noproxy'] = 'set content.proxy none'
c.aliases['tor'] = 'set content.proxy socks://localhost:9050'
c.aliases['play'] = 'spawn {} -c popup -e iplay -b {{url}}'.format(os.environ['TERMINAL'])
c.aliases['tplay'] = 'spawn {} -c popup -e iplay -t -b {{url}}'.format(os.environ['TERMINAL'])

config.bind('t', 'set-cmd-text -s :open -t')
config.bind('O', 'set-cmd-text :open {url:pretty}')
config.bind('T', 'set-cmd-text -s :open -t {url:pretty}')
config.bind('D', 'tab-prev ;; tab-close')
config.bind('gj', 'tab-focus')
config.bind('gt', 'tab-next')
config.bind('<Ctrl-Tab>', 'tab-next')
config.bind('gT', 'tab-prev')
config.bind('<Ctrl-Shift-Tab>', 'tab-prev')
config.bind('gD', 'download')
config.bind('gd', 'download-open')
config.bind('gv', 'set-cmd-text -s :buffer')
config.bind(';m', 'hint links spawn mpv --load-unsafe-playlists {hint-url}')
config.bind(';M', 'hint links spawn torsocks mpv --load-unsafe-playlists {hint-url}')
config.bind(';p', 'hint links spawn google-chrome-stable --incognito {hint-url}')
config.bind(';P', 'spawn google-chrome-stable --incognito {url}')
config.bind(';v', 'hint links spawn youtube-dl {hint-url} --exec "viewnior {}"')
config.bind(';l', 'hint links spawn {} -c popup -e iplay -b {{hint-url}}'.format(os.environ['TERMINAL']))
config.bind(';L', 'hint links spawn {} -c popup -e iplay -t -b {{hint-url}}'.format(os.environ['TERMINAL']))
