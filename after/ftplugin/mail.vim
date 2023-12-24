setlocal spell spelllang=en_us
set wrap linebreak nolist
lua require('cmp').setup.buffer { enabled = false }
set signcolumn=no
map <c-o> o<esc>>>A
imap <c-o> <esc><c-o>
vmap j gj
vmap k gk
vmap $ g$
vmap ^ g^
vmap 0 g0
nmap j gj
nmap k gk
nmap $ g$
nmap ^ g^
nmap 0 g0

let g:goyo_width=80
:Goyo
map ZZ :Goyo\|x!<CR>
map ZQ :Goyo\|q!<CR>
