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
    } `additionalKeys` [ ((mod4Mask, xK_s)                     , spawnSelected defaultGSConfig ["emacs&", "chromium&"])
                       , ((mod4Mask, xK_i)                     , spawn "/home/ubear/bin/idea")
                       , ((0, xF86XK_MonBrightnessDown)        , spawn "xbacklight -dec 20")
                       , ((0, xF86XK_MonBrightnessUp)          , spawn "xbacklight -inc 20")]
