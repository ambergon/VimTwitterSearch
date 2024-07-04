







" 順番通りに出力される。
" SearchWord: だけは固定とする。
" 無ければデフォルトとしてこれを使う。
if !exists( 'g:VimTwitterSearchWords' )
    let g:VimTwitterSearchWords     = [ "SearchWord:" , "from:" , "to:" , "since:" , "until:" ]
endif


" filter:image
" filter:media
" 含めるならinclude / 含めないならexclude
" 結果にリプライを含める。
" exclude:replies
" リツイートを含む
" exclude:nativeretweets
if !exists( 'g:VimTwitterSearchOptions' )
    let g:VimTwitterSearchOptions   = [ "exclude:replies" , "exclude:nativeretweets" ]
endif



function! VimTwitterSearch#TwitterSearch()
    vs VimTwitter://Search

    setl bufhidden=delete
    setl buftype=nowrite
    " bufferを空に。
    execute '%d'

    let l:count = 0
    for l:item in g:VimTwitterSearchWords
        call append( l:count , l:item )
        let l:count += 1
    endfor

    for l:item in g:VimTwitterSearchOptions
        call append( l:count , l:item )
        let l:count += 1
    endfor


    " 最終行を削除
    call deletebufline('%' , '$' )
    " カーソル位置をいい感じに。
    call cursor( 1 , 12 ) 


endfunction





" 現在のバッファ名をチェックする。
function! VimTwitterSearch#TwitterSearchCall()

    let l:BASE_URL = 'https://twitter.com/search?q='
    " 行数を取得
    " echo line('$')
    let l:query = ""
    for l:line in getline( 0 , '$')

        " 左辺:右辺 が存在する行のみ判定する。
        let l:pattern = '^\s*\S\+\s*:\s*\S\+\s*$'
        if l:line =~ l:pattern

            for l:item in g:VimTwitterSearchWords
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

                    let l:query = l:query . l:line . " "
                    continue
                endif

            endfor
        endif

        " include / execlued / filterから始まる行なら追加する。
        " if match( l:line , "^filter:" ) == 0 || match( l:line , "^include:" ) == 0 || match( l:line , "^execlued:" ) == 0 
        if match( l:line , "^execlued:" ) == 0 
            let l:query = l:query . l:line . " "
            continue
        endif
    endfor
    " echo l:query
    " パーセントエンコーディング
    " denops#request( '${name}', 'encode' , [<q-args>])`,
    let l:query = denops#request( 'VimTwitterSearch', 'encode' , [ l:query ] )
    " 文末のスペースを処理
    let l:query = substitute( l:query , ' $', '', '')

    " echo l:query 
    let l:url = l:BASE_URL . l:query
    " 開く。
    call openbrowser#open( l:url )

endfunction












