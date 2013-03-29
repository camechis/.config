-- Stand/ard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
vicious = require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- Useful Paths
home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
themes = confdir .. "/themes"

-- Choose Your Theme
active_theme = themes .. "/newblue"

-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init(active_theme .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "gnome-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
gui_editor = "sublime_text"
browser = "chromium"
fileman = "dolphin " .. home
cli_fileman = terminal .. " -e ranger "
music = terminal .. " -e ncmpcpp "
chat = terminal .. " -e weechat-curses "
tasks = terminal .. " --hold -e sudo htop "

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.



tags = {
   settings = {
     { names  = { "www", "editor", "sts", "terms", "firefox", "fileman", "7", "8", "9" },
       layout = { layouts[2], layouts[1], layouts[1], layouts[4], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
     },
     { names  = { "1",  "2", "3", "4", "5", "6", "7", "8", "9" },
       layout = { layouts[3], layouts[2], layouts[2], layouts[5], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
 }}}
 
 for s = 1, screen.count() do
     tags[s] = awful.tag(tags.settings[s].names, s, tags.settings[s].layout)
 end















--tags = {}
--for s = 1, screen.count() do
    -- Each screen has its own tag table.
 --   	tags[s] = awful.tag({ "term", "web", "files", "chat", "media", "work" }, s,
 -- 		{ layouts[2], layouts[1], layouts[2], layouts[1], layouts[1], layouts[2] })
    
    
    --awful.tag.seticon(active_theme .. "/widgets/arch_10x10.png", tags[s][1])
   -- awful.tag.seticon(active_theme .. "/widgets/cat.png", tags[s][2])
   -- awful.tag.seticon(active_theme .. "/widgets/dish.png", tags[s][3])
   -- awful.tag.seticon(active_theme .. "/widgets/mail.png", tags[s][4])
   -- awful.tag.seticon(active_theme .. "/widgets/phones.png", tags[s][5])
   -- awful.tag.seticon(active_theme .. "/widgets/pacman.png", tags[s][6])
--end

-- }}}

	-- {{{ Menu
	-- Create a laucher widget and a main menu
	myawesomemenu = {
	   { "manual"            , terminal .. " -e man awesome" },
	   { "edit config"       , editor_cmd .. " " .. awesome.conffile },
	   { "edit theme"        , editor_cmd .. " " .. active_theme .. "/theme.lua" },  
	}

	myinternet = {
		{ "Chromium"         , "chromium" },
		{ "Incognito Window" , "chromium --incognito" },
		{ "Chromium + dom"   , "chromium --auth-server-whitelist=\"archnet.mil\" --auth-negotiate-delegate-whitelist=\"archnet.mil\" \"$*\"" },
		{ "IRC Client"       , chat },
		--{ "Torrent"          , "transmission-gtk"},
		--{ "Email"            , "thunderbird" },
		--{ "Skype"            , "skype" },
	}

	mymedia = {
		{ "Spotify"          , "spotify" },
		{ "Ncmpcpp"          , music },
		{ "UNetBootin"       , "sudo unetbootin" },
		{ "Vlc"              , "vlc" },
		{ "Audacity"         , "audacity" },
		{ "Mixxx"            , "mixxx" },
		{ "Webcam"           , "mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 25 -vf screenshot" }
	}

	mygraphics = {
		{ "Stampawindow"     , "scrot --select" },
		{ "Screen"           , "scrot" },
		{ "Blender"          , "blender" },
		{ "Gimp"             , "gimp" },
		{ "Colors"           , "pychrom" },
		{ "Xournal"          , "xournal" }
	}

	myoffice = {
		--{ "Formula"          , "lomath" },
		--{ "Impress"          , "loimpress" },
		--{ "Spreadsheet"      , "localc" },
		--{ "Writer"           , "lowriter" }
	}

	mywork = {
		{ "STS"      , "/tools/springsource3.2-4/sts-3.2.0.RELEASE/STS" },
		{ "Sublime Text"      , "sublime_text" },
		--{ "Lftp"             , terminal .. " --hold -e lftp" }
	}

	myfun = {
		{"Grimrock"	, "/home/camechis/bin/Grimrock"}
		--{"Steam"             , "steam"},
		--{"Play on Linux"     , "playonlinux"},
		--{"Virtual Box"       , "VirtualBox"},
		--{"Metasploit"        , terminal .. " --hold -e ./msf/msfconsole"}
	}

	mysystem = {
		--{ "Appearance"       , "lxappearance" },
		--{ "Desktop"          , "nitrogen" },
		--{ "Xdefaults"        , editor_cmd .. " " .. home .. "/.Xdefaults"},
		--{ "Cleaning"         , "bleachbit" },
		--{ "HardInfo"         , "hardinfo" },
		--{ "Task Manager"     , tasks }
	}

	mysystemroot = {
		--{ "Appearance"       , terminal .. " -e sudo lxappearance" },
		--{ "Cleaning"         , terminal .. " -e sudo bleachbit" },
		--{ "Disk Utility"     , terminal .. " -e sudo palimpsest" },
		--{ "Partitions"       , terminal .. " -e sudo gparted" }
	}

	myexit = {
	   { "Suspend"           , "systemctl suspend" },
	   { "Sleep"             , "systemctl hybrid-sleep" },
	   { "Hibernate"         , "systemctl hibernate" },
	   { "Shutdown"          , "systemctl poweroff" },
	   { "Reboot"            , "systemctl reboot" },
	   { "Quit"              , awesome.quit }
	}

	mymainmenu = awful.menu({ items = { 
										{ "Awesome", myawesomemenu },
							{ "Ranger", cli_fileman },
										{ "File Manager", fileman },
							{ "Terminal", terminal },
						{ "Browser" , browser },
						{ " ", nil, nil}, -- separator
						{ "Internet" , myinternet },
						{ "Multimedia" , mymedia },
										{ "Fun" , myfun },
										{ "Graphics" , mygraphics },
						{ "Office" , myoffice },
										{ "Work" , mywork },
						{ "System" , mysystem },
						{ "System Root" , mysystemroot },
					  { " ", nil, nil}, -- separator
						{ "Search" , "sudo gnome-search-tool" },
						{ "Exit", myexit },
									 }
							})

	mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
										 menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- {{{ Wibox

-- Create a textclock widget
mytextclock = awful.widget.textclock()

-------------------
-- System Widget --
-------------------


-- System Icon
sysicon = wibox.widget.imagebox()
sysicon:set_image(beautiful.widget_sys)

-- System Widget
syswidget = wibox.widget.textbox()
vicious.register( syswidget, vicious.widgets.os, "$2")

-------------------
-- Uptime Widget --
-------------------


-- Exit Menu
exitmenu = awful.menu({items = {
                 { "Sleep" , function () awful.util.spawn("systemctl hybrid-sleep", false) end },
			     { "Hibernate" , function () awful.util.spawn("systemctl hibernate", false) end },
			     { "Shutdown" , function () awful.util.spawn("systemctl poweroff", false) end },
			     { "Reboot" , function () awful.util.spawn("systemctl reboot", false) end },
			     { "Restart" , awesome.restart },
			     { "Quit" , awesome.quit }
			  }
		       })


-- Uptime Icon
uptimeicon = wibox.widget.imagebox()
uptimeicon:set_image(beautiful.widget_uptime)


-- Uptime Widget
uptimewidget = wibox.widget.textbox()
vicious.register( uptimewidget, vicious.widgets.uptime, "$2.$3'")

uptimeicon:buttons(awful.util.table.join(
					 awful.button({ }, 1, function () exitmenu:toggle() end )
				   ))

uptimewidget:buttons(awful.util.table.join(
					 awful.button({ }, 1, function () exitmenu:toggle() end )
				   ))

-----------------
-- Temp Widget --
-----------------


-- Temp Icon
tempicon = wibox.widget.imagebox()
tempicon:set_image(beautiful.widget_temp)
-- Temp Widget
tempwidget = wibox.widget.textbox()
vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 9, { "coretemp.0", "core"} )


-------------------
-- Pacman Widget --
-------------------

-- Pacman Icon
pacicon = wibox.widget.imagebox()
pacicon:set_image(beautiful.widget_pac)

-- Pacman Widget
pacwidget = wibox.widget.textbox()
pacwidget_t = awful.tooltip({ objects = { pacwidget},})
vicious.register(pacwidget, vicious.widgets.pkg,
                function(widget,args)
                    local io = { popen = io.popen }
                    local s = io.popen("sudo yaourt -Sya && yaourt -Qu")
                    local str = ''
                    for line in s:lines() do
                        str = str .. line .. "\n"
                    end
                    pacwidget_t:set_text(str)
                    s:close()
                   return " " .. args[1]
                end, 600, "Arch")
                --'1800' means check every 30 minutes

pacicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " -e yaourt -Syua", false) end)
))


-------------------
-- Volume Widget --
-------------------


-- Vol Icon
volicon = wibox.widget.textbox()
vicious.register( volicon, vicious.widgets.volume, "$2", 1, "Master" ) 

-- Vol bar Widget
volbar = awful.widget.progressbar()
volbar:set_width(50)
volbar:set_height(6)
volbar:set_vertical(false)
volbar:set_background_color("#434343")
volbar:set_border_color(nil)
volbar:set_color(beautiful.fg_normal)
volbarbox = wibox.layout.margin(volbar,0,3,5,5)
vicious.register(volbar, vicious.widgets.volume,  "$1",  1, "Master")


-- Sound volume
volumewidget = wibox.widget.textbox()
vicious.register( volumewidget, vicious.widgets.volume, "$1", 1, "Master" )

volicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("".. terminal.. " -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))

volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("".. terminal.. " -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))


------------------
-- Music Widget --
------------------

-- MPD Icon
mpdicon = wibox.widget.imagebox()
mpdicon:set_image(beautiful.widget_mpd)

-- Initialize MPD Widget
mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then 
            return "Stopped"
        elseif args["{state}"] == "Pause" then
            return "Paused"
        else
            return args["{Title}"].. ' - '.. args["{Artist}"]
        end
    end, 1)

mpdicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " -e ncmpcpp", false) end)
))

-- MPD controls
  music_play = awful.widget.launcher({
    image = beautiful.widget_play,
    command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_pause = awful.widget.launcher({
    image = beautiful.widget_pause,
    command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })
  music_pause.visible = false

  music_stop = awful.widget.launcher({
    image = beautiful.widget_stop,
    command = "ncmpcpp stop && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_prev = awful.widget.launcher({
    image = beautiful.widget_prev,
    command = "ncmpcpp prev && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_next = awful.widget.launcher({
    image = beautiful.widget_next,
    command = "ncmpcpp next && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

----------------
-- Net Widget --
----------------


---- Wired ----

netwiredicon = wibox.widget.imagebox()
netwiredicon:set_image(beautiful.widget_netwired)

netwiredmenu = awful.menu({items = {
                             { "Connect Lan" , function () awful.util.spawn("".. terminal.. " -e sudo netcfg -u wirednetwork", false) end },
                             { "Disconnect Lan" , function () awful.util.spawn("".. terminal.. " -e sudo netcfg -D enp0s25", false) end },
                                   }
                     })

netwiredicon:buttons(awful.util.table.join( awful.button({ }, 1, function () netwiredmenu:toggle() end ) ))

netdownicon = wibox.widget.imagebox()
netdownicon:set_image(beautiful.widget_netdown)

netupicon = wibox.widget.imagebox()
netupicon:set_image(beautiful.widget_netup)

netdowninfo = wibox.widget.textbox()
vicious.register(netdowninfo, vicious.widgets.net, "${enp0s25 down_kb}", 2)

-- netdowninfo:buttons(awful.util.table.join(
--     awful.button({ }, 1, function () awful.util.spawn("sudo netcfg wirednetwork", false) end),
--     awful.button({ }, 3, function () awful.util.spawn("sudo netcfg down wirednetwork", false) end)
-- ))

netupinfo = wibox.widget.textbox()
vicious.register(netupinfo, vicious.widgets.net, "${enp0s25 up_kb}", 2)

-- netupinfo:buttons(awful.util.table.join(
--     awful.button({ }, 1, function () awful.util.spawn("sudo netcfg wirednetwork", false) end),
--     awful.button({ }, 3, function () awful.util.spawn("sudo netcfg down wirednetwork", false) end)
-- ))

---- Wireless ----

wifiicon = wibox.widget.imagebox()
wifiicon:set_image(beautiful.widget_wifi)

wifimenu = awful.menu({items = {
			     { "Connect Home Wifi" , function () awful.util.spawn("".. terminal.. " -e sudo netcfg -u poligon", false) end },
                             { "Connect OtherWifi" , function () awful.util.spawn("".. terminal.. " -e sudo wifi-menu", false) end },
                             { "Disconnect Wifi" , function () awful.util.spawn("".. terminal.. " -e sudo netcfg -D wlp3s0", false) end }
                               }
                     })
                     
wifiicon:buttons(awful.util.table.join( awful.button({ }, 1, function () wifimenu:toggle() end ) ))

wifidowninfo = wibox.widget.textbox()
vicious.register(wifidowninfo, vicious.widgets.net, "${wlp3s0 down_kb}", 2)

-- netdowninfo:buttons(awful.util.table.join(
--     awful.button({ }, 1, function () awful.util.spawn("sudo netcfg home-wireless-wpa", false) end),
--     awful.button({ }, 3, function () awful.util.spawn("sudo netcfg down home-wireless-wpa", false) end)
-- ))

wifiupinfo = wibox.widget.textbox()
vicious.register(wifiupinfo, vicious.widgets.net, "${wlp3s0 up_kb}", 2)

-- netupinfo:buttons(awful.util.table.join(
--     awful.button({ }, 1, function () awful.util.spawn("sudo netcfg home-ethernet", false) end),
--     awful.button({ }, 3, function () awful.util.spawn("sudo netcfg down home-ethernet", false) end)
-- ))


----------------
-- RAM Widget --
----------------

-- MEM icon
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
-- Initialize MEMBar widget
membar = awful.widget.progressbar()
membar:set_width(50)
membar:set_height(6)
membar:set_vertical(false)
membar:set_background_color("#434343")
membar:set_border_color(nil)
membar:set_color(beautiful.fg_normal)
membarbox = wibox.layout.margin(membar,0,3,5,5)
vicious.register(membar, vicious.widgets.mem, "$1", 1)

-- Memory usage
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "$2M", 1)

memicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " -e saidar -c", false) end)
))


-----------------------
-- File System Space --
-----------------------

-- FS icon
fsicon = wibox.widget.imagebox()
fsicon:set_image(beautiful.widget_fs)

-- Enable caching
vicious.cache(vicious.widgets.fs)

-- Initialize FSBar widget
fsbar = awful.widget.progressbar()
fsbar:set_width(50)
fsbar:set_height(6)
fsbar:set_vertical(false)
fsbar:set_background_color("#434343")
fsbar:set_border_color(nil)
fsbar:set_color(beautiful.fg_normal)
fsbarbox = wibox.layout.margin(fsbar,0,3,5,5)
vicious.register(fsbar, vicious.widgets.fs, "${/home used_p}", 60)

-- File System usage
fswidget = wibox.widget.textbox()
vicious.register(fswidget, vicious.widgets.fs, "${/home used_gb}G", 60)


----------------
-- CPU Widget --
----------------
 
-- CPU Icon
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
-- CPU Widget
cpubar = awful.widget.progressbar()
cpubar:set_width(50)
cpubar:set_height(6)
cpubar:set_vertical(false)
cpubar:set_background_color("#434343")
cpubar:set_color(beautiful.fg_normal)
cpubarbox = wibox.layout.margin(cpubar,0,3,5,5)
vicious.register(cpubar, vicious.widgets.cpu, "$1", 3)


-- Cpu usage
cpuwidget = wibox.widget.textbox()
vicious.register( cpuwidget, vicious.widgets.cpu, "$2% $3%", 1)

cpuicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " --hold -e htop", false) end)
))


--------------------
-- Battery Widget --
--------------------


-- BATT Icon
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_batt)

-- Battery usage
powermenu = awful.menu({items = {
			     { "Ondemand" , function () awful.util.spawn("".. terminal.. " -e sudo cpupower frequency-set -g ondemand", false) end },
			     { "Powersave" , function () awful.util.spawn("".. terminal.. " -e sudo cpupower frequency-set -g powersave", false) end },
			     { "Performance" , function () awful.util.spawn("".. terminal.. " -e sudo cpupower frequency-set -g performance", false) end }
			  }
		       })

-- Initialize BATT widget progressbar
batbar = awful.widget.progressbar()
batbar:set_width(50)
batbar:set_height(6)
batbar:set_vertical(false)
batbar:set_background_color("#434343")
batbar:set_border_color(nil)
batbar:set_color(beautiful.fg_normal)
batbarbox = wibox.layout.margin(batbar,0,3,5,5)
vicious.register( batbar, vicious.widgets.bat, "$2", 1, "BAT0" )

batwidget = wibox.widget.textbox()
vicious.register( batwidget, vicious.widgets.bat, "$2", 1, "BAT0" )
baticon:buttons(awful.util.table.join(
					 awful.button({ }, 1, function () powermenu:toggle() end )
				   ))

batwidget:buttons(awful.util.table.join(
					 awful.button({ }, 1, function () powermenu:toggle() end )
				   ))


---------------------
-- Utility Widgets --
---------------------

-- Spacers
rbracket = wibox.widget.textbox()
rbracket:set_text(']')
lbracket = wibox.widget.textbox()
lbracket:set_text('[')
line = wibox.widget.textbox()
line:set_text('|')

-- Space
space = wibox.widget.textbox()
space:set_text(' ')

----------------------------------------------------------------------
------------------------------[ LAYOUT ]------------------------------
----------------------------------------------------------------------


-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    -- left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(space) 
     right_layout:add(sysicon)
     right_layout:add(syswidget)
    right_layout:add(space)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
    
    -- Create the bottom wibox
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local bottom_left_layout = wibox.layout.fixed.horizontal()
    bottom_left_layout:add(lbracket) 
     bottom_left_layout:add(volicon)
     bottom_left_layout:add(space)
     bottom_left_layout:add(volbarbox)
     bottom_left_layout:add(volumewidget)
    bottom_left_layout:add(rbracket)
    bottom_left_layout:add(space)
    bottom_left_layout:add(lbracket) 
     bottom_left_layout:add(baticon)
     bottom_left_layout:add(batbarbox)
     bottom_left_layout:add(batwidget)
    bottom_left_layout:add(rbracket)    
    bottom_left_layout:add(space)
    bottom_left_layout:add(lbracket) 
     bottom_left_layout:add(memicon)
     bottom_left_layout:add(membarbox)
     bottom_left_layout:add(memwidget)
    bottom_left_layout:add(rbracket)
    bottom_left_layout:add(space)
    bottom_left_layout:add(lbracket) 
     bottom_left_layout:add(fsicon)
     bottom_left_layout:add(fsbarbox)
     bottom_left_layout:add(fswidget)
    bottom_left_layout:add(rbracket)
    bottom_left_layout:add(space)
    bottom_left_layout:add(lbracket) 
     bottom_left_layout:add(cpuicon)
     bottom_left_layout:add(cpubarbox)
     bottom_left_layout:add(cpuwidget)
    bottom_left_layout:add(rbracket)


    -- Widgets that are aligned to the right
    local bottom_right_layout = wibox.layout.fixed.horizontal()
    --bottom_right_layout:add(lbracket)
    -- bottom_right_layout:add(mpdicon)
     --bottom_right_layout:add(space)
    -- bottom_right_layout:add(mpdwidget)
    -- bottom_right_layout:add(music_prev)
    -- bottom_right_layout:add(music_stop)
    -- bottom_right_layout:add(music_pause)
    -- bottom_right_layout:add(music_play)
    -- bottom_right_layout:add(music_next)
    --bottom_right_layout:add(rbracket)
    --bottom_right_layout:add(space)
    --bottom_right_layout:add(lbracket)
     --bottom_right_layout:add(pacicon)
     --bottom_right_layout:add(pacwidget)
   -- bottom_right_layout:add(rbracket)
    --bottom_right_layout:add(space)
    --bottom_right_layout:add(lbracket)
     --bottom_right_layout:add(wifiicon)
     ---bottom_right_layout:add(line)
     --bottom_right_layout:add(netdownicon)
     --bottom_right_layout:add(wifidowninfo)
     --bottom_right_layout:add(space)
     --bottom_right_layout:add(netupicon)
     --bottom_right_layout:add(wifiupinfo)
    --bottom_right_layout:add(rbracket)
    --bottom_right_layout:add(space)
   -- bottom_right_layout:add(lbracket)
    -- bottom_right_layout:add(netwiredicon)
    -- bottom_right_layout:add(line)
    -- bottom_right_layout:add(netdownicon)
    -- bottom_right_layout:add(netdowninfo)
    -- bottom_right_layout:add(space)
    -- bottom_right_layout:add(netupicon)
     --bottom_right_layout:add(netupinfo)
    --bottom_right_layout:add(rbracket)
   -- bottom_right_layout:add(space)
   -- bottom_right_layout:add(lbracket)
   --  bottom_right_layout:add(tempicon)
   --  bottom_right_layout:add(tempwidget)
   -- bottom_right_layout:add(rbracket)
    --bottom_right_layout:add(space)
    --bottom_right_layout:add(lbracket)
     --bottom_right_layout:add(uptimeicon)
    -- bottom_right_layout:add(uptimewidget)
    --bottom_right_layout:add(rbracket)


    -- Now bring it all together
    local bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_right(bottom_right_layout)

    mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Media Keys
    awful.key({                   }, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),
    awful.key({                   }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 1%+") end),
    awful.key({                   }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 1%-") end),
    awful.key({                   }, "XF86AudioPlay", function () awful.util.spawn("ncmpcpp toggle") end),
    awful.key({                   }, "XF86AudioNext", function () awful.util.spawn("ncmpcpp next") end),
    awful.key({                   }, "XF86AudioPrev", function () awful.util.spawn("ncmpcpp prev") end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "q", function () awful.util.spawn(browser) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "mplayer2" },
      properties = { floating = true } },
    { rule = { class = "Download" },
      properties = { floating = true } },
    { rule = { class = "Gimp" },
      properties = { floating = true } },
    { rule = { class = "ncmpcpp" },
      properties = { floating = true } }, 
    -- Set Chromium to always map on tags number 2 of screen 1.
    { rule = { class = "Chromium" },
      properties = { tag = tags[1][1] } },
    { rule = { class = "VirtualBox" },
      properties = { tag = tags[6] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
 end
  
  --run_once("nitrogen --restore")
  run_once("nm-applet")
  --run_once("dropbox start")
  --run_once("mpd")
  --run_once("google-musicmanager")
  --run_once("transmission-gtk -m")
-- }}}

autorun = true
autorunApps = 
{
	"chromium",
}
if autorun then
        for app = 1, #autorunApps do
                awful.util.spawn(autorunApps[app])
        end
end

