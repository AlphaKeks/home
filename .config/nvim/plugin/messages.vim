function! Messages()
  let messages = ""
  redir => messages
  silent messages
  redir END
  new
  setlocal noundofile noswapfile buftype=nofile bufhidden=hide
  call setline(1, split(messages, "\n"))
endfunction

command! Messages call Messages()
