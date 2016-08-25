module ApplicationHelper

  def task_state_active(task, state)
    'active' if task.send("#{state}?")
  end

  def task_state_value(state)
    Task.states.index(state)
  end

  def render_task_attachment(attachment)
    return false unless attachment.file.present?
    if attachment.file.is_image?
      image_tag(attachment.file_url)
    else
      link_to(attachment.file.file.filename, attachment.file_url)
    end
  end

end
