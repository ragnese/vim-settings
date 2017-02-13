" Automatically install vim-plug if it's not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    " Unite does all kinds of listing/fuzzy searches
    " NOTE: Unite Depends on vimproc for async stuff
    "Plug 'shougo/unite.vim' | Plug 'shougo/vimproc.vim', { 'do' : 'make' } | let unite_enabled = 1

    " Denite is the replacement for Unite. Not feature complete yet
    Plug 'shougo/denite.nvim' |	let denite_enabled = 1

    " Snippets
    Plug 'sirver/UltiSnips' | let ultisnips_enabled = 1

    Plug 'majutsushi/tagbar' | let tagbar_enabled = 1

    " Buffer and file navigation
    "Plug 'jlanzarotta/bufexplorer' | let bufexplorer_enabled = 1
    " NOTE: VimFiler depends on Unite
    "Plug 'shougo/vimfiler.vim' | let vimfiler_enabled = 1
    Plug 'tpope/vim-vinegar' | let vim_vinegar_enabled = 1
    "Plug 'ctrlpvim/ctrlp.vim' | let ctrlp_enabled = 1

    " Custom vimrc for a directory
    " NOTE: local_vimrc depends on lh-vim-lib
    "Plug 'LucHermitte/local_vimrc' | Plug 'LucHermitte/lh-vim-lib' | let local_vimrc_enabled = 1
    "Plug 'marcweber/vim-addon-local-vimrc' | let vim_addon_local_vimrc_enabled = 1
    "Plug 'embear/vim-localvimrc' | let vim_localvimrc_enabled = 1

    " Multi-language syntax checking
    Plug 'vim-syntastic/syntastic' | let syntastic_enabled = 1

    " Generic autocomplete
    "Plug 'Shougo/neocomplete' | let neocomplete_enabled = 1

    " Multi-language autocompletion/syntax checking/GoTo/etc
    "Plug 'Valloric/YouCompleteMe', { 'do': 'python install.py
    "                                        \ --clang-completer
    "                                        \ --gocode-completer
    "                                        \ --racer-completer' }
    "                                        \ | let YouCompleteMe = 1
    "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' } | let YCM_Generator_enabled = 1

    " Python
    Plug 'davidhalter/jedi-vim' | let jedi_vim_enabled = 1
    "Plug 'neomake/neomake', { 'for': 'python' } | let neomake_enabled = 1
    
    " LaTeX
    Plug 'lervag/vimtex' | let vimtex_enabled = 1

    " Go
    Plug 'fatih/vim-go' | let vim_go_enabled = 1

    " C/C++
    Plug 'Rip-Rip/clang_complete' | let clang_complete_enabled = 1

    " Swift
    Plug 'keith/swift.vim' | let swift_enabled = 1

    " Rust
    Plug 'rust-lang/rust.vim' | let rust_enabled = 1
    Plug 'racer-rust/vim-racer' | let racer_enabled = 1

    " Color themes
    Plug 'tomasr/molokai'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'jacoborus/tender'
    Plug 'zanglg/nova.vim'
    Plug 'joshdick/onedark.vim'
call plug#end()

if exists("unite_enabled")
    " NOTE: If Denite is enabled, it means I'm only using Unite as a 
    " dependency for something else.
    if exists("denite_enabled") && !denite_enabled
        " NOTE: file_rec seems broken for me
        nnoremap <C-p> :Unite -start-insert file_rec<cr>
        nnoremap <leader>/ :Unite grep:.<cr>
        nnoremap <leader>be :Unite buffer<cr>
        " Enable navigation with control-j and control-k in insert mode
        autocmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            imap <buffer> <C-j>   <Plug>(unite_select_next_line)
            imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
        endfunction
    endif
endif

if exists("denite_enabled")
    nnoremap <C-p> :Denite file_rec<cr>
    nnoremap <leader>be :Denite -mode=normal buffer<cr>
    call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
endif

if exists("ultisnips_enabled")
    let g:UltiSnipsSnippetsDir=$HOME."/.vim/UltiSnips"
endif

if exists("vimfiler_enabled")
    let g:loaded_netrwPlugin = 1 " disable netrw
    let g:vimfiler_as_default_explorer = 1
    " toggle sidepane with F5:
    nnoremap <f5> :VimFilerExplorer -toggle<cr> 
    " - in any buffer to open VimFiler with current file selected (like
    "   vinegar):
    nnoremap - :VimFiler -find<cr>
    " Change - to do 'cd ..' instead of close
    autocmd FileType vimfiler nmap <buffer> - <Plug>(vimfiler_switch_to_parent_directory)
endif

if exists("ctrlp_enabled")
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
endif

if exists("local_vimrc_enabled")
    let g:local_vimrc = ".vimrc_local.vim"
endif

if exists("let vim_localvimrc_enabled")
    let g:localvimrc_name = [".vimrc"]
endif

if exists("syntastic_enabled")
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_check_on_wq = 0 " don't check on file close
    let g:syntastic_always_populate_loc_list = 1 " fill location list with errors
    let g:syntastic_auto_loc_list = 0 " open loc list when errors, close when empty
    let g:syntastic_python_checkers = ['pep8']
    let g:syntastic_mode_map = { "mode": "passive",
                                \ "active_filetypes": [],
                                \ "passive_filetypes": [] }
    " I shouldn't need this line...
    "let g:syntastic_rust_checkers = ['rustc']
    " Navigate the loc list:
    nnoremap <leader>n :lnext<cr>
    nnoremap <leader>p :lprevious<cr>
endif

if exists("neocomplete_enabled")
    let g:neocomplete#enable_at_startup = 1
endif

if exists("YouCompleteMe_enabled")
    let g:ycm_rust_src_path = '/usr/src/rust/src'
    nnoremap <Leader>] :YcmCompleter GoTo<CR>
endif

if exists("let vim_go_enabled")
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_interfaces = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1

    let g:go_fmt_autosave = 0
endif

if exists("clang_complete_enabled")
    let g:clang_complete_auto = 0 " Auto pop up
    let g:clang_close_preview = 1 " Close completion window after completion
    let g:clang_auto_select = 1 " Select first entry in list
    let g:clang_snippets = 1
    let g:clang_snippets_engine = 'clang_complete'
    let g:clang_complete_optional_args_in_snippets = 1
endif

if exists("racer_enabled")
    " NOTE: vim-racer recommends 'set hidden'
    let g:racer_cmd = $HOME."/.cargo/bin/racer"
    let $RUST_SRC_PATH = $HOME."/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
    let g:racer_experimental_completer = 1 " Show complete function declaration 
    au FileType rust nmap gd <Plug>(rust-def)
    au FileType rust nmap gs <Plug>(rust-def-split)
    au FileType rust nmap gx <Plug>(rust-def-vertical)
    au FileType rust nmap <leader>gd <Plug>(rust-doc)
endif

if exists("rust_enabled")
    let g:rustfmt_command = $HOME."/.cargo/bin/rustfmt"
endif

