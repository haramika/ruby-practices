#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('l', 'w', 'c')

def main(arguments, options)
  if arguments.size <= 1
    put_content(arguments, options)
  else
    put_content_total(arguments, options)
  end
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
  make_content(arguments).each do |content|
    next unless options.values.any?

    content.delete(:line) unless options['l']
    content.delete(:word) unless options['w']
    content.delete(:byte) unless options['c']
  end
end

def print_value(data)
  data.each_value { |value| print value.to_s.rjust(8) }
end

def put_content(arguments, options)
  select_content(arguments, options).each.with_index do |content, i|
    print_value(content)
    puts " #{arguments[i]}"
  end
end

def make_total(arguments, options)
  put_content(arguments, options).inject do |hash1, hash2|
    hash1.merge(hash2) do |_key, oldval, newval|
      oldval + newval
    end
  end
end

def put_content_total(arguments, options)
  print_value(make_total(arguments, options))
  puts ' total'
end

main(ARGV, options)
