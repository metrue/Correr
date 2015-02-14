require_relative '../lib/comment_getter'

describe "CommentGetter" do
  before do
#    @ruby_file = 'spell_checker.rb'
#    @ruby_text = File.read(@ruby_file)

    @python_file = 'test.py'
    @python_text = File.read(@python_file)

    @c_file = 'test.c'
    @c_text = File.read(@c_file)
  end

  it "should be able to get all text when it's a plain file" do

#    expect(CommentGetter.on(file:@file, type:'plain')).to eq(text)
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
    #expect(CommentGetter.on(file:@file, type:'ruby')).to eq(comments_array)
  end

  it "should be able to get comments from python source code file" do
    expect(CommentGetter.on(file:@python_file, type:'python')).to eq('')
  end

  it "should be able to get comments from C/C++ source code file" do
   # expect(CommentGetter.on(file:@c_file, type:'c')).to eq('')
  end
end
