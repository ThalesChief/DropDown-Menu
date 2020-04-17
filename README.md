# DropDown-Menu
DropDown menu for coronasdk in lua language

I created this dropDown menu using coronasdk widget library.

This is an example of its usage:
```lua
local drop =  require("drop")

local dropDownFonts = drop.new(
	{
		x = display.contentWidth/2,
		y = display.contentHeight/2,
		menuChoices = {"arial.ttf","times.ttf"},
		menuType = "font", -- if its a list of fonts you can put this in menuType and it ill change the font for each option
		width = 145,
		height = 50, -- the height of the rows
		fontSize = 80,
		colorLabel = {0,0,0},
		color ={ 0.18, 0.67, 0.785, 1 },
		colorOver = { 0.004, 0.368, 0.467, 1 }, -- color when clicked
		BorderColor = {0,0,0,.3}, -- border of the window
		BorderSize = 3,
		WindowSize = 300 -- the height of the menu when opened
	},listener -- function that ill be triggered when you click an option
)
```
Return: string

When you click an option it ill return its name in: "dropDownFonts.choice"



