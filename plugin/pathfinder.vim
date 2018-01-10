if exists("g:loaded_pathfinder")
    finish
endif

let g:loaded_pathfinder = 1

if !exists("g:pathfinder_targets")
    let g:pathfinder_targets = [".git"]
endif

function! SetProjectPath()
    for pd in g:pathfinder_targets
        let file = findfile(pd, ".;")
        let dir = finddir(pd, ".;")
        if !empty(file)
            echoerr file
            let &l:path = &path . "," . fnamemodify(file, ":p:h") . "/**"
            return
        elseif !empty(dir)
            let &l:path = &path . "," . fnamemodify(dir, ":p:h:h") . "/**"
            return
        endif
    endfor
endfunction

augroup buffer_path
    autocmd!
    autocmd VimEnter,BufNewFile,BufRead * call SetProjectPath()
augroup END
