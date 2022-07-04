-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local m_image
local syrup_image
local box1 
local choco
local vanilla
local strawberry

function scene:create( event )
	local sceneGroup = self.view
	
	ingredient = 0 -- 선택안할때 대비

	-- 배경 --
	local s_background = display.newImage("Content/image/syrup_choice.png", display.contentWidth, display.contentHeight)
	s_background.x, s_background.y = display.contentWidth/2, display.contentHeight/2
	local syrup_box =  display.newImage("Content/image/syrup_box.png", display.contentWidth*0.496, display.contentHeight*0.534)
	local m = composer.getVariable("m")
	m_image = display.newImage("m")

	box1 = display.newImage("Content/image/box1.png", display.contentWidth*0.492, display.contentHeight*0.651)

	--재료칸 클릭시--
	local material_box =  display.newImage("Content/image/material_box.png", display.contentWidth*0.762, display.contentHeight*0.534)
	local function myTouchListener( event )
 
	    if ( event.phase == "began" ) then
	    	composer.setVariable("s", syrup_image)
	        composer.gotoScene("material")
		end
	end
 
	material_box:addEventListener("touch", myTouchListener)

	--바닐라 시럽--
	vanilla = display.newImage("Content/image/vanilla.png", display.contentWidth * 0.37, display.contentHeight * 0.624)
	--vanilla.fill.effect = "filter.brightness"
	--vanilla.fill.effect.intensity = 0.4

	local function vinailla_button( event )
 		syrub = 3
		print("바닐라"..syrub)
	    if ( event.phase == "began" ) then
	    	display.remove( syrup_image )
	   		syrup_image = display.newImage("Content/image/vanilla_syrup.png", display.contentWidth*0.49, display.contentHeight*0.52)
	    	composer.setVariable("s", syrup_image)
			--syrup_image.x, syrup_image.y = display.contentWidth * 0.49, display.contentHeight * 0.55
		end
	end
 
	vanilla:addEventListener( "touch", vinailla_button )

	--초코 시럽--
	choco = display.newImage("Content/image/choco.png", display.contentWidth * 0.51, display.contentHeight * 0.624)
	--hoco.x, choco.y = display.contentWidth * 0.505, display.contentHeight * 2.31

	local function choco_button( event )
 		syrub = 1
	    if ( event.phase == "began" ) then
	    	display.remove( syrup_image )
	   		syrup_image = display.newImage("Content/image/choco_syrup.png", display.contentWidth*0.51, display.contentHeight*0.52)
	    	composer.setVariable("s", syrup_image)
			--syrup_image.x, syrup_image.y = display.contentWidth * 0.505, display.contentHeight * 0.78
		end
	end
 
	choco:addEventListener( "touch", choco_button )

	--딸기 시럽--
	strawberry = display.newImage("Content/image/strawberry.png", display.contentWidth * 0.63, display.contentHeight * 0.623)
	--strawberry.x, strawberry.y = display.contentWidth * 0.63, display.contentHeight * 2.29

	local function strawberry_button( event )
 		syrub = 2
	    if ( event.phase == "began" ) then
	    	display.remove( syrup_image )
	   		syrup_image = display.newImage("Content/image/strawberry_syrup.png", display.contentWidth*0.495, display.contentHeight*0.513)
	    	composer.setVariable("s", syrup_image)
			--syrup_image.x, syrup_image.y = display.contentWidth * 0.495, display.contentHeight * 0.65
		end
	end
 
	strawberry:addEventListener( "touch", strawberry_button )

	--굽기 버튼--
	local start_button = display.newImage("Content/image/start.png", display.contentWidth*0.5, display.contentHeight*0.71)

	local function start( event )
 	
	    if ( event.phase == "began" ) then
	        composer.gotoScene("plus")
		end
	end
	start_button:addEventListener("touch", start)


	--닫기 버튼--
	local close_button = display.newImage("Content/images/시작/close.png", display.contentWidth*0.872, display.contentHeight*0.355)

	local function close( event )
 
	    if ( event.phase == "began" ) then
	        composer.gotoScene("home")
		end
	end
	close_button:addEventListener("touch", close)


	--레이어 정리--
	sceneGroup:insert( s_background )
	sceneGroup:insert( syrup_box )
	sceneGroup:insert( material_box )
	--sceneGroup:insert( m_image )
	--sceneGroup:insert( syrup_image )
	sceneGroup:insert( box1 )

	sceneGroup:insert(choco)
	sceneGroup:insert(vanilla)
	sceneGroup:insert(strawberry)
	
	if choco == 1 then
		sceneGroup:insert( syrup_image )
	elseif vanilla == 1 then 
		sceneGroup:insert( syrup_image )
	elseif strawberry == 1 then
		sceneGroup:insert( syrup_image )
	end


	sceneGroup:insert( start_button )
	sceneGroup:insert( close_button )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		---deleteBeforeNum()
		---deleteBeforeLevel()
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
		--forCoin()
		--forLevel()
		
		if syrub ~= 0 then
			syrup_image:removeSelf() 
		end
		composer.removeScene("syrup")

		
--[[	choco:removeSelf()
			vanilla:removeSelf()
			strawberry:removeSelf()
		if choco == 1 then
			choco:removeSelf()
		elseif vanilla == 1 then
			vanilla:removeSelf()
		elseif strawberry == 1 then
			strawberry:removeSelf()
	end]]

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