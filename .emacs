(mapcar					; extend load-path
 (lambda (file) (if (file-exists-p file) (add-to-list 'load-path file)))
 '("/Users/Shared/emacs"		; MAC OS
   "D:/site/lisp"			; work
   "D:/site/lisp/ess/lisp"
   ))
(setq-default
 ctl-arrow nil				; display control codes in octal
 fill-column 78
 )
(setq
 blink-matching-paren-distance nil      ; want distant matches too
 column-number-mode 1
 completion-ignored-extensions '(".O" ".o" ".elc" "~")
 confirm-kill-emacs 'yes-or-no-p
 dabbrev-case=fold-search nil           ; want case sensitivity
 desktop-load-locked-desktop nil
 desktop-not-loaded-hook (lambda ()
			   (setq desktop-save nil))
 default-major-mode 'org-mode
 inhibit-startup-message t
 isearch-case-fold-search t
 line-number-mode 1
 make-backup-files nil                  ; don't want tilde files
 next-line-add-newlines nil
 org-clock-into-drawer t
 org-log-note-clock-out t
 print-region-function nil
; ps-lpr-command "d:/sw/gs/gs8.64/bin/gswin32c.exe"
; ps-lpr-switches '("-q" "-dNOPAUSE" "-dBATCH" "-sDEVICE=mswinpr2")
; ps-printer-name t
 require-final-newline t                ; Ask if needed
 scroll-step 1
 show-paren-mode 1
 standard-display-european 1
 vc-command-messages t
 vc-handle-cvs t
 vc-mistrust-permissions t
 vc-path nil
 vc-suppress-confirm nil
 visible-bell t                         ; flash, don't beep
 )
(set 'tab-stop-list
     (let ((i 120)                      ; last tab position
           (s 4)                        ; soft tabwidth
           (v ()))                      ; vector
       (while (> i 0)
         (setq v (cons i v)
               i (- i s)))
       v))
;;(require 'ess-site)
;;(set 'ess-pre-run-hook
;;      (lambda ()
;;        (setq comint-scroll-to-bottom-on-input t
;; 	     ess-ask-for-ess-directory nil
;; 	     ess-directory "D:/R")))
;; (require 'printing)
;; (setenv "GS_LIB" "d:/sw/gs/gs8.64/lib;d:/sw/gs/gs8.64/fonts")

(info)
(set-variable 'Info-enable-edit t)

(add-hook 'comint-output-filter-functions
          'comint-strip-ctrl-m)
(add-hook 'org-ctrl-c-ctrl-c-hook
	  'org-clock-update-time-maybe)

(defun my-org-cycle-at-end-of-drawer ()
  ""
  (interactive)
  (if (save-excursion
	(beginning-of-line 1)
	(and (looking-at "[ \t]*:END:")
	     (save-excursion (re-search-backward org-drawer-regexp nil t))))
      (progn
	(goto-char (1- (match-beginning 1)))
	(setq column (current-column))
	(message "hooked my-org-cycle-at-end-of-drawer")))
  nil)
(add-hook 'org-tab-first-hook
	  'my-org-cycle-at-end-of-drawer)

(add-to-list 'auto-mode-alist '("\\.h\\'"   . c-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'"  . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(and (autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
     (add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode)))
(add-to-list 'auto-mode-alist '("\\.csl\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'". java-mode))
(and (autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
     (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
     (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode)))
(add-to-list 'auto-mode-alist '("\\.src\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tmac\\'". nroff-mode))
(and (autoload 'treetop-mode "treetop-mode" "Treetop editing mode." t)
     (add-to-list 'auto-mode-alist '("\\.treetop$" . treetop-mode))
     (add-to-list 'auto-mode-alist '("\\.tt$" . treetop-mode))
     (add-to-list 'interpreter-mode-alist '("treetop" . treetop-mode)))
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
;; (and (autoload 'wiki-mode "wiki-mode" "Mediawiki editing mode." t)
;;      (add-to-list 'auto-mode-alist '("\\.wiki\\'". wiki-mode)))

(require 'compile)
(add-to-list 'compilation-error-regexp-alist
	     (caar (add-to-list 'compilation-error-regexp-alist-alist
				'(ct-lint
				  "^\\(\\(.+\\):\\([0-9]+\\):\\([0-9]*\\)\\) \\([0-9]+\\): "
				  2 3 4 nil 1))))
;; (defun equal-car (a b)
;; ""
;; (equal (car a) (car b)))
;; (add-to-list 'compilation-error-regexp-alist-alist
;; '() t (lambda (a b) (equal (car a) (car b))))
;;     ;; PC-lint During Specific Walk
;;     ("  File \\(.+\\) line \\([0-9]+\\):" 1 2)
;;     ;; PC-lint messages at module wrap-up
;;    ("L, [a-zA-Z]+ [0-9]+: .+ (line \\([0-9]+\\), file \\([^\n)]+\\))" 2 1)
;;    ("L, [a-zA-Z]+ \\([0-9]+\\): [^\n']+ '[^\n']+' [^\n']+ '\\(.*[/\\]\\)?\\([^\n']+\\)'" 3 1) ; the line number is a lie
;;     ;; PC-lint message at block wrap-up
;; ;;    ("L, \\([^(\n]*\\)([0-9]+,[0-9]+) [^(\n]+ (line \\([0-9]+\\)" 1 2)
;;     ;; PC-lint message with blanks in file name
;; ;;    ("L, \\([^(\n]*\\)(\\([0-9]+\\),\\([0-9]+\\))" 1 2 3)
;;     )
;;   compilation-error-regexp-alist
;;   ))

;; (add-to-list 'compilation-error-regexp-alist 'pc-lint-specific-walk)


(global-font-lock-mode t)
;(add-hook 'makefile-mode 'turn-on-font-lock)
;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;(add-hook 'lisp-mode-hook 'turn-on-font-lock)
;(add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
;(add-hook 'dired-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode 'turn-on-font-lock)
(add-hook 'c++-mode 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode 'turn-on-font-lock)

(defun uniquify-region ()
  "Remove duplicate adjacent lines in the given region"
  (interactive)
  (narrow-to-region (region-beginning) (region-end))
  (beginning-of-buffer)
  (while (re-search-forward "\\(.*\n\\)\\1+" nil t)
    (replace-match "\\1" nil nil))
  (widen) nil)

(defun uniquify-buffer ()
  (interactive)
  (mark-whole-buffer)
  (uniquify-region))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun insert-date-stamp (&optional choice)
  "Inserts a date stamp sequence at the point.

The format of depends on the prefix argument:
M-x insert-date-stamp   YYYY-MM-DD
C-u M-x ...             YYYY-MM-DD-HH-MM
C-u C-u M-x ...         YYYY-MM-DD-HH-MM-SS

Negative arguments first delete old date stamps."
  (interactive "*p")
  (save-match-data
    (if (and (< choice 0)
             (looking-at "\\=[-.0123456789]+"))
        (progn
          (replace-match "")
          (set 'choice (- choice)))))
  (insert (format-time-string
           (cond ((= choice  1) "%Y-%m-%d")
                 ((= choice  4) "%Y-%m-%d-%H-%M")
                 ((= choice 16) "%Y-%m-%d-%H-%M-%S")
                 (t (error "Choice %d is invalid" choice)))
           (current-time) t )))

(defun mark-boilerplate (&optional named)
  "Set the region around the next boilerplate."
  (interactive "P")
  (save-match-data
    (let (boilerplate-beginning)
      (beginning-of-line)
      (search-forward-regexp "#\\[\\s-*\\(.*\\S-\\)\\s-*\\[")
      (goto-char (match-beginning 0))
      (beginning-of-line 2)
      (set 'boilerplate-beginning (point))
      (search-forward-regexp
       (concat "#\\]\\s-*"
               (if named (regexp-quote (match-string 1)) ".*")
               "\\s-*\\]"))
      (goto-char (match-beginning 0))
      (beginning-of-line)
      (push-mark (point) t t)
      (goto-char boilerplate-beginning))))

(defun copy-region-shifted (start end &optional gently)
  "open rectangle; copy; restore"
  (interactive "rP")
  (save-excursion
    (goto-char start)
    (if (bolp) nil (error "The region must start at the beginning of a line"))
    (set 'lines (count-lines start end))
    (open-rectangle start end (null gently))
    (goto-char start)
    (set-mark (point))
    (forward-line lines)
    (copy-region-as-kill start (point))
    (undo)))

(defun tab-to-margin-B (&optional column)
  "Tab to margin B"
  (interactive "p")
  (indent-to (if (and (numberp column) (> column 1)) column 32) 1))
(global-set-key [C-tab] 'tab-to-margin-B)

(defun save-buffer-untabified (&optional args)
  "Untabifies the buffer prior to save."
  (interactive "P")
  (if (or
       (string-equal major-mode "makefile-mode"))
      (message "Not untabifying an apparent makefile.")
    (untabify 1 (1+ (buffer-size))))
  (save-buffer args))

(defun toggle-truncate-lines ()
  "Toggles the truncate-lines variable between t and nil."
  (interactive)
  (set 'truncate-lines (null truncate-lines)))

(defun view-registers ()
  "View registers"
  (interactive)
  (if (interactive-p)
      (save-excursion
        (set-mark (point))
        (let ((c -1)
              (command 'next)
              (i 0)
              (r nil))
          (while (or (eq command 'next) (eq command 'prev))
            (set 'c (cond
                     ((eq command 'next) (1+ c))
                     ((eq command 'prev) (1- c))))
            (if (< c 0) (set 'c 255)
              (if (> c 255) (setq c 0 command 'quit)))
            (if (null (set 'r (get-register c)))
                nil
              (if (frame-configuration-p r)
                  (insert-string "#<frame configuration>")
                (if (markerp r)
                    (insert-string "#<marker>")
                  (if (window-configuration-p r)
                      (insert-string "#<window configuration>")
                    (insert-register c))))
              (message "register %c: [npq.]" c)
              (unwind-protect
                  (while
                      (null
                       (set 'command
                            (progn
                              (set 'i (read-char))
                              (cond
                               ((or (= i ?Q) (= i ?q)) 'quit)
                               ((or (= i ?n) (= i ?N) (= i ?\C-n)) 'next)
                               ((or (= i ?p) (= i ?P) (= i ?\C-p)) 'prev)
                               ((or (= i 32) (= i ?.)) 'ok))))))
                (if (eq command 'ok) nil
                  (if (or (stringp r)
                          (frame-configuration-p r)
                          (markerp r)
                          (window-configuration-p r))
                      (delete-region (point) (mark))
                    (delete-rectangle (point) (mark))))))))
          (message nil))))

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cr" 'org-remember)

(global-set-key "\C-x?" 'toggle-truncate-lines)
(global-set-key "\C-xs" 'save-buffer-untabified)
(global-set-key "\C-xrv" 'view-register)
(global-set-key "\C-xrV" 'view-registers)

(global-set-key [f1] 'list-matching-lines)
(global-set-key [f2] 'find-file)
(global-set-key [f3] 'recompile)
(global-set-key [S-f3] 'compile)
(global-set-key [f4] 'next-error)
(global-set-key [S-f4] 'previous-error)

(global-set-key [f5] 'font-lock-mode)
(global-set-key [C-f5] 'rot13-region)

(global-set-key [f8] 'speedbar-get-focus)

(global-set-key [f9] 'tags-search)
(global-set-key [f10] 'tags-query-replace)
(global-set-key [f11] 'list-tags)
(global-set-key [f12] 'tags-apropos)

(global-set-key [M-insert] 'picture-mode)
(global-set-key [delete] 'delete-char)
(global-set-key [C-return] 'goto-char)
(global-set-key [M-return] 'goto-line)
;(global-set-key (quote [C-%]) 'query-replace-regexp)

(global-set-key [C-right] 'scroll-left)
(global-set-key [C-left] 'scroll-right)

(global-set-key [kp-enter] 'newline-and-indent)
(global-set-key (quote [S-tab]) (quote hippie-expand))
(global-set-key (quote [C-end]) (quote end-of-buffer))
(global-set-key (quote [C-home]) (quote beginning-of-buffer))

;; For autocompletion (like tab in tcsh) -> shift-tab
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers))

;; Style for the indentation
(defun my-c-mode-common-hook ()
  ;; bsd ellemtel java stroustrup cc-mode gnu k&r whitesmith
  (c-set-style "K&R")
  (c-set-offset 'substatement-open 0)
  (setq c-basic-offset 4
        indent-tabs-mode nil
        )
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-csharp-mode-hook ()
  (progn
   (turn-on-font-lock)
   (turn-on-auto-fill)
   (setq tab-width 4)
   (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete)))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(defun my-org-mode-hook ()
  (progn
   (transient-mark-mode 1)
   (turn-on-font-lock)
   (turn-on-auto-fill)
   (setq indent-tabs-mode nil
	 tab-width 4)))
(add-hook 'org-mode-hook 'my-org-mode-hook)
;; Setting up remember
(setq org-directory "~"
      org-default-notes-file "~/notes"
      remember-annotation-functions '(org-remember-annotation)
      remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
				
(defun my-perl-mode-hook ()
  (setq indent-tabs-mode nil
        perl-label-offset 0 ))
(add-hook 'perl-mode-hook 'my-perl-mode-hook)

(defun my-wiki-mode-hook ()
  (setq indent-tabs-mode nil))
(add-hook 'wiki-mode-hook 'my-wiki-mode-hook)

(desktop-save-mode 1)
(set 'desktop-files-not-to-save "^/[^/:]*:\|^\*")
;; (speedbar-add-supported-extension ".hwd")

;;;;;;;;; (server-start)

(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(org-adapt-indentation nil)
 '(org-fontify-emphasized-text nil)
 '(org-hide-leading-stars t)
 '(org-special-ctrl-a/e (quote reversed))
 '(safe-local-variable-values (quote ((org-fontify-emphasized-text . t) (auto-save-timeout . 300) (auto-save-interval . 3000) (require-final-newline) (require-final-newline quote ask) (require-final-newline . 1) (indented-tabs-mode))))
 '(save-place t nil (saveplace))
 '(show-paren-mode 1)
 '(sort-fold-case t t)
 '(temporary-file-directory "D:/temp")
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-hide ((((background light)) (:foreground "ghost white")))))

(put 'scroll-left 'disabled nil)
