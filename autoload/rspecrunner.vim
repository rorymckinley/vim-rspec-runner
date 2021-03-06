if !exists("g:rspecrunner_outfile")
    let g:rspecrunner_outfile = "~/.last-rspec"
endif

if !exists("g:rspecrunner_default_format")
    let g:rspecrunner_default_format = "p"
endif

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

function! rspecrunner#ExampleLineNumber()
  return line(".")
endfunction

function! rspecrunner#QuickfixFormat()
  let l:version = rspecrunner#RspecVersion()
  let l:formatter_path = rspecrunner#PathToFormatter(l:version)
  let l:formatter_class = rspecrunner#FormatterClass(l:version)

  return " -r ".l:formatter_path." -f ".l:formatter_class." -o ".g:rspecrunner_outfile
endfunction

function! rspecrunner#RspecCommand(run_type)
  let l:version = rspecrunner#RspecVersion()
  let l:executable = (l:version ==? "2.x" ? "rspec" : "spec")
  let l:spec_file_path = rspecrunner#SpecFilePath()
  let l:line_number = (a:run_type ==? "example" ? ":".rspecrunner#ExampleLineNumber() : "")

  return "bundle exec ".l:executable.rspecrunner#QuickfixFormat()." -f ".g:rspecrunner_default_format." ".l:spec_file_path.l:line_number
endfunction

function! rspecrunner#RunSpecsFile()
  execute "!".rspecrunner#RspecCommand("file")
  cexpr system("cat ".g:rspecrunner_outfile)
  copen
endfunction

function! rspecrunner#RunSpecsExample()
  execute "!".rspecrunner#RspecCommand("example")
  cexpr system("cat ".g:rspecrunner_outfile)
  copen
endfunction
