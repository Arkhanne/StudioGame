# frozen_string_literal: true

def conversation
  puts 'Hello'
  yield
  puts 'Goodbye'
end

conversation { puts 'Good to meet you!' }

def five_times
  5.times { |n| yield n + 1 }
end

five_times do |n|
  puts "#{n} situps"
  puts "#{n} pushups"
  puts "#{n} chinups"
end

def n_times(number)
  number.times { |n| yield n + 1 }
end

n_times(5) do |n|
  puts "#{n} situps"
  puts "#{n} pushups"
  puts "#{n} chinups"
end
