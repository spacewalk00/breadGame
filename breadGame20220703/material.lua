-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local s_image
local material_image

function scene:create( event )
	local sceneGroup = self.view

	--배경--
	local m_background = display.newImage("Content/image/material_choice.png", display.contentWidth, display.contentHeight)
	m_background.x, m_background.y = display.contentWidth/2, display.contentHeight/2
	local s = composer.getVariable("s")
	s_image = display.newImage("s")
	print(s)
	local syrup_box
--[[
	if syrup == 1 then
		syrup_box =  display.newImage("Content/image/choco.png", display.contentWidth*0.496, display.contentHeight*0.534)
	elseif syrup == 2 then
		syrup_box =  display.newImage("Content/image/strawberry.png", display.contentWidth*0.496, display.contentHeight*0.534)
	elseif syrup == 3 then
		syrup_box =  display.newImage("Content/image/vanilla.png", display.contentWidth*0.496, display.contentHeight*0.534)
	end
	
	
]]

	local material_box =  display.newImage("Content/image/material_box.png", display.contentWidth*0.762, display.contentHeight*0.534)
	--시럽 버튼 클릭시--
	local syrup_box =  display.newImage("Content/image/syrup_box.png", display.contentWidth*0.496, display.contentHeight*0.534)

	local function myTouchListener( event )
	    if ( event.phase == "began" ) then
	    	composer.setVariable("m", material_image)
	        composer.gotoScene("syrup")
		end
	end
	syrup_box:addEventListener("touch", myTouchListener)

	--재료 선택 칸--
	local box2 = display.newImage("Content/image/box2.png", display.contentWidth*0.495, display.contentHeight*0.489)

	--치즈--
	local cheese = display.newImage("Content/image/cheese_btn.png", display.contentWidth * 0.2, display.contentHeight * 0.623)
	--cheese.x, cheese.y = display.contentWidth * 0.2, display.contentHeight * 2.31

	local function cheese_button( event )
 		ingredient = 4
	    if ( event.phase == "began" ) then
	    	display.remove( material_image )
	   		material_image = display.newImage("Content/image/cheese.png", display.contentWidth * 0.76, display.contentHeight * 0.508)
	    	composer.setVariable("m", material_image)
			--material_image.x, material_image.y = display.contentWidth * 0.75, display.contentHeight * 0.61
		end
	end
 
	cheese:addEventListener( "touch", cheese_button )

	--팥--
	local bean = display.newImage("Content/image/bean_btn.png", display.contentWidth * 0.26, display.contentHeight * 0.623)
	--bean.x, bean.y = display.contentWidth * 0.26, display.contentHeight * 2.308

	local function bean_button( event )
 		ingredient = 3
	    if ( event.phase == "began" ) then
	    	display.remove( material_image )
	   		material_image = display.newImage("Content/image/bean.png", display.contentWidth * 0.76, display.contentHeight * 0.51)
	    	composer.setVariable("m", material_image)
			--material_image.x, material_image.y = display.contentWidth * 0.765, display.contentHeight * 0.61
		end
	end
 
	bean:addEventListener( "touch", bean_button )

	--옥수수--
	local corn = display.newImage("Content/image/corn_btn.png", display.contentWidth * 0.33, display.contentHeight * 0.623)
	--corn.x, corn.y = display.contentWidth * 0.335, display.contentHeight * 2.3

	local function corn_button( event )
 		ingredient = 5 
	    if ( event.phase == "began" ) then
	    	display.remove( material_image )
	   		material_image = display.newImage("Content/image/corn.png", display.contentWidth * 0.765, display.contentHeight * 0.51)
	    	composer.setVariable("m", material_image)
			--material_image.x, material_image.y = display.contentWidth * 0.765, display.contentHeight * 0.6
		end
	end
 
	corn:addEventListener( "touch", corn_button )

	--슈가파우더--
	local sugarpowder = display.newImage("Content/image/sugarpowder_btn.png", display.contentWidth * 0.45, display.contentHeight * 0.625)
	--sugarpowder.x, sugarpowder.y = display.contentWidth * 0.45, display.contentHeight * 2.33

	local function sugarpowder_button( event )
 		ingredient = 7
	    if ( event.phase == "began" ) then
	    	display.remove( material_image )
	   		material_image = display.newImage("Content/image/sugarpowder.png", display.contentWidth * 0.764, display.contentHeight * 0.51)
	    	composer.setVariable("m", material_image)
			--material_image.x, material_image.y = display.contentWidth * 0.761, display.contentHeight * 0.62
		end
	end
 
	sugarpowder:addEventListener( "touch", sugarpowder_button )

	--소세지--
	local sausage = display.newImage("Content/image/sausage_btn.png", display.contentWidth * 0.558, display.contentHeight * 0.624)
	--sausage.x, sausage.y = display.contentWidth * 0.557, display.contentHeight * 2.31

	local function sausage_button( event )
 		ingredient = 2
 
	    if ( event.phase == "began" ) then
	    	display.remove( material_image )
	   		material_image = display.newImage("Content/image/sausage.png", display.contentWidth * 0.76, display.contentHeight * 0.515)
	    	composer.setVariable("m", material_image)
			--material_image.x, material_image.y = display.contentWidth * 0.76, display.contentHeight * 0.65
		end
	end
 
	sausage:addEventListener( "touch", sausage_button )

	--반짝이--
	local glitter = display.newImage("Content/image/glitter_btn.png",  display.contentWidth * 0.65, display.contentHeight * 0.624)
	--glitter.x, glitter.y = display.contentWidth * 0.656, display.contentHeight * 2.31

	local function glitter_button( event ) 
 		ingredient = 1

	    if ( event.phase == "began" ) then
	    	display.remove( material_image )
	   		material_image = display.newImage("Content/image/glitter.png", display.contentWidth * 0.76, display.contentHeight * 0.515)
	    	composer.setVariable("m", material_image)
			--material_image.x, material_image.y = display.contentWidth * 0.76, display.contentHeight * 0.67
		end
	end
 
	glitter:addEventListener( "touch", glitter_button )

	--오레오파우더--
	local oreopowder = display.newImage("Content/image/oreopowder_btn.png", display.contentWidth * 0.77, display.contentHeight * 0.622)
	--oreopowder.x, oreopowder.y = display.contentWidth * 0.77, display.contentHeight * 2.27

	local function oreopowder_button( event )
 		ingredient = 6
	    if ( event.phase == "began" ) then
	    	display.remove( material_image )
	   		material_image = display.newImage("Content/image/oreopowder.png", display.contentWidth * 0.76, display.contentHeight * 0.51)
	    	composer.setVariable("m", material_image)
			--material_image.x, material_image.y = display.contentWidth * 0.76, display.contentHeight * 0.62
		end
	end
 
	oreopowder:addEventListener( "touch", oreopowder_button )

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
	--close_button.x, close_button.y = display.contentWidth*0.873, display.contentHeight*-1.6

	local function close( event )
 
	    if ( event.phase == "began" ) then
	        composer.gotoScene("home")
		end
	end
	close_button:addEventListener("touch", close)


	--레이어 정리--
	sceneGroup:insert( m_background )
	sceneGroup:insert( syrup_box )
	sceneGroup:insert( material_box )
	--sceneGroup:insert( s_image )
	--sceneGroup:insert( material_image )
	sceneGroup:insert( box2 )

		sceneGroup:insert(glitter)
		sceneGroup:insert(sausage)
		sceneGroup:insert(bean)
		sceneGroup:insert(cheese)
		sceneGroup:insert(corn)
		sceneGroup:insert(oreopowder)
		sceneGroup:insert(sugarpowder)


	sceneGroup:insert( start_button )
	sceneGroup:insert( close_button )
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
		composer.removeScene("material")
		if material ~= 0 then
		--s_image:removeSelf()
		material_image:removeSelf()
		end 
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
