--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class Team
---@field id integer
---@field players integer[]
---@field isAlive boolean
---@field location Vector
---@field startLocation Vector
---@field isAbandoned boolean
if Team == nil then
	Team = class({})
end

---@param id integer
function Team:constructor(id)
	self.id = id
	self.players = {}
	self.isAlive = false
	self.location = Vector(0, 0, 0)
	self.startLocation = Vector(0, 0, 0)
	self.isAbandoned = false
end

---@return integer
function Team:GetId()
	return self.id
end

---@return integer[]
function Team:GetPlayers()
	return self.players
end

---@param playerId integer
function Team:AddPlayer(playerId)
	table.insert(self.players, playerId)
end

---@return boolean
function Team:IsAlive()
	return self.isAlive == true
end

---@param isAlive boolean
function Team:SetAlive(isAlive)
	self.isAlive = isAlive
end

---@return Vector
function Team:GetLocation()
	return self.location
end

---@param location Vector
function Team:SetLocation(location)
	self.location = location
end

---@return Vector
function Team:GetStartLocation()
	return self.startLocation
end

---@param location Vector
function Team:SetStartLocation(location)
	self.startLocation = location
end

---@return boolean
function Team:IsAbandoned()
	return self.isAbandoned == true
end

function Team:SetAbandoned()
	self.isAbandoned = true
end