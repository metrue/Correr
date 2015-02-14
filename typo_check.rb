#!/usr/bin/env ruby

require "optparse"
require_relative './lib/spell_checker'
require_relative './lib/comment_getter'
require_relative './lib/model'

model = Model.new(base_text: './lib/holmes.txt')
spell_checker = SpellChecker.new(model: model)

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: typo_check.rb a commandline tool to check your typo"

  opts.on("-t", "--type ", "File type, plain, ruby, python, c, c++") do |value|
    options[:type] = value
  end

  opts.on("-f", "--file ", "file name") do |value|
    options[:file] = value
  end
end.parse!

if options[:file] == nil
  system("#{$0} -h")
  exit 0
elsif options[:type] == nil
  file_name = options[:file]
  file_type = File.extname(options[:file]).sub(/^\./, '')
end

# ++
# get comments from source code file
# ++
puts file_name
puts file_type
original_comments = CommentGetter.on(file: file_name, type: file_type)
correct = {}
original_comments.each do |comment_line|
  correct[comment_line] = spell_checker.correct_on_text(comment_line.clone)
end

str = File.read(file_name)
correct.each_pair do |key, value|
  # ++
  # gsub! with happen on origin string, gsub will not
  # ++
  str.gsub!(key, value)
end
File.open("#{file_name}.corrected", "w") do |f|
  f.puts str
end

# ++
# show the nice diff between original file and corrected file
# ++
system("tools/icdiff #{file_name} #{file_name}.corrected")
