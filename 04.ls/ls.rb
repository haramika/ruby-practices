#!/usr/bin/env ruby

# frozen_string_literal: true

current_directories = Dir.glob('*')
column_count = (current_directories.size / 3.0).ceil

def main(directory_names, column)
  (0..(column - 1)).to_a.each do |remainder|
    print_a_directory_line(directory_names, column, remainder)
  end
end

def print_a_directory_line(directory_names, column, remainder)
  selected_files = directory_names.select.with_index { |_file, idx| idx % column == remainder }
  selected_files.each do |file|
    print file.rjust(3).ljust(20)
  end
  puts
end

main(current_directories, column_count)
