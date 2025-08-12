#!/usr/bin/env ruby

# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

total_point = 0

frames.each_with_index do |frame, i|
  total_point +=
    if i >= 9
      frame.sum
    elsif frame[0] == 10
      if frames[i + 1].first == 10
        frame.sum + frames[i + 1].sum + frames[i + 2].first
      else
        frame.sum + frames[i + 1].sum
      end
    elsif frame.sum == 10
      frame.sum + frames[i + 1].first
    else
      frame.sum
    end
end
puts total_point
