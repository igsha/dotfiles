--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Actions.FloatKeys
import XMonad.Actions.NoBorders
import XMonad.Actions.Volume

import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect

import XMonad.ManageHook
import XMonad.Util.WindowProperties

import Data.Monoid
import Data.Ratio ((%))

import System.Exit
import Autostart

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1:term","2:web","3:gvim","4:im","5:mail","6:vbox","7:game",
                   "8", "9", "0", "-", "="]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myScreenLock = "xscreensaver-command -l"

------------------------------------------------------------------------

xF86AudioRaiseVolume, xF86AudioLowerVolume, xF86AudioMute,
    xF86Sleep, xF86HomePage, xF86Mail, xF86Search, xF86Tools, xF86Calculator,
    xF86AudioPrev, xF86AudioPlay, xF86AudioNext, xF86AudioMedia :: KeySym

xF86AudioRaiseVolume = 0x1008ff13
xF86AudioLowerVolume = 0x1008ff11
xF86AudioMute = 0x1008ff12
xF86Sleep = 0x1008ff2f
xF86HomePage = 0x1008ff18
xF86Mail = 0x1008ff19
xF86Search = 0x1008ff1b
xF86Tools = 0x1008ff81
xF86Calculator = 0x1008ff1d
xF86AudioPrev = 0x1008ff16
xF86AudioPlay = 0x1008ff14
xF86AudioNext = 0x1008ff17
xF86AudioMedia = 0x1008ff32

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    , ((modm .|. controlMask,  xK_Return), spawn "tilda")
    -- launch dmenu
    , ((modm,               xK_r     ), spawn "dmenu_run")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm .|. shiftMask, xK_Tab   ), windows W.focusUp)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm .|. shiftMask, xK_t     ), withFocused $ float)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    , ((modm .|. shiftMask, xK_b     ), withFocused toggleBorder)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0, xK_minus, xK_equal])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,s}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    {-
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_s] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    -}
    -- Additioanl keys
    [((modm .|. shiftMask, xK_l), spawn myScreenLock)
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")]
    ++
    -- Multimedia keys
    [ ((0, xF86AudioRaiseVolume),       setMute False >> raiseVolume 5 >> return ())
    , ((0, xF86AudioLowerVolume),       setMute False >> lowerVolume 5 >> return ())
    , ((0, xF86AudioMute),              toggleMute >> return ())
    ]
    ++
    -- MPD controls
    [ ((0, xF86AudioPlay),              spawn "mpc toggle")
    , ((0, xF86AudioPrev),              spawn "mpc prev")
    , ((0, xF86AudioNext),              spawn "mpc next")
    , ((0, xF86AudioMedia),             spawn "switch-sound-card")
    ]
    ++
    -- Tools keys
    [ ((0, xF86Sleep),                  spawn myScreenLock)
    , ((0, xF86HomePage),               return ())
    , ((0, xF86Mail),                   return ())
    , ((0, xF86Search),                 spawn "translate")
    , ((0, xF86Calculator),             spawn "galculator")
    , ((0, xF86Tools),                  return ())
    ] ++
    -- Language layout switch through kbdd
    [ ((0, xK_Scroll_Lock),                spawn "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout")
    , ((shiftMask , xK_Caps_Lock),         spawn "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout")
    ] ++
    -- Moving floating window with key
    [((c .|.  m, k), withFocused $ f (d x))
         | (d, k) <- zip [\a->(a, 0), \a->(0, a), \a->(0-a, 0), \a->(0, 0-a)] [xK_Right, xK_Down, xK_Left, xK_Up]
         , (f, m) <- zip [keysMoveWindow, \d -> keysResizeWindow d (0, 0)] [modm, modm .|. shiftMask]
         , (c, x) <- zip [0, controlMask] [20, 2]
    ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myDefaultLayout = smartBorders $ Full ||| tiled ||| Mirror tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myImLayout = reflectHoriz $ withIM (1%7) (ClassName "Skype" `And` (Not (Role "ConversationsWindow"))) Grid ||| Full

myLayout = onWorkspace "4:im" myImLayout $
            myDefaultLayout

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.

startTrayer w = do
    dpy <- openDisplay ""
    attr <- getWindowAttributes dpy w
    spawn $ "trayer --edge top --align left --SetDockType true --expand true --widthtype pixel --width " ++ (show (wa_x attr)) ++ " --transparent true --alpha 0 --tint 0x444444 --heighttype pixel --height " ++ (show (wa_height attr))

myManageHook = composeAll . concat $
    [
        [ className =? "URxvt" <||> className =? "Lxterminal"   --> doShift "1:term"
        , className =? "Jumanji" <||> className =? "Firefox"    --> doShift "2:web"
        , className =? "Gvim"                                   --> doShift "3:gvim"
        , className =? "Skype" <||> className =? "Pidgin"       --> doShift "4:im"
        , className =? "Thunderbird"                            --> doShift "5:mail"
        , className =? "VirtualBox"                             --> doShift "6:vbox"
        , className =? "Wine"                                   --> doShift "7:game"
        ],
        [ className =? c                                        --> doCenterFloat | c <- floatWindows],
        [ manageDocks
        , isFullscreen                                          --> doFullFloat
        ]
    ]
    where
        floatWindows = [ "Xarchiver", "Galculator", "Zenity",
                         "Ipython-python2.7", "Ipython", "Tilda", "Xmessage","Jitsi", "ffplay", "Gimp" ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook (ConfigureRequestEvent _ _ _ _ _ win x y w h _ _ _ _) = do
    isXmobar <- hasProperty (ClassName "xmobar") win
    case isXmobar of
        True -> io (startTrayer win) >> return (All True)
        _ -> return (All True)
myEventHook _ = return (All True)

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    autostart
    setWMName "LG3D" -- for LaTeXDraw and Java applications

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad =<< xmobar defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook <+> fullscreenEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
