" Avoid multiple loadings of this file
if exists("did_load_filetypes")
    finish
endif

" Set custom mappings for extension to filetype
augroup filetypedetect
    au! BufRead,BufNewFile *.bashrc setfiletype sh
    au! BufRead,BufNewFile *.bash setfiletype sh
    au! BufRead,BufNewFile *.tpp setfiletype cpp
augroup END
