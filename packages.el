(require 'package)
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;;                         ("technomancy" . "http://repo.technomancy.us/emacs/")
(package-initialize)
(defvar syl:packages
  '(
    ace-jump-mode
    auto-complete
    auto-dictionary
    buffer-move
    cmake-mode
    color-moccur
    csharp-mode
    dash
    deft
    deferred
    diminish
    dired+
    elisp-slime-nav
    epc
    erc
    erlang
    evil
    evil-leader
    expand-region
    fill-column-indicator
    find-file-in-project
    flycheck
    flycheck-color-mode-line
    fuzzy
    ghc
    google-translate
    haskell-mode
    helm
    helm-c-yasnippet
    helm-projectile
    htmlize
    jedi
    json-mode
    less-css-mode
    magit
    markdown-mode
    move-text
    multi-term
    org
    p4
    page-break-lines
    paredit
    popup
    popwin
    projectile
    puppet-mode
    python
    quickrun
    rainbow-delimiters
    recentf
    rfringe
    ruby-end
    ruby-mode
    ruby-test-mode
    s
    smart-operator
    smartparens
    ;; sr-speedbar
    string-edit
    stripe-buffer
    subword
    surround
    tagedit
    twittering-mode
    visual-regexp-steroids
    wdired
    window-layout
    yasnippet
    ))

;;; install missing packages
(let ((not-installed (remove-if 'package-installed-p syl:packages)))
  (if not-installed
      (if (y-or-n-p (format "there are %d packages to be installed. install them? " (length not-installed)))
          (progn (package-refresh-contents)
                 (dolist (package syl:packages)
                   (when (not (package-installed-p package))
                     (package-install package)))))))

;;; initialize packages
(setq syl:package-init-dir (concat user-emacs-directory "init-package/"))
(message (format "initializing packages out of %s" syl:package-init-dir))
(dolist (package (append (mapcar 'car package--builtins) package-activated-list))
    (let* ((initfile (concat syl:package-init-dir (format "init-%s.el" package))))
      (if (and (package-installed-p package)
               (file-exists-p initfile))
          (progn (load initfile)
                 (message (format "loaded %s" initfile))))))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'packages)
