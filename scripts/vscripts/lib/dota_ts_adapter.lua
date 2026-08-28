--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "lib/dota_ts_adapter"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 136,
		["9"] = 137,
		["10"] = 137,
		["11"] = 138,
		["12"] = 139,
		["13"] = 142,
		["14"] = 143,
		["17"] = 147,
		["19"] = 136,
		["20"] = 2,
		["21"] = 2,
		["22"] = 2,
		["24"] = 2,
		["25"] = 5,
		["26"] = 5,
		["27"] = 5,
		["29"] = 5,
		["30"] = 6,
		["31"] = 6,
		["32"] = 9,
		["33"] = 9,
		["34"] = 9,
		["36"] = 9,
		["37"] = 12,
		["38"] = 12,
		["39"] = 12,
		["41"] = 12,
		["42"] = 13,
		["43"] = 20,
		["44"] = 13,
		["45"] = 25,
		["46"] = 25,
		["47"] = 25,
		["48"] = 25,
		["49"] = 28,
		["50"] = 28,
		["51"] = 28,
		["52"] = 28,
		["53"] = 31,
		["54"] = 31,
		["55"] = 31,
		["56"] = 31,
		["57"] = 34,
		["58"] = 35,
		["59"] = 36,
		["60"] = 38,
		["61"] = 39,
		["62"] = 41,
		["64"] = 43,
		["66"] = 46,
		["67"] = 48,
		["68"] = 50,
		["69"] = 52,
		["70"] = 53,
		["71"] = 54,
		["72"] = 55,
		["73"] = 56,
		["75"] = 58,
		["76"] = 59,
		["77"] = 60,
		["78"] = 61,
		["79"] = 62,
		["80"] = 63,
		["81"] = 64,
		["82"] = 65,
		["84"] = 67,
		["85"] = 68,
		["89"] = 72,
		["90"] = 73,
		["91"] = 74,
		["93"] = 53,
		["94"] = 38,
		["95"] = 79,
		["96"] = 80,
		["97"] = 81,
		["98"] = 82,
		["99"] = 84,
		["101"] = 86,
		["103"] = 89,
		["104"] = 92,
		["105"] = 94,
		["106"] = 96,
		["107"] = 97,
		["108"] = 98,
		["109"] = 99,
		["110"] = 100,
		["112"] = 97,
		["113"] = 104,
		["114"] = 105,
		["115"] = 106,
		["116"] = 107,
		["117"] = 108,
		["119"] = 110,
		["120"] = 111,
		["122"] = 113,
		["123"] = 114,
		["126"] = 118,
		["128"] = 120,
		["129"] = 121,
		["131"] = 81,
		["132"] = 79,
		["135"] = 129,
		["136"] = 130,
		["137"] = 131,
		["138"] = 132,
		["139"] = 131,
		["140"] = 129,
	}
)
local g = {}
function g.toDotaClassInstance(self, h, i)
	local j = i
	local k = j.prototype
	while k do
		for l in pairs(k) do
			if not (rawget(h, l) ~= nil) then
				h[l] = k[l]
			end
		end
		k = getmetatable(k)
	end
end
g.BaseAbility = c()
local m = g.BaseAbility
m.name = "BaseAbility"
function m.prototype.____constructor(self) end
g.BaseItem = c()
local n = g.BaseItem
n.name = "BaseItem"
function n.prototype.____constructor(self) end
function n.prototype.OnChargeCountChanged(self, o) end
g.BaseArtifact = c()
local p = g.BaseArtifact
p.name = "BaseArtifact"
function p.prototype.____constructor(self) end
g.BaseModifier = c()
local q = g.BaseModifier
q.name = "BaseModifier"
function q.prototype.____constructor(self) end
function q.apply(self, r, s, t, u)
	return r:AddNewModifier(s, t, self.name, u)
end
g.BaseModifierMotionHorizontal = c()
local v = g.BaseModifierMotionHorizontal
v.name = "BaseModifierMotionHorizontal"
d(v, g.BaseModifier)
g.BaseModifierMotionVertical = c()
local w = g.BaseModifierMotionVertical
w.name = "BaseModifierMotionVertical"
d(w, g.BaseModifier)
g.BaseModifierMotionBoth = c()
local x = g.BaseModifierMotionBoth
x.name = "BaseModifierMotionBoth"
d(x, g.BaseModifier)
setmetatable(g.BaseAbility.prototype, { __index = CDOTA_Ability_Lua or C_DOTA_Ability_Lua })
setmetatable(g.BaseItem.prototype, { __index = CDOTA_Item_Lua or C_DOTA_Item_Lua })
setmetatable(g.BaseModifier.prototype, { __index = CDOTA_Modifier_Lua or CDOTA_Modifier_Lua })
g.registerAbility = function(y, z)
	return function(y, t)
		if z ~= nil then
			t.name = z
		else
			z = t.name
		end
		local A = _G
		A[z] = {}
		g.toDotaClassInstance(nil, A[z], t)
		local B = A[z].Spawn
		A[z].Spawn = function(self)
			local s
			if self.GetCaster ~= nil then
				s = self:GetCaster()
			end
			if s and s.__pendingAbilityLevels then
				local C = self:GetAbilityName()
				local D = s.__pendingAbilityLevels
				local E = D[C]
				if E and #E > 0 then
					local F = table.remove(E, 1)
					if #E == 0 then
						e(D, C)
					end
					if F and F > 0 and self:GetLevel() ~= F then
						self:SetLevel(F)
					end
				end
			end
			self:____constructor()
			if B then
				B(self)
			end
		end
	end
end
g.registerModifier = function(self, z)
	local G = self
	return function(y, H)
		if z ~= nil then
			H.name = z
		else
			z = H.name
		end
		local A = _G
		A[z] = {}
		g.toDotaClassInstance(nil, A[z], H)
		local I = A[z].OnCreated
		A[z].OnCreated = function(self, J)
			self:____constructor()
			if I then
				I(self, J)
			end
		end
		local K = LUA_MODIFIER_MOTION_NONE
		local L = H.____super
		while L do
			if L == g.BaseModifierMotionBoth then
				K = LUA_MODIFIER_MOTION_BOTH
				break
			elseif L == g.BaseModifierMotionHorizontal then
				K = LUA_MODIFIER_MOTION_HORIZONTAL
				break
			elseif L == g.BaseModifierMotionVertical then
				K = LUA_MODIFIER_MOTION_VERTICAL
				break
			end
			L = L.____super
		end
		if G and #G > 0 then
			LinkLuaModifier(z, G, K)
		end
	end
end
function g.registerEntityFunction(self, z, M)
	local A = getfenv(2)
	A[z] = function(...)
		M(nil, ...)
	end
end
return g