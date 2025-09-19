#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('a', 'r', 'l')
current_directories = Dir.glob('*', options['a'] ? File::FNM_DOTMATCH : 0)
selected_directories = options['r'] ? current_directories.reverse : current_directories

number_of_row = current_directories.size.ceildiv(3)

def put_total_block(directory_names)
  print 'total '
  puts(directory_names.sum { |file| File::Stat.new(file).blocks })
end

def put_detail(directory_names)
  file_types = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }
  permissions = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
  directory_names.each do |file|
    fs = File::Stat.new(file)

    print file_types[fs.ftype]

    [3, 4, 5].each do |i|
      print permissions[fs.mode.to_s(8).rjust(6, '0').slice(i)]
    end

    ls_contents = [fs.nlink.to_s.rjust(3),
                   Etc.getpwuid(fs.uid).name,
                   Etc.getgrgid(fs.gid).name.rjust(6),
                   fs.size.to_s.rjust(5),
                   fs.mtime.month.to_s.rjust(2),
                   fs.mtime.day.to_s.rjust(2),
                   fs.mtime.strftime('%H:%M'),
                   file].join(' ')

    print ls_contents
    puts
  end
end

def put_file_detail(directory_names)
  put_total_block(directory_names)
  put_detail(directory_names)
end

def put_file_name_only(directory_names, max_column)
  max_column.times { |row| print print_directory_line(directory_names, max_column, row) }
end

def print_directory_line(directory_names, max_column, row)
  selected_files = directory_names[(row..).step(max_column)]
  print selected_files.map { |file| file.ljust(20) }.join(' ')
  puts
end

options['l'] ? put_file_detail(selected_directories) : put_file_name_only(selected_directories, number_of_row)
