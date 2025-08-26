#!/usr/bin/env ruby

# frozen_string_literal: true

current_directories = Dir.entries('../')

def remove_dot(directory_name)
  directory_name.delete_if do |file|
    file.start_with?('.')
  end
end

def print_arry(directory_name, multiple, remainder)
  directory_name.map.with_index do |file, idx|
    print file.ljust(30) if idx % multiple == remainder
  end
  puts
end

remove_dot(current_directories)

print_arry(current_directories, 5, 0)
print_arry(current_directories, 5, 1)
print_arry(current_directories, 5, 2)
print_arry(current_directories, 5, 3)
print_arry(current_directories, 5, 4)
