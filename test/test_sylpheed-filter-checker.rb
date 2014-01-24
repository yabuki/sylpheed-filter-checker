# -*- coding: utf-8 -*-
require 'minitest/unit'
require 'minitest/autorun'
# 絶対パスを指定して require
require File.expand_path(File.dirname(__FILE__) + '/../sylpheed-filter-checker')

#
#
#

class TestFoo < MiniTest::Unit::TestCase
  def setup
#    @foo = Foo.new
  end
  # teardown はあまり使わない
  def teardown
#    @foo = nil
  end

  def test_get_minimal_count
    ARGV[0] = ''
    assert_equal 2, get_minimal_count
  end
  def test_get_minimal_count2
    ARGV[0] = '3'
    assert_equal 3, get_minimal_count
  end
  def test_get_minimal_count3
    ARGV[0] = '1'
    assert_equal 2, get_minimal_count
  end
end

#
#
#
class Test_Filter_XML < MiniTest::Unit::TestCase
  def test_not_exist_XML_file
    filter_xml = Filter_XML.new("notExistFile.xml")
    assert filter_xml.doc.nil?
  end
end

#
#
#
class Test_Hash_contains_Array < MiniTest::Unit::TestCase
  def test_key_empty
    a = Hash_Contains_Array.new()
    a.each do |key, item|
      assert_equal key, nil
    end
  end
  def test_value_empty
    a = Hash_Contains_Array.new()
    a.each do |key, item|
      assert_equal item, nil
    end
  end
  def test_an_item
    a = Hash_Contains_Array.new()
    s = "moge"
    a.push(:hoge, s)
    a.each do | key, item |
      assert_equal item, ["moge"]
    end
  end
  def test_2_items
    a = Hash_Contains_Array.new()
    a.push(:hoge, "foo")
    a.push(:hoge, "bar")
    a.each do | key, item |
      assert_equal item, %w(foo bar)
    end
  end
  def test_3_items
    a = Hash_Contains_Array.new()
    a.push(:hoge, "foo")
    a.push(:hoge, "bar")
    a.push(:hoge, "buz")
    a.each do | key, item |
      assert_equal item, %w(foo bar buz)
    end
  end
end
