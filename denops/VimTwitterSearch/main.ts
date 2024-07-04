






import type { Entrypoint } from "https://deno.land/x/denops_std@v6.5.0/mod.ts";

export const main: Entrypoint = (denops) => {


    denops.dispatcher = {
        // 初期化関数
        async init() {
            // プラグイン名が格納される。
            const { name } = denops;
            await denops.cmd(
                // `command! -nargs=? DenopsHello call denops#request('プラグイン名(読み込むフォルダ名)', '呼び出す関数名', [<q-args>])`,
                // `command! -nargs=? VimTwitterSearch echomsg denops#request( '${name}', 'encode' , [<q-args>])`,
            );
        },

        // Vimから呼び出したい関数を設定
        encode( URL ) {
            // console.log( "call denops twitter ");
            return encodeURIComponent( URL );
            // return `Hello, ${name || "Denops"}!`;
        },
    };
};




