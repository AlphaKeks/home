os.execute("xrandr --output DisplayPort-2 --mode 1920x1080 --rate 240.30 --primary --dpi 96")
os.execute("xrandr --output DisplayPort-3 --mode 1920x1080 --rate 60.00 --dpi 96 --left-of DisplayPort-2")
os.execute("xrandr --output DisplayPort-4 --mode 1920x1080 --rate 60.00 --dpi 96 --above DisplayPort-2")
os.execute("xrandr --output HDMI-A-2 --mode 1920x1080 --rate 60.00 --dpi 96 --right-of DisplayPort-2")

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
