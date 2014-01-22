It is checker program for sylpheed's filters
  * you can check which rules move point.

sylpheed の振り分けルールで同じ場所に
振り分けるルールを列挙します。

## 使い方

環境変数 HOME を参照して、.sylpheed-2.0/filter.xml のファイルを読み取ります。
unixっぽい環境なら、なんもしなくてもいいはずです。

が、何らかの理由で filter.xml を設定する必要があるなら、プログラム中
の XMLFILE にあなたの sylpheed が参照している filter.xml へのフルパス
を記入するといいのではないでしょうか。

ruby sylpheed-filter-checker.rb 数字

与える数字は、重複している移動先の数です。

## 必要なプログラムまたはgem

### 実行環境

実行に必要なのは、ruby 1.9系以上

今のところ、ruby の標準添付のライブラリを使って
プログラムを作っていますので、追加で gem を入れる
必要はありません。

### テスト実行環境

上記に加えて、
テストを実行するのに、rake コマンドが必要です。

#### 使っているtest

minitest を使っています。

#### test の実行方法

rake test
