It is checker program for sylpheed's filters
  * you can check which rules move point.

sylpheed の振り分けルールで同じ場所に
振り分けるルールを列挙します。

## 使い方

プログラムの XMLFILE にあなたの sylpheed が参照している filter.xml へのフルパスを
記入します。

ruby sylpheed-filter-checker.rb 数字

与える数字は、重複している移動先の数です。
