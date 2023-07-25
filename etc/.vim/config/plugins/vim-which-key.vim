" Pfeilsymbol
" '→''🠖''➜'
let g:which_key_sep = '➜'

" Floating/Popup sieht komisch aus
let g:which_key_use_floating_win = 0

" Highlight Gruppen
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator Normal
highlight default link WhichKeyGroup     IncSearch
highlight default link WhichKeyDesc      Function

" UI clutter entfernen
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Keymaps
nnoremap <silent> <leader> :silent WhichKey ','<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual ','<CR>

