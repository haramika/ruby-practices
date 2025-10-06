#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('l', 'w', 'c')

def main(arguments, options)
  put_content(arguments, options)
  put_total(arguments, options) if arguments.size >= 2
end

def select_file(arguments)
  arguments.empty? ? [readlines] : arguments.map { |file| File.readlines(file) }
end

def make_content(arguments, options)
  file_lines = []
  file_words = []
  file_bytes = []

  select_file(arguments).map do |file|
    file_lines.push(file.length)
    file_words.push(file.map { |file| file.split.size }.sum)
    file_bytes.push(file.join.bytesize)
  end

  option_contents = []
  option_contents.push(file_lines) if options['l']
  option_contents.push(file_words) if options['w']
  option_contents.push(file_bytes) if options['c']

  options['l'] | options['w'] | options['c'] ? option_contents : [file_lines, file_words, file_bytes]
end

def put_content(arguments, options)
  if arguments.empty?
    make_content(arguments, options).each { |content| content.each { |content| print content.to_s.rjust(8) } }
    puts
  else
    arguments.size.times do |i|
      make_content(arguments, options).each { |content| print content[i].to_s.rjust(8) }
      print [' ', arguments[i]].join
      puts
    end
  end
end

def put_total(arguments, options)
  make_content(arguments, options).each { |n| print n.sum.to_s.rjust(8) }
  print ' total'
  puts
end

main(ARGV, options)
