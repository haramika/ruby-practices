#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('l')
current_directories = Dir.glob('*')

number_of_row = current_directories.size.ceildiv(3)

def put_total_block(directory_names)
  total_blocks = directory_names.map do |file|
    File::Stat.new(file).blocks
  end
  print 'total '
  puts total_blocks.sum
end

def put_file_detail(directory_names)
  directory_names.each do |file|
    fs = File::Stat.new(file)

    file_types = {
      '-' => 'file',
      'd' => 'directory',
      'l' => 'link'
    }

    file_types.each do |k, v|
      print k if fs.ftype == v
    end

    permissions = {
      '---' => '0',
      '--x' => '1',
      '-w-' => '2',
      '-wx' => '3',
      'r--' => '4',
      'r-x' => '5',
      'rw-' => '6',
      'rwx' => '7'
    }

    [3, 4, 5].each do |i|
      permissions.each do |k, v|
        print k if fs.mode.to_s(8).rjust(6, '0').slice(i) == v
      end
    end

    ls_contents = [
      fs.nlink.to_s.rjust(2),
      Etc.getpwuid(fs.uid).name,
      Etc.getgrgid(fs.gid).name.rjust(6),
      fs.size.to_s.rjust(5),
      fs.mtime.month.to_s.rjust(2),
      fs.mtime.day.to_s.rjust(2),
      fs.mtime.strftime('%H:%M'),
      file
    ]

    ls_contents.each do |content|
      print ' '
      print content
    end

    puts
  end
end

def ls_l(directory_names)
  put_total_block(directory_names)
  put_file_detail(directory_names)
end

def main(directory_names, max_column)
  max_column.times { |row| print print_directory_line(directory_names, max_column, row) }
end

def print_directory_line(directory_names, max_column, row)
  selected_files = directory_names[(row..).step(max_column)]
  print selected_files.map { |file| file.ljust(20) }.join(' ')
  puts
end

options['l'] ? ls_l(current_directories) : main(current_directories, number_of_row)
