-- Awesome keybindings

-- Importing libraries
local gears = require('gears')
local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')

-- Variables
local keys = {}

tags = 5
metakey = 'Mod4'
terminal = 'xfce4-terminal'
editor = 'nvim'
editor_launch = terminal..' -e '..editor

-- Keybindings
keys.globalkeys = gears.table.join(
   
    -- Awesome
    awful.key({metakey, 'Shift'}, 'r', awesome.restart,
              {description = 'Reload awesome', group = 'Awesome'}),
    awful.key({metakey}, 's', hotkeys_popup.show_help,
              {description='Keybindings', group='Awesome'}),
    awful.key({metakey}, 'Tab', function () awful.layout.inc(1) end,
              {description = 'Next layout', group = 'Awesome'}),
    awful.key({metakey}, 'w', function() awful.spawn.with_shell('feh --randomize --bg-fill /usr/share/backgrounds') end,
              {description='Change wallpaper', group='Awesome'}),

    -- Window management
    awful.key({metakey}, 'Escape', awful.tag.history.restore,
              {description='Return to last tag', group='Tags'}),
    awful.key({metakey}, 'Right', function () awful.tag.incmwfact(0.03) end,
              {description = 'Increase master width factor', group = 'Window Management'}),
    awful.key({metakey}, 'Left', function () awful.tag.incmwfact(-0.03) end,
              {description = 'Decrease master width factor', group = 'Window Management'}),
    awful.key({metakey}, 'h', function() awful.client.focus.byidx(-1) end,
              {description = 'Switch between windows', group = 'Window Management'}),
    awful.key({metakey}, 'l', function() awful.client.focus.byidx(1) end,
              {description = 'Switch between windows', group = 'Window Management'}),
    awful.key({metakey, 'Shift'}, 'h', function () awful.client.swap.byidx(-1)    end,
              {description = "Swap window right", group = "Window Management"}),
    awful.key({metakey, 'Shift'}, 'l', function () awful.client.swap.byidx(1) end,
              {description = 'Swap window left', group = 'Window Management'}),

    -- Applications
    awful.key({metakey}, 'Return', function() awful.util.spawn(terminal) end,
              {description='Xfce4-terminal', group='Applications'}),
    awful.key({metakey}, 'r', function() awful.util.spawn('rofi -show drun') end,
              {description='Rofi', group='Applications'}),
    awful.key({metakey}, 'b', function() awful.util.spawn('firefox') end,
              {description='Firefox', group='Applications'}),
    awful.key({metakey}, 'f', function() awful.util.spawn('pcmanfm') end,
              {description='Pcmanfm', group='Applications'}),

    -- Media Keys
    awful.key({}, 'XF86AudioPlay', function() awful.util.spawn('playerctl play-pause') end,
              {description='Play/Pause', group='Media Keys'}),
    awful.key({}, 'XF86AudioRaiseVolume', function() awful.util.spawn('amixer set Master 5%+') end,
              {description='Increase Volume (by 5%)', group='Media Keys'}),
    awful.key({}, 'XF86AudioLowerVolume', function() awful.util.spawn('amixer set Master 5%-') end,
              {description='Decrease Volume (by 5%)', group='Media Keys'}),
    awful.key({}, 'XF86AudioMute', function() awful.util.spawn('amixer -D pulse set Master toggle') end,
              {description='Mute/Unmute', group='Media Keys'}),
    awful.key({}, 'XF86AudioNext', function() awful.util.spawn('playerctl next') end,
              {description='Next track', group='Media Keys'}),
    awful.key({}, 'XF86AudioPrev', function() awful.util.spawn('playerctl previous') end,
              {description='Previous Track', group='Media Keys'}),

    -- Screenshots
    awful.key({metakey}, 'Print', function() awful.util.spawn('flameshot screen') end,
              {description='Fullscreen capture', group='Screenshots'}),
    awful.key({}, 'Print', function() awful.util.spawn('flameshot gui') end,
              {description='Region Capture', group='Screenshots'}),

    -- Brightness
    awful.key({}, 'XF86MonBrightnessUp', function() awful.util.spawn('xbacklight -inc 10') end,
              {description='Increase Brightness', group='Brightness'}),
    awful.key({}, 'XF86MonBrightnessDown', function() awful.util.spawn('xbacklight -dec 10') end,
              {description='Decrease Brightness', group='Brightness'})
)

keys.clientkeys = gears.table.join(
    awful.key({metakey}, 'q', function(c) c:kill() end,
              {description = 'Close', group = 'Window Management'}),
    awful.key({metakey}, 'space', function(c) c.fullscreen = not c.fullscreen; c:raise() end,
              {description = 'Toggle Fullscreen', group = 'Window Management'}),
    awful.key({metakey, 'Shift'}, 'space', function() awful.client.floating.toggle() end,
              {description = 'Toggle Floating', group = 'Window Management'})
)

-- Mouse controls
keys.clientbuttons = gears.table.join(
    awful.button({}, 1, function(c) client.focus = c end),

    -- Meta + left click to move window
    awful.button({metakey}, 1, function() awful.mouse.client.move() end),

    -- Meta + middle click to kill window
     awful.button({metakey}, 2, function(c) c:kill() end),

    -- Meta + right click to resize window
    awful.button({metakey}, 3, function() awful.mouse.client.resize() end)
)

for i = 1, tags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag
        awful.key({metakey}, '#'..i + 9,
                  function ()
                        local tag = awful.screen.focused().tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = 'View tag #'..i, group = 'Tags'}),
        
        -- Move window to tag
        awful.key({metakey, 'Shift'}, '#'..i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = 'Move focused window to tag #'..i, group = 'Tags'}),

        -- Toggle tag display.
        awful.key({metakey, 'Control'}, '#'..i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = 'Toggle tag #' .. i, group = 'Tags'}))
end

-- Set globalkeys
root.keys(keys.globalkeys)

return keys
