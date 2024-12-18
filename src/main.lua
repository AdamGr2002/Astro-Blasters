-- Require other game files (modules)
local config = require "src.config"
local player = require "src.player"
local asteroid = require "src.asteroid"
local bullet = require "src.bullet"
local powerup = require "src.powerup"
local enemy = require "src.enemy"
local collision = require "src.collision"
local utils = require "src.utils"
local gamestate = require "src.gamestate"
local blackhole = require "src.blackhole"
local ui = require "src.ui"


function love.load()
  -- Initialize game
  gamestate.set("menu")
  player.init()
  ui.init()

  config.init()
end

function love.update(dt)
    gamestate.update(dt) -- Updates the current game state

    if gamestate.current == "playing" then
      player.update(dt)
      asteroid.update(dt)
      bullet.update(dt)
      powerup.update(dt)
      enemy.update(dt)
      blackhole.update(dt)
      collision.check()
      ui.update(dt)
   end
end

function love.draw()
  gamestate.draw()

  if gamestate.current == "playing" then
    player.draw()
    asteroid.draw()
    bullet.draw()
    powerup.draw()
    enemy.draw()
    blackhole.draw()
    ui.draw()
   end
end


function love.keypressed(key)
    gamestate.keypressed(key)
    if gamestate.current == "playing" then
         player.keypressed(key)
    end
end

function love.mousepressed(x,y,button,isTouch)
  gamestate.mousepressed(x,y,button,isTouch)
    if gamestate.current == "playing" then
        player.mousepressed(x,y,button,isTouch)
    end
end