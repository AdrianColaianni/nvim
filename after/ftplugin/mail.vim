setlocal spell spelllang=en_us
set wrap linebreak nolist
set signcolumn=no
map <c-o> o<esc>>>A
imap <c-o> <esc><c-o>
vmap j gj
vmap k gk
vmap ^ g^
nmap j gj
nmap k gk
nmap ^ g^

let g:goyo_width=80
:Goyo
map ZZ :Goyo\|x!<CR>
map ZQ :Goyo\|q!<CR>
