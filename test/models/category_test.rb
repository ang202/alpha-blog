# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'Sports')
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test 'name should be valid' do
    @category.name = ''
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    @category2 = Category.new(name: 'Sports')
    assert_not @category2.valid?
  end

  test 'name cannot be too short' do
    @category.name = 'Hi'
    assert_not @category.valid?
  end

  test 'name cannot be too long' do
    @category.name = 'Travel' * 10
    assert_not @category.valid?
  end
end
