function! rspecrunner#FindGemfile()
  return "hello"
endfunction

function! rspecrunner#PathToFormatter(version)
  let l:base = g:plugin_location . "/formatter/"
  let l:format_file = (a:version ==? "2.x" ? "vim_quickfix_formatter.rb" : "vim_quickfix_formatter_rspec1.rb" )
  return l:base . l:format_file
endfunction

function! rspecrunner#RspecVersion()
  let l:nil = system("bundle list | grep 'rspec (2'")
  return v:shell_error == 0 ? "2.x" : "1.x"
endfunction

function! rspecrunner#FormatterClass(version)
  return "RSpec::Core::Formatters::VimQuickfixFormatter"
endfunction

function! rspecrunner#SpecFilePath()
  return expand("%:p")
endfunction

function! rspecrunner#RspecCommand()
  let l:version = rspecrunner#RspecVersion()
  let l:executable = (l:version ==? "2.x" ? "rspec" : "spec")
  let l:formatter_path = rspecrunner#PathToFormatter(l:version)
  let l:formatter_class = rspecrunner#FormatterClass(l:version)
  let l:spec_file_path = rspecrunner#SpecFilePath()

  return "bundle exec ".l:executable." -r ".l:formatter_path." -f ".l:formatter_class." ".l:spec_file_path
endfunction

function! rspecrunner#RunSpecsFile()
  cexpr system(rspecrunner#RspecCommand())
  copen
endfunction
