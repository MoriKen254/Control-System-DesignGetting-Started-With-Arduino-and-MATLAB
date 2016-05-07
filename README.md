# Control-System-DesignGetting-Started-With-Arduino-and-MATLAB
[ArduinoとMATLABで制御系設計をはじめよう！](http://www.amazon.co.jp/gp/product/4906864007/ref=s9_simh_gw_g14_i1_r?pf_rd_m=AN1VRQENFRJN5&pf_rd_s=desktop-1&pf_rd_r=0C59144QVWXPC53XSNNK&pf_rd_t=36701&pf_rd_p=302362649&pf_rd_i=desktop)のコード

書籍ではMatlab 2012を想定しているので，`Matlab and Simulink Library For the Arduino IO Package`というオプション・パッケージを使用していた．

当方の環境では，Matlab 2016a を使用しており，`Matlab and Simulink Support Package for Arduino Hardware`という専用パッケージが提供されているので，こちらを想定したコードに独自に移行している．

# トラブルシューティング
## 4章
### mdlファイルを再起動するとArduinoと通信できない
多分，前回実行時のオブジェクトファイルにゴミが残っていてうまくいかない．とりあえず下記の通りに操作すれば回避できる．てか自動で解決してくれorz．

1. 前回実行時の自動生成ファイル「.hex, .elf, .eep等」やフォルダ「hogehoge_ert_rtw, slprj」を全部削除する．
1. ハードウェアオプションを再設定する．
 1. 「ツール」→「ターゲットハードウェアで実行」→「オプション」を選択する．
 1. 「ハードウェア実行」→「ハードウェアボード」を「なし」に設定し，「適用」を押す．
 2. 「ハードウェア実行」→「ハードウェアボード」を「Arduino Mega 2560」に設定し，「OK」を押す．

### Scope の入力を複数設定したい
1. Scopeブロックをダブルクリックする．
2. 「ファイル」→「入力端子の数」→「2」を選択する．

### Scope のグラフを縦二段表示にしたい
1. Scopeブロックをダブルクリックする．
2. ツールバーの歯車マークをクリック→レイアウトで縦二段を選択する．
