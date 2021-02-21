require 'terminal-table'
require_relative 'csv_parser'

class Product
  attr_reader :code, :name, :price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end

  def to_s
    table = Terminal::Table.new(headings: ['Code', 'Name', 'Price'], rows: [ to_a ])
  end

  def to_a
    [ @code, @name, @price ]
  end

  def self.create
    filename = 'input/sample_products.csv'
    products = CsvParser.new(filename).read
  end
end

