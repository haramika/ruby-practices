#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
opt = OptionParser.new

params = {}
opt.on('-a') { params[:a] = true }
opt.parse!(ARGV)

option = params[:a] ? File::FNM_DOTMATCH : 0
current_directories = Dir.glob('*', option)

number_of_row = current_directories.size.ceildiv(3)

def main(directory_names, max_column)
  max_column.times { |row| print print_directory_line(directory_names, max_column, row) }
end

def print_directory_line(directory_names, max_column, row)
  selected_files = directory_names[(row..).step(max_column)]
  print selected_files.map { |file| file.ljust(20) }.join(' ')
  puts
end

main(current_directories, number_of_row)
