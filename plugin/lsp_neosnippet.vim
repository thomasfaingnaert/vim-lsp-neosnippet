if exists('g:lsp_neosnippet_loaded')
    finish
endif
let g:lsp_neosnippet_loaded = 1

let g:lsp_snippets_get_snippet = [function('lsp_neosnippet#get_snippet')]
let g:lsp_snippets_expand_snippet = [function('lsp_neosnippet#expand_snippet')]
