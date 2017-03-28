(TeX-add-style-hook
 "org-ref"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "fontenc"
    "fixltx2e"
    "graphicx"
    "longtable"
    "float"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "marvosym"
    "wasysym"
    "amssymb"
    "hyperref"
    "natbib"
    "glossaries"
    "makeidx")
   (LaTeX-add-labels
    "sec-1"
    "sec-1-1"
    "sec-1-1-1"
    "sec-1-1-2"
    "sec-1-1-3"
    "tab-ydata"
    "sec-1-1-4"
    "table-1"
    "table-3"
    "sec-misc"
    "sec-1-1-4-1"
    "eq:1"
    "sec-1-1-5"
    "sec-1-2"
    "sec-1-3"
    "sec-1-4"
    "sec-1-5"
    "sec-2"
    "sec-2-1"
    "sec-2-2"
    "sec-2-2-1"
    "sec-2-2-2"
    "sec-2-2-3"
    "sec-2-2-4"
    "sec-2-3"
    "sec-2-4"
    "sec-2-5"
    "sec-2-6"
    "sec-2-7"
    "sec-2-8"
    "sec-2-9"
    "sec-2-10"
    "sec-2-11"
    "sec-2-12"
    "sec-3"
    "sec-3-1"
    "sec-3-2"
    "sec-3-2-1"
    "sec-3-2-2"
    "sec-3-2-3"
    "sec-3-3"
    "sec-3-3-1"
    "sec-3-3-2"
    "sec-3-3-3"
    "sec-3-3-4"
    "sec-3-3-5"
    "sec-4"
    "sec-5"
    "sec-5-1"
    "sec-5-2"
    "sec-6"
    "bibliography-link")
   (LaTeX-add-bibliographies)
   (LaTeX-add-index-entries
    "bibliography"
    "bibliographystyle"
    "cite"
    "natbib"
    "biblatex"
    "cite!replace"
    "cite!shift"
    "label"
    "ref"
    "ref!pageref"
    "ref!nameref"
    "ref!eqref"
    "list of tables"
    "list of figures"
    "helm-bibtex"
    "bibtex!clean entry"
    "export!LaTeX"
    "export!html"
    "export!ascii"
    "doi"
    "isbn"
    "pubmed"
    "arxiv"
    "orcid"
    "researcher id"
    "bibtex!conversion"
    "customization"
    "completion"
    "link!completion"
    "link!storing"
    "index"
    "glossary")))

