function! rspecrunner#FindGemfile()
  return "hello"
endfunction

function! rspecrunner#PathToFormatter()
  return g:plugin_location . "/formatter/vim_quickfix_formatter.rb"
endfunction

function! rspecrunner#GetExecutable()
  system("bundle list | grep 'rspec (2'")
  return v:shell_error == 0 ? "rspec" : "spec"
endfunction
