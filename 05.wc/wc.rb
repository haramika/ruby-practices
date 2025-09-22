#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

OPTIONS = ARGV.getopts('l', 'w', 'c')

TOTAL_LINE = ARGV.sum { |file| File.readlines(file).length }.to_s.rjust(8)
TOTAL_WORD = ARGV.sum { |file| File.read(file).split.size }.to_s.rjust(7)
TOTAL_BYTE = ARGV.sum { |file| File.size(file) }.to_s.rjust(8)
TOTAL_CONTENTS = [TOTAL_LINE, TOTAL_WORD, TOTAL_BYTE, 'total'].join(' ')
TOTAL_OPTIONS = if OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c']
                  [OPTIONS['l'] ? TOTAL_LINE : '',
                   OPTIONS['w'] ? TOTAL_WORD : '',
                   OPTIONS['c'] ? TOTAL_BYTE : '',
                   'total'].join(' ')
                else
                  TOTAL_CONTENTS
                end

def main
  ARGV.empty? ? put_standard_input : put_file_content
end

def put_file_content
  ARGV.size.times do |i|
    file_line = File.readlines(ARGV[i]).length.to_s.rjust(8)
    file_word = File.read(ARGV[i]).split.size.to_s.rjust(7)
    file_byte = File.size(ARGV[i]).to_s.rjust(8)
    all_contents = [file_line, file_word, file_byte, ARGV[i]].join(' ')

    selected_contents = if OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c']
                          [OPTIONS['l'] ? file_line : '',
                           OPTIONS['w'] ? file_word : '',
                           OPTIONS['c'] ? file_byte : '',
                           ARGV[i]].join(' ')
                        else
                          all_contents
                        end
    print selected_contents
    puts
  end

  print TOTAL_OPTIONS if ARGV.size != 1
  puts
end

def put_standard_input
  standard_inputs = readlines.map(&:chomp)
  standard_input_line = standard_inputs.length.to_s.rjust(8)
  standard_input_word = standard_inputs.map { |file| file.split(' ').size }.sum.to_s.rjust(7)
  standard_input_byte = standard_inputs.join.bytesize.to_s.rjust(7)
  all_standard_inputs = [standard_input_line, standard_input_word, standard_input_byte].join(' ')

  standard_input_options = [OPTIONS['l'] ? standard_input_line : '',
                            OPTIONS['w'] ? standard_input_word : '',
                            OPTIONS['c'] ? standard_input_byte : ''].join(' ')

  print OPTIONS['l'] | OPTIONS['w'] | OPTIONS['c'] ? standard_input_options : all_standard_inputs
  puts
end

main
