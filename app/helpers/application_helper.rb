module ApplicationHelper
  def page_title(obj)
    case action_name
    when "new", "create"
      "Create new #{obj.class.to_s.downcase}"
    when "edit", "update"
      "Editing #{obj.class.to_s.downcase}"
    else
      nil
    end
  end
end
