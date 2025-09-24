#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

OPTIONS = ARGV.getopts('l', 'w', 'c')

TOTAL_LINE = ARGV.sum { |file| File.readlines(file).length }.to_s.rjust(8)
TOTAL_WORD = ARGV.sum { |file| File.read(file).split.size }.to_s.rjust(8)
TOTAL_BYTE = ARGV.sum { |file| File.size(file) }.to_s.rjust(8)
TOTAL_CONTENTS = [TOTAL_LINE, TOTAL_WORD, TOTAL_BYTE, ' total'].join

def main
  if ARGV.empty?
    put_standard_input
  else
    put_file_content
    put_total
  end
end

def put_file_content
  ARGV.size.times do |i|
    file_line = File.readlines(ARGV[i]).length.to_s.rjust(8)
    file_word = File.read(ARGV[i]).split.size.to_s.rjust(8)
    file_byte = File.size(ARGV[i]).to_s.rjust(8)
    all_contents = [file_line, file_word, file_byte].join

    option_contents = []
    option_contents.push(file_line) if OPTIONS['l']
    option_contents.push(file_word) if OPTIONS['w']
    option_contents.push(file_byte) if OPTIONS['c']

    print OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? option_contents.join : all_contents
    print [' ', ARGV[i]].join
    puts
  end
end

def put_total
  total_options = []
  total_options.push(TOTAL_LINE) if OPTIONS['l']
  total_options.push(TOTAL_WORD) if OPTIONS['w']
  total_options.push(TOTAL_BYTE) if OPTIONS['c']
  total_options.push(' total')

  return if ARGV.size == 1

  print OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? total_options.join : TOTAL_CONTENTS
  puts
end

def put_standard_input
  standard_inputs = readlines.map(&:chomp)
  standard_input_line = standard_inputs.length.to_s.rjust(8)
  standard_input_word = standard_inputs.map { |file| file.split(' ').size }.sum.to_s.rjust(8)
  standard_input_byte = standard_inputs.join.bytesize.to_s.rjust(8)
  all_standard_inputs = [standard_input_line, standard_input_word, standard_input_byte].join

  standard_input_options = []
  standard_input_options.push(standard_input_line) if OPTIONS['l']
  standard_input_options.push(standard_input_word) if OPTIONS['w']
  standard_input_options.push(standard_input_byte) if OPTIONS['c']

  print OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? standard_input_options.join : all_standard_inputs
  puts
end

main
