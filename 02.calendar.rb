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
if target_year == 0
  target_year = today.year
end
target_month = params[:m].to_i
if target_month == 0
  target_month = today.month
end

first_date = Date.new(target_year,target_month,1)
last_date = Date.new(target_year,target_month,-1)

if target_month == 0
  puts "#{today.month}月 #{today.year}".center(20)
else
  puts "#{target_month}月 #{target_year}".center(20)
end

WEEKDAYS = %w[日 月 火 水 木 金 土]
WEEKDAYS.each do |w|
  print w.rjust(2)
end

puts
print "   " * first_date.wday
(first_date..last_date).each do |date|
  print date.day.rjust(3)
  puts if date.saturday?
end
