-- === Pomodoro ===
-- Based on https://github.com/atsepkov/hammerspoon-config/blob/master/modules/pomodoor.lua
local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Pomodoro"
obj.version = "1.0"

local mods = {"cmd", "ctrl", "alt"}
local enableKey = "["
local disableKey = "]"
local minuteInSeconds = 60
local workInSeconds = 25 * minuteInSeconds
local restInSeconds = 5 * minuteInSeconds
local timeReminders = {
	[60] = "1 minute",
	[20] = "20 seconds",
	[10] = "10 seconds"
}
local workFinish = "Work complete! Rest yourself!"
local restFinish = "Done resting! Back to work!"
local state = {
	reminder = nil,
	menu = nil,
	timer = nil,
	totalWork = 0,
	currentMode = "work",
	isActive = false,
	timeLeft = workInSeconds,
	disableCount = 0
}

local function createMenu()
	if state.menu == nil then
		state.menu = hs.menubar.new()
	end
end

local function updateDisplay()
	local min = math.floor(state.timeLeft / minuteInSeconds)
	local sec = math.floor(state.timeLeft % minuteInSeconds)
	local str = string.format("( %s | %02d:%02d | %02d )", state.currentMode, min, sec, state.totalWork)
	state.menu:setTitle(str)
end

local function disable()
	local wasActive = state.isActive
	state.isActive = false

	if (state.disableCount == 0) then
		if wasActive then
			state.timer:stop()
		end
	elseif (state.disableCount == 1) then
		state.timeLeft = workInSeconds
		state.currentMode = "work"
		updateDisplay()
	elseif (state.disableCount >= 2) then
		if state.menu == nil then
			state.disableCount = 2
			return
		end
		state.menu:delete()
		state.menu = nil
		state.timer:stop()
		state.timer = nil
	end

	state.disableCount = state.disableCount + 1
end

local function updateTime()
	if state.isActive == false then
		return
	else
		state.timeLeft = state.timeLeft - 1

		if timeReminders[state.timeLeft] then
			state.reminder:speak(timeReminders[state.timeLeft])
		end

		if (state.timeLeft <= 5 and state.timeLeft > 0) then
			state.reminder:speak(state.timeLeft)
		end

		if (state.timeLeft <= 0) then
			if state.currentMode == "work" then
				hs.alert.show(workFinish, 2)
				state.reminder:speak(workFinish)
				state.totalWork = state.totalWork + 1
				state.currentMode = "rest"
				state.timeLeft = restInSeconds
			else
				hs.alert.show(restFinish, 2)
				state.reminder:speak(restFinish)
				state.currentMode = "work"
				state.timeLeft = workInSeconds
			end
		end
	end
end

local function updateMenu()
	updateTime()
	updateDisplay()
end


local function enable()
	state.disableCount = 0
	if (state.isActive) then
		return
	elseif state.timer == nil then
		createMenu()
		state.timer = hs.timer.new(1, updateMenu)
	end

	state.isActive = true
	state.timer:start()
end

function obj:init()
	state.reminder = hs.speech.new()
	state.reminder:volume(1)
	state.reminder:rate(220)
	createMenu()
	updateMenu()

	hs.hotkey.bind(mods, enableKey, enable)
	hs.hotkey.bind(mods, disableKey, disable)
end

return obj
