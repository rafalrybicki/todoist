module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end

  def colors
    [
      { index: 1, name: 'Red', value: 'red' },
      { index: 2, name: 'Orange', value: 'orange' },
      { index: 3, name: 'Yellow', value: 'yellow' },
      { index: 4, name: 'Olive Green', value: '#afb83b' },
      { index: 5, name: 'Lime Green', value: 'limegreen' },
      { index: 6, name: 'Green', value: 'green' },
      { index: 7, name: 'Mint Green', value: '#6accbc' },
      { index: 8, name: 'Teal', value: 'teal' },
      { index: 9, name: 'Sky Blue', value: 'skyblue' },
      { index: 10, name: 'Blue', value: 'blue' },
      { index: 11, name: 'Grape', value: '#884dff' },
      { index: 12, name: 'Violet', value: 'violet' },
      { index: 13, name: 'Lavender', value: 'lavender' },
      { index: 14, name: 'Magenta', value: 'magenta' },
      { index: 15, name: 'Salmon', value: 'salmon' },
      { index: 16, name: 'Grey', value: 'grey' },
      { index: 17, name: 'Taupe', value: '#ccac93' },
      { index: 18, name: 'Black', value: 'black' },
      { index: 0, name: 'Charcoal', value: '#808080' }
    ]
  end
end
