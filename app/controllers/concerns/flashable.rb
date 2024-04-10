module Flashable
  extend ActiveSupport::Concern

  def success_msg(options = {})
    expected_keys = [:with, :action]
    unexpected_keys = options.keys - expected_keys
    return flash["jade-350"] = "Action succeeded!" if options.empty? || unexpected_keys.present?

    action = action_name
    action = "delete" if action_name == "destroy"

    msg_for = self.class.name.gsub("Controller", "").singularize
    flash["jade-350"] = "#{msg_for} #{options[:with]} was successfully #{options[:action] || action}d!"
  end
end