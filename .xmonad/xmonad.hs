import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.GroupNavigation

import XMonad.Layout.IndependentScreens as LIS
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import Graphics.X11.ExtraTypes.XF86

import Data.IORef
import System.IO

toggleExternalScreen :: IORef Bool -> X ()
toggleExternalScreen ref = do
  externalScreenEnabled <- io $ fmap not $ readIORef ref
  io $ writeIORef ref externalScreenEnabled
  if externalScreenEnabled
    then spawn "xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --mode 1920x1080 --rotate left --right-of eDP1"
    else spawn "xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --off"

main = do
  xmproc <- spawnPipe "xmobar"

  externalScreenState <- newIORef False

  xmonad $ defaultConfig
    { manageHook = manageDocks <+> (isFullscreen --> doFullFloat) <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
                  { ppOutput = hPutStrLn xmproc
                  , ppTitle = xmobarColor "green" "" . shorten 50
                  }

    , terminal    = "urxvt"
    , modMask     = mod4Mask
    , borderWidth = 1
    , startupHook = setWMName "LG3D"
    } `additionalKeys` [ ((mod4Mask, xK_s)                     , spawnSelected defaultGSConfig ["emacs&", "chromium&", "lucidor&"])
                       , ((mod4Mask, xK_i)                     , spawn "/home/ubear/bin/idea/bin/idea.sh")
                       , ((mod4Mask, xK_n)                     , spawn "touch ~/.pomodoro_session")
                       , ((mod4Mask, xK_l)                     , spawn "xscreensaver-command -lock")
                       , ((0, xF86XK_Display)                  , toggleExternalScreen externalScreenState)
                       , ((0, xF86XK_MonBrightnessDown)        , spawn "xbacklight -dec 10")
                       , ((0, xF86XK_MonBrightnessUp)          , spawn "xbacklight -inc 10")
                       , ((0, xF86XK_AudioLowerVolume)         , spawn $ changeVolumeCmd "-")
                       , ((0, xF86XK_AudioRaiseVolume)         , spawn $ changeVolumeCmd "+")
                       , ((0, xF86XK_AudioMute)                , spawn "sh -c \"pactl set-sink-mute 0 toggle\"")
                       , ((mod1Mask, xK_Tab)                   , nextMatch Backward (return True))
                       , ((mod1Mask .|. shiftMask, xK_Tab)     , nextMatch Forward (return True))

                       ]

changeVolumeCmd :: String -> String
changeVolumeCmd sign = "sh -c \"pactl set-sink-mute 0 false ; pactl set-sink-volume 0 " ++ sign ++ "5%\""
