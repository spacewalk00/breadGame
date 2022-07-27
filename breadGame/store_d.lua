-----------------------------------------------------------------------------------------
--
-- store_i.lua
--
-----------------------------------------------------------------------------------------
local json = require('json')
local deco, pos, msg
--

local function deco_parse()
	local filename = system.pathForFile("Content/JSON/deco.json")
	deco, pos, msg = json.decodeFile(filename)

	if deco then
		print(deco[1].name)
	else
		print(pos)
		print(msg)
	end
end
deco_parse()
--[[
decoCnt = {}
decoFlag = {}

for i=1, #deco do
	decoCnt[i] = 0
	decoFlag[i] = 0
end]]

local composer = require( "composer" )
local scene = composer.newScene()


--위젯:스크롤--
local widget = require( "widget" )

local ingreGroup = display.newGroup()
local cnt = {}

local function displayIngreCnt(i)
	cnt[i] = display.newText(ingreGroup, decoCnt[i].."개", display.contentWidth*0.8, display.contentHeight*(0.06+0.13* (i-1)), "Content/font/ONE Mobile POP.ttf")
	cnt[i].x, cnt[i].y = display.contentWidth*0.8, display.contentHeight*(0.06+0.13* (i-1))
	cnt[i]:setFillColor( 0.894, 0.772, 0.713 )
	cnt[i].size = 50
end

local function printAllCnt()
	for i=1, #deco do
		displayIngreCnt(i)
	end
end

local function deleteBeforeCnt(i)
	display.remove(cnt[i])
end

local function deleteAllCnt()
	for i=1, #deco do
		deleteBeforeCnt(i)
	end
end

function scene:create( event )
	local sceneGroup = self.view

	local topGroup = display.newGroup()

	local background = display.newImage("Content/images/storeBackground.png")

	--background.x = display.contentCenterX
	--background.y = display.contentHeight * 0.08
	background.x, background.y = display.contentCenterX, display.contentCenterY
	
	local store = display.newImageRect("Content/images/store.png", 200, 200)
	store.x, store.y = display.contentWidth*0.15, display.contentHeight*0.04
	--local storeText = display.newText("상점", display.contentWidth*0.28, display.contentHeight*0.05, "Content/font/ONE Mobile POP.ttf")
	--storeText:setFillColor(0)
	--storeText.size = 70
	local storeText = display.newImage("Content/images/text_store2.png")
	storeText.x, storeText.y = display.contentWidth*0.28, display.contentHeight*0.05

	coins = display.newImage("Content/images/coins.png")	
	coins.x, coins.y = display.contentWidth*0.5, display.contentHeight*0.05
	showCoin.x, showCoin.y = display.contentWidth*0.55, display.contentHeight*0.05

	local explainText = display.newText("※장식과 카펫은 1개만 구매가능합니다.", display.contentWidth*0.6, display.contentHeight*0.08 ,"Content/font/ONE Mobile POP.ttf")
	explainText.size = 40
	explainText:setFillColor(1)

	local home = display.newImage("Content/images/home.png")
	home.x, home.y = display.contentWidth*0.9, display.contentHeight*0.05
	home:addEventListener("tap", gotoh) 

	local productType = display.newImage("Content/images/top_bar.png")
	productType.x, productType.y = display.contentWidth*0.5, display.contentHeight*0.12

	local choiceMark = display.newImage("Content/images/chosen.png")

	choiceMark.x, choiceMark.y = display.contentWidth*0.5, display.contentHeight*0.14
	--choiceMark.x, choiceMark.y = display.contentWidth*0.8, display.contentHeight*0.14
	--choiceMark.x, choiceMark.y = display.contentWidth*0.2, display.contentHeight*0.14

	local ingredientBtn = display.newRect(display.contentWidth*0.2, display.contentHeight*0.12, 280, 150)
	ingredientBtn.alpha = 0.01
	local ingredientText = display.newText("재료", display.contentWidth*0.2, display.contentHeight*0.12, "Content/font/ONE Mobile POP.ttf")
	--ingredientText.fill.blendMode = "srcIn"
	ingredientText.size = 70

	local decoBtn = display.newRect(display.contentWidth*0.5, display.contentHeight*0.12, 280, 150)
	decoBtn.alpha = 0.01
	local decoText = display.newText("장식", display.contentWidth*0.5, display.contentHeight*0.12, "Content/font/ONE Mobile POP.ttf")
	decoText.size = 70
	decoText:setFillColor(0)

	local wallBtn = display.newRect(display.contentWidth*0.8, display.contentHeight*0.12, 280, 150)
	wallBtn.alpha = 0.01
	local wallText = display.newText("카펫", display.contentWidth*0.8, display.contentHeight*0.12, "Content/font/ONE Mobile POP.ttf")
	--wallText.fill.blendMode = "srcIn"
	wallText.size = 70
	
	topGroup:insert(background)
	topGroup:insert(store)
	topGroup:insert(storeText)
	topGroup:insert(coins)
	topGroup:insert(explainText)
	topGroup:insert(home)
	topGroup:insert(productType)
	topGroup:insert(choiceMark)
	topGroup:insert(ingredientBtn)
	topGroup:insert(ingredientText)
	topGroup:insert(decoBtn)
	topGroup:insert(decoText)
	topGroup:insert(wallBtn)
	topGroup:insert(wallText)	

	ingredientBtn:addEventListener("tap", gotoi)
	--decoBtn:addEventListener("tap", gotod)
	wallBtn:addEventListener("tap", gotow)


	

	-- 이 부분이 달라짐 store_i, store_d, store_w의 차이--
	--commonFrame()

	local listGroup = display.newGroup()
	local background2 = display.newImage("Content/images/storeBackground.png")

	background2.x, background2.y = display.contentCenterX, display.contentCenterY

	local product_bar = {}
	local p_pic_bar = {}
	local p_pic = {}
	--local cnt = {}
	local ingreName = {}
	local ingreInfo = {}
	local defaultBox 


	for i=1, #deco do
		product_bar[i] = display.newImage(ingreGroup, "Content/images/product_bar.png")
		product_bar[i].x, product_bar[i].y = display.contentWidth*0.5, display.contentHeight*(0.06+0.13* (i-1))
		p_pic_bar[i] = display.newImage(ingreGroup, "Content/images/syrup_bar.png")
	    p_pic_bar[i].x, p_pic_bar[i].y = display.contentWidth*0.22, display.contentHeight*(0.06+0.13* (i-1))

	    p_pic[i] = display.newImageRect(ingreGroup, deco[i].image, 200, 200)
		p_pic[i].x, p_pic[i].y = display.contentWidth*0.22, display.contentHeight*(0.06+0.13* (i-1))
		p_pic[i].name = i

		displayIngreCnt(i)
		cnt[i]:removeSelf()

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
		ingreName[i]:setFillColor(0)
		ingreGroup:insert(ingreName[i])

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
		ingreGroup:insert(ingreInfo[i])

	listGroup:insert(background2)
	listGroup:insert(ingreGroup)


	--[[sceneGroup:insert(background) sceneGroup:insert(background2)
	sceneGroup:insert(store)
	sceneGroup:insert(storeText)
	sceneGroup:insert(home)
	sceneGroup:insert(productType)
	sceneGroup:insert(choiceMark)
	sceneGroup:insert(decoBtn)
	sceneGroup:insert(decoText)
	sceneGroup:insert(decoBtn)
	sceneGroup:insert(decoText)
	sceneGroup:insert(wallBtn)
	sceneGroup:insert(wallText)	
	sceneGroup:insert(ingreGroup)]]

	function pop( event )
		-- 뒷 배경 어둡게 --

		audio.play( soundTable["clickSound"],  {channel=5}) 
		local darkening = display.newImageRect("Content/images/dark.png", 1440*2, 710*7)
		darkening.x, darkening.y = display.contentCenterX, display.contentCenterY

		local popGroup = display.newGroup()

		local window = display.newImage(popGroup, "Content/images/syrup_window.png")
		window.x, window.y = display.contentCenterX, display.contentCenterY

		local title = display.newText(popGroup, deco[i].name, display.contentCenterX, display.contentHeight*0.37, "Content/font/ONE Mobile POP.ttf")
		title:setFillColor(0)
		title.size = 90

		local pictureBar = display.newImage(popGroup, "Content/images/syrup_bar.png")
		pictureBar.x, pictureBar.y = display.contentWidth*0.25, display.contentHeight*0.5

		local picture = display.newImageRect(popGroup, deco[i].image, 200, 200)
		picture.x, picture.y = display.contentWidth*0.25, display.contentHeight*0.5

		local popTextOptions = 
		{
			text = deco[i].sentence,
			x = display.contentWidth*0.7,
			y = display.contentHeight*0.5,
			width = 1000,
			font = "Content/font/ONE Mobile POP.ttf",
			fontSize = 45,
			align = "left"
		}
		local info = display.newText(popTextOptions)
		info:setFillColor(0)
		info.size = 50
		popGroup:insert(info)

		local buyingBar = display.newImage(popGroup, "Content/images/buying.png")
		buyingBar.x, buyingBar.y = display.contentWidth*0.75, display.contentHeight*0.6
		local coinShape = display.newImage(popGroup, "Content/images/coin.png")
		coinShape.x, coinShape.y = display.contentWidth*0.65, display.contentHeight*0.6

		-- 정확한 가격 책정은 나중에 --
		local buyingText = display.newText(popGroup, "         " .. deco[i].price ..  "    구매", display.contentWidth*0.78, display.contentHeight*0.6, "Content/font/ONE Mobile POP.ttf")
		buyingText:setFillColor(0) 
		buyingText.size = 50

		local close = display.newImage(popGroup, "Content/images/close.png")
		close.x, close.y = display.contentWidth*0.9, display.contentHeight*0.35

		popGroup:toFront()

		local function tapListener( event )
	    	print("탭탭탭")
			audio.play( soundTable["clickSound"],  {channel=5} )
	    	popGroup:removeSelf()
	    	darkening:removeSelf()
	    end

	    local function consume( event )
			-- 1개만 살 수 있게 변경 --
	    	if decoCnt[i] == 0 then
	    	-- 코인 차감 --
	    	if( coinNum >= deco[i].price) then
	    	coinNum = coinNum - deco[i].price
		
			showCoin.text = coinNum
			showCoin.x, showCoin.y = display.contentWidth*0.55, display.contentHeight*0.05

			-- 시럽 보유 카운트--
			decoCnt[i] = decoCnt[i] + 1

	   		deleteBeforeCnt(i)
	    	displayIngreCnt(i)

			print(deco[i].name .."시럽 산 뒤에" .. decoCnt[i])
			audio.play( soundTable["cashSound"] ,  {channel=4})
			else 
				print("야 너 돈 없어")
			end
		end
			-- 
			popGroup:removeSelf()
			darkening:removeSelf()
	    end

	    buyingBar:addEventListener("tap", consume)
	    close:addEventListener("tap", tapListener)
	end

	p_pic[i]:addEventListener("tap", pop)

	end

	sceneGroup:insert(topGroup)
	sceneGroup:insert(listGroup)

	topGroup:toFront()

	local scrollS
	-- 스크롤 만들기
	local function scroll( event )
		if ( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true

			event.target.yStart = event.target.y
			scrollS = display.newImage("Content/images/scrollShadow.png")
			scrollS.x, scrollS.y =  display.contentCenterX, display.contentHeight*0.99

		elseif ( event.phase == "moved" ) then
			if ( event.target.isFocus) then

				event.target.y = event.target.yStart + event.yDelta

			end
		elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
			if ( event.target.isFocus ) then
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
			end
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
			scrollS:removeSelf()
		end
	 
	    -- In the event a scroll limit is reached...
	    if ( event.limitReached ) then
	        if ( event.direction == "up" ) then print( "Reached bottom limit" )
	        elseif ( event.direction == "down" ) then print( "Reached top limit" )
	        --elseif ( event.direction == "left" ) then print( "Reached right limit" )
	        --elseif ( event.direction == "right" ) then print( "Reached left limit" )
	        end
	    end
	 
	    return true
	end

	local scrollView = widget.newScrollView(
		{
	        horizontalScrollDisabled=true,
	        top = 400,
	        width = 1440,
	        height = 2150,
	        hideBackground = true
	        --backgroundColor = { 0.894, 0.772, 0.713 }

	        --0.949, 0.839, 0.776
		}
	)
	scrollView:insert(ingreGroup)
	--scrollView:addEventListener("touch", scroll)
	sceneGroup:insert(scrollView)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		--  coins:removeSelf()
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		printAllCnt()

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
		deleteAllCnt()
		for i=1, #deco do
			if decoCnt[i] == 1 and delete_deco_from_list[i] == 0 then
				decoFlag[i] = 1
				print(i.."인덱스의 flag는"..decoFlag[i].."\n")
			end
		end
		-- Called when the scene is now off screen
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
