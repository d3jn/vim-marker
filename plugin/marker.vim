" Vim Marker
" Author:     Serhii Yaniuk <serhiiyaniuk@gmail.com>
" Repository: github.com/d3jn/vim-marker
" License:    MIT License

if exists('g:marker_loaded')
    finish
endif
let g:marker_loaded = 1

if !exists('g:markers_dir')
    let g:markers_dir = fnamemodify($MYVIMRC, ':p:h').'/markers'
endif

augroup marker_filetype_php
    autocmd!
    autocmd BufRead *.php call marker#MarkByFiletype('php')
augroup END

augroup marker_filetype_vue
    autocmd!
    autocmd BufRead *.vue call marker#MarkByFiletype('vue')
augroup END
