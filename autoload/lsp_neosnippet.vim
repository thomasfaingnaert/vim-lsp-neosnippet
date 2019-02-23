function! lsp_neosnippet#get_vim_completion_item(item, ...) abort
    let a:item['label'] = trim(a:item['label'])

    let l:completion = call(function('lsp#omni#default_get_vim_completion_item'), [a:item] + a:000)

    if has_key(a:item, 'insertTextFormat') && a:item['insertTextFormat'] == 2
        let l:trigger = a:item['label']
        let l:snippet = substitute(a:item['insertText'], '\%x00', '\\n', 'g')
        let l:snippet = l:snippet . '${0}'

        let l:completion['user_data'] = json_encode(
                    \   {
                    \       'snippet_trigger': l:trigger,
                    \       'snippet': l:snippet
                    \   })
    endif

    return l:completion
endfunction

function! lsp_neosnippet#get_supported_capabilities() abort
    let l:capabilities = lsp#default_get_supported_capabilities()

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
