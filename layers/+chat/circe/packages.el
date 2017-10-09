(setq circe-packages '(general circe circe-notifications))

(defun circe/post-init-persp-mode ()
  (with-eval-after-load 'persp-mode
    (push
     (lambda (b)
       (-contains-p
        '(circe-server-mode circe-channel-mode)
        (buffer-local-value 'major-mode b)))
     persp-filter-save-buffers-functions)))

(defun slack/post-init-flyspell ()
  (add-hook 'lui-mode-hook 'flyspell-mode))

(defun circe/init-circe ()
  (use-package circe
    :defer t
    :init
    (spacemacs/set-leader-keys
      "aic" 'circe/my-irc)
    :config
    (progn
      (enable-circe-color-nicks)
      (spacemacs|define-transient-state circe
        :title "Circe Tracking State"
        :bindings
        ("n" tracking-next-buffer "next")
        ("N" tracking-previous-buffer "previous")
        ("p" tracking-previous-buffer "previous")
        ;; ("K" circe-leave-chell "kill")
        ("q" nil "quit" :exit t))
      (add-hook 'circe-mode-hook #'evil-normalize-keymaps)
      (general-evil-define-key '(normal) circe-mode-map
        ",b" #'helm-circe-by-server
        ",r" #'circe-reconnect
        ",t" #'spacemacs/circe-transient-state/body))))
