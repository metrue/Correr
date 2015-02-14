class CommentGetter
  def self.on(file:, type:)
    type ||= 'plain'
    case type
    when 'plain'
      [File.read(file)]
    when 'ruby','rb'
      comments_of_ruby(file)
    when 'python','py'
      comments_of_python(file)
    when 'perl','pl'
      comments_of_perl(file)
    when 'shell','sh'
      comments_of_shell(file)
    when 'javascript','js'
      comments_of_c(file)
    when 'c','h'
      comments_of_c(file)
    when 'c++','cpp','cxx'
      comments_of_cpp(file)
    else
      [File.read(file)]
    end
  end

  # ++
  # get comments of ruby source code
  # ++
  def self.comments_of_ruby(source_file)
    comments = []
    File.readlines(source_file).each do |line|
      if line =~ /^#\!/
        next
      elsif line =~ /(\#.*)$/
        comments << line
      end    
    end  
    comments
  end

  # ++
  # get commendts of shell source code
  # ++
  def self.comments_of_shell(source_file)
    comments_of_ruby(source_file)
  end
  
  # ++
  # get commendts of perl source code
  # ++
  def self.comments_of_perl(source_file)
    comments_of_ruby(source_file)
  end
  
  # ++
  # get comments of python
  # ++
  def self.comments_of_python(source_file)
    comments = []
    multi_comment = false
    File.readlines(source_file).each do |line|
      if line =~ /^#\!/
        next
      elsif multi_comment == false && line =~ /'''/
        # ++
        # multi comment start
        # ++
        comments << line
        multi_comment = true
      elsif multi_comment == false && line !~ /'''/
        if line =~ /\s*(#.*)$/
          comments << line
        end
      elsif multi_comment == true && line =~ /'''/
        # ++
        # multi comment end
        # ++
        comments << line
        multi_comment = false
      elsif multi_comment == true && line !~ /'''/
        comments << line
      end
    end
    comments
  end

  # ++
  # get comments of C/C++
  # ++
  def self.comments_of_c(source_file)
    comments = []
    multi_comment = false
    File.readlines(source_file).each do |line|
      if multi_comment == false && line =~ /\/\*/
        # ++
        # multi comment start
        # ++
        comments << line
        multi_comment = true
      elsif multi_comment == false && line !~ /\/\*/
        if line =~ /.*(\/\/.*)$/
          comments << line
        end
      elsif multi_comment == true && line =~ /\*\//
        # ++
        # multi comment end
        # ++
        comments << line
        multi_comment = false
      elsif multi_comment == true && line !~ /\*\//
        comments << line
      end
    end
    comments
  end

  def self.comments_of_cpp(source_file)
    comments_of_c(source_file)
  end
end
