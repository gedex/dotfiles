-- === Fokus ===
-- Set one task you'd like to focus on now
local obj = {}
obj.__index__ = obj

-- Metadata.
obj.name = "Fokus"
obj.version = "1.0"

local mods = {"cmd", "ctrl", "alt"}
local promptKey = "p"
local resetKey = "o"
local promptText = "Task to focus on:"
local buttonOkText = "OK"
local buttonCancelText = "Cancel"
local state = {
	menu = nil,
	task = ""
}

local function appTitle()
	local s = "⭐︎"
	if string.len(state.task) > 0 then
		s = "⭑"
	end

	return s
end

local function appTooltip()
	local s = "No task to focus on"
	if string.len(state.task) > 0 then
		s = string.format("Focusing on '%s'", state.task)
	end

	return s
end

local function updateDisplay()
	state.menu:setTitle(appTitle())
	state.menu:setTooltip(appTooltip())
end

local function setTask(task)
	-- No need to persist and update the display if there's no change.
	if task == state.task then
		return
	end

	state.task = task
	updateDisplay()

	-- Save to a file.
	local filename = string.format(
		"%s/.fokus/%s.txt",
		os.getenv("HOME"),
		os.date("%Y-%m-%d")
	)
	local entry = string.format(
		"%s    %s\n",
		os.date("%Y-%m-%d %H:%M:%S"),
		state.task
	)

	hs.fs.mkdir(string.format("%s/%s", os.getenv("HOME"), ".fokus"))
	hs.fs.touch(filename)
	local file = io.open(filename, "a")
	file:write(entry)
	file:close()
end

local function prompt()
	hs.focus()
	local btn, task = hs.dialog.textPrompt(
		obj.name,
		promptText,
		state.task,
		buttonOkText,
		buttonCancelText
	)

	if btn == "OK" then
		setTask(task)
	end
end

local function reset()
	setTask("")
end

local function createMenu()
	if state.menu == nil then
		state.menu = hs.menubar.new()
		state.menu:setClickCallback(prompt)

		updateDisplay()
	end
end

function obj:init()
	createMenu()

	hs.hotkey.bind(mods, promptKey, prompt)
	hs.hotkey.bind(mods, resetKey, reset)
end

return obj
