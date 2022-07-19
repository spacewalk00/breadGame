-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

syrub = 0
ingredient = 0

composer.setVariable("s", syrub)
composer.setVariable("m", ingredient)

function moveToBook(event)
	print("도감으로 이동")
	------------showCoin관련 수정
	showCoin.isVisible = false
	composer.gotoScene("bookMain")
end

function moveToBreadRoom(event)
	print("빵방으로 이동")
	-------------showCoin 관련 수정
	showCoin.x, showCoin.y = display.contentWidth*0.54, display.contentHeight*0.05
	composer.gotoScene("part5")
end
---------------업적으로 이동---------------------
local function  gotoAchieve(event)
	print("업적으로 이동")
	---------showCoin 관련 수정
	showCoin.x, showCoin.y = display.contentWidth*0.54, display.contentHeight*0.053
	composer.gotoScene("achieve")
end
------------------------------------------------
----------------------- 재화 관련 -------------------------
-----------showCoin 수정
--showCoin = display.newText(coinNum, display.contentWidth*0.35, display.contentHeight*0.04, "Content/font/ONE Mobile POP.ttf", 50)
--showCoin:setFillColor(0)
--[[
function forCoin()
	showCoin = display.newText(coinNum, display.contentWidth*0.35, display.contentHeight*0.04, "Content/font/ONE Mobile POP.ttf", 50)
	showCoin:setFillColor(0)
end

function deleteBeforeNum()
	showCoin:removeSelf()
end

--forCoin()
]]
----------------- 경험치에 따른 레벨업 관련 ---------------------
levelUpFlag = 0 
local function levelUpPop( n ) --레벨업 창 화면에 띄우기 --
	print("레벨업!!!!!!!!!"..n.."으로")
	--audio.play( soundTable["levelUpSound"] ,  {channel=6})
	
	levelUpFlag = 1

	levelGroup = display.newGroup()

	levelDarkening = display.newImageRect(levelGroup, "Content/images/dark.png", 1440*2, 710*7)
	levelDarkening.x, levelDarkening.y = display.contentCenterX, display.contentCenterY
	
	local levelUpPopMark = display.newImage(levelGroup, "Content/images/levelUp.png")
	levelUpPopMark.x, levelUpPopMark.y = display.contentCenterX, display.contentCenterY*0.8
	showNewLevel = display.newText(n, display.contentWidth*0.075, display.contentHeight*0.045, "Content/font/ONE Mobile POP.ttf", 100)
	showNewLevel.x, showNewLevel.y = display.contentWidth*0.52, display.contentHeight*0.37
	showNewLevel:setFillColor(1)

	
	levelGroup:insert(showNewLevel)

	---deleteBeforeLevel()
	---forLevel()
	
	local message = display.newText(levelGroup, "LEVEL UP!", display.contentCenterX, display.contentCenterY, "Content/font/ONE Mobile POP.ttf", 100)
	message:setFillColor(1)

	transition.fadeOut(levelGroup, {timer = 2000, delay = 1000})
end
--------------------------------showLevel 수정
	showLevel = display.newText(levelNum, display.contentWidth*0.075, display.contentHeight*0.045, "Content/font/ONE Mobile POP.ttf", 90)
	showLevel:setFillColor(1)
	--[[
function forLevel() -- 레벨 숫자 다루기--
	showLevel = display.newText(levelNum, display.contentWidth*0.075, display.contentHeight*0.045, "Content/font/ONE Mobile POP.ttf", 90)
	showLevel:setFillColor(1)
end
function deleteBeforeLevel() --레벨 숫자 다루기2--
	showLevel:removeSelf()	
end
	]]

function levelUp() --레벨업 --
	print("레벨 몇이냐면..."..levelNum.."!!!!!!!")
	for i=2, 10 do
		if exp >= 1000 + (i-2)*1000 and levelFirstTime[i] == 1 then
			levelNum = i
			if i == 10 then
				coinNum = coinNum + 10000
			else 
				coinNum = coinNum + 3000
			end
			levelFirstTime[i] = 0
			levelUpPop(levelNum)
			--재화 갱신--
			---deleteBeforeNum()
			---forCoin()
			----------showCoin 수정
			showCoin.text = coinNum
			----------showLevel 수정
			showLevel.text = levelNum
			break
		end
	end
end

function scene:create( event )
	local sceneGroup = self.view
	--[[
	-- 배경 --
	local background = display.newImage("Content/image/main_image.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2]]

	----------showCoin 수정
	showCoin.text = coinNum
	---forCoin() -- 재화 업뎃
	-----------showLevel 수정
	---forLevel() -- 레벨 업뎃
	local background = display.newImage("Content/images/background.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY

	local oven = display.newImageRect("Content/images/oven.png", 1550, 820)
	oven.x, oven.y = display.contentCenterX, display.contentHeight*0.9

	local level = display.newImage("Content/images/level.png")
	level.x, level.y = display.contentWidth*0.07, display.contentHeight*0.04

	--local showLevel = display.newText(levelNum, display.contentWidth*0.075, display.contentHeight*0.045, "Content/font/ONE Mobile POP.ttf", 90)
	--showLevel:setFillColor(1)

	local coins = display.newImage("Content/images/coins.png")
	coins.x, coins.y = display.contentWidth*0.3, display.contentHeight*0.04

	local book = display.newImage("Content/images/book.png");
	book.x, book.y = display.contentWidth*0.75, display.contentHeight*0.04
	local s_book = display.newImage("Content/images/shadow.png")
	s_book.x, s_book.y = display.contentWidth*0.75, display.contentHeight*0.04
	local text_book = display.newImage("Content/images/text_Book2.png")
	text_book.x, text_book.y = display.contentWidth*0.75, display.contentHeight*0.065

	local store = display.newImageRect("Content/images/store.png", 170, 170)
	store.x, store.y = display.contentWidth*0.9, display.contentHeight*0.035
	local s_store = display.newImage("Content/images/shadow.png")
	s_store.x, s_store.y = display.contentWidth*0.9, display.contentHeight*0.04
	local text_store = display.newImage("Content/images/text_store.png")
	text_store.x, text_store.y = display.contentWidth*0.9, display.contentHeight*0.065

	local function gotoStore(event)
	    	--deleteBeforeNum()
	    	--forCoin()
	    -------------showCoin 관련 수정--------
		showCoin.x, showCoin.y = display.contentWidth*0.55, display.contentHeight*0.05
		composer.gotoScene("store_i")
	end
	store:addEventListener("tap", gotoStore)

	
	local success = display.newImage("Content/images/success.png")
	success.x, success.y = display.contentWidth*0.75, display.contentHeight*0.13
	local s_success = display.newImage("Content/images/shadow.png")
	s_success.x, s_success.y = display.contentWidth*0.75, display.contentHeight*0.13
	local text_success = display.newImage("Content/images/text_acheivements.png")
	text_success.x, text_success.y = display.contentWidth*0.75, display.contentHeight*0.155

	local breadRoom = display.newImageRect("Content/images/breadRoom.png", 170, 170)
	breadRoom.x, breadRoom.y = display.contentWidth*0.9, display.contentHeight*0.135
	local s_breadRoom = display.newImage("Content/images/shadow.png")
	s_breadRoom.x, s_breadRoom.y = display.contentWidth*0.9, display.contentHeight*0.13
	local text_breadRoom = display.newImage("Content/images/text_breadRoom.png")
	text_breadRoom.x, text_breadRoom.y = display.contentWidth*0.9, display.contentHeight*0.155
	
	book:addEventListener("tap", moveToBook)
	breadRoom:addEventListener("tap", moveToBreadRoom)
	----------업적 관련 추가--------------
	success:addEventListener("tap", gotoAchieve)
	-------------------------------------
	
	--[[
	----------엔딩보기 추가---------------
	local ending = display.newText("엔딩보기", display.contentWidth*0.95, display.contentHeight*0.99, "font/ONE Mobile POP.ttf", 40)
	--ending:setFillColor(0.5)
	function gotoEnd(event)
		----------------showCoin관련 수정
		showCoin.isVisible = false
		composer.gotoScene("outtro")
	end
	ending:addEventListener("tap", gotoEnd)
	]]
	
	-------------------------------------
	--재료 추가 버튼--
	local material_button = display.newImage("Content/image/material_button.png", display.contentWidth, display.contentHeight)
	material_button.x, material_button.y = display.contentWidth * 0.138, display.contentHeight * 0.444

	local function plus( event )
 
	    if ( event.phase == "began" ) then
			showCoin.isVisible = false
	        composer.gotoScene("syrup")
		end
	end
	material_button:addEventListener("touch", plus)


	sceneGroup:insert( background )

	sceneGroup:insert( oven )
	sceneGroup:insert( level )
	sceneGroup:insert( showLevel )
	sceneGroup:insert( coins ) 
	sceneGroup:insert( s_book ) sceneGroup:insert( book ) sceneGroup:insert( text_book )
	sceneGroup:insert( s_store ) sceneGroup:insert( store ) sceneGroup:insert( text_store )
	sceneGroup:insert( s_success ) sceneGroup:insert( success ) sceneGroup:insert( text_success )
	sceneGroup:insert( s_breadRoom ) sceneGroup:insert( breadRoom ) sceneGroup:insert( text_breadRoom )
	sceneGroup:insert( material_button )

	-------------------엔딩보기------------
	--빵 도감 채운 개수 전역변수
	breadBook_count = 0
	--업그레이드 빵 도감 채운 개수
	breadBookUP_count = 0
	for n = 1, 4 do
		for m = 1, 8 do	
			if openBread[n][m] ~= 0 then
				breadBook_count = breadBook_count + 1
			end
		end
	end
	for n = 1, 4 do
		for m = 1, 8 do
			if openUBread[n][m] ~= 0 then
				breadBookUP_count = breadBookUP_count + 1
			end
		end
	end
	if breadBook_count + breadBookUP_count >= 63 then 
		local endingButton = display.newImage("Content/images/아웃트로/togoEnd.png", display.contentWidth*0.88, display.contentHeight*0.19)
		local ending = display.newText("엔딩보기", display.contentWidth*0.88, display.contentHeight*0.19, "font/ONE Mobile POP.ttf", 40)
		--ending:setFillColor(0.5)

		function gotoEnding(event)
		----------------showCoin관련 수정
			showCoin.isVisible = false
			composer.gotoScene("outtro")
		end
		endingButton:addEventListener("tap", gotoEnding)
		sceneGroup:insert(endingButton)
		sceneGroup:insert(ending)
	end
	-------------------------------------
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
	elseif phase == "did" then
		composer.removeScene("home")
		composer.removeScene("result")
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