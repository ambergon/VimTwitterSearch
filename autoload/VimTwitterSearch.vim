







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
    let g:VimTwitterSearchOptions   = [ "exclude:replies" , "exclude:nativeretweets" , "filter:images"]
endif


" 指定バッファ名のウィンドウがあればそれに移動。 return 0
" 無ければ何ももしない。                         return 1
function! s:SwitchToBufferByName(buffer_name)
    " 現在のウィンドウ番号を保存
    let l:current_win = winnr()
    " 全てのウィンドウをループ
    for l:win in range(1, winnr('$'))
        " ウィンドウを移動
        execute l:win . 'wincmd w'
        " 現在のウィンドウのバッファ名を取得
        let l:bufname = bufname('%')
        " バッファ名が指定された名前と一致するか確認
        if l:bufname == a:buffer_name
            " 一致する場合、そのウィンドウに移動して終了
            return
        endif
    endfor
    " 一致するウィンドウが見つからなかった場合、\w9元のウィンドウに戻る
    execute l:current_win . 'wincmd w'
    vs VimTwitter://Search
endfunction


function! VimTwitterSearch#TwitterSearch()

    call s:SwitchToBufferByName( 'VimTwitter://Search' )

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
        if match( l:line , l:pattern) == 0
        " if l:line =~ l:pattern
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

        " include / exclude / filterから始まる行なら追加する。
        if match( l:line , "^filter:" ) == 0 || match( l:line , "^include:" ) == 0 || match( l:line , "^exclude:" ) == 0 
            let l:query = l:query . l:line . " "
        endif
    endfor
    echo l:query
    " 文末のスペースを処理
    let l:query = substitute( l:query , ' $', '', '')
    " パーセントエンコーディング
    let l:query = denops#request( 'VimTwitterSearch', 'encode' , [ l:query ] )

    let l:url = l:BASE_URL . l:query
    " 開く。
    call openbrowser#open( l:url )

endfunction












