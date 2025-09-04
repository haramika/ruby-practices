#!/usr/bin/env ruby

# frozen_string_literal: true

current_directories = Dir.glob('*')
number_of_row = current_directories.size.ceildiv(3)

def main(directory_names, max_column)
  max_column.times { |row| print print_directory_line(directory_names, max_column, row) }
end

def print_directory_line(directory_names, max_column, row)
  selected_files =  directory_names[(row..).step(max_column)].to_a
  selected_files.each do |file|
    print file.ljust(20)
  end
  puts
end

main(current_directories, number_of_row)
