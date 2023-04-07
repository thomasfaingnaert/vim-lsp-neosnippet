function! s:escape_snippet(text) abort
    " neosnippet.vim expects the tabstops to have curly braces around
    " them, e.g. ${1} instead of $1, so we add these in now.
    let l:snippet = substitute(a:text, '\$\(\d\+\)', '${\1}', 'g')

    " Escape single quotes
    let l:snippet = substitute(l:snippet, "'", "''", 'g')

    " Make sure the snippet ends in ${0}
    if l:snippet !~# "\${0}$"
        let l:snippet .= "${0}"
    endif

    return l:snippet
endfunction

function! lsp_neosnippet#expand_snippet(params) abort
    call feedkeys("\<C-r>=neosnippet#anonymous('" . s:escape_snippet(a:params.snippet) . "')\<CR>", 'n')
endfunction
