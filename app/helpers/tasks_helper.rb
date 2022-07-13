module TasksHelper
  def completed?
    completed == true
  end

  def today?
    today_date?(target_date)
  end

  def overdue?
    overdue_date?(target_date, completed)
  end

  def update_today_tasks_size?(task)
    was_today = today_or_overdue?(task[:prev_target_date])
    is_today = today_or_overdue?(task[:target_date])

    return true if was_today || is_today && task[:completed] != task[:prev_completed]
    return true if (was_today && !is_today) || (!was_today && is_today)

    false
  end

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

  private

  def today_date?(date)
    date && date >= Time.now.beginning_of_day && date <= Time.now.end_of_day
  end

  def overdue_date?(date, completion = false)
    date && date < Time.now.beginning_of_day && completion == false
  end

  def today_or_overdue?(date)
    today_date?(date) || overdue_date?(date)
  end
end
