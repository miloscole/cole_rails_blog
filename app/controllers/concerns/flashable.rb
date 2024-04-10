module Flashable
  extend ActiveSupport::Concern

  def success_msg(options = {})
    return flash["jade-350"] = options[:custom] unless options[:custom].nil?
    expected_keys = [:for, :with, :action]
    unexpected_keys = options.keys - expected_keys
    return flash["jade-350"] = "Action succeeded!" if options.empty? || unexpected_keys.present?

    action = action_name
    action = "delete" if action_name == "destroy"

    msg_for = self.class.name.gsub("Controller", "").singularize
    flash["jade-350"] = "#{(options[:for] || msg_for).capitalize}
                         #{options[:with]} was successfully
                         #{options[:action] || action}d!"
  end

  def error_msg(custom = nil)
    custom ||= "Something went wrong, please try again"
    flash["red-550"] = custom
  end
end
