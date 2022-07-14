-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
--coinNum = 10000

local composer = require( "composer" )
local scene = composer.newScene()

-- JSON 파싱
local json = require('json')

function parse()
	local filename = system.pathForFile("Content/JSON/breadInfo.json")
	Data, pos, msg = json.decodeFile(filename)
end
-- local UBreadInfo, pos, msg --파싱시 오류 받아옴
-- BreadInfo는 Data
function parseUBreadInfo() --파싱을 하는 함수
	local filename = system.pathForFile("Content/JSON/ubreadInfo.json")
	UBreadInfo, pos, msg = json.decodeFile(filename)
	-- 디버그
	if UBreadInfo then
		print(UBreadInfo[1].breads[1].name)
	else
		print(pos)
		print(msg)
	end
end
parseUBreadInfo()
parse()

--[[-- 빵의 개수 --breadsCnt
breadsCnt = { {1, 1, 1, 1, 1, 1, 1, 1}, {1, 0, 0, 0, 0, 0, 0, 0}, 
				{1, 0, 0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0} 		}
UbreadsCnt = { {1, 1, 1, 1, 1, 1, 1, 1}, {1, 0, 0, 0, 0, 0, 0, 0}, 
				{1, 0, 0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0} 		}
-- 새빵 (미해금0 , 해금 -1, 확인했음 1로 변화)
openBread = { {-1, 1, 1, 1, -1, 1, 1, 1}, {-1, 0, 0, 0, 0, 0, 0, 0}, 
				{1, 0, 0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0} }
openUBread = { {1, 1, 1, 1, 1, 1, 1, 1}, {0, 0, 0, 0, 0, 0, 0, 0}, 
				{0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0} }		
-- 빵레벨
Bread_level = { {1, 1, 1, 1, 1, 1, 1, 1}, {1, 0, 0, 0, 0, 0, 0, 0}, 
				{1, 0, 0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0} }]]

-- 폰트
Font = { 	font_Bold = native.newFont("Content/font/ONE Mobile Bold.ttf"),
			font_Light = native.newFont("Content/font/ONE Mobile Light.ttf"),
			font_POP = native.newFont("Content/font/ONE Mobile POP.ttf"),
			font_Regular = native.newFont("Content/font/ONE Mobile Regular.ttf"),
			font_Title = native.newFont("Content/font/ONE Mobile Title.ttf") 		}

BackGround = display.newImage("Content/images/main_background.png")
BackGround.x, BackGround.y = display.contentWidth/2, display.contentHeight/2

--audio.play(soundTable["backgroundMusic"], { loops = 3 })

function scene:create( event )
	local sceneGroup = self.view

-- 도감 스크롤
	local widget = require( "widget" )
	local function scroll( event )
		if ( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
			event.target.yStart = event.target.y

		elseif ( event.phase == "moved" ) then
			if ( event.target.isFocus) then
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
	        end
	    end
	 
	    return true
	end
	local scrollView = widget.newScrollView(
		{
	        horizontalScrollDisabled=true,
	        top = 0,
	        width = 1440,
	        height = 2650,
	        backgroundColor = { 0.894, 0.772, 0.713 }
		}
	)

-- 도감 그룹화 함수
	local allBread = { } 
	local newBread = { }
	local BImage = { }
	local BText = { }
	local BreadGroup
	local index1 = 1
	local index2 = 1

-- 빵 정보창 이동 (빵 클릭)
	local function goInfo(event)
		audio.play(soundTable["clickSound"],  {channel=5})
		print(event.target.id)
		print(event.target.id1)
		print(event.target.id2)
		composer.setVariable("Id1", event.target.id1)
		composer.setVariable("Id2", event.target.id2)
		composer.setVariable("Id", event.target.id)
		composer.removeScene("view1")		
		composer.gotoScene( "view2" )
	end

-- 도감 오브젝트 tap이벤트에 넣기	
	local function tapInfo(Bjson, max)
		index1, index2 = 1, 1
		local jsc, index
		if Bjson == Data then
			jsc = openBread
			index = 1
		else
			jsc = openUBread
			index = 2
		end						
		for i = 1, max do
			lock = jsc[index1][index2]
			if lock ~= 0 then
				allBread[i]:addEventListener("tap", goInfo)
			end
			allBread[i].id1 = index1
			allBread[i].id2 = index2
			allBread[i].id = index
			index2 = index2 + 1
			if index2 == 9 then
				index2 = 1
				index1 = index1 + 1
			end
		end
	end
-- [BreadGroup] 도감생성
	local function xy(obj, i1, j)
		if i1 % 3 == 1 then
			obj[i1].x= BackGround.x*0.45
		elseif i1 % 3 == 2 then
			obj[i1].x = BackGround.x
		else
			obj[i1].x = BackGround.x*1.55
		end
		obj[i1].y = BackGround.y*j
	end
	-- local function makeAllBook(js, 64) -- 전체 도감
	local function makeBook(js)
		BreadGroup = display.newGroup()
		index1, index2 = 1, 1
		local jul = 0.15
		local jsc
		if js == Data then
			jsc = openBread
		else
			jsc = openUBread
		end
		for i = 1, 32 do
			lock = 0
			lock = jsc[index1][index2]
			-- print(js[index1].breads[index2].image.."는 해금?"..jsc[index1][index2])
			Bimage = js[index1].breads[index2].image
			Bname = js[index1].breads[index2].name
			if i % 3 == 1 then
				jul = jul + 0.33
			end
			if lock ~= 0 then
				if lock == -1 then
					newBread[i] = display.newImageRect(BreadGroup, "Content/images/halo.png", 480, 480)
					xy(newBread, i, jul)
					allBread[i] = display.newImage(BreadGroup, "Content/images/illuGuide_new.png")
				else 
					allBread[i] = display.newImage(BreadGroup, "Content/images/illuGuide_nomal.png")
				end
				xy(allBread, i, jul)
				BText[i]= display.newText(BreadGroup, Bname, allBread[i].x, BackGround.y*(jul+0.09), Font.font_POP, 35)
				BText[i]:setFillColor(0)
				BImage[i] = display.newImageRect(BreadGroup, "Content/images/"..Bimage..".png", 200, 200)
				BImage[i].x, BImage[i].y = allBread[i].x, allBread[i].y
			else
				allBread[i] = display.newImage(BreadGroup, "Content/images/illu_book_secret.png")
				xy(allBread, i, jul)				
			end
	
			index2 = index2 + 1
			if index2 == 9 then
				index2 = 1
				index1 = index1 + 1
			end
		end	
		tapInfo(js, 32)
		scrollView:insert(BreadGroup)
		scrollView:addEventListener("touch",scroll)
	end

	makeBook(Data, 32)	

-- [도감 BasicGroup] 도감 메뉴
	local illuBook_BasicGroup = display.newGroup()
	local illuBook_back = display.newImage(illuBook_BasicGroup,"Content/images/main_background1.png")
	illuBook_back.x, illuBook_back.y = BackGround.x, BackGround.y*0.1

	-- 도감, 홈 버튼
	local illuBook_book = display.newImage(illuBook_BasicGroup,"Content/images/book.png")
	illuBook_book.x, illuBook_book.y = BackGround.x*0.25, BackGround.y*0.1
	local illuBook_home = display.newImage(illuBook_BasicGroup,"Content/images/home.png")
	illuBook_home.x, illuBook_home.y = BackGround.x*1.75, BackGround.y*0.1
	local illuBook_bookText = display.newImage(illuBook_BasicGroup,"Content/images/text_Book.png")
	illuBook_bookText.x, illuBook_bookText.y = BackGround.x*0.53, BackGround.y*0.1

	-- 메뉴바
	local illuBook_menu = display.newImage(illuBook_BasicGroup,"Content/images/illuGuide_manu.png")
	illuBook_menu.x, illuBook_menu.y = BackGround.x, BackGround.y/5

	-- 메뉴 선택	
	illuBook_menuC = display.newImage(illuBook_BasicGroup,"Content/images/illuGuide_manuchoice.png")
	illuBook_menuC.x, illuBook_menuC.y = illuBook_menu.x*0.45, illuBook_menu.y*1.22
	-- illuBook_menu[1].x, illuBook_menu[1].x*1.55

	-- 메뉴 이름
	local menuAll = display.newText(illuBook_BasicGroup,"전체", illuBook_menu.x*0.45, illuBook_menu.y, Font.font_POP, 65)
	local menuNomal = display.newText(illuBook_BasicGroup,"일반", illuBook_menu.x, illuBook_menu.y, Font.font_POP, 65)
	local menuRare = display.newText(illuBook_BasicGroup,"레어", illuBook_menu.x*1.55, illuBook_menu.y, Font.font_POP, 65)

-- 도감 이동 함수
	local function MakeMenu (kind)
		if kind == Data then
			illuBook_menuC.x, illuBook_menuC.y = illuBook_menu.x, illuBook_menu.y*1.22	
			BreadGroup:removeSelf()
			makeBook(Data)			
		elseif kind == UBreadInfo then
			illuBook_menuC.x, illuBook_menuC.y = illuBook_menu.x*1.55, illuBook_menu.y*1.22
			BreadGroup:removeSelf()
			makeBook(UBreadInfo)			
		else
			illuBook_menuC.x, illuBook_menuC.y = illuBook_menu.x*0.45, illuBook_menu.y*1.22
			BreadGroup:removeSelf()
			makeBook(Data)		
		end
	end

	local function NomalMenu( event )
		audio.play(soundTable["clickSound"],  {channel=5})		
		MakeMenu (Data)
	end 

	local function RareMenu( event )
		audio.play(soundTable["clickSound"],  {channel=5})
		MakeMenu (UBreadInfo)
	end 

	local function AllMenu( event )
		audio.play(soundTable["clickSound"],  {channel=5})
		MakeMenu (All)
	end 


	menuNomal:addEventListener("tap", NomalMenu)
	menuRare:addEventListener("tap", RareMenu)
	menuAll:addEventListener("tap", AllMenu)

-- 레이어정리
	sceneGroup:insert(BackGround)	
	-- scrollView:insert(BreadGroup)
	-- scrollView:addEventListener("touch",scroll)
	sceneGroup:insert(scrollView)	
	sceneGroup:insert(illuBook_BasicGroup)

-- 홈으로 이동
	local function goHome(event)
		audio.play(soundTable["clickSound"],  {channel=5})	
		print("goHome!!")
		composer.removeScene("view1")
		---------showCoin 관련 수정
		showCoin.isVisible = true
		showCoin.text = coinNum
		composer.gotoScene( "home" )
	end
	illuBook_home:addEventListener("tap",goHome)

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