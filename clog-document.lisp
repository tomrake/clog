;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CLOG - The Common Lisp Omnificent GUI                                 ;;;;
;;;; (c) 2020-2021 David Botton                                            ;;;;
;;;; License BSD 3 Clause                                                  ;;;;
;;;;                                                                       ;;;;
;;;; clog-document.lisp                                                    ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cl:in-package :clog)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Implementation - clog-document
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass clog-document (clog-obj)()
  (:documentation "CLOG Document Objects encapsulate the document."))

;;;;;;;;;;;;;;;;;;;;;;;;
;; make-clog-document ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-clog-document (connection-id)
  "Construct a new clog-document. (Private)"
  (make-instance 'clog-document :connection-id connection-id :html-id "document"))

;;;;;;;;;;;;
;; domain ;;
;;;;;;;;;;;;

(defgeneric domain (clog-document)
  (:documentation "Get domain."))

(defmethod domain ((obj clog-document))
  (query obj "domain"))

;;;;;;;;;;;;;;;;;;;;
;; input-encoding ;;
;;;;;;;;;;;;;;;;;;;;

(defgeneric input-encoding (clog-document)
  (:documentation "Get input encoding."))

(defmethod input-encoding ((obj clog-document))
  (query obj "inputEncoding"))

;;;;;;;;;;;;;;;;;;;
;; last-modified ;;
;;;;;;;;;;;;;;;;;;;

(defgeneric last-modified (clog-document)
  (:documentation "Get last modified."))

(defmethod last-modified ((obj clog-document))
  (query obj "lastModified"))

;;;;;;;;;;;;;
;; referer ;;
;;;;;;;;;;;;;

(defgeneric referer (clog-document)
  (:documentation "Get referer."))

(defmethod referer ((obj clog-document))
  (query obj "referer"))

;;;;;;;;;;;
;; title ;;
;;;;;;;;;;;

(defgeneric title (clog-document)
  (:documentation "Get/setf title."))

(defmethod title ((obj clog-document))
  (query obj "title"))

(defgeneric set-title (clog-document value))
  
(defmethod set-title ((obj clog-document) value)
  (execute obj (format nil "title='~A'" (cc:escape-string value))))
(defsetf title set-title)

;;;;;;;;;
;; url ;;
;;;;;;;;;

(defgeneric url (clog-document)
  (:documentation "Get url."))

(defmethod url ((obj clog-document))
  (query obj "url"))

;;;;;;;;;;;;;;;;;;;;;;
;; document-element ;;
;;;;;;;;;;;;;;;;;;;;;;

(defgeneric document-element (clog-document)
  (:documentation "Get document-element."))

(defmethod document-element ((obj clog-document))
  (make-instance 'clog-base :connection-id (connection-id obj) :html-id "documentElement"))

;;;;;;;;;;;;;;;;;;
;; head-element ;;
;;;;;;;;;;;;;;;;;;

(defgeneric head-element (clog-document)
  (:documentation "Get head-element."))

(defmethod head-element ((obj clog-document))
  (make-instance 'clog-base :connection-id (connection-id obj) :html-id "head"))
  
;;;;;;;;;;
;; body ;;
;;;;;;;;;;

(defgeneric body-element (clog-document)
  (:documentation "Get body-element."))

(defmethod body-element ((obj clog-document))
  (make-instance 'clog-base :connection-id (connection-id obj) :html-id "body"))

;;;;;;;;;;;;;;;;;
;; ready-state ;;
;;;;;;;;;;;;;;;;;

(defgeneric ready-state (clog-document)
  (:documentation "Get ready-state."))

(defmethod ready-state ((obj clog-document))
  (query obj "readyState"))

;;;;;;;;;;;;;;
;; load-css ;;
;;;;;;;;;;;;;;

(defgeneric load-css (clog-document css-url)
  (:documentation "Load css from CSS-URL."))

(defmethod load-css ((obj clog-document) css-url)
  (jquery-execute (head-element obj)
		  (format nil "append('<link rel=\"stylesheet\"
           href=\"~A\" type=\"text/css\">')" (escape-string css-url))))

;;;;;;;;;
;; put ;;
;;;;;;;;;

(defgeneric put (clog-document message)
  (:documentation "Write text to browser document object."))

(defmethod put ((obj clog-document) message)
  (execute obj (format nil "write('~A')" (escape-string message))))

;;;;;;;;;;;;;;
;; put-line ;;
;;;;;;;;;;;;;;

(defgeneric put-line (clog-document message)
  (:documentation "Write text to browser document object with new-line."))

(defmethod put-line ((obj clog-document) message)
  (execute obj (format nil "writeln('~A')" (escape-string message))))

;;;;;;;;;;;;
;; put-br ;;
;;;;;;;;;;;;

(defgeneric put-br (clog-document message)
  (:documentation "Write text to browser document object with <\br>new-line."))

(defmethod put-br ((obj clog-document) message)
  (execute obj (format nil "writeln('~A<\br>')" (escape-string message))))

;;;;;;;;;;;;;;
;; new-line ;;
;;;;;;;;;;;;;;

(defgeneric new-line (clog-document)
  (:documentation "Write to browser document <\br>new-line."))

(defmethod new-line ((obj clog-document))
  (execute obj (format nil "writeln('<\br>')")))
