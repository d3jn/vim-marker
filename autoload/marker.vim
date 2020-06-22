" Vim Marker
" Author:     Serhii Yaniuk <serhiiyaniuk@gmail.com>
" Repository: github.com/d3jn/vim-marker
" License:    MIT License

function! marker#MarkFirstOccurrenceOf(pattern, mark, preserve_position)
    if a:preserve_position
        let view = winsaveview()
    endif

    let line_number = s:GotoFirstOccurrenceOf(a:pattern)
    if line_number > 0
        execute "normal m".a:mark
    endif

    if a:preserve_position
        call winrestview(view)
    endif
endfunction

function! s:GotoFirstOccurrenceOf(pattern)
    execute "normal! gg"
    let line_number = search(a:pattern, 'n')

    if line_number > 0
        call cursor(line_number, 1)
    endif

    return line_number
endfunction
