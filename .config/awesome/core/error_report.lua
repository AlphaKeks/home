local naughty = require("naughty")
local errors = awesome.startup_errors

if errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Errors occurred during startup.",
    text = tostring(errors),
  })
end

do
  local in_error = false

  awesome.connect_signal("debug::error", function(err)
    if in_error then
      return
    end

    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Error occurred.",
      text = tostring(err),
    })

    in_error = false
  end)
end

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
