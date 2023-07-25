" Wo und wie hoch
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Mapping von Elementen auf Syntaxgruppen
" - Siehe https://github.com/junegunn/fzf/blob/master/README-VIM.md
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Search'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Search'],
  \ 'info':    ['fg', 'Search'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Keyword'],
  \ 'pointer': ['fg', 'Keyword'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Search'],
  \ 'gutter':  ['bg', 'LineNr'],
  \ 'header':  ['bg', 'Error'] }

" Preview window. Abschalten wenn leer.
let g:fzf_preview_window = 'right:50%'

" Ein prefix für alle Commands. Also FzfFiles statt Files
let g:fzf_command_prefix = 'Fzf'

" Ag zum listen von files nutzen
command! -bang -nargs=? -complete=dir FzfHFiles
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git --ignore "build*" -g ""', 'options': ''}, <bang>0)

" Excludes für FzfAg:
command! -bang -nargs=* FzfAg
  \ call fzf#vim#ag(<q-args>, '--hidden --ignore .git --ignore "build*"', fzf#vim#with_preview(), <bang>0)

" Dateien per leader-e
nmap <leader>e :FzfHFiles<CR>

" Ag/Grep per leader-/
nmap <leader>/ :FzfAg<space>
nnoremap <leader># :FzfAg <C-R><C-W><CR>

