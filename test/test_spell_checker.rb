require_relative 'spell_checker'

describe 'SpellChecker' do
  before do
    @text = "you are good, But you are not kind"
  end

  it "should be able to read words" do 
    expect = ['you', 'are', 'good', 'but', 'you', 'are', 'not', 'kind']
    expect(SpellChecker.words(@text)).to eq(expect)
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
    expect(SpellChecker.train(words)).to eq(model)
  end

  it "should be able to correct a word" do
    expect(SpellChecker.correct_on_word("ys")).to eq('is')
  end

  it "should be able to correct on a text" do
    text = "you are godd\n"
    expect(SpellChecker.correct_on_text(text)).to eq("you are good\n")
  end
end
