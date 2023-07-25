" Automatisch diese extensions installieren
" This is a list of extensions that are installed once COC loads (if not yet
" installe).
" Use ':CocList marketplace' to search for extensions
let g:coc_global_extensions = [
            \'coc-marketplace',
            \'coc-clangd',
            \'coc-cmake',
            \'coc-tsserver',
            \'coc-json',
            \'coc-html',
            \'coc-css',
            \
            \'coc-python' ]
" -----------------------------------------------------------------------------
"  Key mappings:
"

" <c-space> um code completion zu triggern
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Leader-ff für auto-fix
nmap <leader>ff <Plug>(coc-fix-current)

" Ausgewähltes element in liste durch enter wählen
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window
"nnoremap <silent> K :call ShowDocumentation()<CR>
"function! ShowDocumentation()
"  if CocAction('hasProvider', 'hover')
"    call CocActionAsync('doHover')
"  else
"    call feedkeys('K', 'in')
"  endif
"endfunction


" Highlight the symbol and its references when holding the cursor
" autocmd CursorHold * silent call CocActionAsync('highlight')
" TODO: which highlight group?


" Formatting selected code
" Warning: clash with neo-format?
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)


" -------- Navigation

" GoTo code navigation
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)


" -------- Code Actions

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
"nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
"nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
"nmap <leader>qf  <Plug>(coc-fix-current)


" -------- Refactor Actions

" Remap keys for applying refactor code actions
"nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
"xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
"nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)


" -------- CodeLens Actions

" Run the Code Lens action on the current line
"nmap <leader>cl  <Plug>(coc-codelens-action)

" -------- More:
" See https://github.com/neoclide/coc.nvim


" Add `:Format` command to format current buffer
"command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
