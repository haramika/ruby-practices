#!/usr/bin/env ruby

# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = scores.flat_map { |s| s == 'X' ? [10, 0] : s.to_i }

frames = shots.each_slice(2).to_a

total_point = frames.each_with_index.sum do |frame, i|
  if frame[0] == 10 && i < 9
    frame = frame.sum + frames[i + 1].sum
    frame += frames[i + 2].first if frames[i + 1].first == 10
    frame
  elsif frame.sum == 10 && i < 9
    frame.sum + frames[i + 1].first
  else
    frame.sum
  end
end
puts total_point
