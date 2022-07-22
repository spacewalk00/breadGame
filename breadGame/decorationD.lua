-----------------------------------------------------------------------------------------
--
-- deco.lua
--
-----------------------------------------------------------------------------------------

-- JSON 파싱
local widget = require( "widget" )

local composer = require( "composer" )
local scene = composer.newScene()

local json = require('json')

local function parse()
	local filename = system.pathForFile("Content/JSON/deco.json")
	deco, pos, msg = json.decodeFile(filename)

	if deco then
		print(deco[1].name)
	else
		print(pos)
		print(msg)
	end
end
parse()


function gotoDecoC(event)
	composer.gotoScene("decorationC")
	--audio.play( soundTable["clickSound"],  {channel=5} )
	print("카펫")
end
function gotoDecoD(event)
	composer.gotoScene("decorationD")
	--audio.play( soundTable["clickSound"],  {channel=5} )
	print("장식")
end



function scene:create( event )
	local sceneGroup = self.view

	local popGroup = display.newGroup()

	local window = display.newImageRect(popGroup, "Content/images/list.png", display.contentWidth*0.78, display.contentHeight*0.62)
	window.x, window.y = display.contentWidth*0.5, display.contentHeight*0.54

	local close = display.newImageRect(popGroup, "Content/images/close.png", display.contentWidth*0.1, display.contentHeight*0.05)
	close.x, close.y = 1240, 583--display.contentWidth*0.8565, display.contentHeight*0.24

	local pushBtn = display.newImageRect(popGroup, "Content/images/pushBtn.png", display.contentWidth*0.25, display.contentHeight*0.05)
	pushBtn.x, pushBtn.y = display.contentWidth*0.5, display.contentHeight*0.79

	local function insertObj ( event ) 
		popGroup:removeSelf()

		-- 카펫 변경 코드 p_check[i].isVisible == true인 카펫 -- 
	end
	
	close:addEventListener("tap", insertObj) --
	pushBtn:addEventListener("tap", insertObj)

	local carpetBtn = display.newRect(445, 667, 280, 150)
	carpetBtn:setFillColor(0)
	carpetBtn.alpha = 0.2
	popGroup:insert( carpetBtn )

	local carpetText = display.newImage("Content/images/text_carpet.png")
	carpetText.x, carpetText.y = 445, 667
	popGroup:insert( carpetText )

	local decoBtn = display.newRect(897, 667, 280, 150)
	decoBtn:setFillColor(0)
	decoBtn.alpha = 0.2
	popGroup:insert( decoBtn )

	local decoText = display.newImage("Content/images/text_decor.png")
	decoText.x, decoText.y = 897, 667
	popGroup:insert( decoText ) 
	
	local choiceMark = display.newImage("Content/images/chosen.png")
	choiceMark.x, choiceMark.y = 900, 760
	popGroup:insert( choiceMark )


	decoBtn:addEventListener("tap", gotoDecoD)
	carpetBtn:addEventListener("tap", gotoDecoC)

    ------------------------
    local carpetGroup = display.newGroup()

	local product_bar = {}
	local p_pic_bar = {}
	local p_pic = {}
	local p_checkBox = {}
	local p_check = {}

	local ingreName = {}
	local ingreInfo = {}
	--local defaultBox 

	--임시--
	decoFlag = { 1, 0 }
	--[[decoKindCnt = 0
	--decoCheckFlag = {0, }
	for i=1, #deco do
		if decoFlag == 1 then
			decoKindCnt = decoKindCnt + 1
		end
	end]]

	for i=1, #deco do
		if decoFlag[i] == 1 then
			product_bar[i] = display.newImage(carpetGroup, "Content/images/deco_bar.png")
			product_bar[i].x, product_bar[i].y = display.contentWidth*0.5, display.contentHeight*(0.06+0.13* (i-1))
			p_pic_bar[i] = display.newImage(carpetGroup, "Content/images/deco_box.png")
		    p_pic_bar[i].x, p_pic_bar[i].y = display.contentWidth*0.22, display.contentHeight*(0.06+0.13* (i-1))

		    p_pic[i] = display.newImage(carpetGroup, deco[i].image)
			p_pic[i].x, p_pic[i].y = display.contentWidth*0.22, display.contentHeight*(0.06+0.13* (i-1))
			p_pic[i].name = i

			p_checkBox[i] = display.newImage(carpetGroup, "Content/images/deco_checkBox.png")
			p_checkBox[i].x, p_checkBox[i].y = display.contentWidth*0.17, display.contentHeight*(0.06+0.13* (i-1) - 0.03)


			p_check[i] = display.newImage(carpetGroup, "Content/images/deco_check.png")
			p_check[i].x, p_check[i].y = display.contentWidth*0.17, display.contentHeight*(0.06+0.13* (i-1) - 0.03)
			p_check[i].isVisible = false
			
			--중복 체크 불가 구현
			local function checked( event ) 
				if p_check[i].isVisible == false then
					for j=1, #deco do
						if decoFlag[j] == 1 then
							if p_check[j].isVisible == true and  j ~= i then
								print("중복으로 체크할 수 없습니다")
								break
							else
								p_check[i].isVisible = true
								print("체크하겠습니다.")
								break
							end
						end
					end
					--decoCheckFlag[i] = 1
				else 
					p_check[i].isVisible = false
					print("체크 해제하겠습니다.")
					--decoCheckFlag[i] = 0
				end
			end
			p_checkBox[i]:addEventListener("tap", checked)

			local nameOptions = 
			{
				text = deco[i].name,
				x = display.contentWidth*(0.41 + 0.24),
				y = display.contentHeight*(0.04 + 0.13*(i-1)),
				width = 1000,
				font = "Content/font/ONE Mobile POP.ttf",
				fontSize = 60,
				align = "left"
			}
			ingreName[i] = display.newText(nameOptions) 
			--ingreName[i] = display.newText(ingreGroup, deco[i].name, display.contentWidth*(0.41), display.contentHeight*(0.22+0.13*(i-1)), "font/ONE Mobile POP.ttf") 
			ingreName[i]:setFillColor(0)
			--ingreGroup:insert(ingreName[i])
			carpetGroup:insert(ingreName[i])

			local sentenceOptions = 
			{
				text = deco[i].sentence,
				x = display.contentWidth*(0.41 + 0.24),
				y = display.contentHeight*(0.04 +0.13*(i-1)+ 0.04),
				width = 1000,
				font = "Content/font/ONE Mobile POP.ttf",
				fontSize = 45,
				align = "left"
			}
			ingreInfo[i] = display.newText(sentenceOptions)
			--ingreInfo[i] = display.newText(ingreGroup, deco[i].sentence, display.contentWidth*(0.41+0.2), display.contentHeight*(0.22+0.13*(i-1)+ 0.04), "font/ONE Mobile POP.ttf")
			ingreInfo[i]:setFillColor(0)
			--ingreGroup:insert(ingreInfo[i])
			carpetGroup:insert(ingreInfo[i])
		end
	end

	local scrollView = widget.newScrollView(
	{
		horizontalScrollDisabled=true,
		left = 70,
		top = 790,
		width = 1115,
		height = 1150,
		backgroundColor = { 0, 0, 0 , 0}

	} )
	scrollView:insert( carpetGroup )
	popGroup:insert( scrollView )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

	elseif phase == "did" then
		composer.removeScene("decorationD")
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene