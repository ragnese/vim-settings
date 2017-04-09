" Automatically install vim-plug if it's not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    " Denite does listing/fuzzy searches from various sources
    Plug 'shougo/denite.nvim' |	let denite_enabled = 1

    " Snippets
    Plug 'sirver/UltiSnips' | let ultisnips_enabled = 1

    " Git integration
    Plug 'tpope/vim-fugitive' | let vim_fugitive_enabled = 1

    " Buffer and file navigation
    Plug 'scrooloose/nerdtree' | let nerdtree_enabled = 1
    "Plug 'jlanzarotta/bufexplorer' | let bufexplorer_enabled = 1
    "Plug 'tpope/vim-vinegar' | let vim_vinegar_enabled = 1
    "Plug 'ctrlpvim/ctrlp.vim' | let ctrlp_enabled = 1

    " Custom vimrc for a directory
    "Plug 'LucHermitte/local_vimrc' | Plug 'LucHermitte/lh-vim-lib' | let local_vimrc_enabled = 1
    "Plug 'marcweber/vim-addon-local-vimrc' | let vim_addon_local_vimrc_enabled = 1
    Plug 'embear/vim-localvimrc' | let vim_localvimrc_enabled = 1

    " Multi-language syntax checking
    Plug 'w0rp/ale' | let ale_enabled = 1
    "Plug 'vim-syntastic/syntastic' | let syntastic_enabled = 1

    " Generic autocomplete
    " Multi-language autocompletion/syntax checking/GoTo/etc
    "Plug 'Valloric/YouCompleteMe', { 'do': 'python install.py
    "                                        \ --clang-completer
    "                                        \ --gocode-completer
    "                                        \ --racer-completer' }
    "                                        \ | let YouCompleteMe = 1
    "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' } | let YCM_Generator_enabled = 1

    " Python
    Plug 'davidhalter/jedi-vim' | let jedi_vim_enabled = 1
    
    " LaTeX
    "Plug 'lervag/vimtex' | let vimtex_enabled = 1

    " Go
    Plug 'fatih/vim-go' | let vim_go_enabled = 1

    " C/C++
    "Plug 'octol/vim-cpp-enhanced-highlight' | let vim_cpp_enhanced_highlight_enabled = 1
    Plug 'Rip-Rip/clang_complete' | let clang_complete_enabled = 1

    " Swift
    Plug 'keith/swift.vim' | let swift_enabled = 1

    " Rust
    Plug 'rust-lang/rust.vim' | let rust_enabled = 1
    Plug 'racer-rust/vim-racer' | let racer_enabled = 1

    " TOML
    Plug 'cespare/vim-toml' | let vim_toml_enabled = 1

    " Avro
    Plug 'AoLab/vim-avro' | let vim_avro_enabled = 1

    " Color themes
    Plug 'tomasr/molokai'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'tomasiser/vim-code-dark'
    Plug 'tyrannicaltoucan/vim-quantum'
call plug#end()

if exists("denite_enabled")
    nnoremap <C-p> :Denite file_rec<cr>
    nnoremap <leader>be :Denite -mode=normal buffer<cr>
    call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
endif

if exists("ultisnips_enabled")
    let g:UltiSnipsSnippetsDir=$HOME."/.vim/UltiSnips"
endif

if exists("vim_fugitive_enabled")
    "set statusline+=\ %{fugitive#statusline()}
endif

if exists("nerdtree_enabled")
    let g:NERDTreeShowHidden = 1
    noremap <F5> :NERDTreeToggle<CR>
    nnoremap - :NERDTreeFind<CR>
endif

if exists("ctrlp_enabled")
    " The following lines check if ripgrep is in PATH and then tells CtrlP
    " to use it.
    silent exec '!which rg > /dev/null'
    if !v:shell_error
        let g:ctrlp_user_command = 'rg %s --files'
    endif
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrp_show_hidden = 1
endif

if exists("local_vimrc_enabled")
    let g:local_vimrc = ".vimrc_local.vim"
endif

if exists("vim_localvimrc_enabled")
    let g:localvimrc_name = [".vimrc"]
endif

if exists("ale_enabled")
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_text_changed = 0
endif

if exists("syntastic_enabled")
    "set statusline+=%#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    "set statusline+=%*
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

if exists("YouCompleteMe_enabled")
    let g:ycm_rust_src_path = '/usr/src/rust/src'
    nnoremap <Leader>] :YcmCompleter GoTo<CR>
endif

if exists("jedi_vim_enabled")
    let g:jedi#popup_on_dot = 0
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

if exists("vim_cpp_enhanced_highlight_enabled")
    " I honestly can't see what the following two options even do
    "let g:cpp_member_variable_highlight = 1
    "let g:cpp_class_scope_highlight = 1
    " Default mode does better job. Only enable this if default is too slow
    "let g:cpp_experimental_template_highlight = 1
endif

if exists("clang_complete_enabled")
    let g:clang_complete_auto = 0 " Auto pop up
    let g:clang_close_preview = 1 " Close completion window after completion
    let g:clang_auto_select = 1 " Select first entry in list
    let g:clang_snippets = 1
    let g:clang_snippets_engine = 'clang_complete'
    let g:clang_complete_optional_args_in_snippets = 1
endif

if exists("rust_enabled")
    let g:rustfmt_command = $HOME."/.cargo/bin/rustfmt"
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

