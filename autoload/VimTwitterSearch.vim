









" 順番通りに出力される。
" SearchWord: だけは固定とする。
let g:VimTwitterSearchArray = [ "SearchWord:" , "from:" , "to:" , "since:" , "until:" , "exclude:replies" , "exclude:nativeretweets" ]



function! VimTwitterSearch#TwitterSearch()
    vs VimTwitter://Search

    setl bufhidden=delete
    setl buftype=nowrite

    " 空にする。
    execute '%d'

    let l:count = 0
    for l:item in g:VimTwitterSearchArray
        call append( l:count , l:item )
        let l:count += 1
    endfor


    " call append( 0 , "word:")
    " " from:@xxx
    " call append( 1 , "from:")
    " call append( 2 , "to:")
    " call append( 3 , "since:")
    " call append( 4 , "until:")
    " " call append( 0 , "filter:image")
    " " call append( 0 , "filter:media")
    " "" 含めるならinclude / 含めないならexclude
    " " 結果にリプライを含める。
    " call append( 6 , "exclude:replies")
    " " リツイートを含む
    " call append( 7 , "exclude:nativeretweets")
    " 最終行を削除
    call deletebufline('%' , '$' )
endfunction











" call VimTwitterSearch#TwitterSearch()



" 現在のバッファ名をチェックする。
function! VimTwitterSearch#TwitterSearchCall()

    " マッチするか確かめ、
    " queryに流す。


    " 行数を取得
    " echo line('$')



    let l:query = ""
    for l:line in getline( 0 , '$')

        " :で始まる行である。
        " 空白以外の文字列が記入されている。
        " yyyy-mm-ddである。


        " : 右辺が何もなければカット。
        " あればクエリとして 半角スペースでつなげる。

        " VimScriptで、左辺:右辺 で構成されるテキストか判定するコードを書け。

        let l:pattern = '^\s*\S\+\s*:\s*\S\+\s*$'

        " 左辺:右辺 が存在する行のみ判定する。
        if l:line =~ l:pattern

            for l:item in g:VimTwitterSearchArray
                " マッチするか調査する。
                " if match( l:line , '^from:' ) == 0
                if match( l:line , '^' . l:item  ) == 0
                    " 規定文字以外入力がなければカット
                    if l:line == l:item
                        continue
                    endif

                    " 検索文字だけ左辺と:を取り除く。
                    if match( l:item , "^SearchWord:" ) == 0
                        let l:line = substitute( l:line , '^SearchWord:' , "" , '' )
                    endif

                    " マッチするなら半角スペースでつなげる。
                    let l:query = l:query . " " . l:line

                endif
            endfor
        endif
    endfor
    " echo l:query
    " パーセントエンコーディング
    call denops#request( 'VimTwitterSearch', 'encode' , [ l:query ] )
    " denops#request( '${name}', 'encode' , [<q-args>])`,





    " if expand( '%:p' ) == 'VimTwitter://Search'
    "     echo "aaa"
    " else
    "     echo "bbb"
    " endif
endfunction


" call VimTwitterSearch#TwitterSearchCall()













