# VimTwitterSearch
毎回ツイッター(現X)の検索クエリを忘れるので作成されました。


## Requirements
[GitHub - vim-denops/denops.vim: 🐜  An ecosystem of Vim/Neovim which allows developers to write cross-platform plugins in Deno](https://github.com/vim-denops/denops.vim)<br>
[GitHub - tyru/open-browser.vim: Open URI with your favorite browser from your most favorite editor](https://github.com/tyru/open-browser.vim)<br>
が必要です。


## Usage
<br>TwitterSearch
<br>コマンドを使用することで、各種クエリが書き込まれたバッファーが開かれます。
<br>
<br>g:VimTwitterSearchWords = []
<br>を編集することで、このバッファに書き込まれる内容が変化します。
<br>配列内部の 'SearchWord:' は必須です。
<br>
<br>またオプションとして
<br>g:VimTwitterSearchOptions = []
<br>変数を指定することができます。
<br>filter:/include:/exclude:から始まる要素を格納します。
<br>接頭辞に!などを付けておくことでバッファーに含むが無視することができます。
<br>
<br>TwitterSearchOpen
<br>コマンドを使用することで、現在のバッファーの内容でブラウザを開きます。


## License
MIT

## Author
ambergon
