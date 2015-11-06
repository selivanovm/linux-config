import XMonad
import XMonad.Actions.GridSelect
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.SetWMName
import Graphics.X11.ExtraTypes.XF86

main = xmonad $ defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    , borderWidth = 1
    , startupHook = setWMName "LG3D"
    } `additionalKeys` [ ((mod4Mask, xK_s)                     , spawnSelected defaultGSConfig ["emacs&", "chromium&"])
                       , ((0, xF86XK_MonBrightnessDown)        , spawn "xbacklight -dec 20")
                       , ((0, xF86XK_MonBrightnessUp)          , spawn "xbacklight -inc 20")]
