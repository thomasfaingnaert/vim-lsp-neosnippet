function! lsp_neosnippet#get_vim_completion_item(item, ...) abort
    let a:item['label'] = trim(a:item['label'])

    let l:completion = call(function('lsp#omni#default_get_vim_completion_item'), [a:item] + a:000)

    " Set trigger and snippet
    if has_key(a:item, 'insertTextFormat') && a:item['insertTextFormat'] == 2
        if has_key(a:item, 'insertText')
            let l:trigger = a:item['label']
            let l:snippet = a:item['insertText']

            let l:user_data = {'vim-lsp-neosnippet': { 'trigger': l:trigger, 'snippet': l:snippet } }
            let l:completion['user_data'] = json_encode(l:user_data)
        elseif has_key(a:item, 'textEdit')
            let l:user_data = json_decode(l:completion['user_data'])

            let l:trigger = a:item['label']
            let l:snippet = l:user_data['vim-lsp/textEdit']['newText']

            " neosnippet.vim expects the tabstops to have curly braces around
            " them, e.g. ${1} instead of $1, so we add these in now
            let l:snippet = substitute(l:snippet, '\$\(\d\+\)', '${\1}', 'g')

            let l:user_data['vim-lsp/textEdit']['newText'] = ''

            let l:user_data['vim-lsp-neosnippet'] = { 'trigger': l:trigger, 'snippet': l:snippet }
            let l:completion['user_data'] = json_encode(l:user_data)
        endif
    endif

    return l:completion
endfunction

function! lsp_neosnippet#get_supported_capabilities(server_info) abort
    let l:capabilities = lsp#default_get_supported_capabilities(a:server_info)

    if has_key(a:server_info, 'config') && has_key(a:server_info['config'], 'snippets') &&
                \ a:server_info['config']['snippets'] == 0
        return l:capabilities
    endif

    let l:capabilities['textDocument'] =
                \   {
                \       'completion': {
                \           'completionItem': {
                \               'snippetSupport': v:true
                \           }
                \       }
                \   }

    return l:capabilities
endfunction

function! s:expand_snippet(timer) abort
    call feedkeys("\<C-r>=neosnippet#anonymous(\"" . s:snippet . "\")\<CR>")
endfunction

function! s:handle_snippet(item) abort
    if !has_key(a:item, 'user_data')
        return
    endif

    try
        let l:user_data = json_decode(a:item['user_data'])
    catch
        return
    endtry

    if (type(l:user_data) != type({})) || (!has_key(l:user_data, 'vim-lsp-neosnippet'))
        return
    endif

    let s:trigger = l:user_data['vim-lsp-neosnippet']['trigger']
    let s:snippet = l:user_data['vim-lsp-neosnippet']['snippet']

    call timer_start(0, function('s:expand_snippet'))
endfunction

augroup lsp_neosnippet
    autocmd!
    autocmd User lsp_complete_done call s:handle_snippet(v:completed_item)
augroup END
