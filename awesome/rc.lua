--     ___                                        
--    /   |_      _____  _________  ________  ___ 
--   / /| | | /| / / _ \/ ___/ __ \/ __  __ \/ _ \
--  / ___ | |/ |/ /  __(__  ) /_/ / / / / / /  __/
-- /_/  |_|__/|__/\___/____/\____/_/ /_/ /_/\___/ 

-- AWESOME CONFIG (~/.config/awesome/rc.lua)
-------------------------------------------------------

-- Hide vim/tmux keybinds from the hotkeys popup
package.loaded['awful.hotkeys_popup.keys.tmux'] = {}
package.loaded['awful.hotkeys_popup.keys.vim'] = {}

-- Importing libraries
local gears = require('gears')
local awful = require('awful')
local wibox = require("wibox")
local naughty = require('naughty')
require('awful.autofocus')
local beautiful = require('beautiful')
local keys = require('keys')
local dpi = require("beautiful.xresources").apply_dpi

-- custom widgets
local todo = require("widgets.todo-widget.todo")
local battery = require("widgets.battery-widget")
local work = require("widgets.work")

-- Loading the theme
theme_path = string.format('%s/.config/awesome/themes/%s/theme.lua', os.getenv('HOME'), 'dusk')
beautiful.init(theme_path)

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.magnifier,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
}

awful.rules.rules = {
    -- All windows
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keys.clientkeys,
                     buttons = keys.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
                   }
    },
        
    -- Floating exceptions
    { rule_any = {
            class = {'Lxappearance', 'qt5ct'},
            name = {'Event Tester'}, --xev
            role = {'pop-up', 'GtkFileChooserDialog'},
            type = {'dialog'}
        },
        properties = {floating = true}
    }
}

-- Limit notification size
naughty.config.defaults['icon_size'] = 100

-- Enable sloppy focus
client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = false})
end)

-- Colored borders
client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)

awful.screen.connect_for_each_screen(function(s)
    -- wibar
    wibar = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = beautiful.bg_normal, fg = beautiful.fg_normal})

    local tagTable = {}
    for i = 1, 5 do
        table.insert(tagTable, tostring(i))
    end

    awful.tag(tagTable, s, awful.layout.layouts[1])

    -- Create a wibox for each screen and add it
    taglist_buttons = gears.table.join(
                        awful.button({ }, 1, function(t) t:view_only() end),
                        awful.button({ modkey }, 1, function(t)
                                                  if client.focus then
                                                      client.focus:move_to_tag(t)
                                                  end
                                              end),
                        awful.button({ }, 3, awful.tag.viewtoggle),
                        awful.button({ modkey }, 3, function(t)
                                                  if client.focus then
                                                      client.focus:toggle_tag(t)
                                                  end
                                              end),
                        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                    )

    -- taglist
    mytaglist = awful.widget.taglist {
      screen = s,
      filter = awful.widget.taglist.filter.all,
      style = {
              shape = gears.shape.rectangle
          },
          layout = {
              spacing = 8,
              layout = wibox.layout.fixed.horizontal
          },
      buttons = taglist_buttons
    }

    -- awesome icon
    local icon = wibox.widget.imagebox(beautiful.awesome_icon, true)

    local separator = wibox.widget.textbox(' ')

    -- random text widget
    local titles = {"δ", "Δ", "λ", "Σ", "φ", "Ψ", "Ω","ω" }
    local flag = 1
    local textbox = wibox.widget.textbox(titles[flag])
    textbox:connect_signal('button::press', function(textbox)
      flag = (flag%8)+1 -- toggle flag
      textbox.markup = titles[flag]
    end)

    -- time & calendar widgets
    local time = wibox.widget.textclock("%I:%M - %d %b - %a")
    local cal = awful.widget.calendar_popup.month({
      style_weekday = {border_color="#0000000"},
      style_header = {border_color="#0000000"},
      style_normal={border_color="#0000000"},
      style_focus={border_color="#0000000"}
    })
    cal:attach(time, 'tr')

    -- attach widgets to wibar
    wibar: setup {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        separator,
        icon,
        separator,
        mytaglist,
      },
      textbox, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        work,
        todo(),
        separator,
        battery {
          ac_prefix = " ",
          battery_prefix = " ",
          percent_colors = {
            { 20, "red"},
            { 21, beautiful.fg_normal},
          },
        },
        separator,
        time,
        separator,
      },
    }
end)

-- Set wallpaper (slideshow)
-- gears.timer {
--   timeout = 600,
--   call_now = true,
--   autostart = true,
--   callback = function()
--     awful.spawn.with_shell('feh --randomize --bg-fill /usr/share/backgrounds')
--   end
-- }

awful.spawn.with_shell('feh --bg-scale /usr/share/backgrounds/ds.png')

-- Autostart
awful.spawn.with_shell('picom --experimental-backends')

-- Garbage Collection
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
