" VimTwitterSearch
" Version: 0.0.1
" Author: 
" License: 

if exists('g:loaded_VimTwitterSearch')
  finish
endif
let g:loaded_VimTwitterSearch = 1





" ウィンドウを出す。
command! -nargs=0  TwitterSearch        call VimTwitterSearch#TwitterSearch()
" ウィンドウから情報を取得する。
" プラグインがあればそのリンクに流そう。
command! -nargs=0  TwitterSearchCall    call VimTwitterSearch#TwitterSearchCall()















