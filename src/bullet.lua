local config = require "src.config"
local bullets = {}

local bullet = {}

function bullet.shoot(player)
  if player.timeSinceLastShot >= player.reloadTime then
   local bullet = {}
      bullet.x = player.x + player.width / 2
      bullet.y = player.y + player.height / 2
      bullet.speed = 500
      bullet.rotation = player.rotation
      bullet.img = love.graphics.newImage("assets/bullet.png")
      bullet.width = bullet.img:getWidth()
      bullet.height = bullet.img:getHeight()
      table.insert(bullets, bullet)
     player.timeSinceLastShot = 0
   end
end

function bullet.update(dt)
   for i = #bullets, 1, -1 do
    local bullet = bullets[i]
      local angle = math.rad(bullet.rotation)
       bullet.x = bullet.x + math.cos(angle) * bullet.speed * dt
       bullet.y = bullet.y + math.sin(angle) * bullet.speed * dt

      -- Remove bullets off screen
    if bullet.x < 0 or bullet.x > config.WINDOW_WIDTH or bullet.y < 0 or bullet.y > config.WINDOW_HEIGHT then
          table.remove(bullets, i)
    end
  end
end


function bullet.draw()
  for _, bullet in ipairs(bullets) do
      love.graphics.draw(bullet.img, bullet.x, bullet.y, math.rad(bullet.rotation), 1, 1, bullet.width / 2, bullet.height/2)
  end
end

return bullet