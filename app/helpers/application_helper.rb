module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Twitter clone"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end

end
