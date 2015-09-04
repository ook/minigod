#!/usr/bin/env ruby -w

args = ARGV
watching = args.join(' ')

break_requested = false

abort('No command, no watch…') if watching.strip.length == 0

Signal.trap('TERM') do
  break_requested = true
  puts 'SIGTERM: Minigod WON’T restart the command next time.'
end

puts "Minigod will watch: '#{watching}'"

loop do
  pid = fork do
    exec(watching)  
  end
  Process.wait(pid)
  puts 'Minigod lost its child…'
  break if break_requested
  puts 'Put here a hook for feedback… as an email, SMS, earthquake…'
  puts 'Minigod respawn!'
end

puts 'Minigod die as expected.'
