#!/usr/bin/env ruby

# frozen_string_literal: true

current_directories = Dir.glob('*')
column_count = (current_directories.size / 3.0).ceil

def main(directory_name, column)
  (0..column).to_a.each do |remainder|
    print_directory(directory_name, column, remainder)
  end
end

def print_directory(directory_name, column, remainder)
  directory_name.map.with_index do |file, idx|
    print file.rjust(3).ljust(20) if idx % column == remainder
  end
  puts
end

main(current_directories, column_count)
