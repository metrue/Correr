#!/usr/bin/env ruby

require_relative './lib/spell_checker'
require_relative './lib/comment_getter'

require "optparse"

def correction(text:)
  text.scan(/\w+/).each do |word|
     correct[word] =  SpellChecker.correct(word)
  end

  correct.each_pair do |key, val|
    text.gsub!(key, val)
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: typo_check.rb a commandline tool to check your typo"

  opts.on("-t", "--type ", "File type, plain, ruby, python, c, c++") do |value|
    options['type'] = value
  end

  opts.on("-f", "--file ", "file name") do |value|
    options['file'] = value
  end
end.parse!

# ++
# get comments from source code file
# ++
original_comments = CommentGetter.on(file: options['file'], 
                                     type: 'ruby')
correct = {}
original_comments.each do |comment_line|
  correct[comment_line] = SpellChecker.correct_on_text(comment_line.clone)
end

str = File.read(options['file'])
correct.each_pair do |key, value|
  # ++
  # gsub! with happen on origin string, gsub will not
  # ++
  str.gsub!(key, value)
end
File.open("#{options['file']}.corrected", "w") do |f|
  f.puts str
end

# ++
# show the nice diff between original file and corrected file
# ++
system("tools/icdiff #{options['file']} #{options['file']}.corrected")

__END__
correct = {}
File.read('README.md').scan(/\w+/).each do |word|
   correct[word] =  SpellChecker.correct(word)
end

str = File.read('README.md')
correct.each_pair do |key, val|
  str.gsub!(key, val)
end

File.open('readme.md.bak', 'w') do |f|
  f.write str
end
