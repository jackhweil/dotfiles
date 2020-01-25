" Avoid multiple loadings of this file
if exists("did_load_filetypes")
    finish
endif

" Set custom mappings for extension to filetype
augroup filetypedetect
    au! BufRead,BufNewFile *.bashrc setfiletype sh
augroup END
