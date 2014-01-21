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

## test

minitest を使っています。

### test の実行方法

rake test
