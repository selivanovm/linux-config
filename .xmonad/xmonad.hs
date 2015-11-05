import XMonad
import XMonad.Actions.GridSelect
import XMonad.Util.EZConfig(additionalKeys)

main = xmonad $ defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    , borderWidth = 3
    } `additionalKeys` [ ((mod4Mask, xK_s), spawnSelected defaultGSConfig ["emacs&", "chromium&"]) ]

