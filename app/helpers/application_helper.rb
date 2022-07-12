module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end

  def menu_list_item_for(name, path, quantity, &block)
    render(
      partial: 'layouts/menu_list_item',
      locals: { name:, path:, quantity:, block: }
    )
  end

  def colors
    [
      { name: 'Black', value: 'black' },
      { name: 'Red', value: 'red' },
      { name: 'Orange', value: 'orange' },
      { name: 'Yellow', value: 'yellow' },
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
