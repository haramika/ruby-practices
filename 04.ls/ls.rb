#!/usr/bin/env ruby

# frozen_string_literal: true

current_directories = Dir.glob('*')
number_of_column = (current_directories.size / 3.0).ceil

def main(directory_names, max_column)
  (0..(max_column - 1)).to_a.each do |row|
    print_directory_line(directory_names, max_column, row)
  end
end

def print_directory_line(directory_names, max_column, row)
  selected_files = directory_names.select.with_index { |_file, idx| idx % max_column == row }
  selected_files.each do |file|
    print file.rjust(3).ljust(20)
  end
  puts
end

main(current_directories, number_of_column)
