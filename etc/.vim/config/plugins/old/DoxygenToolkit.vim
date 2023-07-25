function! DoxyKeys()
  nnoremap <silent> <leader>d :Dox<CR>
endfunction

" Tune DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_startCommentTag = "/**"
let g:DoxygenToolkit_startCommentBlock = "/*"
let g:DoxygenToolkit_paramTag_pre = "\\param "
let g:DoxygenToolkit_returnTag = "\\return "
let g:DoxygenToolkit_fileTag = "\\file "
let g:DoxygenToolkit_authorTag = "\\author "
let g:DoxygenToolkit_dateTag = "\\date "
let g:DoxygenToolkit_blockTag = "\\name "
let g:DoxygenToolkit_classTag = "\\class "
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "

" au BufNewFile,BufRead *.glsl,*.vs,*.fs,*.java,*.cc,*.c,*.cpp,*.h,*.hh,*.hpp call DoxyKeys()
