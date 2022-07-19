-----------------------------------------------------------------------------------------
--
-- bookInfo.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

parseUBreadInfo()
parse()

function scene:create( event )
	local sceneGroup = self.view

	Index = composer.getVariable( "Id" )
	Index1 = composer.getVariable( "Id1" )
	Index2 = composer.getVariable( "Id2" )

	print("빵목록"..Index)
	print("빵번호1:"..Index1)
	print("빵번호2:"..Index2)

	local BreadJson, open, cnt
	if Index == 1 then
		BreadJson = Data
		open = openBread
		cnt = breadsCnt
	else
		BreadJson = UBreadInfo
		open = openUBread
		cnt = UbreadsCnt
	end
	print(cnt[1][1].." cnt")
	print(open[1][1].." open")
	print(BreadJson[1].breads[1].name)

-- [backGroup] 도감, 홈 버튼
	local backGroup = display.newGroup()
	local infoGround = display.newImage(backGroup, "Content/images/illuBook_info.png")
	infoGround.x, infoGround.y = display.contentWidth/2, display.contentHeight/2
	local illuBook = display.newImage(backGroup, "Content/images/book.png")
	illuBook.x, illuBook.y = BackGround.x*0.25, BackGround.y*0.1
	local illuBook_text = display.newImage(backGroup ,"Content/images/text_Book.png")
	illuBook_text.x, illuBook_text.y = infoGround.x*0.53, infoGround.y*0.1
	local home = display.newImage(backGroup, "Content/images/home.png")
	home.x, home.y = BackGround.x*1.75, BackGround.y*0.1
	sceneGroup:insert(BackGround)
	sceneGroup:insert(backGroup)

-- [coinGroup] makeCoin 보유코인, 빵개수
	local coinText, cntText
	local coin = { }
	local coinGroup
	local function makeCoin()
		coinGroup = display.newGroup()
		coin[1] = display.newImage(coinGroup,"Content/images/coin.png")
		coin[1].x, coin[1].y = BackGround.x*0.9, BackGround.y*0.1
		-- coin[2] 코인 값의 배경
		coinText = display.newText(coinGroup, coinNum, BackGround.x*1.1, BackGround.y*0.105, Font.font_POP, 50)
		cntText = display.newText(coinGroup, BreadJson[Index1].breads[Index2].name.."의 개수 : "..cnt[Index1][Index2],
				 BackGround.x*0.6, BackGround.y*0.45, Font.font_POP, 60)
		cntText:setFillColor(0)
		sceneGroup:insert(coinGroup)
	end

-- makeLvPrice 레벨업, 진화 비용
	local salePrice
	local levelPrice = { }
	local function makeLvPrice()
		levelPrice[1] = Data[Index1].breads[Index2].Lv1
		levelPrice[2] = Data[Index1].breads[Index2].Lv2
		levelPrice[3] = Data[Index1].breads[Index2].Lv3
		levelPrice[4] = Data[Index1].breads[Index2].Lv4
		levelPrice[5] = Data[Index1].breads[Index2].Lv5
		levelPrice[6] = Data[Index1].breads[Index2].Lv6
		levelPrice[7] = Data[Index1].breads[Index2].Lv7
		levelPrice[8] = Data[Index1].breads[Index2].Lv8
		levelPrice[9] = Data[Index1].breads[Index2].Lv9
		levelPrice[10] = Data[Index1].breads[Index2].Lv10
	end

-- makeSalePrice 되팔기 비용
	local salePrice, lv
	local function  makeSalePrice()
		lv = Bread_level[Index1][Index2]
		if BreadJson == UBreadInfo then
			lv = 10
		end
		salePrice = 0
		for i=1, lv do			
			salePrice = salePrice + levelPrice[i]
		end
		salePrice = salePrice * 1.5

		-- 반죽만 있는 빵 가격
		if Index1 == 1 and Index2 == 1 then 
			salePrice = 300
		end
	end

-- [upSetGroup] Up키 셋팅
	local upgradeKey, upText, uCoin, upCoin
	local upSetGroup
	local function UpSet ()
		lv = Bread_level[Index1][Index2]	
		upSetGroup = display.newGroup()
		if breadsCnt[Index1][Index2] > 0 and Bread_level[Index1][Index2] == 10 then
			upKey = display.newImage(upSetGroup, "Content/images/illuBook_upgrade2.png")
			upText = display.newImage(upSetGroup, "Content/images/text_upgrade.png")
		else			--if Bread_level[Index1][Index2] < 10 then
			upKey = display.newImage(upSetGroup, "Content/images/illuBook_upgrade.png")
			upText = display.newImage(upSetGroup, "Content/images/text_levelUpSmall.png")			
		end
		upText.x, upText.y = infoGround.x*1.3, infoGround.y*1.5	
		upKey.x, upKey.y = infoGround.x*1.45, infoGround.y*1.5	
		print(levelPrice[lv])	
		upCoin = display.newText(upSetGroup, levelPrice[lv], upKey.x*1.15, upKey.y, Font.font_POP, 50)
		upCoin.x, upCoin.y = infoGround.x*1.65, infoGround.y*1.5
		uCoin = display.newImage(upSetGroup, "Content/images/coin.png")	
		uCoin.x, uCoin.y = infoGround.x*1.5, infoGround.y*1.5
		sceneGroup:insert(upSetGroup)
	end

-- [infoGroup, lvGroup, saleC] info function (빵이름, 빵이미지, 빵소개, 빵레벨, 새빵)
	local breadName, breadImage, breadSentence, breadLevel, new
	local leftKey, rightKey 
	local saleC, saleCGroup
	local infoGroup, lvGroup

	local function level(js)
		lvGroup = display.newGroup()
		breadLevel = display.newText(lvGroup, js[Index1].breads[Index2].name.."  Lv."..Bread_level[Index1][Index2], infoGround.x, infoGround.y*0.335, Font.font_POP, 70)
		--breadLevel = display.newText(lvGroup ,"Lv."..Bread_level[Index1][Index2], infoGround.x, infoGround.y*0.335, Font.font_POP, 80)
		--breadLevel:setFillColor(0)
		sceneGroup:insert(lvGroup)
	end

	-- [saleGroup] 판매키
	local saleGroup = display.newGroup()
	local saleKey = display.newImage(saleGroup,"Content/images/illuBook_sale.png")
	saleKey.x, saleKey.y = infoGround.x*0.55, infoGround.y*1.5
	local saleKeyText = display.newImage(saleGroup, "Content/images/text_sale.png")
	saleKeyText.x, saleKeyText.y = saleKey.x*0.7, saleKey.y
	sceneGroup:insert(saleGroup)	

	local sCoin = display.newImage(saleGroup,"Content/images/coin.png")
	sCoin.x, sCoin.y = saleKey.x*1.1, saleKey.y

	local function saleCoin()
		makeSalePrice()
		saleCGroup = display.newGroup()
		saleC = display.newText(saleCGroup, salePrice, infoGround.x*0.75, infoGround.y*1.5 , Font.font_POP, 50)
		sceneGroup:insert(saleCGroup)
	end

	local function infoBasic(js)
		infoGroup = display.newGroup()
		makeCoin()
		Bimage = js[Index1].breads[Index2].image
		print(js[Index1].breads[Index2].name.."빵의 정보창")
		--breadName = display.newText(infoGroup, js[Index1].breads[Index2].name, infoGround.x, infoGround.y*0.335, Font.font_POP, 70)
		breadImage = display.newImageRect(infoGroup, "Content/images/"..Bimage..".png",900,900)
		breadImage.x, breadImage.y = infoGround.x, infoGround.y*0.8
		breadSentence = display.newText(infoGroup,js[Index1].breads[Index2].sentence, infoGround.x, infoGround.y*1.25, 950,350 ,Font.font_POP, 50)
		breadSentence:setFillColor(0)
		makeLvPrice()
		makeSalePrice()		
		-- BreadJson이 Data일때
		if js == Data then 	
			level(js)
			UpSet()
		end
		if open[Index1][Index2] == -1 then
			new = display.newImage(infoGroup, "Content/images/new.png")
			new.x, new.y = BackGround.x*0.45, BackGround.y*0.55	
			open[Index1][Index2] = 1
		end	
		saleCoin()	
		open[Index1][Index2] = 1
		sceneGroup:insert(infoGroup)
		sceneGroup:insert(lvGroup)
	end

	infoBasic(BreadJson)

-- [keyGroup] 방향키
	local keyGroup = display.newGroup()
	local leftKey = display.newImage(keyGroup,"Content/images/illuBook_left.png")
	leftKey.x, leftKey.y = infoGround.x*0.1, infoGround.y
	local rightKey = display.newImage(keyGroup,"Content/images/illuBook_right.png")
	rightKey.x, rightKey.y = infoGround.x*1.9, infoGround.y	
	sceneGroup:insert(keyGroup)	

-- 되팔기 작동 함수 (빵 - 1, 코인 + a, 판매완료창)	
	local function sale( event )
		audio.play(soundTable["cashSound"],  {channel=4})	
		if cnt[Index1][Index2] > 0 then
			cnt[Index1][Index2] = cnt[Index1][Index2] - 1
			coinNum = coinNum + salePrice
			-----showCoin 관련 수정
			showCoin.text = coinNum
			coinGroup:removeSelf()
			makeCoin()
		end
	end

-- [upGroup] 업그레이드창 함수
	local dark, upWindow, upSuc, upNew1, upNew2
	local upBread, upBreadN, upBreadI
	local upDel, upCheckI, upCheckT
	local upGroup

	local function upgradeOK (event)
		audio.play(soundTable["clickSound"],  {channel=5})	
		upGroup:removeSelf()
		makeCoin()
		level(BreadJson)	
		saleCoin()
	end

	local function upgrade() 
		upGroup = display.newGroup()
		Uimage = UBreadInfo[Index1].breads[Index2].image
		dark = display.newImageRect(upGroup, "Content/images/dark.png", 1440*2, 710*7)
		dark.x, dark.y = BackGround.x, BackGround.y
		upWindow = display.newImage(upGroup, "Content/images/window.png")
		upWindow.x, upWindow.y = BackGround.x, BackGround.y*1.1
		upSuc = display.newText(upGroup, "빵 진화 성공", upWindow.x, upWindow.y*0.5, Font.font_POP, 100)
		upNew1 = display.newImage(upGroup, "Content/images/new.png")
		upNew1.x, upNew1.y = upWindow.x*0.6, upWindow.y*0.7
		upNew2 = display.newImage(upGroup, "Content/images/halo.png")
		upNew2.x, upNew2.y = upWindow.x, upWindow.y*0.9
		upBread = display.newImageRect(upGroup, "Content/images/"..Uimage..".png", 650, 650)
		upBread.x, upBread.y = upWindow.x, upWindow.y*0.9
		upBreadN = display.newText(upGroup, UBreadInfo[Index1].breads[Index2].name, upWindow.x, upWindow.y*1.15, Font.font_POP, 80)
		upBreadI = display.newText(upGroup, UBreadInfo[Index1].breads[Index2].sentence, upWindow.x, upWindow.y*1.27, 890, 210, Font.font_POP, 60)
		upBreadN:setFillColor(0)
		upBreadI:setFillColor(0)
		upDel = display.newImage(upGroup, "Content/images/delete.png")
		upDel.x, upDel.y = upWindow.x*1.77, upWindow.y*0.46
		upCheckI = display.newImage(upGroup, "Content/images/button.png")
		upCheckI.x, upCheckI.y = upWindow.x, upWindow.y*1.45
		upCheckT = display.newImage(upGroup, "Content/images/text_OK.png")
		upCheckT.x, upCheckT.y = upCheckI.x, upCheckI.y
		-- breadsCnt[Index1][Index2] = breadsCnt[Index1][Index2] - 1
		UbreadsCnt[Index1][Index2] = UbreadsCnt[Index1][Index2] + 1
		openUBread[Index1][Index2] = -1

		sceneGroup:insert(upGroup)
		upDel:addEventListener("tap", upgradeOK)
		upCheckI:addEventListener("tap", upgradeOK)
	end

-- 레벨업 함수 
	local function levelUp( event )
		if coinNum >= levelPrice[lv] and Bread_level[Index1][Index2] < 10 
			and cnt[Index1][Index2] > 0 and levelPrice[lv] ~= 0 then
			audio.play(soundTable["levelUpSound"],  {channel=6})		
			Bread_level[Index1][Index2] = Bread_level[Index1][Index2]+ 1
			coinNum = coinNum - levelPrice[lv]
			coinGroup:removeSelf()
			upSetGroup:removeSelf()
			breadLevel:removeSelf()
			saleCGroup:removeSelf()
			makeLvPrice()
			makeCoin()	
			UpSet()				
			level(BreadJson)			
			saleCoin()
			upKey:addEventListener("tap", levelUp)
		elseif cnt[Index1][Index2] > 0 and Bread_level[Index1][Index2] == 10 and cnt[Index1][Index2] > 0 then
			coinGroup:removeSelf()
			upSetGroup:removeSelf()
			breadLevel:removeSelf()
			saleCGroup:removeSelf()
			upgrade()
		end
	end

-- 되팔기, 레벨업 세팅 함수
	local function setting()
		if BreadJson ~= UBreadInfo then
			upKey:addEventListener("tap", levelUp)
		end	
		saleKey:addEventListener("tap", sale)
	end

	setting()

-- 방향키 작동 함수 (이전, 다음 빵으로 이동)
	local function moveLeftKey( event )
		audio.play(soundTable["clickSound"],  {channel=5})	
		local index1, index2
		if Index1 == 1 and Index2 == 1 then
		elseif Index2 == 1 then
			index1, index2 = Index1 - 1, 8
			if open[index1][index2] ~= 0 then
				Index1, Index2 = index1, index2 
				infoGroup:removeSelf()				
				coinGroup:removeSelf()
				saleCGroup:removeSelf()
				if BreadJson ~= UBreadInfo then
					lvGroup:removeSelf()
					upSetGroup:removeSelf()					
				end
				infoBasic(BreadJson)
				setting()
			end
		else
			index1, index2 = Index1, Index2 - 1
			if open[index1][index2] ~= 0 then
				Index1, Index2 = index1, index2 
				infoGroup:removeSelf()
				coinGroup:removeSelf()	
				saleCGroup:removeSelf()								
				if BreadJson ~= UBreadInfo then
					lvGroup:removeSelf()
					upSetGroup:removeSelf()					
				end
				infoBasic(BreadJson)
				setting()
			end
		end
	end 

	local function moveRightKey( event )
		audio.play(soundTable["clickSound"],  {channel=5})	
		local index1 
		local index2
		if Index1 == 4 and Index2 == 8 then
		elseif Index2 == 8 then
			index1, index2 = Index1 + 1, 1
			if open[index1][index2] ~= 0 then
				Index1, Index2 = index1, index2 
				infoGroup:removeSelf()
				coinGroup:removeSelf()
				saleCGroup:removeSelf()
				if BreadJson ~= UBreadInfo then
					lvGroup:removeSelf()
					upSetGroup:removeSelf()					
				end
				infoBasic(BreadJson)
				setting()
			end
		else
			index1, index2 = Index1, Index2 + 1
			if open[index1][index2] ~= 0 then
				Index1, Index2 = index1, index2 
				infoGroup:removeSelf()				
				coinGroup:removeSelf()
				saleCGroup:removeSelf()
				if BreadJson ~= UBreadInfo then
					lvGroup:removeSelf()
					upSetGroup:removeSelf()					
				end
				infoBasic(BreadJson)
				setting()
			end
		end
	end
	leftKey:addEventListener("tap", moveLeftKey)
	rightKey:addEventListener("tap", moveRightKey)

-- 도감 이동 함수
	local function goBook(event)
		audio.play(soundTable["clickSound"],  {channel=5})	
		print("move!!")
		infoGroup:removeSelf()
		coinGroup:removeSelf()
		saleCGroup:removeSelf()
		if BreadJson ~= UBreadInfo then
			upSetGroup:removeSelf()
			breadLevel:removeSelf()	
		end	
		composer.removeScene("bookInfo")
		composer.gotoScene( "bookMain" )
	end
	
	illuBook:addEventListener("tap", goBook)
	illuBook_text:addEventListener("tap", goBook)

-- 레이어정리
	--[[sceneGroup:insert(BackGround)
			sceneGroup:insert(backGroup)
			sceneGroup:insert(infoGroup)	
			sceneGroup:insert(coinGroup)
			sceneGroup:insert(saleGroup)
			sceneGroup:insert(saleCGroup)
			sceneGroup:insert(keyGroup)
			if BreadJson ~= UBreadInfo then
				sceneGroup:insert(lvGroup)
				sceneGroup:insert(upSetGroup)	
				--sceneGroup:insert(upGroup)		
			end	]]

-- 홈으로 이동
	local function goHome(event)
		audio.play(soundTable["clickSound"],  {channel=5})	
		print("goHome!!")
		composer.removeScene("bookInfo")
		-------showCoin 관련 수정
		showCoin.isVisible = true
		showCoin.text = coinNum
		composer.gotoScene( "home" )
	end
	home:addEventListener("tap",goHome)

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
