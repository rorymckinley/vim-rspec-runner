let g:plugin_location = expand("<sfile>:h")

nnoremap <silent> <Leader>sf :call rspecrunner#RunSpecsFile()<CR>
nnoremap <silent> <Leader>se :call rspecrunner#RunSpecsExample()<CR>
