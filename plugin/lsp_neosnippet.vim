if exists('g:lsp_neosnippet_loaded')
    finish
endif
let g:lsp_neosnippet_loaded = 1

let g:lsp_get_vim_completion_item = [function('lsp_neosnippet#get_vim_completion_item')]
let g:lsp_get_supported_capabilities = [function('lsp_neosnippet#get_supported_capabilities')]
