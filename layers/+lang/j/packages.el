(setq j-packages
      '(
        (j-mode :location (recipe
                           :fetcher github
                           :repo "zellio/j-mode"))
        (helm-j-cheatsheet :toggle (configuration-layer/layer-usedp 'helm))
        org
        ))

(defun j/init-helm-j-cheatsheet ()
  (use-package helm-j-cheatsheet
    :defer t
    :init
    (spacemacs/set-leader-keys-for-major-mode 'j-mode
      "hc" 'helm-j-cheatsheet)))

(defun j/init-j-mode ()
  (use-package j-mode
    :defer t
    :init
    (spacemacs/register-repl 'j-mode #'j-console "j")
    (spacemacs/set-leader-keys-for-major-mode 'j-mode
      "'" 'j-console
      "hs" 'j-help-lookup-symbol
      "hh" 'j-help-lookup-symbol-at-point
      "sb" 'j-console-execute-buffer
      "sl" 'j-console-execute-line
      "sr" 'j-console-execute-region)))

(defun j/pre-init-org ()
  (spacemacs|use-package-add-hook org
    :post-config (add-to-list 'org-babel-load-languages '(J . t))))
