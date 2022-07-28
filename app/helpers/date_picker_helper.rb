module DatePickerHelper
  def task_form_path(options)
    new_params = {}
    new_params[:project_id] = params[:project_id] || options[:project_id]
    new_params[:selected_date] = options.has_key?(:selected_date) ? options[:selected_date] : selected_date
    new_params[:month_index] = options[:month_index] if options[:month_index]

    new_project_task_path(new_params)
  end

  def date_picker_suggestion_for(name, date, &block)
    render(
      partial: 'date_picker_suggestion',
      locals: { name:, date:, block: }
    )
  end

  def date_picker_description(date)
    return 'Due date' unless date

    date = date.to_date

    if date == today
      'Today'
    elsif date == today + 1.day
      'Tomorrow'
    elsif date > today && date <= today + 7.days
      date.strftime('%A')
    else
      date.strftime('%-d %b')
    end
  end

  def today
    Date.today
  end

  def month_index
    return (selected_date.to_date.month - today.month) if selected_date && params[:month_index].nil?

    params[:month_index].to_i
  end

  def str_date(date)
    date.to_s.split(' ')[0]
  end

  def calendar_month_days
    calendar_first_day_of_month.at_beginning_of_week..calendar_last_day_of_month.at_end_of_week
  end

  def calendar_day_css_class(date)
    css_class = ''
    css_class += 'selected' if date.to_s == selected_date
    css_class += ' disabled' if date < calendar_first_day_of_month || date > calendar_last_day_of_month

    css_class
  end

  private

  def selected_date
    params[:selected_date]
  end

  def calendar_date
    today + month_index.months
  end

  def calendar_first_day_of_month
    calendar_date.at_beginning_of_month
  end

  def calendar_last_day_of_month
    calendar_date.at_end_of_month
  end
end
