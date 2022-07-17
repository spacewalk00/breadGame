---- 인벤토리 ---

local composer = require( "composer" )
local scene = composer.newScene()
local text_list
local list
local close
local check

local levelNum

local background_room1
local background_room2
local background_carpet
local homeIcon
local bookIcon
local breadIcon
local text_breadRoom
local coinIcon
local coinNum_text
local gray_upperLeft
local gray_upperRight
local gray_lowerLeft
local gray_lowerRight
local text_bookIcon
local store
local text_storeIcon
local temp
local text_tempIcon
local breadRoom
local text_breadRoomIcon
local pushIcon
local text_push

local icon
local icon_inven = {}
local check_list = {0, }
local check_inven = {}
local bread_name = {}
local bread_name_text = {}
local bread_inven = {}
local pushIcon
local text_push2
local breadRoom_image = {}
local breadGroup = display.newGroup()
local k
--local breadRoom_count = 0 		--전역변수 때문에 지웁니다!
-- 넣은 빵의 세부정보 --
local breadInfo_background
local breadInfo_profile

local breadInfo_image = {}
local breadInfo_level = {} -- 빵 도감에서 주는 Json에서는 breadInfo에 레벨 정보까지 추가하기
local breadInfo_name = {}
local breadInfo_text = {}
local breadInfoGroup = display.newGroup()

local reverse
local t1
-- count 변수 : 빵방에 넣은 빵이 없을 때 인덱스 에러 피하기 위한 장치 --
local count = 0

-- 새빵 (미해금0 , 해금 -1, 확인했음 1로 변화)
--[[
openBread = { {-1, 1, 1, 1, -1, 1, 1, 1}, {-1, 0, 0, 0, 0, 0, 0, 0}, 
				{1, 0, 0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0} }
openUBread = { {1, 1, 1, 1, 1, 1, 1, 1}, {0, 0, 0, 0, 0, 0, 0, 0}, 
				{0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0} }	

]]

--사운드
soundTable = {
	clickSound = audio.loadSound( "Content/audio/click.wav" ),
}

--JSON 파싱
local json = require('json')

local function parse()
	local filename = system.pathForFile("Content/JSON/breadInfo.json")
	Data, pos, msg = json.decodeFile(filename)
end

-- 업그레이드 빵 파싱
local function parseUBreadInfo() 
	filename = system.pathForFile("Content/JSON/ubreadInfo.json")
	uBreadInfo = json.decodeFile(filename)
	
end

parse()
parseUBreadInfo()

function scene:create( event )
	local sceneGroup = self.view

    -- 배경 --
	background_room1 = display.newImageRect("Content/images/room1.png", display.contentWidth, display.contentHeight)
	background_room1.x, background_room1.y = display.contentWidth*0.5, display.contentHeight*0.5

	background_room2 = display.newImageRect("Content/images/room2.png", display.contentWidth, display.contentHeight)
	background_room2.x, background_room2.y = display.contentWidth*0.5, display.contentHeight*0.5

	background_carpet = display.newImageRect("Content/images/carpet.png", display.contentWidth, display.contentHeight)
	background_carpet.x, background_carpet.y = display.contentWidth*0.5, display.contentHeight*0.5

	-- 홈, 빵방, 코인 --
	homeIcon = display.newImageRect("Content/images/home.png", display.contentWidth*0.07, display.contentHeight*0.04)
	homeIcon.x, homeIcon.y = display.contentWidth*0.08, display.contentHeight*0.05

	breadIcon = display.newImageRect("Content/images/breadIcon.png", display.contentWidth*0.1, display.contentHeight*0.05)
	breadIcon.x, breadIcon.y = display.contentWidth*0.2, display.contentHeight*0.054

	text_breadRoom = display.newText("빵방", display.contentWidth*0.5, display.contentHeight*0.5,"font/ONE Mobile POP.ttf", 40)
	text_breadRoom:setFillColor(1)
	text_breadRoom.x, text_breadRoom.y = display.contentWidth*0.29, display.contentHeight*0.05

	coinIcon = display.newImageRect("Content/images/coinIcon.png", display.contentWidth*0.2, display.contentHeight*0.035)
	coinIcon.x, coinIcon.y = display.contentWidth*0.5, display.contentHeight*0.05

	coinNum_text = display.newText(coinNum, display.contentWidth*0.5, display.contentHeight*0.5,"font/ONE Mobile Bold.ttf", 23)
	coinNum_text:setFillColor(1)
	coinNum_text.x, coinNum_text.y = display.contentWidth*0.54, display.contentHeight*0.05

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

	text_bookIcon = display.newText("도감",display.contentWidth*0.5, display.contentHeight*0.5,"font/ONE Mobile Bold.ttf", 23)
    text_bookIcon:setFillColor(1)
	text_bookIcon.x, text_bookIcon.y = display.contentWidth*0.73, display.contentHeight*0.081

	store = display.newImageRect("Content/images/store.png", display.contentWidth*0.1, display.contentHeight*0.07)
 	store.x, store.y = display.contentWidth*0.9, display.contentHeight*0.047

	text_storeIcon = display.newText("상점",display.contentWidth*0.5, display.contentHeight*0.46,"font/ONE Mobile Bold.ttf", 23)
	text_storeIcon:setFillColor(1)
	text_storeIcon.x, text_storeIcon.y = display.contentWidth*0.9, display.contentHeight*0.081

	temp = display.newImageRect("Content/images/temp.png", display.contentWidth*0.1, display.contentHeight*0.05)
 	temp.x, temp.y = display.contentWidth*0.73, display.contentHeight*0.14

	text_tempIcon = display.newText("업적",display.contentWidth*0.5, display.contentHeight*0.46,"font/ONE Mobile Bold.ttf", 23)
	text_tempIcon:setFillColor(1)
	text_tempIcon.x, text_tempIcon.y = display.contentWidth*0.73, display.contentHeight*0.17

	breadRoom = display.newImageRect("Content/images/breadRoom.png", display.contentWidth*0.09, display.contentHeight*0.04)
	breadRoom.x, breadRoom.y = display.contentWidth*0.9, display.contentHeight*0.138

	text_breadRoomIcon = display.newText("빵방",display.contentWidth*0.5, display.contentHeight*0.46,"font/ONE Mobile Bold.ttf", 23)
	text_breadRoomIcon:setFillColor(1)
	text_breadRoomIcon.x, text_breadRoomIcon.y = display.contentWidth*0.9, display.contentHeight*0.17
	
	-- 빵 넣기 아이콘 --
	pushIcon = display.newImageRect("Content/images/push.png", display.contentWidth*0.25, display.contentHeight*0.05)
	pushIcon.x, pushIcon.y = display.contentWidth*0.24, display.contentHeight*0.15

	text_push = display.newText("빵 넣기",display.contentWidth*0.5, display.contentHeight*0.5,"font/ONE Mobile Bold.ttf", 40)
    text_push:setFillColor(1)
	text_push.x, text_push.y = display.contentWidth*0.24, display.contentHeight*0.15
    text_push:toFront()

	local function BreadMove(obj)
		print("빵무브")
		wMove = math.random( 2, 5 )
		hMove = math.random( 5, 7 )
		speed = math.abs(wMove - obj.x) * math.random( 90, 120 )
		transition.moveTo( obj, { x=wMove, y=hMove, time=speed } )
		t1 = timer.performWithDelay(1000, shake, 0)   
	end
	-- Bmove에 대상 이미지!
	local function shake(event)
		print("shake")
		local t10 = event.target.param10

		--BreadMove(breadRoom_image[t10])
		if (reverse == 0) then
		reverse = 1
		transition.to(event.target, {rotation=-15, time=2, transition=easing.inOutCubic })
		else
		reverse = 0
		transition.to(event.target, {rotation=15, time=2, transition=easing.inOutCubic })
		end   
		print(reverse)
	end
		
	local function infoClosed(event)
	--	for i=1, 64 do
			--if(breadInfo_name[i] ~= nill) then
				breadInfoGroup:removeSelf()
				closeIcon:removeSelf()
		--	end
		--end
	end
	
	-- 빵 클릭시 세부 정보 뜨게 --
	local function show_breadinfo(event)
		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true

			audio.play( soundTable["clickSound"],  {channel=5}) 

			local k = event.target.param2
			local index1 = event.target.param12
			local index2 = event.target.param13
			local info = event.target.param14

			print("출력은 "..k)
				-- 빵 정보 창 --
			breadInfo_background = display.newImageRect(breadInfoGroup, "Content/images/breadInfo_background.png", display.contentWidth, display.contentHeight*0.2)
			breadInfo_background.x, breadInfo_background.y = display.contentWidth*0.5, display.contentHeight*0.9
			
			breadInfo_profile = display.newImageRect(breadInfoGroup, "Content/images/breadInfo_profile.png", display.contentWidth*0.25, display.contentHeight*0.15)
			breadInfo_profile.x, breadInfo_profile.y = display.contentWidth*0.28, display.contentHeight*0.9

			levelNum=2
			breadInfo_level = display.newText(breadInfoGroup, "Lv." .. levelNum ,display.contentWidth*1.5, display.contentHeight*1.5,"font/ONE Mobile Bold.ttf", 60)
			breadInfo_level:setFillColor(0)
			breadInfo_level.x, breadInfo_level.y = display.contentWidth*0.5, display.contentHeight*0.84

			name = info[index1].breads[index2].name
			breadInfo_name[k] =  display.newText(breadInfoGroup, name, display.contentWidth*0.2, display.contentHeight*0.2,"font/ONE Mobile Bold.ttf", 60)
			breadInfo_name[k]:setFillColor(0)
			breadInfo_name[k].x, breadInfo_name[k].y = display.contentWidth*0.66, display.contentHeight*0.84
			
			sentence = info[index1].breads[index2].sentence
			breadInfo_text[k] =  display.newText(breadInfoGroup, sentence, display.contentWidth*0.2, display.contentHeight*0.2,"font/ONE Mobile Bold.ttf", 40)
			breadInfo_text[k]:setFillColor(0)
			breadInfo_text[k].x, breadInfo_text[k].y = display.contentWidth*0.68, display.contentHeight*0.92

			image = info[index1].breads[index2].image
			breadInfo_image[k] = display.newImageRect(breadInfoGroup, "Content/images/"..image..".png", display.contentWidth*0.17, display.contentHeight*0.1)
			breadInfo_image[k].x, breadInfo_image[k].y = display.contentWidth*0.29, display.contentHeight*0.9

			breadInfoGroup:toFront()

			closeIcon = display.newImageRect("Content/images/close.png", display.contentWidth*0.1, display.contentHeight*0.05)
			closeIcon.x, closeIcon.y = display.contentWidth*0.962, display.contentHeight*0.813

			closeIcon:addEventListener("tap", infoClosed)
		
		elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
		end
	end

	-- 빵 넣기 클릭 이벤트 --
	function catch(event)
		if ( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
		elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
			audio.play( soundTable["clickSound"],  {channel=5}) 

			list = display.newImageRect("Content/images/list.png", display.contentWidth*0.78, display.contentHeight*0.62)
			list.x, list.y = display.contentWidth*0.5, display.contentHeight*0.54
	   
			text_list = display.newText("빵 목록",display.contentWidth*0.5, display.contentHeight*0.5,"font/ONE Mobile Bold.ttf", 50)
			text_list:setFillColor(1)
			text_list.x, text_list.y = display.contentWidth*0.5, display.contentHeight*0.27

			close = display.newImageRect("Content/images/close.png", display.contentWidth*0.1, display.contentHeight*0.05)
			close.x, close.y = display.contentWidth*0.8565, display.contentHeight*0.24
			
			push = display.newImageRect("Content/images/push.png", display.contentWidth*0.25, display.contentHeight*0.05)
			push.x, push.y = display.contentWidth*0.5, display.contentHeight*0.79

			text_push2 = display.newText("넣기",display.contentWidth*0.2, display.contentHeight*0.2,"font/ONE Mobile Bold.ttf", 45)
			text_push2:setFillColor(1)
			text_push2.x, text_push2.y = display.contentWidth*0.5, display.contentHeight*0.79

			-- 빵목록 내에서만 스크롤 가능하게 하려 했으나 불가능
			--[[local widget = require( "widget" )
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
			
				--breadGroup:toFront()
				return true
			end
			local scrollView = widget.newScrollView(
				{
					horizontalScrollDisabled=true,
					left = 160,
					top = 790,
					width = 1115,
					height = 1150,
					backgroundColor = { 0.894, 0.772, 0.713 }

				}
			)]]

			index1, index2 = 1, 1
			local jul = 0.15
			
			function openBreadsCNT()
				count = count + 1
				local index1 = 1
				local index2 = 1
				BreadsCNT = 0
				for i=1,32 do
				   if openBread[index1][index2] ~= 0 then
					  BreadsCNT = BreadsCNT + 1
				   end
				   index2 = index2 + 1
				   if index2 == 9 then
					  index2 = 1
					  index1 = index1 + 1
				   end
				end
				index1, index2 = 1, 1
				for i=1,32 do
				   if openUBread[index1][index2] ~= 0 then
					  BreadsCNT = BreadsCNT + 1
				   end
				   index2 = index2 + 1
				   if index2 == 9 then
					  index2 = 1
					  index1 = index1 + 1
				   end
				end
				return BreadsCNT
			end
			print("총 발견한 빵은.."..openBreadsCNT())
			breadsCNT = openBreadsCNT()
				
			local m = 0
			
			local iconIndex = 1
			-- 일반 빵 -- 
			for i=1, 64 do 
				if i <= 32 then -- '일반 빵'에서 해금된 빵 가져오기
					jsc = openBread
					info = Data
				else -- '업글 빵'에서 해금된 빵 가져오기
					jsc = openUBread
					info = uBreadInfo
				end

				lock = jsc[index1][index2]
					if i % 3 == 1 then
						jul = jul + 0.33
					end

				local j = i + 3

				-- 도감에서 미해금(0)이 아닌 경우 빵이 뜨게 하기(해금(-1), 확인(1)) --
				if lock ~= 0 then
					-- 흰색 네모 창 --
					icon_inven[iconIndex] = display.newImageRect(breadGroup, "Content/images/icon.png", display.contentWidth*0.23, display.contentHeight*0.12)

					icon_inven[iconIndex].param2 = index1
					icon_inven[iconIndex].param3 = index2
					icon_inven[iconIndex].param4 = info

					image = info[index1].breads[index2].image
					bread_inven[iconIndex] = display.newImageRect(breadGroup,  "Content/images/"..image..".png", display.contentWidth*0.19, display.contentHeight*0.1)
					bread_inven[iconIndex].x, bread_inven[iconIndex].y = display.contentWidth*0.25, display.contentHeight*0.38

					--bread_name[i] = display.newText(breadGroup, bread_name_text[i], display.contentWidth*0.2, display.contentHeight*0.2,"font/ONE Mobile Bold.ttf", 27)
					breadName = info[index1].breads[index2].name
					bread_name[iconIndex] = display.newText(breadGroup, breadName, display.contentWidth*0.2, display.contentHeight*0.2,"font/ONE Mobile Bold.ttf", 27)
					bread_name[iconIndex]:setFillColor(0)
					breadGroup:toFront()

					-- 한 줄에 3개씩 뜨게 위치 설정--
					if(j%3 == 1 or i == 1) then
						icon_inven[iconIndex].x = display.contentWidth*0.25
						icon_inven[iconIndex].y = display.contentHeight*(0.38 + (0.13*m))

						bread_name[iconIndex].x = display.contentWidth*0.25
						bread_name[iconIndex].y = display.contentHeight*(0.427 + (0.13*m))

						bread_inven[iconIndex].x = display.contentWidth*0.25
						bread_inven[iconIndex].y = display.contentHeight*(0.38 + (0.13*m))	
						iconIndex = iconIndex + 1	
					end
					if(j%3 == 2 or i == 2) then
						icon_inven[iconIndex].x = display.contentWidth*0.5
						icon_inven[iconIndex].y = display.contentHeight*(0.38 + (0.13*m))
					
						bread_name[iconIndex].x = display.contentWidth*0.5
						bread_name[iconIndex].y = display.contentHeight*(0.427 + (0.13*m))

						bread_inven[iconIndex].x = display.contentWidth*0.5
						bread_inven[iconIndex].y = display.contentHeight*(0.38 + (0.13*m))
						iconIndex = iconIndex + 1
					end
					if(j%3 ==0) then
						icon_inven[iconIndex].x = display.contentWidth*0.75
						icon_inven[iconIndex].y = display.contentHeight*(0.38 + (0.13*m))
						bread_name[iconIndex].x = display.contentWidth*0.75
						bread_name[iconIndex].y = display.contentHeight*(0.427 + (0.13*m))

						bread_inven[iconIndex].x = display.contentWidth*0.75
						bread_inven[iconIndex].y = display.contentHeight*(0.38 + (0.13*m))
						iconIndex = iconIndex + 1
						m = m + 1
					end
					print("icon개수는"..iconIndex)
					
					-- 체크표시했으면(빵방에 넣었으면) 닫기 눌렀다가 빵넣기 다시 눌러도 체크가 다시 나타나게 함
					for i=1,  breadsCNT do 
						if(check_list[i] == 0 and check_inven[i] ~= nill) then
							check_inven[i]:toFront()
						end
					end
				end
				index2 = index2 + 1
					if index2 == 9 then
						index2 = 1
						index1 = index1 + 1
					end

					if i==32 then
						index1, index2 = 1, 1
						info = uBreadInfo
					end
			end

			-- 스크롤 --
			local function scroll( event )
				if ( event.phase == "began" ) then
					display.getCurrentStage():setFocus( event.target )
					event.target.isFocus = true
		
					event.target.yStart = event.target.y
		
				elseif ( event.phase == "moved" ) then
					if ( event.target.isFocus ) then
						event.target.y = event.target.yStart + event.yDelta
					end
				elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
					if ( event.target.isFocus ) then
						display.getCurrentStage():setFocus( nil )
						event.target.isFocus = false
					end
					display.getCurrentStage():setFocus( nil )
					event.target.isFocus = false
				 end
			end

			-- 빵을 체크 클릭/해제할 때 발생하는 이벤트 --
			function checked( event )
				if ( event.phase == "began" ) then
					print("체크했당")

					audio.play( soundTable["clickSound"],  {channel=5}) 
					
					-- 몇 번째 아이콘인지 매개변수 전달 --
					local k = event.target.param1
					local index1 = event.target.param2
					local index2 = event.target.param3
					local info = event.target.param4

					-- 0인 경우 체크 제거 --
					if(check_list[k] == 0) then
						breadRoom_count = breadRoom_count - 1
						display.remove(check_inven[k])
						display.remove(breadRoom_image[k])
						check_list[k] = 1

					-- 1인 경우 체크 추가 --
					else
						breadRoom_count = breadRoom_count + 1
						print(k.."체크인벤 k값")
						check_inven[k] = display.newImageRect("Content/images/check.png", display.contentWidth*0.04, display.contentHeight*0.02)
					--	check_inven[k] = display.newImageRect(breadGroup, "Content/images/check.png", display.contentWidth*0.04, display.contentHeight*0.02)
						--check_inven[k]:toFront()
--						check_inven[k]:addEventListener("touch", scroll)
					
						local n = k / 3
						-- 체크 위치 설정 --
						if(k%3 == 1 or k == 1) then
							check_inven[k].x = display.contentWidth*0.155
							check_inven[k].y = display.contentHeight*(0.29 + (0.13*n))
						elseif(k%3 == 2 or k == 2) then
							check_inven[k].x = display.contentWidth*0.41
							check_inven[k].y = display.contentHeight*(0.245 + (0.13*n))
						elseif(k%3 ==0) then
							check_inven[k].x = display.contentWidth*0.66
							check_inven[k].y = display.contentHeight*(0.205 + (0.13*n))
						end
						check_list[k] = 0

						-- 체크와 동시에 빵방에 삽입 --
						--image = Data[1].breads[k].image
						image = info[index1].breads[index2].image
						breadRoom_image[k] = display.newImageRect("Content/images/"..image..".png", display.contentWidth*0.17, display.contentHeight*0.1)
						breadRoom_image[k].x, breadRoom_image[k].y = math.random(display.contentWidth*0.12, display.contentWidth*0.9), math.random(display.contentHeight*0.31, display.contentHeight*0.71)
						breadRoom_image[k]:toBack()
					
						breadRoom_image[k].param12 = index1
						breadRoom_image[k].param13 = index2
						breadRoom_image[k].param14 = info
						
						breadRoom_image[k]:addEventListener("touch", show_breadinfo)

						breadRoom_image[k].param10 = k
						breadRoom_image[k]:addEventListener("touch", shake)
						--BreadMove(breadRoom_image[k])
						--breadRoom_image[k]:toBack()
						
						list:toFront()
						text_list:toFront()
						close:toFront()
						push:toFront()
						text_push2:toFront()
						--scrollView:toFront()
						breadGroup:toFront()

						for i=1, breadsCNT do -- 빵 개수만큼 체크 개수 생성
							if(check_list[i] == 0 and check_inven[i] ~= nill) then
								check_inven[i]:toFront()
								breadRoom_image[i].param2 = i
							end
						end
						
					end
					display.getCurrentStage():setFocus( event.target )
					event.target.isFocus = true

					-- 빵방에 있는 빵 개수 카운트 --
					print(breadRoom_count)
				elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
					print("체크체크체크")
				end
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end

			breadGroup:addEventListener("touch", scroll)

			-- 창 닫기 --
			local function closed( event )
				if ( event.phase == "began" ) then
					display.getCurrentStage():setFocus( event.target )
					event.target.isFocus = true
				elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
					audio.play( soundTable["clickSound"],  {channel=5}) 

					display.remove(close)
					display.remove(list)
					display.remove(text_list)
					display.remove(icon1)
					display.remove(check)
					display.remove(push)
					display.remove(text_push2)

					for i=1, breadsCNT do
						display.remove(bread_name[i])
						display.remove(icon_inven[i])
						display.remove(bread_inven[i])
						
						-- 체크 잠시 사라지게 했다가 다시 뜨게 함
						--if(check_list[i] == 0 and check_inven[i] ~= nill) then
						if(check_inven[i] ~= nill) then
							check_inven[i]:toBack()
			
							breadRoom_image[i]:toFront()
						end
					end
				end
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end

			close:addEventListener("touch", closed)
			--scrollView:insert(breadGroup)
			--scrollView:addEventListener("touch",scroll)

			for i=1, breadsCNT do	
				icon_inven[i].param1 = i
				icon_inven[i]:addEventListener("touch", checked)
			end
			push:addEventListener("touch", closed)

		end
		display.getCurrentStage():setFocus( nil )
		event.target.isFocus = false
	end	
	pushIcon:addEventListener("touch", catch)

	-- 씬 이동 --
	local function moveToBook(event)
		print("도감으로 이동")
		---------showCoin 관련 수정
		showCoin.isVisible = false
		-------수정	
			if(count > 0) then
				for i=1, breadsCNT do
					if(breadRoom_image[i] ~= nill) then
						breadRoom_image[i].isVisible = false
					end
				end
			end
		composer.gotoScene("bookMain")
	end

	local function moveToStore(event)
		print("상점으로 이동")
		---------------showCoin 관련 수정
		showCoin.isVisible = true
		showCoin.x, showCoin.y = display.contentWidth*0.55, display.contentHeight*0.05
		-------수정	
			if(count > 0) then
				for i=1, breadsCNT do
					if(breadRoom_image[i] ~= nill) then
						breadRoom_image[i].isVisible = false
					end
				end
			end
		composer.gotoScene("store_i")
	end

	local function moveToAchieve(event)
		print("업적으로 이동")
		---------------showCoin 관련 수정
		showCoin.isVisible = true
		showCoin.x, showCoin.y = display.contentWidth*0.54, display.contentHeight*0.053
		-------수정	
			if(count > 0) then
				for i=1, breadsCNT do
					if(breadRoom_image[i] ~= nill) then
						breadRoom_image[i].isVisible = false
					end
				end
			end
		composer.gotoScene("achieve")
	end
	
	local function moveToHome(event)
		print("홈으로 이동")
		------------------showCoin 관련 수정
		showCoin.isVisible = true
		-------수정	
			if(count > 0) then
				for i=1, breadsCNT do
					if(breadRoom_image[i] ~= nill) then
						breadRoom_image[i].isVisible = false
					end
				end
			end
		composer.gotoScene("home")
	end

	bookIcon:addEventListener("tap", moveToBook)
	store:addEventListener("tap", moveToStore)
	homeIcon:addEventListener("tap", moveToHome)
	temp:addEventListener("tap", moveToAchieve)



	----------------에러 수정--------------------

	    	sceneGroup:insert(background_room1)
			sceneGroup:insert(background_room2)
			sceneGroup:insert(background_carpet)
			
			sceneGroup:insert(homeIcon)
			sceneGroup:insert(breadIcon) 
			sceneGroup:insert(text_breadRoom) 
			sceneGroup:insert(coinIcon) 
			sceneGroup:insert(coinNum_text) 
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
			sceneGroup:insert(breadRoom)
			sceneGroup:insert(text_breadRoomIcon)
			
			sceneGroup:insert(pushIcon)
			sceneGroup:insert(text_push)
	    	--sceneGroup:insert(breadGroup)
	--------------------------------------------
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

		--------------------------------버튼, x 탭시 팝업창 내리기---------------------------------------------------
	    local function tapListener(event)
	    	print("탭 화면사라짐")
	    end
	    --[[
	    bookIcon:addEventListener("tap", tapListener)
	    store:addEventListener("tap", tapListener)
		homeIcon:addEventListener("tap", tapListener)
		temp:addEventListener("tap", tapListener)
		]]
	end
	
end

function scene:hide( event )

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