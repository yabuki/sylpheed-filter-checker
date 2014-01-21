# -*- coding: utf-8 -*-
# This software is distributed under Apache License 2.0.
# please see COPYING.
# Author: YABUKI Yukiharu
# Date: 2014/01/20

require 'rexml/document'
include REXML

XMLFILE="#{ENV['HOME']}/.sylpheed-2.0/filter.xml"

moveDestinationsHash = Hash.new(0)

#
# main
#
if __FILE__ == $0
  minimalCount = (ARGV[0]).to_i
  if minimalCount < 2 then
    minimalCount = 2
  end
  begin
    doc = Document.new(open(XMLFILE))
  rescue => ex
  ensure
  end
  XPath.each(doc,"/filter/rule") do |element|
    subdoc = Document.new(element.to_s) # //action-list/move を要素毎に検索するため
    if element.attributes["enabled"] == "true" then
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
    if item.size >= minimalCount then
      puts "#{key} へ移動するルールは、#{item} の #{item.size} 個です。"
    end
  end
end
