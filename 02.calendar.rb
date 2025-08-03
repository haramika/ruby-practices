#!/usr/bin/env ruby
require 'optparse'
require 'date'
opt = OptionParser.new

params = {}

opt.on('-y VAL') {|v| params[:y] = v}
opt.on('-m VAL') {|v| params[:m] = v}

opt.parse!(ARGV)

date = Date.today

days = ["日".rjust(2), "月".rjust(2), "火".rjust(2), "水".rjust(2), "木".rjust(2), "金".rjust(2), "土".rjust(2)]

designated_year=params[:y].to_i
  if params[:y].to_i == 0
    designated_year=date.year
  end
designated_month=params[:m].to_i
  if params[:m].to_i == 0
    designated_month=date.month
  end

first_date=Date.new(designated_year,designated_month,1)
last_date=Date.new(designated_year,designated_month,-1)
cal_date=first_date..last_date

f_date=Date.new(date.year,date.month,1)
l_date=Date.new(date.year,date.month,-1)
today_date=f_date..l_date

if params[:m].to_i == 0
  puts "#{date.month}月 #{date.year}".center(20)
else
  puts "#{params[:m].to_i}月 #{params[:y].to_i}".center(20)
end

puts days.join

if params[:m].to_i == 0
  print "   " * f_date.wday
  today_date.each do |d|
    if d.strftime('%a') == "Sat"
      print d.strftime('%e').rjust(3)
      puts "\n"
    else
      print d.strftime('%e').rjust(3)
    end
  end
else
  print "   " * first_date.wday
  cal_date.each do |c|
    if  c.strftime('%a') == "Sat"
      print c.strftime('%e').rjust(3)
      puts "\n"
    else
      print c.strftime('%e').rjust(3)
    end
  end
end

