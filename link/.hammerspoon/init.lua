-- Miro's windows manager.
local hyper = {"ctrl", "alt", "cmd"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.3
spoon.MiroWindowsManager:bindHotkeys({
	up = {hyper, "k"},
	down = {hyper, "j"},
	right = {hyper, "l"},
	left = {hyper, "h"},
	fullscreen = {hyper, "i"}
})
