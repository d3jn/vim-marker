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
        execute "normal! m".a:mark
    endif

    if a:preserve_position
        call winrestview(view)
    endif
endfunction

function! marker#MarkAuto()
    call marker#MarkByFiletype(&filetype)
endfunction

function! marker#MarkByFiletype(filetype)
    let markers = s:ReadMarkersForFiletype(a:filetype)

    let view = winsaveview()
    for marker in markers
        call marker#MarkFirstOccurrenceOf(marker.pattern, marker.mark, 0)
    endfor
    call winrestview(view)
endfunction

function! s:GotoFirstOccurrenceOf(pattern)
    execute "normal! gg"
    let line_number = search(a:pattern, 'n')

    if line_number > 0
        call cursor(line_number, 1)
    endif

    return line_number
endfunction

function! s:ReadMarkersForFiletype(filetype)
    let markers = []
    let markers_file = g:markers_dir.'/'.a:filetype.'.markers'
    echo markers_file
    if filereadable(markers_file)
        let lines = readfile(markers_file)

        for line in lines
            let matches = matchlist(line, '^\([^ ]\+\) \(.\+\)$')

            if ((matches[1] != '') && (matches[2] != ''))
                let markers = add(markers, {'mark': matches[1], 'pattern': matches[2]})
            endif
        endfor
    endif

    return markers
endfunction
