# vim-lsp-neosnippet
This plugin integrates [neosnippet.vim](https://github.com/Shougo/neosnippet.vim) in [vim-lsp](https://github.com/prabirshrestha/vim-lsp) to provide Language Server Protocol snippets.
You can use both Vim's built-in omnifunc or [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) for completion.

## Demo
![GIF demo](https://raw.githubusercontent.com/thomasfaingnaert/images/master/demo-neosnippet.gif)

## Quick Start
This plugin requires [neosnippet.vim](https://github.com/Shougo/neosnippet.vim), [vim-lsp](https://github.com/prabirshrestha/vim-lsp) and their dependencies.
If these are already installed and you are using [vim-plug](https://github.com/junegunn/vim-plug), you can simply add this to your vimrc:
```vim
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-neosnippet'
```

Otherwise, you can install these using [vim-plug](https://github.com/junegunn/vim-plug) as well:
```vim
Plug 'Shougo/neosnippet.vim'
Plug 'prabirshrestha/async.vim'
Plug 'thomasfaingnaert/vim-lsp', {'branch': 'ultisnips-integration'}
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-neosnippet'
```

## Disable for specific language servers
By default, snippet integration is enabled for all language servers. You can disable snippets for one or more servers manually as follows:
```vim
autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            \ 'config': { 'snippets': 0 }
            \ })
```

## Example Configuration (using omnifunc)
```vim
call plug#begin()

Plug 'Shougo/neosnippet.vim'
Plug 'prabirshrestha/async.vim'
Plug 'thomasfaingnaert/vim-lsp', {'branch': 'ultisnips-integration'}
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-neosnippet'

call plug#end()

imap <expr> <Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
smap <expr> <Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

if executable('clangd')
    augroup vim_lsp_cpp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
                    \ })
	autocmd FileType c,cpp,objc,objcpp,cc setlocal omnifunc=lsp#complete
    augroup end
endif

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

set completeopt+=menuone
```
