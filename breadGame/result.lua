-----------------------------------------------------------------------------------------
--
-- result.lua
--
-----------------------------------------------------------------------------------------
-- JSON 파싱
local json = require("json")

local function parse()
	local filename = system.pathForFile("Content/JSON/breadInfo.json")
	Data, pos, msg = json.decodeFile(filename)
end
parse()
----------------------경험치/레벨업 보상 관련------------------
local function parse2()
	filename = system.pathForFile("Content/JSON/ingredient.json")
	ingredients, pos2, msg2 = json.decodeFile(filename)

	--[[if ingredients then
		print(ingredients[1].name)
	else
		print(pos2)
		print(msg2)
	end]]
end
parse2()
---- 새빵 (미해금0 , 해금 -1, 확인했음 1로 변화)
--[[openBread = { {1, -1, 1, 1, 1, 1, 1, 1}, {1, 0, 0, 0, 0, 0, 0, 0}, 
				{1, 0, 0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0} }
openUBread = { {1, 1, 1, 1, 1, 1, 1, 1}, {0, 0, 0, 0, 0, 0, 0, 0}, 
				{0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0} }]]

--빵카운트 배열 --
--[[breadsCnt = {}
for i=1, 5 do 
	breadsCnt[i] = {}
	for j=1, 8 do
		if( i== 5) then
			print("폭탄빵")
			breadsCnt[5][1] = 0
			break
		end
		breadsCnt[i][j] = 0
	end
end]]
--

--스크롤뷰
--[[local widget = require("widget")
local scrollView = widget.newScrollView(
{
    horizontalScrollDisabled=true,
    top = 1590,
    left = 200,
    width = 1000,
    height = 300
    --hideBackground = true
    --0.949, 0.839, 0.776
})
]]
local function ingreRandom() --시럽/재료 각각 랜덤으로 하나씩 보상--
	audio.play( soundTable["rewardSound"] ,  {channel=7})
	local n = math.random(2, 5) --초코시럽(2), 딸기시럽(3), 슈크림시럽(4)
	ingreCnt[n] = ingreCnt[n] + 1

	n = math.random(5, 12) -- 재료 랜덤하게
	ingreCnt[n] = ingreCnt[n] + 1
end
---------성공빵 비율/ level1: 50 (+ 5%) / portion = 5 (+0.5)-----------
local function successPortion()
	for i=1, 10 do
		if levelNum == i then
			portion = 5 + 0.5*(i-1)
		end
	end
	print(levelNum.."에서 성공비율은 "..portion)
end	
successPortion()
--

--씬시작--
local composer = require( "composer" )
local scene = composer.newScene()

local image, name, sentence 
local new, newFlag = 0
local fail = 0

function scene:create( event )
	local sceneGroup = self.view
	-- 배경 --
	local background = display.newImage("Content/image/인트로/face_love.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY

	--local oven = display.newImageRect("Content/images/oven.png", 1550, 820)
	--oven.x, oven.y = display.contentCenterX, display.contentHeight*0.9

	local level = display.newImage("Content/images/level.png")
	level.x, level.y = display.contentWidth*0.07, display.contentHeight*0.04
	
	local showLevel = display.newText(levelNum, display.contentWidth*0.075, display.contentHeight*0.045, "Content/font/ONE Mobile POP.ttf", 90)
	showLevel:setFillColor(1)

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

	local coins = display.newImage("Content/images/coins.png")
	coins.x, coins.y = display.contentWidth*0.3, display.contentHeight*0.04

	--경험치 추가--
	local expDisplay = display.newText("경험치: "..exp, display.contentWidth*0.555, display.contentHeight*0.04, "Content/font/ONE Mobile POP.ttf")
	expDisplay:setFillColor(0)
	expDisplay.size = 50
	
	expHint = display.newText(1000*levelNum.."이 넘으면 레벨업!", display.contentWidth*0.555, display.contentHeight*0.07, "Content/font/ONE Mobile POP.ttf")
	expHint:setFillColor(0.2)
	expHint.size = 35
	--

	local function gotoStore(event)
		coins:removeSelf()
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
	--
	darkening = display.newImageRect("Content/images/dark.png", 1440*2, 710*7)
	darkening.x, darkening.y = display.contentCenterX, display.contentCenterY

	
	sceneGroup:insert( background )

	--sceneGroup:insert( oven )
	sceneGroup:insert( level )
	sceneGroup:insert( showLevel )
	sceneGroup:insert( coins ) 
	sceneGroup:insert( expDisplay )
	sceneGroup:insert( expHint )
	sceneGroup:insert( s_book ) sceneGroup:insert( book ) sceneGroup:insert( text_book )
	sceneGroup:insert( s_store ) sceneGroup:insert( store ) sceneGroup:insert( text_store )
	sceneGroup:insert( s_success ) sceneGroup:insert( success ) sceneGroup:insert( text_success )
	sceneGroup:insert( s_breadRoom ) sceneGroup:insert( breadRoom ) sceneGroup:insert( text_breadRoom )
	sceneGroup:insert( darkening )

end

function scene:show( event )
	------------------------------------ 등장하는 빵을 결정하는 정보 설정 -------------------------------------------
	local sceneGroup = self.view
	local phase = event.phase
	
	--local syrub -- x(0), 초코(1), 딸기(2), 슈크림(3) --
	--local ingredient -- x(0), 반짝이(1)/소세지(2)/팥(3)/치즈(4)/옥수수(5)/오레오(6)/슈가(7)--

	if phase == "will" then
		--audio.play(soundTable["backgroundMusic"])
		-- 성공빵 확률 만들기--
		local n = math.random(0, 10)
		print(n)

		if n >= portion and n <= 10 then
			fail = 1
			syrub = 4
			ingredient = 0 --폭탄빵 [5][1]
			exp = exp + 20 -- 폭탄빵 경험치 20 제공
			---업적 관련
			bomb_count = bomb_count + 1 				--실패빵 제작 개수
			breadBomb_count = breadBomb_count + 1 		--실패빵 연속 제작 개수
			if breadBomb_count == 5 then
				quest_clear[4][1] = 1 
			end
			if breadBomb_count == 10 then 
				quest_clear[4][2] = 1
			end
			breadNormal_count = 0 						--연속 일반빵 제작 개수
		else
			fail = 0
			print("시럽은"..syrub.." 재료는 "..ingredient) -- 여기 들어와야함 왜 여기까지 안들어오냐면 listenr가 비어있다는데..
			--syrub = 1 
			--ingredient = 0
			--
			exp = exp + 100 -- 성공적인 빵 경험치 100 제공
			--시럽 3개 보상 제공--
			ingreCnt[2] = ingreCnt[2] + 1
			ingreCnt[3] = ingreCnt[3] + 1
			ingreCnt[4] = ingreCnt[4] + 1

			---업적 관련
			bread_count = bread_count + 1 					--일반빵 제작 개수
			breadNormal_count = breadNormal_count + 1  		--연속 일반빵 제작 개수
			if breadNormal_count == 5 then
				quest_clear[3][1] = 1 
			end
			if breadNormal_count == 10 then 
				quest_clear[3][2] = 1
			end
			breadBomb_count = 0 							--연속 실패빵 제작 개수
		end

		--print(fail.."인데 1이면 실패, 0이면 성공")
		--print("초코시럽 몇개냐면"..ingreCnt[2].."  딸기시럽 몇개냐면"..ingreCnt[3])

		image = Data[syrub+1].breads[ingredient+1].image
		name = Data[syrub+1].breads[ingredient+1].name
		sentence = Data[syrub+1].breads[ingredient+1].sentence

		-- new 빵은 new 그림--
		if(breadsCnt[syrub+1][ingredient+1] == 0 and syrub >= 0 and ingredient >=0) then
			newFlag = 1
		end
		-- 빵 Cnt 증가 --
		breadsCnt[syrub+1][ingredient+1] = breadsCnt[syrub+1][ingredient+1] + 1
		-- 빵 해금 갱신
		if openBread[syrub+1][ingredient+1] == 0 then
			openBread[syrub+1][ingredient+1] = -1
		end

	elseif phase == "did" then
		----------------------------------------- 완성된 빵 (팝업창 띄우기) ------------------------------------------------
		local windowGroup = display.newGroup()
		local fixedGroup = display.newGroup()
		local textGroup = display.newGroup() --스크롤

		local window = display.newImage(windowGroup, "Content/images/window.png")
		window.x, window.y = display.contentWidth*0.5, display.contentHeight*0.55

		local sf, showsf
		if fail == 0 then
			sf = "Content/images/text_success.png"
			audio.play( soundTable["breadSound"],  {channel=3} )
		elseif fail == 1 then
			sf = "Content/images/text_fail.png"
			audio.play( soundTable["bombSound"] ,  {channel=2})
		end

		local text_success = display.newImage(windowGroup, sf)
		text_success.x, text_success.y = display.contentWidth*0.5, display.contentHeight*0.27
		--showsf = display.newText(sf, display.contentWidth*0.5, display.contentHeight*0.27, "Content/font/ONE Mobile POP.ttf")
		--showsf:setFillColor(0)
		--showsf.size = 100

		-- 빵빠레 --
		local halo = display.newImage("Content/images/halo.png")
		halo.x, halo.y = display.contentWidth*0.5, display.contentHeight*0.5

		halo.rotation = -45
		local reverse = 1
		local function rock()
			if (reverse == 0) then
				reverse = 1
				transition.to(halo, {rotation=-45, time=1000, transition=easing.inOutCubic })
			else
				reverse = 0
				transition.to(halo, {rotation=45, time=1000, transition=easing.inOutCubic })
			end
		end
		timer.performWithDelay(900, rock, 0) -- repeat forever

		-- new 빵은 new 그림--
		if(newFlag == 1) then
			new = display.newImage("Content/images/new.png")
			new.x, new.y = display.contentWidth*0.3, display.contentHeight*0.4
		end


		-- 빵그룹--
		local tempBread = display.newImageRect("Content/images/"..image..".png", 500, 500)
		tempBread.x, tempBread.y = display.contentWidth*0.5, display.contentHeight*0.485

		local showName = display.newText(name, display.contentWidth*0.5, display.contentHeight*0.6, "Content/font/ONE Mobile POP.ttf")
		showName:setFillColor(0)
		showName.size = 100	

		fixedGroup:insert( window )
		--fixedGroup:insert( showsf )
		fixedGroup:insert( text_success )
		fixedGroup:insert( halo )
		fixedGroup:insert( tempBread )
		fixedGroup:insert( showName )

		-- Text box with transparent background
		--[[local textBox = native.newTextBox( 720, 1740, 1080, 300)
		textBox.font = native.newFont( "Content/font/ONE Mobile POP.ttf", 16 )
		textBox:setTextColor(0.5)
		textBox.size = 60

		--textBox.hasBackground = false
		textBox.text = sentence]]
			
		--[[local showBox = display.newRect(1000, 1000, 300, 300)
		showBox:setFillColor(0)
		local showSentence = display.newText(sentence, display.contentWidth*0.5, display.contentHeight*0.68, "Content/font/ONE Mobile POP.ttf")
		showSentence:setFillColor(0)
		showSentence.size = 50
		local option = {
			type = "text",
			filename = "showSentence"
		}
		showBox.fill = option

		scrollView:insert( showBox )

		textGroup:insert( showSentence )
		textGroup:insert( showBox )]]
		local showSentence = display.newText(sentence, display.contentWidth*0.5, display.contentHeight*0.68, "Content/font/ONE Mobile POP.ttf")
		showSentence:setFillColor(0)
		showSentence.size = 50
		textGroup:insert(showSentence)

		fixedGroup:toFront()

		local button = display.newImage("Content/images/button.png")
		button.x, button.y = display.contentWidth*0.5, display.contentHeight*0.8
		
		local check = "Content/images/text_OK.png"
		local showCheck = display.newImage(check)
		showCheck.x, showCheck.y = display.contentWidth*0.5, display.contentHeight*0.8
		--local showCheck = display.newText(check, display.contentWidth*0.5, display.contentHeight*0.8, "Content/font/ONE Mobile POP.ttf")
		--showCheck:setFillColor(0)
		--showCheck.size = 80

		local close = display.newImage("Content/images/close.png")
		close.x, close.y = display.contentWidth*0.9, display.contentHeight*0.25

		windowGroup:insert( window )
		windowGroup:insert( text_success )
		--windowGroup:insert( showsf )
		windowGroup:insert( halo )

		windowGroup:insert( tempBread )
		windowGroup:insert( showName )
		--windowGroup:insert( showBox )
		windowGroup:insert( showSentence )
		--windowGroup:insert( textBox )
		--windowGroup:insert( scrollView )

		windowGroup:insert( button )
		windowGroup:insert( showCheck )
		if( newFlag == 1) then
			windowGroup:insert( new )
		end
		windowGroup:insert( close )

	 	--------------------------------버튼, x 탭 (팝업창 내리기/new빵일 때 재화지급(ex) 1000)---------------------------------------------------
	    local function tapListener(event)
	    	windowGroup:removeSelf()
	    	if newFlag == 1 then
	    	new:removeSelf()
	    	end
	    	darkening:removeSelf()

	    	if(fail == 0) then
				--보상 표시--
				local rewardGroup = display.newGroup()

				local choco = display.newImage(rewardGroup, ingredients[2].image)
				choco.x, choco.y = display.contentWidth*0.555, display.contentHeight*0.5

				local straw = display.newImage(rewardGroup, ingredients[3].image)
				straw.x, straw.y = display.contentWidth*0.555, display.contentHeight*0.55

				local vanilla = display.newImage(rewardGroup, ingredients[4].image)
				vanilla.x, vanilla.y = display.contentWidth*0.555, display.contentHeight*0.6

				transition.moveTo(choco, {time = 1500, x=display.contentWidth*0.138, y=display.contentHeight*0.444} ) 
				transition.moveTo(straw, {time = 1500, x=display.contentWidth*0.138, y=display.contentHeight*0.444} ) 
				transition.moveTo(vanilla, {time = 1500, x=display.contentWidth*0.138, y=display.contentHeight*0.444} ) 

				transition.fadeOut(rewardGroup, {timer = 1500, delay = 500})

				audio.play( soundTable["rewardSound"],  {channel=7} )

	    		-- new일 때 코인 지급 -- 
				if newFlag == 1 then
					coinNum = coinNum + 1000
					showCoin.text = coinNum

					newFlag = 0
					audio.play( soundTable["cashSound"] ,  {channel=4})
				end
	    	end

			audio.play( soundTable["clickSound"],  {channel=5}) 
			composer.gotoScene("home")
	    	levelUp()

	    	syrub = 0
	    	ingredient = 0
	    end

	    button:addEventListener("tap", tapListener)
	    close:addEventListener("tap", tapListener)
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
		composer.removeScene("result")
	end
end

function scene:destroy( event )
	local sceneGroup = self.view	
end

---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene