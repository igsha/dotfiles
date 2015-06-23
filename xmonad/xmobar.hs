Config {
         -- font = "xft:terminus:size=9"
         font = "-*-terminus-*-*-*-*-12-*-*-*-*-*-*-*"
       , bgColor = "#444444"
       , fgColor = "#c0c0c0"
       , border = NoBorder
       , borderColor = "black"
       , position = TopW R 92
       , lowerOnStart = False
       , hideOnStart = False
       , persistent = True
       , commands = [ Run Memory ["-t","<icon=.xmonad/xbm8x8/mem.xbm/> <usedratio>%", "-w", "2"] 10
                    , Run MultiCpu ["-w", "3", "-c", " ", "-L", "5", "-H", "50", "--normal", "#ffc0cb", "--high", "#ff69b4", "-t", "<icon=.xmonad/xbm8x8/cpu.xbm/> <total>%"] 20
                    , Run Date "%a %Y-%b-%d %H:%M" "date" 10
                    , Run StdinReader
                    , Run Weather "UUEE" ["-t","<tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 6000
                    -- , Run Network "eth0" ["-L","0","-H","32","-w", "3", "--normal","green","--high","red"] 30
                    , Run Network "wlp6s0" ["-t", "<icon=.xmonad/xbm8x8/wifi_02.xbm/> <rx>KB:<tx>KB", "-L","0","-H","32","-w", "3", "--normal","green","--high","red"] 30
                    , Run Kbd [("us", "US"), ("ru", "RU")]
                    , Run Volume "default" "Master" ["-t", "<icon=.xmonad/xbm8x8/spkr_01.xbm/> <volume>%<status>"] 20
                    -- , Run BatteryP ["BAT0"] ["-t", "<left>% (<timeleft>) [<acstatus>]", "-L", "10", "-H", "80", "-p", "3", "--",
                       -- "-O","<fc=green>On</fc>", "-o", "<fc=red>Off</fc>", "-f", "/sys/class/power_supply/ADP1/online"] 60
                    , Run Locks
                    , Run Com ".xmonad/xmobar-trayer.sh" [] "trayer" 0
                    , Run CoreTemp ["-t", "<icon=.xmonad/xbm8x8/temp.xbm/> <core0>:<core1>:<core2>:<core3>C", "-L", "40", "-H", "87", "-l", "lightblue", "-n", "gray90", "-h", "red"] 70
                    --, Run DiskIO [("/", "root: <read>/<write>"), ("sda3", "home: <read>/<write>")] [] 50
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%trayer%%StdinReader% }{%locks% | %kbd% | <action=pavucontrol>%default:Master%</action> | %coretemp% | %multicpu% | %memory% | %wlp6s0% | %UUEE% | <action=xclock -update 1><fc=#ee9a00>%date%</fc></action>"
       }
