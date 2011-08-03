#!/usr/bin/env ruby

# REFERENCES
# Mention of API: http://biorelated.wordpress.com/2009/01/06/approximate-string-matching-metrics-with-amatch/
# Home of API: http://flori.github.com/amatch/
# Documentation of API: http://flori.github.com/amatch/doc/index.html

require 'rubygems'
require 'bundler/setup'
require 'amatch'

class String
  attr_accessor :flagged
end

def compare(aa, bb)
  i = 0
  aa.each do |a|
    i += 1
    
    j = 0
    bb.each do |b|
      j += 1
      
      next if a.equal?(b) || b.flagged
      
      value = a.hamming_similar(b)
      
      if value > 0.5
        puts "%f -----" % value
        puts "%d: %s" % [i, a]
        puts "%d: %s" % [j, b]
        
        a.flagged = true
        
        next
      end
    end
  end
end

def compare_files(file1, file2)  
  current_messages = []
  File.open(file1, "r") do |infile|
    while (line = infile.gets)
      current_messages << line unless line !~ /\S/
    end
  end

  new_messages = []
  File.open(file2, "r") do |infile|
    while (line = infile.gets)
      new_messages << line unless line !~ /\S/
    end
  end

  compare(current_messages, new_messages)
end

def compare_within_file(file)
  messages = []
  File.open(file, "r") do |infile|
    while (line = infile.gets)
      messages << line unless line !~ /\S/
    end
  end
  
  compare(messages, messages)
end

if ARGV.length == 1
  compare_within_file(ARGV[0])
elsif ARGV.length == 2
  compare_files(ARGV[0], ARGV[1])
else
  puts 'Missing arguments: script/compare.rb file1 [file2]'
end