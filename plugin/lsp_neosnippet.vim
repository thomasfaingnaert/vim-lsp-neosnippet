if exists('g:lsp_neosnippet_loaded')
    finish
endif
let g:lsp_neosnippet_loaded = 1

let g:lsp_snippet_expand = [function('lsp_neosnippet#expand_snippet')]
