require_relative 'spell_checker'

describe 'SpellChecker' do
  before do
    @spell_checker = SpellChecker.new
    @text = "you are good, But you are not kind"
  end

  it "should be able to read words" do 
    expect = ['you', 'are', 'good', 'but', 'you', 'are', 'not', 'kind']
    expect(@spell_checker.words(@text)).to eq(expect)
  end

  it "should be able to calculate the times of each word" do
    words = ['you', 'are', 'good', 'but', 'you', 'are', 'not', 'kind']
    model = {
      'you' => 3,
      'are' => 3,
      'good' => 2,
      'but' => 2,
      'not' => 2,
      'kind' => 2
    }
    expect(@spell_checker.train(words)).to eq(model)
  end

  it "it should can deletion" do
    @word = 'y'
  #  puts @spell_checker.deletion(@word)
   # puts @spell_checker.transposition(@word) 
   # puts @spell_checker.alteration(@word)
   # puts @spell_checker.insertion(@word) 
  end

  it "should get all the words with edit_len=1" do
    puts @spell_checker.edits1("y")
  end

  it "should be able to correct a word" do
    puts "++"
    puts @spell_checker.correct("ys")
    puts "++"
  end
end
