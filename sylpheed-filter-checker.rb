# -*- coding: utf-8 -*-
# This software is Apache License 2.0. please see COPYING.
# Author YABUKI Yukiharu

require 'rexml/document'
include REXML

XMLFILE="/home/yabuki/.sylpheed-2.0/filter.xml"


moveDestinationsHash = Hash.new(0)

#
# main
#
if __FILE__ == $0
  begin
    doc = Document.new(open(XMLFILE))
  rescue => ex
  ensure
  end
  XPath.each(doc,"/filter/rule") do |element|
    subdoc = Document.new(element.to_s) # //action-list/move を要素毎に検索するあため
    if element.attributes["enabled"] then
      moveDestination = XPath.first(subdoc, "//action-list/move/text()")
      val = moveDestinationsHash.key?("#{moveDestination}")
      if val then
        # 2回目以降
        item = moveDestinationsHash["#{moveDestination}"]
        item.push(element.attributes["name"])
        moveDestinationsHash["#{moveDestination}"] = item
      else
        # 1回目
        item = Array.new
        moveDestinationsHash["#{moveDestination}"] = item.push(element.attributes["name"])
      end
    end
  end
  moveDestinationsHash.each do | key, item |
    if item.size > 2 then
      puts "#{key} へ移動するルールは、#{item} の #{item.size} 個です。"
    end
  end
end
