local hyper = {"ctrl", "alt", "cmd"}

-- Smart configuration reloading
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Fokus
hs.loadSpoon("Fokus")
spoon.Fokus:init()

-- Pomodoro
hs.loadSpoon("Pomodoro")
spoon.Pomodoro:init()

-- Miro's windows manager.
hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.3
spoon.MiroWindowsManager:bindHotkeys({
	up = {hyper, "k"},
	down = {hyper, "j"},
	right = {hyper, "l"},
	left = {hyper, "h"},
	fullscreen = {hyper, "i"}
})

-- Window sizing
local hyperInc = {"cmd", "ctrl"}
local hyperDec = {"alt", "ctrl"}
local sizingSize = 20

hs.hotkey.bind(hyperInc, "h", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + sizingSize
	f.x = f.x - sizingSize
	win:setFrame(f)
end)
hs.hotkey.bind(hyperDec, "h", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w - sizingSize
	win:setFrame(f)
end)

hs.hotkey.bind(hyperInc, "l", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + sizingSize
	win:setFrame(f)
end)
hs.hotkey.bind(hyperDec, "l", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w - sizingSize
	f.x = f.x + sizingSize
	win:setFrame(f)
end)

hs.hotkey.bind(hyperInc, "k", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.h = f.h + sizingSize
	f.y = f.y - sizingSize
	win:setFrame(f)
end)
hs.hotkey.bind(hyperDec, "k", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.h = f.h - sizingSize
	win:setFrame(f)
end)

hs.hotkey.bind(hyperInc, "j", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.h = f.h + sizingSize
	win:setFrame(f)
end)
hs.hotkey.bind(hyperDec, "j", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.h = f.h - sizingSize
	f.y = f.y + sizingSize
	win:setFrame(f)
end)

-- Window moving
local hyperMoving = {"ctrl", "shift"}
local movingSize = 20
hs.hotkey.bind(hyperMoving, "h", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.x = f.x - movingSize
	win:setFrame(f)
end)
hs.hotkey.bind(hyperMoving, "l", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.x = f.x + movingSize
	win:setFrame(f)
end)
hs.hotkey.bind(hyperMoving, "k", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.y = f.y - movingSize
	win:setFrame(f)
end)
hs.hotkey.bind(hyperMoving, "j", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.y = f.y + movingSize
	win:setFrame(f)
end)
