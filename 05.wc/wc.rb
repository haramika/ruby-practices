#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

OPTIONS = ARGV.getopts('l', 'w', 'c')

def main
  put_content(ARGV)
  put_total(ARGV) if ARGV.size >= 2
end

def select_file(argv)
  argv.empty? ? [readlines] : argv.map { |file| File.readlines(file) }
end

def put_content(argv)
  select_file(ARGV).map.with_index do |file, i|
    file_line = file.length
    file_word = file.map { |file| file.split.size }.sum
    file_byte = file.join.bytesize

    contents = OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? [] : [file_line, file_word, file_byte]

    contents.push(file_line) if OPTIONS['l']
    contents.push(file_word) if OPTIONS['w']
    contents.push(file_byte) if OPTIONS['c']
    contents.each { |content| print content.to_s.rjust(8) }
    print [' ', argv[i]].join
    puts
  end
end

def put_total(argv)
  total_line = argv.sum { |file| File.readlines(file).length }
  total_word = argv.sum { |file| File.read(file).split.size }
  total_byte = argv.sum { |file| File.size(file) }

  total_contents = OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? [] : [total_line, total_word, total_byte]

  total_contents.push(total_line) if OPTIONS['l']
  total_contents.push(total_word) if OPTIONS['w']
  total_contents.push(total_byte) if OPTIONS['c']
  total_contents.each { |content| print content.to_s.rjust(8) }
  print ' total'
  puts
end

main
