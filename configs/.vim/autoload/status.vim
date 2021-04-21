function! status#VarIfExists(varname, ...)
    let l:default_value = get(a:, 1, 0)

    if exists(a:varname)
        return {a:varname}
    else
        return l:default_value
    endif
endfunction

function! status#Refresh()
    for l:nr in s:listbufs()
        if winnr() == l:nr
            let l:active = status#Active()
            call setwinvar(l:nr, '&statusline', l:active)
        else
            let l:inactive = status#Inactive()
            call setwinvar(l:nr, '&statusline', l:inactive)
        endif
        if !exists('&statusline')
            let l:broken = status#Broken()
            call setwinvar(l:nr, '&statusline', l:broken)
        endif
    endfor
endfunction

function! status#Modified(one, two)
    if a:two > 0
        let b:modified = 1
    else
        let b:modified = 0
    endif
endfunction

function! status#Branch(one, two)
    if strlen(a:two) > 0
        let b:branch = a:two
    else
        let b:branch = ""
    endif
endfunction

function! status#GitInfo()
    let l:git_string = "\ "
    if status#VarIfExists("b:modified", 0)
        let l:git_string .= "%#Question#"                                " change color if current file differs in git
        let l:git_string .= "%{status#VarIfExists(\"b:branch\", \"\")}"  " current detected git branch
        let l:git_string .= "%#LineNr#"                                  " change color back
    else
        let l:git_string .= "%{status#VarIfExists(\"b:branch\", \"\")}"  " current detected git branch
    endif
    let l:git_string .= "\ "
    return l:git_string
endfunction

function! status#Active()
    let l:active = ''
    let a=job_start(['/bin/sh', '-c', 'git diff-files --no-ext-diff --quiet && git diff-index --no-ext-diff --quiet --cached HEAD'], { 'exit_cb': 'status#Modified' })
    let b=job_start(['/bin/sh', '-c', "git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'"], { 'out_io': 'pipe', 'err_io':'null', 'out_cb': 'status#Branch' })
    let l:active = "%#LineNr#"                         " use line numbering highlight group
    let l:active .= status#GitInfo()
    let l:active .= "\%0.60F"                          " full file name up to 60 chars
    let l:active .= "\ ⇄"
    let l:active .= "\ b%-1.3n\ "                      " b<buffer number> capped at 3 digits
    let l:active .= "%="                               " right align from here on
    let l:active .= "%h%m%r%w"                         " flags
    let l:active .= "[%{strlen(&ft)?&ft:'none'},"      " filetype
    let l:active .= "%{strlen(&fenc)?&fenc:&enc},"     " encoding
    let l:active .= "%{&fileformat}]"                  " file format
    let l:active .= "\ %p%%"                           " percentage through file
    let l:active .= "\ [%l/%L]"                        " line/numlines
    let l:active .= "\ [%c/%{strwidth(getline('.'))}]" " col/numcols
    let l:active .= "\ %*"
    return l:active
endfunction

function! status#Inactive()
    let l:inactive = ''
    let l:inactive = "%#LineNr#"                         " use line numbering highlight group
    let l:inactive .= "\%0.60F"                          " full file name up to 60 chars
    let l:inactive .= "\ ⇄"
    let l:inactive .= "\ b%-1.3n\ "                      " b<buffer number> capped at 3 digits
    let l:inactive .= "%="                               " right align from here on
    let l:inactive .= "%h%m%r%w"                         " flags
    let l:inactive .= "[%{strlen(&ft)?&ft:'none'},"      " filetype
    let l:inactive .= "%{strlen(&fenc)?&fenc:&enc},"     " encoding
    let l:inactive .= "%{&fileformat}]"                  " file format
    let l:inactive .= "\ %p%%"                           " percentage through file
    let l:inactive .= "\ [%l/%L]"                        " line/numlines
    let l:inactive .= "\ [%c/%{strwidth(getline('.'))}]" " col/numcols
    let l:inactive .= "\ %*"
    return l:inactive
endfunction

function! status#Broken()
    let l:broken = ''
    let l:broken = "%#LineNr#"                         " use line numbering highlight group
    let l:broken .= "\%0.60F"                          " full file name up to 60 chars
    let l:broken .= "\ ⇄"
    let l:broken .= "\ b%-1.3n\ "                      " b<buffer number> capped at 3 digits
    let l:broken .= "%="                               " right align from here on
    let l:broken .= "%h%m%r%w"                         " flags
    let l:broken .= "[%{strlen(&ft)?&ft:'none'},"      " filetype
    let l:broken .= "%{strlen(&fenc)?&fenc:&enc},"     " encoding
    let l:broken .= "%{&fileformat}]"                  " file format
    let l:broken .= "\ %p%%"                           " percentage through file
    let l:broken .= "\ [%l/%L]"                        " line/numlines
    let l:broken .= "\ [%c/%{strwidth(getline('.'))}]" " col/numcols
    let l:broken .= "\ %*"
    return l:broken
endfunction

function! s:listbufs()
    let l:bufs = []
    for prop in getbufinfo()
        call add( l:bufs, prop['bufnr'])
    endfor
    return l:bufs
endfunction

function! status#Autocmd()
    autocmd BufEnter,BufWritePre,ShellCmdPost * let b:modified = ''
    autocmd BufEnter,BufWritePre,ShellCmdPost * let b:branch = ''
    autocmd BufEnter,BufWritePost,InsertEnter,ShellCmdPost * call status#Refresh()
endfunction

