runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Disable swapfile and backup {{{
set nobackup
set noswapfile
"}}}

"some common configs {{{
"map visual mode vertical selectoin"
nmap <leader>v <c-v>
set fenc=utf-8
set termencoding=utf-8
set fileencodings=utf-8,chinese
set encoding=utf-8 "if not set, the powerline plugins won't work
set autoindent
set tabstop=4 " tab width is 4 spaces
set shiftwidth=4 " indent also with 4 spaces
set softtabstop=4
set expandtab
set textwidth=300
set t_Co=256
set number
set hidden
set showmatch
set comments=sl:/*,mb:\ *,elx:\ */
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
set autoread
set title
set matchpairs+=<:>
set ruler
set backspace=indent,eol,start
map Y y$
set laststatus=2
set pastetoggle=<F2>
set nolist
syntax on

"nerdTree plugin config {{{
autocmd vimenter * NERDTree
nmap <silent> <leader>n :NERDTreeToggle <CR>
let NERDTreeShowHidden=1

"config syntastic {{{
let g:syntastic_check_on_open=1
"}}}


"set colorscheme {{{
syntax enable
"}}}

"config tagbar plugin {{{
let Tlist_Use_Right_Window = 1
"}}}


"solarized colorschema config{{{
let g:solarized_diffmode="low"
"}}}

" Always change to directory of the buffer currently in focus {{{
" autocmd! bufenter *.* :cd %:p:h
" autocmd! bufread *.* :cd %:p:h
"}}}

" Better navigating through omnicomplete option list {{{
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>
"}}}

"c/c++/javascript/java fold method
autocmd filetype c,cpp,javascript,java set foldmarker={,}

"configure for UltiSnips plugin {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"}}}

"auto reload vimrc configuration {{{
au BufWritePost .vimrc so ~/.vimrc
nmap <leader>vv :tabedit $MYVIMRC<CR>
"}}}

"config clang_complete library {{{
" g:clang_user_options set at vimprj section
au BufNewFile,BufRead *
\ if expand('%:e') =~ '^\(h\|hh\|hxx\|hpp\|ii\|ixx\|ipp\|inl\|txx\|tpp\|tpl\|cc\|cxx\|cpp\)$' |
\ if &ft != 'cpp' |
\ set ft=cpp |
\ endif |
\ endif

let g:clang_use_library=0
let g:clang_complete_copen=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
" Avoids lame path cache generation and other unknown sources for includes
let g:clang_auto_user_options=''
let g:clang_memory_percent=70

set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
" The single one that works with clang_complete
let g:clang_snippets_engine='clang_complete'

" Complete options (disable preview scratch window, longest removed to aways
" show menu)
set completeopt=menu,menuone

" Limit popup menu height
set pumheight=20

" SuperTab completion fall-back
let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'
"}}}

"keymaps for c/c++ development{{{
" Reparse the current translation unit in background
command! Parse call g:ClangBackgroundParse()
" Reparse the current translation unit and check for errors
command! ClangCheck call g:ClangUpdateQuickFix()

" Set the most common used run command
if has('win32') || has('win64') || has('os2')
    let g:common_run_command='$(FILE_TITLE)$'
else
    let g:common_run_command='./$(FILE_TITLE)$'
endif
" SingleCompile for C++ with Clang
function! s:LoadSingleCompileOptions()
    call SingleCompile#SetCompilerTemplate('c',
                \'clang',
                \'the Clang C and Objective-C compiler',
                \'clang',
                \'-o $(FILE_TITLE)$ ' . g:single_compile_options,
                \g:common_run_command)
 
    call SingleCompile#ChooseCompiler('c', 'clang')
 
    call SingleCompile#SetCompilerTemplate('cpp',
                \'clang',
                \'the Clang C and Objective-C compiler',
                \'clang++',
                \'-o $(FILE_TITLE)$ ' . g:single_compile_options,
                \g:common_run_command)
    call SingleCompile#ChooseCompiler('cpp', 'clang')
endfunction

"config for neocomplcache{{{
" use neocomplcache & clang_complete

" add neocomplcache option
let g:neocomplcache_force_overwrite_completefunc=1

" add clang_complete option
let g:clang_complete_auto=1
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
"}}}
