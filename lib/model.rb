class Model
  # ++
  # Term-Frequency
  # ++
  attr_reader :tf

  def initialize(base_text: base_text)
    @tf = train(words(File.read(base_text)))
  end

  def words(text)
    text.downcase.scan(/[a-z]+/)
  end

  def train(words)
    model = Hash.new(1)
    words.each {|f| model[f] += 1 }
    model
  end
end
