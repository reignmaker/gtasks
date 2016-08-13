module ApplicationHelper

  def task_state_active(task, state)
    'active' if task.send("#{state}?")
  end

  def task_state_value(state)
    Task.states.index(state)
  end

  def render_task_attachment(attachment)
    if attachment.file
      return image_tag(attachment.file_url) if attachment.file.is_image?
      return link_to(attachment.file.file.filename, attachment.file_url) unless attachment.file.is_image?
    end
  end

end
