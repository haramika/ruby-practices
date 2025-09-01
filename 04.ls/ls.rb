#!/usr/bin/env ruby

# frozen_string_literal: true

current_directories = Dir.glob("*")

def main(directory_name, multiple)
  remainder_number = (0..100).to_a
  remainder_number.each do |remainder|
    print_directory(directory_name, multiple, remainder) if remainder < multiple
  end
end

def print_directory(directory_name, multiple, remainder)
  directory_name.map.with_index do |file, idx|
    print file.ljust(20) if idx % multiple == remainder
  end
  puts
end

main(current_directories, 3)
