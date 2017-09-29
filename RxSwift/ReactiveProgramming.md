# What is Reactive Programming

refs: http://ninjinkun.hatenablog.com/entry/introrxja

* ストリームとは
  * 時間順に並んだ進行中のイベントの列
  * 値（何らかの型）, エラー, 完了という3つのシグナルを発行できる
  * 3つのイベントは関数を定義することによって非同期にキャプチャする
    * 関数群（3つのイベント）は `observer` と定義する
  * ストリームをlisteningすることは `subscribing` と呼ぶ
  * ストリームはobserveされるsubjectもしくはobservableである



