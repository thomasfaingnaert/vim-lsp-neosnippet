function! lsp_neosnippet#get_snippet(text) abort
    " neosnippet.vim expects the tabstops to have curly braces around
    " them, e.g. ${1} instead of $1, so we add these in now.
    let l:snippet = substitute(a:text, '\$\(\d\+\)', '${\1}', 'g')

    " Make sure the snippet ends in ${0}
    if l:snippet !~# "\${0}$"
        let l:snippet .= "${0}"
    endif

    return l:snippet
endfunction

function! lsp_neosnippet#expand_snippet(trigger, snippet) abort
    call feedkeys(repeat("\<BS>", len(a:trigger)))
    call feedkeys("\<C-r>=neosnippet#anonymous(\"" . a:snippet . "\")\<CR>")
endfunction
