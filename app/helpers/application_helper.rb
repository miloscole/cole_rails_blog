module ApplicationHelper
  def page_title_for(object)
    obj = object.instance_of?(Symbol) ? object : object.class.to_s.downcase
    case action_name
    when "new", "create"
      "Create new #{obj}"
    when "edit", "update"
      "Editing #{obj}"
    else
      nil
    end
  end
end
