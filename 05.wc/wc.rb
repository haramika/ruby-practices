#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('l', 'w', 'c')

def main(arguments, options)
  put_content(arguments, options)
  put_total(arguments, options) if arguments.size >= 2
end

def select_file(arguments)
  arguments.empty? ? [readlines.join] : arguments.map { |file| File.read(file) }
end

def make_content(arguments)
  select_file(arguments).map do |file|
    { line: file.lines.count,
      word: file.split.size,
      byte: file.bytesize }
  end
end

def select_content(arguments, options)
  if options['l'] | options['w'] | options['c']
    make_content(arguments).each do |content|
      content.delete(:line) unless options['l']
      content.delete(:word) unless options['w']
      content.delete(:byte) unless options['c']
    end
  else
    make_content(arguments)
  end
end

def put_content(arguments, options)
  select_content(arguments, options).each.with_index do |content, i|
    content.each_value { |value| print value.to_s.rjust(8) }
    print [' ', arguments[i]].join
    puts
  end
end

def put_total(arguments, options)
  merge_data = select_content(arguments, options).inject do |v1, v2|
    v1.merge(v2) do |_key, oldval, newval|
      oldval + newval
    end
  end
  merge_data.each_value { |value| print value.to_s.rjust(8) }
  print ' total'
  puts
end

main(ARGV, options)
