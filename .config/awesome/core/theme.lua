local dpi = require("beautiful.xresources").apply_dpi
local colors = AlphaKeks.colors
local fonts = AlphaKeks.fonts

return {
  -- The Awesome icon path
  awesome_icon = "/mnt/mass/pictures/Schnose/schnose.png",
  -- The default focused element background color
  bg_focus = colors.base,
  -- The default minimized element background color
  bg_minimize = colors.mantle,
  -- The default background color
  bg_normal = colors.base,
  -- The systray background color
  bg_systray = colors.base,
  -- The default urgent element background color
  bg_urgent = colors.red,
  -- The border color when the client is active
  border_color_active = colors.base,
  -- The fallback border color when the client is floating
  border_color_floating = colors.subtext1,
  -- The border color when the (floating) client is active
  border_color_floating_active = colors.text,
  -- The border color when the (floating) client is not active and new
  border_color_floating_new = colors.subtext1,
  -- The border color when the (floating) client is not active
  border_color_floating_normal = colors.subtext1,
  -- The border color when the (floating) client has the urgent property set
  border_color_floating_urgent = colors.red,
  -- The border color when the (fullscreen) client has the urgent property set
  border_color_fullscreen_urgent = colors.red,
  -- The border color when the client is marked
  border_color_marked = colors.mauve,
  -- The border color when the client is not active and new
  border_color_new = colors.base,
  -- The border color when the client is not active
  border_color_normal = colors.base,
  -- The border color when the client has the urgent property set
  border_color_urgent = colors.red,
  -- The fallback border width when nothing else is set
  border_width = 2,
  -- The client border width for the active client
  border_width_active = 2,
  -- The fallback border width when the client is floating
  border_width_floating = 4,
  -- The client border width for the active floating client
  border_width_floating_active = 4,
  -- The client border width for the new floating clients
  border_width_floating_new = 4,
  -- The client border width for the normal floating clients
  border_width_floating_normal = 4,
  -- The client border width for the urgent floating clients
  border_width_floating_urgent = 4,
  -- The client border width for the fullscreen clients
  border_width_fullscreen = 0,
  -- The client border width for the active fullscreen client
  border_width_fullscreen_active = 0,
  -- The client border width for the new fullscreen clients
  border_width_fullscreen_new = 0,
  -- The client border width for the normal fullscreen clients
  border_width_fullscreen_normal = 0,
  -- The client border width for the urgent fullscreen clients
  border_width_fullscreen_urgent = 2,
  -- The fallback border width when the client is maximized
  border_width_maximized = 0,
  -- The client border width for the active maximized client
  border_width_maximized_active = 0,
  -- The client border width for the new maximized clients
  border_width_maximized_new = 0,
  -- The client border width for the normal maximized clients
  border_width_maximized_normal = 0,
  -- The client border width for the urgent maximized clients
  border_width_maximized_urgent = 2,
  -- The client border width for the new clients
  border_width_new = 2,
  -- The client border width for the normal clients
  border_width_normal = 2,
  -- The client border width for the urgent clients
  border_width_urgent = 2,
  -- The calendar font
  calendar_font = fonts.normal,
  -- Format the weekdays with three characters instead of two
  calendar_long_weekdays = true,
  -- Start the week on Sunday
  calendar_start_sunday = false,
  -- Display the calendar week numbers
  calendar_week_numbers = false,
  -- The outer (unchecked area) background color, pattern or gradient
  checkbox_bg = colors.mantle,
  -- The outer (unchecked area) border color
  checkbox_border_color = colors.crust,
  -- The outer (unchecked area) border width
  checkbox_border_width = 1,
  -- The checked part border color
  checkbox_check_border_color = colors.lavender,
  -- The checked part border width
  checkbox_check_border_width = 2,
  -- The checked part filling color
  checkbox_check_color = colors.subtext0,
  -- The checked part shape
  checkbox_check_shape = "rectangle",
  -- The padding between the outline and the progressbar
  checkbox_paddings = 2,
  -- The outer (unchecked area) shape
  checkbox_shape = "rectangle",
  -- The default focused element foreground (text) color
  fg_focus = colors.text,
  -- The default minimized element foreground (text) color
  fg_minimize = colors.text,
  -- The default focused element foreground (text) color
  fg_normal = colors.text,
  -- The default urgent element foreground (text) color
  fg_urgent = colors.red,
  -- The default font
  font = fonts.normal,
  -- Hide the border on fullscreen clients
  fullscreen_hide_border = true,
  -- The graph foreground color
  graph_fg = colors.poggers,
  -- The icon theme name
  icon_theme = "Papirus-Colors-Dark",
  -- The layoutlist font
  layoutlist_font = fonts.monospace,
  -- The selected layout title font
  layoutlist_font_selected = fonts.monospace,
  -- The default number of master windows
  master_count = 1,
  -- Hide the border on maximized clients
  maximized_hide_border = true,
  -- Honor the screen padding when maximizing
  maximized_honor_padding = false,
  -- The default focused item background color
  menu_bg_focus = colors.base,
  -- The default background color
  menu_bg_normal = colors.base,
  -- The menu item border color
  menu_border_color = colors.base,
  -- The menu item border width
  menu_border_width = 1,
  -- The default focused item foreground (text) color
  menu_fg_focus = colors.text,
  -- The default foreground (text) color
  menu_fg_normal = colors.text,
  -- The menu text font
  menu_font = fonts.normal,
  -- Menubar selected item background color
  menubar_bg_focus = colors.overlay0,
  -- Menubar normal background color
  menubar_bg_normal = colors.base,
  -- Menubar border color
  menubar_border_color = colors.base,
  -- Menubar selected item text color
  menubar_fg_focus = colors.text,
  -- Menubar normal text color
  menubar_fg_normal = colors.text,
  -- Menubar font
  menubar_font = fonts.normal,
  -- The background color for normal actions
  notification_action_bg_normal = colors.base,
  -- The background color for selected actions
  notification_action_bg_selected = colors.overlay0,
  -- The background image for normal actions
  notification_action_bgimage_normal = colors.mantle,
  -- The background image for selected actions
  notification_action_bgimage_selected = colors.overlay0,
  -- The foreground color for normal actions
  notification_action_fg_normal = colors.text,
  -- The foreground color for selected actions
  notification_action_fg_selected = colors.lavender,
  -- Notifications background color
  notification_bg = colors.crust,
  -- The background color for normal notifications
  notification_bg_normal = colors.crust,
  -- The background color for selected notifications
  notification_bg_selected = colors.surface2,
  -- Notifications border color
  notification_border_color = colors.poggers,
  -- Notifications border width
  notification_border_width = 2,
  -- The foreground color for normal notifications
  notification_fg_normal = colors.overlay0,
  -- The foreground color for selected notifications
  notification_fg_selected = colors.overlay2,
  -- Notifications font
  notification_font = fonts.normal,
  -- The maximum notification position
  notification_position = "bottom_right",
  -- The client opacity for the normal floating clients
  opacity_floating_normal = 0.95,
  -- The progressbar background color
  progressbar_bg = colors.mantle,
  -- The progressbar foreground color
  progressbar_fg = colors.poggers,
  -- The prompt background color
  prompt_bg = colors.mantle,
  -- The prompt cursor background color
  prompt_bg_cursor = colors.text,
  -- The prompt foreground color
  prompt_fg = colors.text,
  -- The prompt cursor foreground color
  prompt_fg_cursor = colors.text,
  -- The prompt text font
  prompt_font = fonts.monspace,
  -- The separator's color
  separator_color = colors.mantle,
  -- The systray icon spacing
  systray_icon_spacing = 12,
  -- The maximum number of rows for systray icons
  systray_max_rows = 1,
  -- The tag list empty elements background color
  taglist_bg_empty = colors.mantle,
  -- The tag list main background color
  taglist_bg_focus = colors.mantle,
  -- The tag list occupied elements background color
  taglist_bg_occupied = colors.mantle,
  -- The tag list urgent elements background color
  taglist_bg_urgent = colors.mantle,
  -- The tag list volatile elements background color
  taglist_bg_volatile = colors.mantle,
  -- Do not display the tag icons, even if they are set
  taglist_disable_icon = true,
  -- The tag list empty elements foreground (text) color
  taglist_fg_empty = colors.mantle,
  -- The tag list main foreground (text) color
  taglist_fg_focus = colors.lavender,
  -- The tag list occupied elements foreground (text) color
  taglist_fg_occupied = colors.surface1,
  -- The tag list urgent elements foreground (text) color
  taglist_fg_urgent = colors.red,
  -- The tag list volatile elements foreground (text) color
  taglist_fg_volatile = colors.yellow,
  -- The taglist font
  taglist_font = fonts.monospace,
  -- The elements shape border color
  taglist_shape_border_color = colors.mantle,
  -- The empty elements shape border color
  taglist_shape_border_color_empty = colors.mantle,
  -- The selected elements shape border color
  taglist_shape_border_color_focus = colors.mantle,
  -- The urgents elements shape border color
  taglist_shape_border_color_urgent = colors.mantle,
  -- The volatile elements shape border color
  taglist_shape_border_color_volatile = colors.mantle,
  -- The shape elements border width
  taglist_shape_border_width = 0,
  -- The shape used for the empty elements border width
  taglist_shape_border_width_empty = 0,
  -- The shape used for the selected elements border width
  taglist_shape_border_width_focus = 0,
  -- The shape used for the urgent elements border width
  taglist_shape_border_width_urgent = 0,
  -- The shape used for the volatile elements border width
  taglist_shape_border_width_volatile = 0,
  -- The space between the taglist elements
  taglist_spacing = dpi(1),
  -- The focused client background color
  tasklist_bg_focus = colors.mantle,
  -- The minimized clients background color
  tasklist_bg_minimize = colors.surface0,
  -- The default background color
  tasklist_bg_normal = colors.mantle,
  -- The urgent clients background color
  tasklist_bg_urgent = colors.red,
  -- Disable the tasklist client icons
  tasklist_disable_icon = colors.red,
  -- Disable the tasklist client titles
  tasklist_disable_task_name = false,
  -- The focused client foreground (text) color
  tasklist_fg_focus = colors.text,
  -- The minimized clients foreground (text) color
  tasklist_fg_minimize = colors.text,
  -- The default foreground (text) color
  tasklist_fg_normal = colors.text,
  -- The urgent clients foreground (text) color
  tasklist_fg_urgent = colors.text,
  -- The tasklist font
  tasklist_font = colors.normal,
  -- The focused client title alignment
  tasklist_font_focus = colors.normal,
  -- The minimized clients font
  tasklist_font_minimized = colors.normal,
  -- The urgent clients font
  tasklist_font_urgent = colors.normal,
  -- The titlebar background color
  titlebar_bg = colors.base,
  -- The focused titlebar background color
  titlebar_bg_focus = colors.base,
  -- The titlebar background color
  titlebar_bg_normal = colors.base,
  -- The urgent titlebar background color
  titlebar_bg_urgent = colors.base,
  -- The titlebar foreground (text) color
  titlebar_fg = colors.text,
  -- The focused titlebar foreground (text) color
  titlebar_fg_focus = colors.text,
  -- The titlebar foreground (text) color
  titlebar_fg_normal = colors.text,
  -- The urgent titlebar foreground (text) color
  titlebar_fg_urgent = colors.red,
  -- The default gap
  useless_gap = dpi(8),
  -- The default wallpaper background color
  wallpaper_bg = colors.base,
  -- The default wallpaper foreground color
  wallpaper_fg = colors.base,
  -- The wibar's background color
  wibar_bg = colors.mantle,
  -- The wibar border color
  wibar_border_color = colors.mantle,
  -- The wibar border width
  wibar_border_width = 0,
  -- The wibar's foreground (text) color
  wibar_fg = colors.text,
  -- The wibar's height
  wibar_height = 20,
  -- If the wibar is to be on top of other windows
  wibar_ontop = false,
}

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
