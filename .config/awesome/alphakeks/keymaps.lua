local gears = require("gears")
local awful = require("awful")
local keys = AlphaKeks.keys
local programs = AlphaKeks.programs

awful.keyboard.append_global_keybindings({
  awful.key({ keys.mod, keys.shift }, "r", function()
    awesome.restart()
  end),

  --[[ very important applications ]]--

  awful.key({ keys.mod }, keys.enter, function()
    awesome.spawn(programs.terminal)
  end),

  awful.key({ keys.mod }, keys.space, function()
    awesome.spawn(programs.launcher)
  end),

  awful.key({ keys.mod }, "b", function()
    awesome.spawn(programs.browser)
  end),

  awful.key({ keys.mod }, "e", function()
    awesome.spawn(programs.filemanager)
  end),

  awful.key({ keys.mod }, "m", function()
    local rofi_beats = os.getenv("HOME") .. "/.local/bin/scripts/rofi-beats.sh"
    awesome.spawn(rofi_beats)
  end),

  awful.key({}, keys.print, function()
    awesome.spawn(programs.screenshots)
  end),

  --[[ window management ]]--
  awful.key({ keys.mod }, "h", function()
    awful.client.focus.global_bydirection("left")
  end),

  awful.key({ keys.mod }, "j", function()
    awful.client.focus.global_bydirection("down")
  end),

  awful.key({ keys.mod }, "k", function()
    awful.client.focus.global_bydirection("up")
  end),

  awful.key({ keys.mod }, "l", function()
    awful.client.focus.global_bydirection("right")
  end),

  awful.key({ keys.mod, keys.shift }, "h", function()
    awful.client.swap.global_bydirection("left")
  end),

  awful.key({ keys.mod, keys.shift }, "j", function()
    awful.client.swap.global_bydirection("down")
  end),

  awful.key({ keys.mod, keys.shift }, "k", function()
    awful.client.swap.global_bydirection("up")
  end),

  awful.key({ keys.mod, keys.shift }, "l", function()
    awful.client.swap.global_bydirection("right")
  end),

  --[[ Switching between tags ]]--

  awful.key({ keys.mod }, "#10", function()
    local tag = awful.screen.focused().tags[1]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#11", function()
    local tag = awful.screen.focused().tags[2]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#12", function()
    local tag = awful.screen.focused().tags[3]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#13", function()
    local tag = awful.screen.focused().tags[4]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#14", function()
    local tag = awful.screen.focused().tags[5]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#15", function()
    local tag = awful.screen.focused().tags[6]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#16", function()
    local tag = awful.screen.focused().tags[7]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#17", function()
    local tag = awful.screen.focused().tags[8]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#18", function()
    local tag = awful.screen.focused().tags[9]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod }, "#19", function()
    local tag = awful.screen.focused().tags[10]
    if tag then
      tag:view_only()
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#10", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[1]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#11", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[2]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#12", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[3]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#13", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[4]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#14", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[5]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#15", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[6]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#16", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[7]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#17", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[8]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#18", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[9]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),

  awful.key({ keys.mod, keys.shift }, "#19", function()
    if not client.focus then
      return
    end

    local tag = client.focus.screen.tags[10]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end),
})

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ keys.mod }, "q", function(c)
      c:kill()
    end),

    awful.key({ keys.mod }, "t", function(c)
      c.floating = false
      c:raise()
    end),

    awful.key({ keys.mod }, "f", function(c)
      c.floating = true
      c:raise()
    end),

    awful.key({ keys.mod, keys.shift }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end),
  })
end)

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({ }, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),

    awful.button({ keys.mod }, 1, function(c)
      c:activate({
        context = "mouse_click",
        action = "mouse_move",
      })
    end),

    awful.button({ keys.mod }, 3, function(c)
      c:activate({
        context = "mouse_click",
        action = "mouse_resize",
      })
    end),
  })
end)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
