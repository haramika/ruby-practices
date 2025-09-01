#!/usr/bin/env ruby

# frozen_string_literal: true

current_directories = Dir.glob("*")

def print_directory(directory_name, multiple, remainder)
  directory_name.map.with_index do |file, idx|
    print file.ljust(20) if idx % multiple == remainder
  end
  puts
end

print_directory(current_directories, 3, 0)
print_directory(current_directories, 3, 1)
print_directory(current_directories, 3, 2)
