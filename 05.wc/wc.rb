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
  if options.values.any?
    make_content(arguments).each do |content|
      content.delete(:line) unless options['l']
      content.delete(:word) unless options['w']
      content.delete(:byte) unless options['c']
    end
  else
    make_content(arguments)
  end
end

def print_content(data)
  data.each_value { |value| print value.to_s.rjust(8) }
end

def put_content(arguments, options)
  select_content(arguments, options).each.with_index do |content, i|
    print_content(content)
    puts " #{arguments[i]}"
  end
end

def make_total(arguments, options)
  select_content(arguments, options).inject do |hash1, hash2|
    hash1.merge(hash2) do |_key, oldval, newval|
      oldval + newval
    end
  end
end

def put_total(arguments, options)
  print_content(make_total(arguments, options))
  puts ' total'
end

main(ARGV, options)
