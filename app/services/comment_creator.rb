class CommentCreator

  attr_reader :comment

  # def self.build(scope, current_user, comment_params)
  #   comment = scope.build(comment_params)
  #   comment.user = current_user

  #   new()
  # end

  def initilize(comment)
    @comment = comment
  end

  # def save
  #   # binding.pry
  #   if comment.save?
  #     notify_watchers
  #   end
  # end




end
