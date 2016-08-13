module ApplicationHelper

  def task_state_active(task, state)
    'active' if task.send("#{state}?")
  end

  def task_state_value(state)
    Task.states.index(state)
  end

end
