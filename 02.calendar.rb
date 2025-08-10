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
if params[:y].to_i == 0
  target_year = today.year
end
target_month = params[:m].to_i
if params[:m].to_i == 0
  target_month = today.month
end

first_date = Date.new(target_year,target_month,1)
last_date = Date.new(target_year,target_month,-1)
cal_date = first_date..last_date

if params[:m].to_i == 0
  puts "#{today.month}月 #{today.year}".center(20)
else
  puts "#{params[:m].to_i}月 #{params[:y].to_i}".center(20)
end

WEEKDAYS = %w[日 月 火 水 木 金 土]
WEEKDAYS.each do |w|
  print w.rjust(2)
end

puts "\n"
print "   " * first_date.wday
cal_date.each do |d|
  if d.saturday?
    print d.strftime('%e').rjust(3)
    puts "\n"
  else
    print d.strftime('%e').rjust(3)
  end
end

