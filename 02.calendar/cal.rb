#!/usr/bin/env ruby
require 'optparse'
require 'date'
opt = OptionParser.new

params = {}

opt.on('-y VAL') {|v| params[:y] = v}
opt.on('-m VAL') {|v| params[:m] = v}

opt.parse!(ARGV)

today = Date.today

target_year = params[:y].to_i
target_year = today.year if target_year == 0

target_month = params[:m].to_i
target_month = today.month if target_month == 0

first_date = Date.new(target_year,target_month,1)
last_date = Date.new(target_year,target_month,-1)

puts "#{target_month}月 #{target_year}".center(20)

WEEKDAYS = %w[日 月 火 水 木 金 土]
WEEKDAYS.each do |w|
  print w.ljust(2)
end

puts
print "   " * first_date.wday
(first_date..last_date).each do |date|
  print date.strftime('%e').ljust(3)
  puts if date.saturday?
end

puts

