class CommentGetter
  def self.on(file:, type:)
    type ||= 'plain'
    case type
    when 'plain'
      File.read(file)
    when 'ruby'
      comments_of_ruby(file)
    when 'perl'
      comments_of_ruby(file)
    when 'shell'
      comments_of_ruby(file)
    else
      comments_of_ruby(file)
    end
  end

  def self.comments_of_ruby(source_file)
    comments = []
    File.readlines(source_file).each do |line|
      if line =~ /(\#.*)$/
        comments << line
      end    
    end  
    comments
  end
end
