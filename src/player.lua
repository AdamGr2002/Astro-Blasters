local config = require "src.config"
local player = {}

function player.init()
    player.x = config.WINDOW_WIDTH / 2
    player.y = config.WINDOW_HEIGHT / 2
    player.speed = config.PLAYER_SPEED
    player.img = love.graphics.newImage("assets/spaceship.png")
    player.width = player.img:getWidth()
    player.height = player.img:getHeight()
    player.rotation = 0

    player.reloadTime = 0.2
    player.timeSinceLastShot = 0

end

function player.update(dt)
-- Player Update logic (move, rotate)
    local dx = 0
    local dy = 0

    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        dx = -1
        player.rotation = 270
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        dx = 1
        player.rotation = 90
    elseif love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        dy = -1
        player.rotation = 0
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
       dy = 1
       player.rotation = 180
    end

    local magnitude = math.sqrt(dx*dx + dy*dy)

    if magnitude > 0 then
      dx = dx / magnitude
      dy = dy / magnitude
    end

    player.x = player.x + dx * player.speed * dt
    player.y = player.y + dy * player.speed * dt

    -- Keep player within screen bounds
    if player.x < 0 then player.x = 0 end
    if player.x > config.WINDOW_WIDTH - player.width then player.x = config.WINDOW_WIDTH - player.width end
    if player.y < 0 then player.y = 0 end
    if player.y > config.WINDOW_HEIGHT - player.height then player.y = config.WINDOW_HEIGHT - player.height end

    player.timeSinceLastShot = player.timeSinceLastShot + dt
end

function player.draw()
  love.graphics.draw(player.img, player.x, player.y, math.rad(player.rotation), 1, 1, player.width / 2, player.height/2)
end

function player.keypressed(key)
    if key == "space" then
         require "src.bullet".shoot(player)
     end
end

function player.mousepressed(x,y,button,isTouch)
    if button == 1 then
       require "src.bullet".shoot(player)
   end
end

return player