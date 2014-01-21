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
