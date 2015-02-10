require_relative 'comment_getter'

describe "CommentGetter" do
  before do
    @file = 'spell_checker.rb'
  end

  it "should be able to get all text when it's a plain file" do
    text = File.read(@file)
    expect(CommentGetter.on(file:@file, type:'plain')).to eq(text)
  end

  it "should be able to get comment from ruby source code file" do
    comments = <<EOF  
  # ++
  # get all the words with edit_distance == 1
  # a n-length word edit_distance == 1 include:
  #   a. deletion (n)
  #   b. transpositon (n-1)
  #   c. insertion (26(n+1))
  #   d. alteration (25n)
  # ++
EOF
  comments_array = comments.split("\n")
    expect(CommentGetter.on(file:@file, type:'ruby')).to eq(comments_array)
  end
end
