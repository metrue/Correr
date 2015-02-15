#!/usr/bin/env ruby

require "optparse"

BIN_PATH = File.expand_path(File.dirname($0))
LIB_PATH = File.expand_path(File.join(BIN_PATH, "./lib"))
TOOLS_PATH = File.expand_path(File.join(BIN_PATH, "./tools"))

Dir[File.join(LIB_PATH, "*.rb")].each do |file|
  require file
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: typo_check.rb a commandline tool to check your typo"

  opts.on("--type ", "File type, plain, ruby, python, c, c++") do |value|
    options[:type] = value
  end

  opts.on("--files file1,file2,...", Array, "files need to check") do |value|
    options[:files] = value
  end

  opts.on("--words word1, word2,.. ", Array, "words need to check") do |value|
    options[:words] = value
  end
end.parse!

if options[:files] == nil && options[:words] == nil
  system("#{$0} -h")
  exit 0
end


model = Model.new(base_text: File.join(LIB_PATH, "big.txt"))
spell_checker = SpellChecker.new(model: model)

# ++
# correct given words
# ++
if options[:words]
  options[:words].each do |word|
    correct = spell_checker.correct_on_word(word)
    printf("%-20s\t-->\t%20s\n", word, correct)
  end
  exit 0
end

# ++
# correct given files
# ++
threads = []
options[:files].each do |file|
  threads << Thread.new do
    if options[:type] == nil
      file_type = File.extname(file).sub(/^\./, '')
    end
    # ++
    # get comments from source code file
    # ++
    original_comments = CommentGetter.on(file: file, type: file_type)
    correct = {}
    original_comments.each do |comment_line|
      correct[comment_line] = spell_checker.correct_on_text(comment_line.clone)
    end

    str = File.read(file)
    correct.each_pair do |key, value|
      # ++
      # gsub! with happen on origin string, gsub will not
      # ++
      str.gsub!(key, value)
    end
    File.open("#{file}.corrected", "w") do |f|
      f.puts str
    end

    # ++
    # show the nice diff between original file and corrected file
    # ++
    system(File.join(TOOLS_PATH, "icdiff") + " #{file} #{file}.corrected")
  end
end
threads.each { |t| t.join }
