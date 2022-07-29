module ApplicationHelper
  include DatePickerHelper

  def inbox_id
    inbox_id ||= current_user.inbox_id
  end

  def today_tasks_size
    current_user.tasks.today.size
  end

  def render_turbo_stream_flash_messages
    turbo_stream.replace 'flash', partial: 'flash'
  end

  def menu_list_item_for(name, path, quantity, project_id = nil, &block)
    render(
      partial: 'menu_list_item',
      locals: { name:, path:, quantity:, project_id:, block: }
    )
  end

  def colors
    [
      { name: 'Black', value: 'black' },
      { name: 'Red', value: 'red' },
      { name: 'Orange', value: 'orange' },
      { name: 'Yellow', value: 'rgb(250, 208, 0)' },
      { name: 'Olive Green', value: '#afb83b' },
      { name: 'Lime Green', value: 'limegreen' },
      { name: 'Green', value: 'green' },
      { name: 'Mint Green', value: '#6accbc' },
      { name: 'Teal', value: 'teal' },
      { name: 'Sky Blue', value: 'skyblue' },
      { name: 'Blue', value: 'blue' },
      { name: 'Grape', value: '#884dff' },
      { name: 'Violet', value: 'violet' },
      { name: 'Lavender', value: 'lavender' },
      { name: 'Magenta', value: 'magenta' },
      { name: 'Salmon', value: 'salmon' },
      { name: 'Grey', value: 'grey' },
      { name: 'Taupe', value: '#ccac93' },
      { name: 'Charcoal', value: '#808080' }
    ]
  end
end
