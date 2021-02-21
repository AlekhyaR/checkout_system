# frozen_string_literal: true

require 'csv'

class CsvParser
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def read
    row_details = []

    CSV.foreach(filename, headers: true,
                          header_converters: ->(value) { value.strip },
                          converters: ->(value) { value.strip }) do |row|

      row_details << Product.new(row['Code'], row['Name'], row['Price'])
    end

    row_details
  end
end
