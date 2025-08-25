#!/usr/bin/env ruby

# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = scores.flat_map { |s| s == 'X' ? [10, 0] : s.to_i }

frames = shots.each_slice(2).to_a

total_point = frames.each_with_index.sum do |frame, i|
  frame.sum + if i >= 9
                0
              elsif frame[0] == 10
                frame = frames[i + 1].sum
                frame += frames[i + 2].first if frames[i + 1].first == 10
                frame
              elsif frame.sum == 10
                frames[i + 1].first
              else
                0
              end
end

puts total_point
