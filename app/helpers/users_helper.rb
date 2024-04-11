module UsersHelper
  def delete_link_visibility_per_user(user)
    if current_user&.admin? && !user.admin?
      link_to "Delete", user_path(user), data: { turbo_method: :delete, turbo_confirm: "Are you sure?" }
    elsif current_user&.admin? && user.admin?
      content_tag :strong, "Admin"
    else
      nil
    end
  end
end
