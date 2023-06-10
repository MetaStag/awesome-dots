-- Workbench widget
-- made by @MetaStag

-- Modules
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local HOME = os.getenv('HOME')

-- Loading the theme
theme_path = string.format('%s/.config/awesome/themes/%s/theme.lua', HOME, 'dusk')
beautiful.init(theme_path)

local function study()
  awful.spawn('firefox --new-window https://www.notion.so')
  awful.spawn('firefox --new-window https://piped.kavin.rocks/')
  main_popup.visible = not main_popup.visible
end

local function block()
  awful.spawn.with_shell('~/.config/awesome/widgets/block.sh')
  main_popup.visible = not main_popup.visible
end

local function power()
  power_popup.visible = not power_popup.visible
  awful.placement.under_mouse(power_popup)
end

local function logout()
  awful.spawn('sudo /bin/systemctl restart lightdm.service')
end

local function shutdown()
  awful.spawn('shutdown now')
end

local function reboot()
  awful.spawn('reboot')
end

local main_items = {
  { name = ' Study Mode', func = study},
  { name = ' Block Firefox', func = block},
  { name = 'Power Menu ', func = power}
}

local power_items = {
  { name = ' Log Out', func = logout},
  { name = ' Shutdown', func = shutdown},
  { name = ' Reboot', func = reboot}
}
local function popup_generator()
  return awful.popup {
    ontop = true,
    visible = false, -- should be hidden when created
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 4)
    end,
    border_width = 1,
    maximum_width = 400,
    offset = { y = 5},
    widget = {}
  }
end

main_popup = popup_generator()
power_popup = popup_generator()

local function row_generator(popup, row_items)
  local rows = { layout = wibox.layout.fixed.vertical }
  for _, item in pairs(row_items) do
    local row = wibox.widget {
      {
          {
            text = item.name,
            widget = wibox.widget.textbox
          },
        margins = 8,
        widget = wibox.container.margin
      },
      bg = beautiful.bg_normal,
      widget = wibox.container.background
    }

    row:connect_signal("mouse::enter", function(c) -- hover bg change effect
      c:set_bg(beautiful.bg_focus)
    end)
    row:connect_signal("mouse::leave", function(c)
      c:set_bg(beautiful.bg_normal)
    end)

    row:buttons(
      awful.util.table.join(
        awful.button({}, 1, function()
          item.func()
        end)
      )
    )
    table.insert(rows, row)
  end

  return rows
end

main_popup:setup(row_generator(main_popup, main_items))
power_popup:setup(row_generator(power_popup, power_items))

local work = wibox.widget {
  {
    text = '理 ',
    widget = wibox.widget.textbox
  },
  margins = 1,
  widget = wibox.container.margin
}

work:buttons(
  awful.util.table.join(
    awful.button({}, 1, function()
      if main_popup.visible then
        main_popup.visible = not main_popup.visible
      else
        main_popup.visible = not main_popup.visible
        main_popup:move_next_to(mouse.current_widget_geometry)
      end
      if power.popup.visible then
        power_popup.visible = not power_popup.visible
      end
    end))
)

return work
