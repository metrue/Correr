class SpellChecker
  def initialize(model:)
    raise "No model given, cannot do spell checking" if model == nil
    @letters = ('a'..'z').to_a.join
    @model = model     
  end

  def correct_on_text(text)
    # ++
    # should notice that correction happend right on the origin text
    # ++ 
    correct = {}
    text.scan(/\w+/).each do |word|
       correct[word] =  correct_on_word(word)
    end

    correct.each_pair do |key, val|
      text.gsub!(key, val)
    end
    text
  end

  def correct_on_word(word)
    (known([word]) or known(edits1(word)) or known_edits2(word) or
      [word]).max {|a,b| @model.tf[a] <=> @model.tf[b] }
  end

  private
  # ++
  # get all the words with edit_distance == 1
  # a n-length word edit_distance == 1 nclude:
  #   a. deletion (n)
  #   b. transpositon (n-1)
  #   c. insertion (26(n+1))
  #   d. alteration (25n)
  # ++
  def edits1(word)
    result = deletion(word) + transposition(word) + alteration(word) + 
     insertion(word)
    result.empty? ? nil : result
  end

  def known_edits2(word)
    result = []
    edits1(word).each do |e1| 
      edits1(e1).each do
      |e2| result << e2 if @model.tf.has_key?(e2) 
      end
    end
    result.empty? ? nil : result
  end

  def deletion(word)
    n = word.length
    (0...n).collect do |i| 
      word[0...i] + word[ i + 1..-1] 
    end
  end

  def transposition(word)
    n = word.length
    (0...n-1).collect do |i|
      word[0...i] + word[i+1,1] + word[i,1] + word[i+2..-1]
    end
  end

  def alteration(word)
    n = word.length
    alteration = []
    n.times do |i| 
      @letters.each_byte do |l| 
        alteration << word[0...i]+l.chr+word[i+1..-1]
      end
    end
    alteration
  end

  def insertion(word)
    n = word.length
    insertion = []
    (n+1).times do |i| 
      @letters.each_byte do |l| 
        insertion << word[0...i]+l.chr+word[i..-1] 
      end
    end
    insertion
  end

  def known(words)
    result = words.find_all {|w| @model.tf.has_key?(w) }
    result.empty? ? nil : result
  end
end
