#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

OPTIONS = ARGV.getopts('l', 'w', 'c')

def main
  put_content
  put_total if ARGV.size >= 2
end

def put_content
  selected_contents = ARGV.empty? ? [readlines] : ARGV.map { |file| File.readlines(file) }

  selected_contents.map.with_index do |file, i|
    file_line = file.length
    file_word = file.map { |file| file.split.size }.sum
    file_byte = file.join.bytesize

    contents = OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? [] : [file_line, file_word, file_byte]

    contents.push(file_line) if OPTIONS['l']
    contents.push(file_word) if OPTIONS['w']
    contents.push(file_byte) if OPTIONS['c']
    contents.each { |content| print content.to_s.rjust(8) }
    print [' ', ARGV[i]].join
    puts
  end
end

def put_total
  total_line = ARGV.sum { |file| File.readlines(file).length }
  total_word = ARGV.sum { |file| File.read(file).split.size }
  total_byte = ARGV.sum { |file| File.size(file) }

  total_contents = OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? [] : [total_line, total_word, total_byte]

  total_contents.push(total_line) if OPTIONS['l']
  total_contents.push(total_word) if OPTIONS['w']
  total_contents.push(total_byte) if OPTIONS['c']
  total_contents.each { |content| print content.to_s.rjust(8) }
  print ' total'
  puts
end

main
