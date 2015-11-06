import XMonad
import XMonad.Actions.GridSelect
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.SetWMName

main = xmonad $ defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    , borderWidth = 1
    , startupHook = setWMName "LG3D"
    } `additionalKeys` [ ((mod4Mask, xK_s), spawnSelected defaultGSConfig ["emacs&", "chromium&"]) ]
