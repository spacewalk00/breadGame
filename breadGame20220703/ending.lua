-----------------------------------------------------------------------------------------
--
-- ending.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	--배경화면
	local background = display.newImage("Content/images/끝/openingBG.png", display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	--제목
	local title = display.newImage("Content/images/끝/title.png", display.contentWidth/2, display.contentHeight*0.15)
	--클릭 텍스트
	local endText = display.newText("END", display.contentWidth/2, display.contentHeight*0.24, "font/ONE Mobile POP.ttf", 100)
	--local clickText = display.newText("여기를 터치하여 시작하세요", display.contentWidth/2, display.contentHeight*0.9, "font/ONE Mobile POP.ttf", 60)
	transition.blink( endText , { time=1700 })



	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(title)
	sceneGroup:insert(endText)
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
		--composer.removeScene("opening")
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