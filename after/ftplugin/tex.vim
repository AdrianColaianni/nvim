setlocal spell spelllang=en_us
set wrap linebreak nolist
lua require('cmp').setup.buffer { enabled = false }
set signcolumn=no
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
