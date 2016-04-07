module ApplicationHelper
  def error_messages_for(object)
    render 'error_messages', object: object
  end
end
