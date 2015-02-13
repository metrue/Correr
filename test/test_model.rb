require_relative 'model'

describe "Model" do
  before do
    @model = Model.new(base_text: 'holmes.txt')
  end

  it "should be able to count the term frequency" do
    puts @model.tf
  end
end
