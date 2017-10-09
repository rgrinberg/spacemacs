(defun circe/network-connected-p (network)
  "Return non-nil if there's any Circe server-buffer whose
`circe-server-netwok' is NETWORK."
  ;; need this to be callable from use-package
  (when (boundp 'circe-server-buffers)
    (catch 'return
      (dolist (buffer (circe-server-buffers))
        (with-current-buffer buffer
          (if (string= network circe-server-network)
              (throw 'return t)))))))

;; TODO rewrite the stuff below so that we don't call with-current-buffer over
;; and over
(defun circe/maybe-connect (network)
  "Connect to NETWORK, but ask user for confirmation if it's
already been connected to."
  (interactive "sNetwork: ")
  (if (or (not (circe/network-connected-p network))
          (y-or-n-p (format "Already connected to %s, reconnect?" network)))
      (circe network)))

(defun circe/my-irc ()
  "connect to freenode/gitter/oftc/mozilla"
  (interactive)
  (dolist (net '("Freenode" "gitter"))
    (circe/maybe-connect net)))
