#!/usr/bin/env ruby

# Returns just the unique lines of a file.

def unique_lines(filename)
  unique_messages = []
  File.open(filename, "r") do |infile|
    while (line = infile.gets)
      unique_messages << line unless line !~ /\S/
    end
  end

  unique_messages.uniq!

  # current_messages = []
  # File.open("background/current.txt", "r") do |infile|
  #   while (line = infile.gets)
  #     current_messages << line unless line !~ /\S/
  #   end
  # end
  # 
  # unique_messages = new_messages.delete_if { |msg|
  #   current_messages.include?(msg)
  # }

  puts unique_messages
end

if ARGV.length == 1
  unique_lines(ARGV[0])
else
  puts 'Missing argument: script/unique.rb filename'
end