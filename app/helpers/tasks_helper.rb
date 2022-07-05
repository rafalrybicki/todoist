module TasksHelper
  def task_css_class
    css_class = 'task'
    css_class += ' task--completed' if completed?
    css_class += ' task--scheduled' if target_date

    css_class
  end

  def target_date_css_class
    css_class = 'task__target-date'
    css_class += ' task__target-date--overdue' if overdue?

    css_class
  end

  def completed?
    completed == true
  end

  def overdue?
    completed == false && target_date < Time.now.beginning_of_day
  end
end
