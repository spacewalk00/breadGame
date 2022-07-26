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
	local filename = system.pathForFile("Content/JSON/wallPaper.json")
	wallPaper, pos, msg = json.decodeFile(filename)

	if wallPaper then
		print(wallPaper[1].name)
	else
		print(pos)
		print(msg)
	end
end
parse()

--local carpetFlag = 0
--local carpetIndex 
local function gotoBreadRoomFromC(event)

	composer.gotoScene("breadRoom")
	print("빵방으로 가서 아이템 적용")
	
	-- 고른 아이템 변수 전달 
	if event.target.name == "pushBtn" then
		--carpetFlag = 1
		
		--[[
		-- 고른 아이템 목록에서 삭제
		if wallCnt[carpetIndex] == 1 then
		wallCnt[carpetIndex] = wallCnt[carpetIndex] - 1
		wallPaperFlag[carpetIndex] = 0 
		end
		-- 카펫 변경 코드 p_check[i].isVisible == true인 카펫 -- 
		]]

	end
end
--
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

local background_room1
local background_room2
local background_carpet
local homeIcon
local breadIcon
local text_breadRoom
local coinIcon
local gray_upperLeft
local gray_upperRight
local gray_lowerLeft
local gray_lowerRight
local bookIcon
local text_bookIcon
local store
local text_storeIcon
local temp
local text_tempIcon
local dia
local text_deco
local pushIcon
local text_push 

local carpetChange = -1

function scene:create( event )
	local sceneGroup = self.view
	--breadRoom.lua 동일 코드 --

    -- 배경 --
	background_room1 = display.newImageRect("Content/images/room1.png", display.contentWidth, display.contentHeight)
	background_room1.x, background_room1.y = display.contentWidth*0.5, display.contentHeight*0.5

	background_room2 = display.newImageRect("Content/images/room2.png", display.contentWidth, display.contentHeight)
	background_room2.x, background_room2.y = display.contentWidth*0.5, display.contentHeight*0.5

	background_carpet = display.newImageRect("Content/images/carpet.png", display.contentWidth, display.contentHeight)
	background_carpet.x, background_carpet.y = display.contentWidth*0.5, display.contentHeight*0.5
	background_carpet.isVisible = false
	
	carpetChange = composer.getVariable("forItemRoomBackground")
	if carpetChange == nil then
		carpetChange = -1
	end
	
	if carpetChange > 0 then -- 배경카펫
		background_carpet = display.newImageRect(wallPaper[carpetChange].image2, display.contentWidth, display.contentHeight)
		background_carpet.x, background_carpet.y = display.contentWidth*0.5, display.contentHeight*0.5
	end
	
	-- 홈, 빵방, 코인 --
	homeIcon = display.newImageRect("Content/images/home.png", display.contentWidth*0.07, display.contentHeight*0.04)
	homeIcon.x, homeIcon.y = display.contentWidth*0.08, display.contentHeight*0.05

	breadIcon = display.newImageRect("Content/images/breadRoom2.png", display.contentWidth*0.1, display.contentHeight*0.05)
	breadIcon.x, breadIcon.y = display.contentWidth*0.2, display.contentHeight*0.054

	text_breadRoom = display.newImageRect("Content/images/text_breadRoom.png", display.contentWidth*0.46, display.contentHeight*0.27)
	text_breadRoom.x, text_breadRoom.y = display.contentWidth*0.3, display.contentHeight*0.05

	coinIcon = display.newImage("Content/images/coins.png")
	coinIcon.x, coinIcon.y = display.contentWidth*0.525, display.contentHeight*0.05
		
	showCoin.isVisible = true
	showCoin.x, showCoin.y = display.contentWidth*0.5748, display.contentHeight*0.05
	showCoin:setFillColor(1)

	-- 다른 페이지 넘어가는 아이콘 및 회색 배경 --
	gray_upperLeft = display.newImageRect("Content/images/gray.png", display.contentWidth*0.13, display.contentHeight*0.07)
	gray_upperLeft.x, gray_upperLeft.y = display.contentWidth*0.73, display.contentHeight*0.06

	gray_upperRight = display.newImageRect("Content/images/gray.png", display.contentWidth*0.13, display.contentHeight*0.07)
	gray_upperRight.x, gray_upperRight.y = display.contentWidth*0.9, display.contentHeight*0.06

	gray_lowerLeft = display.newImageRect("Content/images/gray.png", display.contentWidth*0.13, display.contentHeight*0.07)
 	gray_lowerLeft.x, gray_lowerLeft.y = display.contentWidth*0.73, display.contentHeight*0.145

	gray_lowerRight = display.newImageRect("Content/images/gray.png", display.contentWidth*0.13, display.contentHeight*0.07)
 	gray_lowerRight.x, gray_lowerRight.y = display.contentWidth*0.9, display.contentHeight*0.145

	bookIcon = display.newImageRect("Content/images/book.png", display.contentWidth*0.11, display.contentHeight*0.06)
 	bookIcon.x, bookIcon.y = display.contentWidth*0.73, display.contentHeight*0.05

	text_bookIcon = display.newImage("Content/images/text_Book2.png")
	text_bookIcon.x, text_bookIcon.y = display.contentWidth*0.73, display.contentHeight*0.081

	store = display.newImageRect("Content/images/store.png", display.contentWidth*0.1, display.contentHeight*0.07)
	store.x, store.y = display.contentWidth*0.904, display.contentHeight*0.047
	
	text_storeIcon = display.newImage("Content/images/text_store.png")
	text_storeIcon.x, text_storeIcon.y = display.contentWidth*0.9, display.contentHeight*0.08
	
	temp = display.newImageRect("Content/images/temp.png", display.contentWidth*0.08, display.contentHeight*0.05)
 	temp.x, temp.y = display.contentWidth*0.73, display.contentHeight*0.14

	text_tempIcon = display.newImage("Content/images/text_acheivements.png")
	text_tempIcon.x, text_tempIcon.y = display.contentWidth*0.73, display.contentHeight*0.17

	dia = display.newImageRect("Content/images/dia.png", display.contentWidth*0.09, display.contentHeight*0.04)
	dia.x, dia.y = display.contentWidth*0.9, display.contentHeight*0.138

	text_deco = display.newImage("Content/images/text_deco.png")
	text_deco.x, text_deco.y = display.contentWidth*0.9, display.contentHeight*0.17

	pushIcon = display.newImageRect("Content/images/push.png", display.contentWidth*0.25, display.contentHeight*0.05)
	pushIcon.x, pushIcon.y = display.contentWidth*0.24, display.contentHeight*0.15

	text_push = display.newImage("Content/images/text_breadPush.png")
	text_push.x, text_push.y = display.contentWidth*0.24, display.contentHeight*0.15
    text_push:toFront()
	--

	-- 꾸미기 창 --

	local popGroup = display.newGroup()

	local window = display.newImageRect(popGroup, "Content/images/list.png", display.contentWidth*0.78, display.contentHeight*0.62)
	window.x, window.y = display.contentWidth*0.5, display.contentHeight*0.54

	local close = display.newImageRect(popGroup, "Content/images/close.png", display.contentWidth*0.1, display.contentHeight*0.05)
	close.x, close.y = 1240, 583--display.contentWidth*0.8565, display.contentHeight*0.24

	local pushBtn = display.newImageRect(popGroup, "Content/images/pushBtn.png", display.contentWidth*0.25, display.contentHeight*0.05)
	pushBtn.x, pushBtn.y = display.contentWidth*0.5, display.contentHeight*0.79

    local menuGroup = display.newGroup()

	local carpetBtn = display.newRect(menuGroup, 460, 667, 280, 150)
	carpetBtn:setFillColor(0)
	carpetBtn.alpha = 0.01
	popGroup:insert( carpetBtn )

	local carpetText = display.newImage(menuGroup, "Content/images/text_carpet.png")
	carpetText.x, carpetText.y = 460, 667
	popGroup:insert( carpetText )

	local decoBtn = display.newRect(menuGroup, 990, 667, 280, 150)
	decoBtn:setFillColor(0)
	decoBtn.alpha = 0.01
	popGroup:insert( decoBtn )

	local decoText = display.newImage(menuGroup, "Content/images/text_decor.png")
	decoText.x, decoText.y = 990, 667
	popGroup:insert( decoText ) 

	--carpetBtn:addEventListener("tap", gotoDecoC)
	decoBtn:addEventListener("tap", gotoDecoD)

	close.name = "close"
	close:addEventListener("tap", gotoBreadRoomFromC) 

	pushBtn.name = "pushBtn"
	pushBtn:addEventListener("tap", gotoBreadRoomFromC)

	------------------------
    local carpetGroup = display.newGroup()

	local choiceMark = display.newImage(carpetGroup, "Content/images/chosen.png")
	choiceMark.x, choiceMark.y = 430, 760
	popGroup:insert( choiceMark )

	local product_bar = {}
	local p_pic_bar = {}
	local p_pic = {}
	local p_checkBox = {}
	local p_check = {}

	local ingreName = {}
	local ingreInfo = {}
	--local defaultBox 

	--임시--
	--wallPaperFlag = { 1, 1, 1, 1}
	
	local overlapFlag = 0
	local idx = 1
	for i=1, #wallPaper do
		if wallPaperFlag[i] == 1 then
			product_bar[i] = display.newImage(carpetGroup, "Content/images/deco_bar.png")
			product_bar[i].x, product_bar[i].y = display.contentWidth*0.39, display.contentHeight*(0.06+0.13* (idx-1))
			p_pic_bar[i] = display.newImage(carpetGroup, "Content/images/deco_box.png")
		    p_pic_bar[i].x, p_pic_bar[i].y = display.contentWidth*0.11, display.contentHeight*(0.06+0.13* (idx-1))

		    p_pic[i] = display.newImageRect(carpetGroup, wallPaper[i].image, 150, 150)
			p_pic[i].x, p_pic[i].y = display.contentWidth*0.11, display.contentHeight*(0.06+0.13* (idx-1))
			p_pic[i].name = i

			p_checkBox[i] = display.newImage(carpetGroup, "Content/images/deco_checkBox.png")
			p_checkBox[i].x, p_checkBox[i].y = display.contentWidth*0.06, display.contentHeight*(0.06+0.13* (idx-1) - 0.03)


			p_check[i] = display.newImage(carpetGroup, "Content/images/deco_check.png")
			p_check[i].x, p_check[i].y = display.contentWidth*0.06, display.contentHeight*(0.06+0.13* (idx-1) - 0.03)
			--p_check[i].isVisible = false
			if check_done[i] == 1 then	--만약 체크 했었으면
				p_check[i].isVisible = true
			else
				p_check[i].isVisible = false
			end
			--중복 체크 불가 구현			
			local function checked( event ) 
				if p_check[i].isVisible == false then
					for j=1, #wallPaper do
						if p_check[j] ~= nil and p_check[j].isVisible ~= nil and p_check[j].isVisible == true then
							overlapFlag = 1
							print("중복됐습니다.")
							break
						end
					end
					if overlapFlag == 0 then
						p_check[i].isVisible = true
						check_done[i] = 1
						print("체크하겠습니다.")
						carpetIndex = i
					else
						overlapFlag = 0
					end
				else
					p_check[i].isVisible = false
					check_done[i] = 0
					print("체크 해제하겠습니다.")
				end
			end
			p_checkBox[i]:addEventListener("tap", checked)

			local nameOptions = 
			{
				text = wallPaper[i].name,
				x = display.contentWidth*(0.41 + 0.24 - 0.1),
				y = display.contentHeight*(0.04 + 0.13*(idx-1)),
				width = 1000,
				font = "Content/font/ONE Mobile POP.ttf",
				fontSize = 60,
				align = "left"
			}
			ingreName[i] = display.newText(nameOptions) 
			--ingreName[i] = display.newText(ingreGroup, wallPaper[i].name, display.contentWidth*(0.41), display.contentHeight*(0.22+0.13*(i-1)), "font/ONE Mobile POP.ttf") 
			ingreName[i]:setFillColor(0)
			--ingreGroup:insert(ingreName[i])
			carpetGroup:insert(ingreName[i])

			local sentenceOptions = 
			{
				text = wallPaper[i].sentence,
				x = display.contentWidth*(0.41 + 0.24 - 0.1),
				y = display.contentHeight*(0.04 +0.13*(idx-1)+ 0.04),
				width = 1000,
				font = "Content/font/ONE Mobile POP.ttf",
				fontSize = 45,
				align = "left"
			}
			idx = idx + 1
			ingreInfo[i] = display.newText(sentenceOptions)
			--ingreInfo[i] = display.newText(ingreGroup, wallPaper[i].sentence, display.contentWidth*(0.41+0.2), display.contentHeight*(0.22+0.13*(i-1)+ 0.04), "font/ONE Mobile POP.ttf")
			ingreInfo[i]:setFillColor(0)
			--ingreGroup:insert(ingreInfo[i])
			carpetGroup:insert(ingreInfo[i])
		end
	end

	local scrollView = widget.newScrollView(
	{
		horizontalScrollDisabled=true,
		left = 169,
		top = 800,
		width = 1115,
		height = 1150,
		backgroundColor = { 0, 0, 0 , 0}

	} )
	scrollView:insert( carpetGroup )
	popGroup:insert( scrollView )

	sceneGroup:insert(background_room1)
	sceneGroup:insert(background_room2)
	sceneGroup:insert(background_carpet)
			
	sceneGroup:insert(homeIcon)
	sceneGroup:insert(breadIcon) 
	sceneGroup:insert(text_breadRoom) 
	sceneGroup:insert(coinIcon) 
	sceneGroup:insert(gray_lowerLeft) 
	sceneGroup:insert(gray_lowerRight) 
	sceneGroup:insert(gray_upperLeft) 
	sceneGroup:insert(gray_upperRight) 
	sceneGroup:insert(bookIcon)
	sceneGroup:insert(text_bookIcon)
	sceneGroup:insert(store)
		
	sceneGroup:insert(text_storeIcon)
	sceneGroup:insert(temp)
	sceneGroup:insert(text_tempIcon)
	sceneGroup:insert(text_deco)
	sceneGroup:insert(dia)
	sceneGroup:insert(pushIcon)
	sceneGroup:insert(text_push)

	sceneGroup:insert(menuGroup)
	sceneGroup:insert(popGroup)
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
		composer.removeScene("decorationC")

		--[[if carpetFlag == 1 then
			composer.setVariable("carpetIndex", carpetIndex)
			print(carpetIndex)
			carpetFlag = 0
		end]]
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