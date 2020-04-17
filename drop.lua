local M = {}
local W = display.contentWidth
local H = display.contentHeight

local widget = require "widget"

local function triangle(x1,y1,x2,y2,x3,y3)
	local triangle = display.newLine(x1,y1,x2,y2)    
	triangle:append(x3,y3,x1,y1)
	return triangle
end

local function new(atributos,listener)
	local vectorOptions = {"opção1","opção2","opção3"}
	local ColorLABEL = {0,0,0}
	local COLOR = {1,1,1}
	local COLOROVER = {.5,.5,.5}
	local WidtH = 200
	local HeighT = 80
	local SizE = HeighT
	local BorderColor = {0,0,0}
	local BorderSize = 0
	local WindowSize = 300
	local FONT = "Fontes/segoeui.ttf"
	local X = 0
	local Y = 0
	
	if atributos.menuChoices then
		vectorOptions = atributos.menuChoices
	end
	if atributos.color then
		COLOR = atributos.color
	end
	if atributos.colorOver then
		COLOROVER = atributos.colorOver
	end
	if atributos.colorLabel then
		ColorLABEL = atributos.colorLabel
	end
	if atributos.width then
		WidtH = atributos.width
	end
	if atributos.height then
		HeighT = atributos.height
		SizE = HeighT
	end
	if atributos.fontSize then
		SizE = atributos.fontSize
	end
	if atributos.x then
		X = atributos.x
	end
	if atributos.y then
		Y = atributos.y
	end
	if atributos.BorderColor then
		BorderColor = atributos.BorderColor
	end
	if atributos.BorderSize then
		BorderSize = atributos.BorderSize
	end
	if atributos.WindowSize then
		WindowSize = atributos.WindowSize
	end


	local buttonGroup = display.newGroup()
	--buttonGroup.anchorX=0
	--buttonGroup.anchorY=0
	buttonGroup.x = X
	buttonGroup.y = Y
	
	local labelTest = display.newText(string.gsub(vectorOptions[1],"%.ttf",""),0,0,"Fontes/segoeui.ttf",SizE)
	while labelTest.width > WidtH-10 do
		labelTest.size = labelTest.size-1
	end
	while labelTest.height > HeighT -1 do
		labelTest.size = labelTest.size-1
	end
	SizE = labelTest.size
	labelTest:removeSelf()
	
	local function openWindow()
		
		local function closeDropDown(e)
			e.target:removeSelf()
			buttonGroup.window:removeSelf()
			buttonGroup.strokeR:removeSelf()
			buttonGroup.strokeL:removeSelf()
			buttonGroup.strokeB:removeSelf()
		end
		buttonGroup.protectiveScreen = display.newRect(W/2-buttonGroup.x,H/2-buttonGroup.y,W,H)
		buttonGroup.protectiveScreen.alpha = .2
		buttonGroup.protectiveScreen.isHitTestable = true
		buttonGroup.protectiveScreen:addEventListener("touch",function() return true end)
		timer.performWithDelay(1,function()
			buttonGroup.protectiveScreen:addEventListener("tap",closeDropDown);
		end,1)
		buttonGroup:insert(buttonGroup.protectiveScreen)
		
		local function onRowTouch( event )
 
			-- Get reference to the row group
			local row = event.row
			if event.phase == 'release' then
				buttonGroup.protectiveScreen:removeSelf()
				buttonGroup.window:removeSelf()
				buttonGroup.strokeR:removeSelf()
				buttonGroup.strokeL:removeSelf()
				buttonGroup.strokeB:removeSelf()
				buttonGroup.choice = row.params.optionText
				buttonGroup.optionText.text = string.gsub(row.params.optionText,"%.ttf","")
				buttonGroup.optionText.size = SizE
				while buttonGroup.optionText.width > WidtH-30 do
					buttonGroup.optionText.size = buttonGroup.optionText.size-1
				end
				while buttonGroup.optionText.height > HeighT -1 do
					buttonGroup.optionText.size = buttonGroup.optionText.size-1
				end
				
				listener()
			end
			
			return true
		end
		local function onRowRender( event )
 
			-- Get reference to the row group
			local row = event.row
		 
			-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
			local title = row.params.optionText
			local font = FONT
			if atributos.menuType and atributos.menuType == "font" then
				font = title
			end
			local rowTitle = display.newText( row, "  "..string.gsub(title,".+",{["%.ttf"] = "", ["%.otf"] = ""}), 0, 0, font, SizE )
			rowTitle:setFillColor( 0 )
			while rowTitle.width > WidtH-30 do
				rowTitle.size = rowTitle.size-1
			end
			while rowTitle.height > HeighT -1 do
				rowTitle.size = rowTitle.size-1
			end
			row.SizE = rowTitle.size
			row.title = title
			
			local rowLine = display.newRect(row,0,0,rowWidth,4)
			rowLine:setFillColor(ColorLABEL)
			rowLine.anchorX=0
		 
			-- Align the label left and vertically centered
			rowTitle.anchorX = 0
			rowTitle.x = 0
			rowTitle.y = rowHeight * 0.5
		end
		
		buttonGroup.window = widget.newTableView(
			{
				height = WindowSize,
				width = WidtH,
				onRowRender = onRowRender,
				onRowTouch = onRowTouch,
				rowTouchDelay = 0,
				backgroundColor = COLOR,
				listener = scrollListener
			}
		)
		buttonGroup.window.anchorY=0
		buttonGroup.window.x = buttonGroup.botao.x
		buttonGroup.window.y = buttonGroup.botao.y + HeighT/2
		buttonGroup:insert(buttonGroup.window)
		
		buttonGroup.strokeL = display.newRect(buttonGroup.window.x-buttonGroup.window.width/2,buttonGroup.window.y+buttonGroup.window.height/2,3,buttonGroup.window.height)
		buttonGroup.strokeL:setFillColor(COLOR[1]/2,COLOR[2]/2,COLOR[3]/2)
		buttonGroup:insert(buttonGroup.strokeL)
		buttonGroup.strokeR = display.newRect(buttonGroup.window.x+buttonGroup.window.width/2,buttonGroup.window.y+buttonGroup.window.height/2,4,buttonGroup.window.height)
		buttonGroup.strokeR:setFillColor(COLOR[1]/2,COLOR[2]/2,COLOR[3]/2)
		buttonGroup:insert(buttonGroup.strokeR)
		
		buttonGroup.strokeB = display.newRect(buttonGroup.window.x,buttonGroup.window.y+buttonGroup.window.height,buttonGroup.window.width,4)
		buttonGroup.strokeB:setFillColor(COLOR[1]/2,COLOR[2]/2,COLOR[3]/2)
		buttonGroup:insert(buttonGroup.strokeB)
		
		for i = 1, #vectorOptions do
 

			rowHeight = SizE + 20
			rowColor = { default=COLOR }
			lineColor = ColorLABEL

		 
			-- Insert a row into the tableView
			buttonGroup.window:insertRow(
				{
					rowHeight = rowHeight,
					rowColor = rowColor,
					lineColor = lineColor,
					params = {optionText = vectorOptions[i]}
				}
			)
		end
		
		
		return true
	end
	
	buttonGroup.botao = widget.newButton {
		shape = "left",
		fillColor = { default=COLOR, over=COLOROVER },
		width = WidtH,
		height = HeighT,
		label = "",
		labelAlign = "left",
		font = FONT,
		fontSize = SizE,
		strokeWidth = BorderSize,
		labelColor = { default=ColorLABEL, over={ 0.2/ColorLABEL[1], 0.2/ColorLABEL[2], 0.2/ColorLABEL[3], 1 } },
		strokeColor = { default=BorderColor, over={ 1/BorderColor[1], 1/BorderColor[2], 1/BorderColor[3], .5 } },
		onRelease = openWindow
	}
	buttonGroup.botao.width = WidtH
	buttonGroup.botao.height = HeighT
	buttonGroup:insert(buttonGroup.botao)
	
	buttonGroup.optionText = display.newText(string.gsub(vectorOptions[1],"%.ttf",""),0,0,FONT,SizE)
	buttonGroup.optionText.anchorX = 0
	buttonGroup.optionText.x = buttonGroup.botao.x - WidtH/2 + 5
	buttonGroup.optionText.y = buttonGroup.botao.y
	buttonGroup.optionText:setFillColor(ColorLABEL)
	buttonGroup:insert(buttonGroup.optionText)
	
	buttonGroup.myTriangle1 = triangle(0,14,-7,0,7,0)
	buttonGroup.myTriangle1:setStrokeColor( BorderColor )
	buttonGroup.myTriangle1.strokeWidth = 2
	buttonGroup.myTriangle1.x = buttonGroup.botao.x + WidtH/2 - 14 - 3
	buttonGroup.myTriangle1.y = buttonGroup.botao.y+ HeighT/2 - 14 - 2
	buttonGroup.myTriangle1.alpha = .4
	buttonGroup:insert(buttonGroup.myTriangle1)
	
	
	
	return buttonGroup
end
M.new = new

return M