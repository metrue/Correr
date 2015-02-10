require_relative 'spell_checker'
require "optparse"




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
