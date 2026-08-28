--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_base"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArraySplice
local e = {}
e.TutorialBase = c()
local f = e.TutorialBase
f.name = "TutorialBase"
function f.prototype.____constructor(self)
	self.timerList = {}
	self.upper_list = {}
	self.registeredEventIDs = {}
	self.playerID = GameModeTutorial:GetPlayerID()
	self.hero = GameModeTutorial:GetHero()
	print("constructor", self.constructor.name)
end
function f.prototype.spawn(self) end
function f.prototype.dispose(self)
	self:UnregisterAllEvents()
	self:ClearAllUppers()
	for g, h in ipairs(self.timerList) do
		Timer:StopTimer(h)
	end
end
function f.prototype.RegisterEvent(self, i, j)
	local k = Event:Register(i, j, self)
	local l = self.registeredEventIDs
	l[#l + 1] = k
	return k
end
function f.prototype.UnregisterEvent(self, m)
	do
		local n = #self.registeredEventIDs - 1
		while n >= 0 do
			if self.registeredEventIDs[n + 1] == m then
				d(self.registeredEventIDs, n, 1)
				break
			end
			n = n - 1
		end
	end
	Event:Unregister(m)
end
function f.prototype.GameTimer(self, o, j)
	local h = Timer:GameTimer(o, j)
	local p = self.timerList
	p[#p + 1] = h
	return h
end
function f.prototype.UnregisterAllEvents(self)
	for g, k in ipairs(self.registeredEventIDs) do
		Event:Unregister(k)
	end
	self.registeredEventIDs = {}
end
function f.prototype.AddTutorialUpper(self, q, r, s, t, u, v, w)
	local k
	if q == "Ability" and w ~= nil then
		k = GameModeTutorial:AddTutorialAbilityUpper(r, w, s, t, u, v)
	elseif q == "Movement" then
		k = GameModeTutorial:AddTutorialMovementUpper(r, s, t, u, v)
	elseif q == "Interact" then
		k = GameModeTutorial:AddTutorialInteractUpper(r, s, t, u, v)
	else
		k = GameModeTutorial:AddTutorialTextUpper(r, s, t, u, v)
	end
	local x = self.upper_list
	x[#x + 1] = k
	return k
end
function f.prototype.ClearAllUppers(self)
	for g, k in ipairs(self.upper_list) do
		GameModeTutorial:CloseTutorialUpper(k)
	end
	self.upper_list = {}
end
function f.prototype.Activate(self) end
function f.prototype.GetPlayerID(self)
	return self.playerID
end
function f.prototype.GetRoom(self)
	return GameModeTutorial:GetCurrentTutorialRoom()
end
function f.prototype.GetHero(self)
	return self.hero
end
function f.prototype.Complete(self)
	GameModeTutorial:OnTutorialFlowComplete(self.constructor.name)
end
function f.prototype.ShowPing(self, y, z, s)
	if s == nil then
		s = 2
	end
	local A = {
		Tips = { index = 0, color = Vector(0.2, 1, 0.2), particle = "particles/ui_mouseactions/ping_world.vpcf" },
		Battle = { index = 5, color = Vector(0.8, 0.5, 0), particle = "particles/ui_mouseactions/ping_attack.vpcf" },
		warning = { index = 6, color = Vector(0.9, 0.2, 0.05), particle = "particles/ui_mouseactions/ping_retreat.vpcf" },
	}
	local B = A[y]
	local C = ParticleManager:CreateParticleForce(B.particle, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(C, 11, Vector(1, 0, 0))
	local D = z
	if z and z.GetAbsOrigin then
		D = z:GetAbsOrigin()
		ParticleManager:SetParticleControlEnt(C, 0, z, PATTACH_ABSORIGIN_FOLLOW, nil, D, false)
		ParticleManager:SetParticleControlEnt(C, 1, z, PATTACH_OVERHEAD_FOLLOW, nil, D, false)
		ParticleManager:SetParticleControlEnt(C, 11, z, PATTACH_OVERHEAD_FOLLOW, nil, D, false)
	else
		D = GetGroundPosition(z, nil)
		ParticleManager:SetParticleControl(C, 0, D)
		ParticleManager:SetParticleControl(C, 1, D + Vector(0, 0, 300))
		ParticleManager:SetParticleControl(C, 10, D + Vector(0, 0, 300))
	end
	ParticleManager:SetParticleControl(C, 2, Vector(1, s, 0))
	ParticleManager:SetParticleControl(C, 3, Vector(0, 0, 0))
	ParticleManager:SetParticleControl(C, 5, Vector(A[y].index, 0, 0))
	local E = A[y].color
	ParticleManager:SetParticleControl(C, 7, E)
	ParticleManager:ReleaseParticleIndex(C)
	local F = "General.Ping"
	if y == "Battle" then
		F = "PingAttack.Layer"
	elseif y == "warning" then
		F = "General.PingHeart"
	end
	EmitSoundOnLocationForPlayer(F, D, self.playerID)
end
return e