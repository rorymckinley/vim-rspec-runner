function! rspecrunner#FindGemfile()
  return "hello"
endfunction

function! rspecrunner#PathToFormatter(version)
  let l:base = g:plugin_location . "/formatter/"
  let l:format_file = (a:version ==? "2.x" ? "vim_quickfix_formatter.rb" : "vim_quickfix_formatter_rspec1.rb" )
  return l:base . l:format_file
endfunction

function! rspecrunner#GetExecutable()
  system("bundle list | grep 'rspec (2'")
  return v:shell_error == 0 ? "2.x" : "1.x"
endfunction

function! rspecrunner#FormatterClass(formatter_path)
  let l:sed_search_and_replace = '"s/^.*class\s\+\([A-Za-z]\+\).*/\1/"'
  return system("grep 'class Vim' ".a:formatter_path." | sed -e ".l:sed_search_and_replace)
endfunction

function! rspecrunner#SpecFilePath()
  return expand("%:p")
endfunction
