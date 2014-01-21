# -*- coding: utf-8 -*-
# This software is distributed under Apache License 2.0.
# please see COPYING.
# Author: YABUKI Yukiharu
# Date: 2014/01/20

require 'rexml/document'
include REXML
require 'pp'

XMLFILE="#{ENV['HOME']}/.sylpheed-2.0/filter.xml"

class Filter_XML
  attr_reader :doc
  def initialize(path = XMLFILE)
    begin
      @doc = Document.new(open(XMLFILE))
    rescue => ex
    ensure
    end
  end
  def each
    XPath.each(@doc, "/filter/rule") do | element |
      yield element
    end
  end
  def rule_enabled?( element )
    return element.attributes["enabled"] == "true" ? true : false
  end
  def looking_for_move_action(element)
    subdoc = Document.new(element.to_s) # //action-list/move を要素毎に検索するため
    return XPath.first(subdoc, "//action-list/move/text()")
  end
end
#
#
#
class Hash_Contains_Array
  def initialize
    @h = Hash.new(0)
  end
  def push(key, value)
    if @h.key?("#{key}") then
      # 2回目以降
      item = @h["#{key}"]
    else
      # 1回目
      item = Array.new
    end
    @h["#{key}"] = item.push(value)
  end
  def each
    @h.each do | key, item |
      yield key, item
    end
  end
end
# いくつ、同じ行き先を持つ要素を表示するかを
# 決定する
#
def get_minimal_count
  minimal_count = (ARGV[0]).to_i
  return minimal_count < 2 ? 2 : minimal_count
end

#
# main
#
if __FILE__ == $0
  move_destinations = Hash_Contains_Array.new

  filter_xml = Filter_XML.new()
  filter_xml.each do | element |
    if filter_xml.rule_enabled?(element) then
      moveDestination = filter_xml.looking_for_move_action(element)
      move_destinations.push(moveDestination, element.attributes["name"])
    end
  end
  minimal_count = get_minimal_count()
  move_destinations.each do | key, item |
    if item.size >= minimal_count then
      puts "#{key} へ移動するルールは、#{item} の #{item.size} 個です。"
    end
  end
end
