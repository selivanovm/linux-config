(require 'package)
;; declare repositories that will be used by package.el
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))

;; load packages installed with package manager
(package-initialize)

(let* ((pack-names '("foundation-pack"
                     "colour-pack"
                     "lang-pack"
                     "power-pack"
                     "git-pack"
                     "org-pack"
                     "clojure-pack"
                     "bindings-pack"
                     ))
       (live-dir (file-name-as-directory "stable"))
       (dev-dir  (file-name-as-directory "dev")))

  (setq live-packs (mapcar (lambda (p) (concat live-dir p)) pack-names) )
  (setq live-dev-pack-list (mapcar (lambda (p) (concat dev-dir p)) pack-names) ))

;; my stuff
;; (set-default-font " -unknown-Ubuntu Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")

;; (projectile-global-mode)

(setq org-todo-keywords
   '((sequence "TODO" "IN-PROGRESS" "IN-REVIEW" "|" "DONE" "DELEGATED" "CANCELED")))

(add-hook 'php-mode-hook
          '(lambda ()
             (auto-complete-mode t)
             (require 'ac-php)
             (setq ac-sources  '(ac-source-php ) )
             (yas-global-mode 1)
             (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
             (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back)    ;go back
             ))
