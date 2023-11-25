love.graphics.setDefaultFilter("nearest", "nearest")
local STI = require("sti")
local Player = require("player")
local Coin = require("coin")
local GUI = require("gui")
local Spike = require("spike")
local Camera = require("camera")
local Enemy = require("enemy")
local Map = require("map")


function love.load()

    background = love.graphics.newImage("assets/background.png")
    GUI:load()
    Enemy.loadAssets()
    Map:load()
    Player:load()

end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    Coin.updateAll(dt)
    Enemy.updateAll(dt)
    GUI:update(dt)
    Spike.updateAll(dt)
    Camera:setPosition(Player.x, 0)
    Map:update(dt)
end

function love.draw()
    love.graphics.draw(background)
    Map.level:draw(-Camera.x,-Camera.y,Camera.scale,Camera.scale)

    Camera:apply()

    Player:draw()
    Coin.drawAll()
    Spike.drawAll()
    Enemy.drawAll()

    Camera.clear()

    GUI:draw()
end

function love.keypressed(key)
    Player:jump(key)
end

function beginContact(a, b, collision)
    if Coin.beginContact(a,b,collision) then return end
    if Spike.beginContact(a,b,collision) then return end
    Enemy.beginContact(a,b,collision)
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end
