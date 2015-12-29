import XMonad
import XMonad.Actions.GridSelect

import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import Graphics.X11.ExtraTypes.XF86

import System.IO

main = do
  xmproc <- spawnPipe "xmobar"

  xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
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
                       , ((mod4Mask, xK_i)                     , spawn "/home/ubear/bin/idea")
                       , ((mod4Mask, xK_n)                     , spawn "touch ~/.pomodoro_session")
                       , ((0, xF86XK_MonBrightnessDown)        , spawn "xbacklight -dec 10")
                       , ((0, xF86XK_MonBrightnessUp)          , spawn "xbacklight -inc 10")1
                       , ((0, xF86XK_AudioLowerVolume)         , spawn $ changeVolumeCmd "-")
                       , ((0, xF86XK_AudioRaiseVolume)         , spawn $ changeVolumeCmd "+")
                       , ((0, xF86XK_AudioMute)                , spawn "sh -c \"pactl set-sink-mute 0 toggle\"")
                       ]

changeVolumeCmd :: String -> String
changeVolumeCmd sign = "sh -c \"pactl set-sink-mute 0 false ; pactl set-sink-volume 0 " ++ sign ++ "5%\""
