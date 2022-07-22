-----------------------------------------------------------------------------------------
--
-- intro.lua
--
-----------------------------------------------------------------------------------------

-- JSON 파싱
local json = require('json')

local Data, pos, msg

local function parse()
	local filename = system.pathForFile("Content/JSON/intro.json")
	Data, pos, msg = json.decodeFile(filename)

	--디버그
	if Data then
		print(Data[1].type)
	else
		print(pos)
		print(msg)
	end
	--
end
parse()
--

-------업적 전역 변수----------
--돈 전역 변수
--coinNum = 0
--폭탄빵 제작 전역변수
bomb_count = 0
--연속 일반빵 제작 전역변수
breadNormal_count = 0
--폭탄빵 연속 제작 전역변수
breadBomb_count = 0
--빵 제작 전역변수
bread_count = 0
--빵 도감 채운 개수 전역변수
breadBook_count = 0
--업그레이드 빵 도감 채운 개수
breadBookUP_count = 0
--빵 방 빵 채운 개수 전역변수
breadRoom_count = 0





local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local windowGroup = display.newGroup()

	--배경화면
	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	--skip 버튼
	local skip_B = display.newText("SKIP", display.contentWidth*0.92, display.contentHeight*0.04, "Content/font/ONE Mobile POP.ttf")
	skip_B.size = 50
	skip_B:setFillColor(0)
	--말풍선
	local bubble = display.newImage("Content/images/인트로/bubble.png", display.contentWidth/2, display.contentHeight*0.86)

	--local name = display.newImage("Content/images/인트로/name.png", display.contentWidth*0.1, display.contentHeight*0.8, display.contentWidth, display.contentHeight)
	--클릭 버튼
	local click = display.newImage("Content/images/인트로/click.png", bubble.x + 550, bubble.y + 165)
	--대사
	local script = display.newText("더미 텍스트", bubble.x, bubble.y-20, "Content/font/ONE Mobile POP.ttf")
	--script.width = display.contentWidth*0.6
	script.size = 65
	script:setFillColor(0)

	---------------skip하기--------------
	local function skip(event)
		local options = {
			effect = "crossFade",
			time = 200
		}
		composer.gotoScene("home", options)
	end
	skip_B:addEventListener("tap", skip)

	------------------대사----------------
	local index = 1
	local function nextScript( ... )
		local options = {
			effect = "fade",
			time = 200
		}
		if (index <= #Data) then
			if( Data[index].type == "background" ) then
				
				--배경 바꾸기
				background.fill = {
					type = "image",
					filename = Data[index].img
				}
				index = index + 1
				nextScript()
			
			elseif( Data[index].type == "bubble" ) then
			 
			 	--말풍선
				bubble.fill = {
					type = "image",
					filename = Data[index].img
				}
				index = index + 1
				nextScript()
			
			elseif( Data[index].type == "Narration" ) then
			 
			 	--해설
				 script.text = Data[index].content
				 index = index + 1
			end
		else	
			composer.gotoScene("home", options)
		end
	end
	nextScript()


	local function tap( event )
		audio.play(SE1, {channel=5})
		audio.stopWithDelay(420, {channel=5})
		nextScript()
	end
	background:addEventListener("tap", tap)

--[[
	windowGroup:insert(background)
	windowGroup:insert(skip_B)
	windowGroup:insert(bubble)
	windowGroup:insert(click)
	windowGroup:insert(script)]]


	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(skip_B)
	sceneGroup:insert(bubble)
	--sceneGroup:insert(name)
	sceneGroup:insert(click)
	sceneGroup:insert(script)


	--windowGroup:removeSelf()
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

		--{**오프닝 때 초기화(정적변수기능없음) 통째로 가져가주세요--
		coinNum = 0 --}


		--{**오프닝 때 초기화(정적변수기능없음) 통째로 가져가주세요--
		exp = 0 --exp = 0
		levelNum = 1 --levelNum = 1 

		levelFirstTime = {} -- 경험치가 처음으로 일정 수준을 넘었을 때만 레벨업을 주기 위함. --
			function levelTimeReset() 
				for i=2, 10 do
		 		levelFirstTime[i] = 1
			end
		end
		levelTimeReset() --}

		ingreCnt = {} --재료카운트
		for i=1, 11 do
			ingreCnt[i] = 0
		end

	elseif phase == "did" then

		
		-- Called when the scene is now off screen
		composer.removeScene("intro")
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