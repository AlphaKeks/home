os.execute("xrandr --output DisplayPort-0 --mode 1920x1080 --rate 240.30 --primary --dpi 96")
os.execute("xrandr --output DisplayPort-1 --mode 1920x1080 --rate 60.00 --dpi 96 --left-of DisplayPort-0")
os.execute("xrandr --output DisplayPort-2 --mode 1920x1080 --rate 60.00 --dpi 96 --above DisplayPort-0")
os.execute("xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60.00 --dpi 96 --right-of DisplayPort-0")

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
