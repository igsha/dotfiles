" switch to alternate source file

if exists("g:switchalt")
  finish
endif

function s:SwitchToAlt(src_file_root, extention)
  let &l:path= '.,../**'
  if tolower(a:extention) == "h" || tolower(a:extention) == "hpp"
    exec 'find ' . a:src_file_root . ".c*"
  else
    exec 'find ' . a:src_file_root . ".h*"
  endif
endfunction

command -nargs=0 Iswitchalt call s:SwitchToAlt(expand("%:r"), expand("%:e"))
map <Leader>s :Iswitchalt<CR>

let g:switchalt = '1.3'

" vim: ts=2 sw=2
