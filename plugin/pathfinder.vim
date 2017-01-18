if exists("g:loaded_pathfinder")
    finish
endif

let g:loaded_pathfinder = 1

if !exists("g:pathfinder_targets")
    let g:pathfinder_targets = [".git"]
endif

function! SetProjectPath()
    for pd in g:pathfinder_targets
        let dir = finddir(pd, ".;")
        if empty(dir)
            continue
        endif
        let &l:path = &path . fnamemodify(dir, ":p:h:h") . "/**"
        return
    endfor
endfunction

augroup buffer_path
    autocmd!
    autocmd BufNewFile,BufRead * call SetProjectPath()
augroup END
