--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_base"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayForEach
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["8"] = 3,
		["9"] = 3,
		["10"] = 3,
		["11"] = 16,
		["12"] = 9,
		["13"] = 10,
		["14"] = 11,
		["15"] = 15,
		["16"] = 17,
		["17"] = 18,
		["18"] = 19,
		["19"] = 20,
		["20"] = 21,
		["21"] = 22,
		["22"] = 23,
		["23"] = 24,
		["24"] = 25,
		["25"] = 25,
		["26"] = 25,
		["27"] = 26,
		["28"] = 27,
		["29"] = 28,
		["30"] = 29,
		["31"] = 30,
		["32"] = 31,
		["33"] = 31,
		["34"] = 31,
		["35"] = 32,
		["36"] = 33,
		["37"] = 34,
		["39"] = 36,
		["40"] = 37,
		["41"] = 38,
		["43"] = 31,
		["44"] = 31,
		["47"] = 25,
		["48"] = 25,
		["49"] = 44,
		["50"] = 45,
		["51"] = 46,
		["52"] = 47,
		["53"] = 48,
		["56"] = 51,
		["57"] = 52,
		["59"] = 16,
		["60"] = 55,
		["61"] = 55,
		["62"] = 58,
		["63"] = 62,
		["64"] = 63,
		["65"] = 64,
		["66"] = 64,
		["67"] = 64,
		["68"] = 64,
		["69"] = 64,
		["70"] = 64,
		["71"] = 65,
		["72"] = 65,
		["73"] = 66,
		["75"] = 58,
		["76"] = 69,
		["77"] = 73,
		["78"] = 73,
		["79"] = 69,
		["80"] = 76,
		["81"] = 77,
		["82"] = 78,
		["83"] = 79,
		["86"] = 82,
		["87"] = 83,
		["88"] = 83,
		["89"] = 83,
		["90"] = 84,
		["91"] = 85,
		["93"] = 83,
		["94"] = 83,
		["96"] = 89,
		["97"] = 90,
		["98"] = 90,
		["99"] = 90,
		["100"] = 91,
		["101"] = 92,
		["102"] = 93,
		["104"] = 90,
		["105"] = 90,
		["107"] = 97,
		["108"] = 76,
		["109"] = 99,
		["110"] = 99,
		["111"] = 102,
		["112"] = 103,
		["113"] = 102,
		["114"] = 106,
		["115"] = 107,
		["116"] = 106,
		["117"] = 110,
		["118"] = 110,
		["119"] = 110,
		["121"] = 111,
		["122"] = 112,
		["123"] = 113,
		["125"] = 115,
		["126"] = 110,
		["127"] = 118,
		["128"] = 119,
		["129"] = 118,
		["130"] = 121,
		["131"] = 122,
		["132"] = 121,
		["133"] = 124,
		["134"] = 126,
		["135"] = 127,
		["136"] = 128,
		["137"] = 124,
		["138"] = 130,
		["139"] = 131,
		["140"] = 132,
		["142"] = 130,
		["143"] = 135,
		["144"] = 136,
		["145"] = 136,
		["147"] = 136,
		["149"] = 136,
		["150"] = 136,
		["151"] = 136,
		["153"] = 136,
		["154"] = 135,
		["155"] = 139,
		["156"] = 140,
		["157"] = 140,
		["158"] = 141,
		["159"] = 142,
		["160"] = 143,
		["162"] = 139,
	}
)
local f = {}
f.GreevilEffectBase = c()
local g = f.GreevilEffectBase
g.name = "GreevilEffectBase"
function g.prototype.____constructor(self, h, i)
	self._stackCount = 0
	self._buff_list = {}
	self._battle_buff_info = {}
	self.propertyList = {}
	self.name = i
	self.playerID = h
	self.modifierEventIDList = {}
	self._buff_list = {}
	self.propertyList = {}
	self._battle_buff_info = {}
	self.kv = KeyValues.GreevilEffectKV[i]
	self.type = self.kv.CardType
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE, function()
		if #self._battle_buff_info > 0 then
			local j = PlayerData:getHero(self.playerID)
			if j then
				local k = j.hero
				local l = j.illusion
				d(self._battle_buff_info, function(m, n)
					if IsValid(k) then
						local o = k:FindAbilityByName("greevil_effect_dummy")
						k:AddNewModifier(k, o, n.name, n.params)
					end
					if IsValid(l) then
						local o = l:FindAbilityByName("greevil_effect_dummy")
						l:AddNewModifier(l, o, n.name, n.params)
					end
				end)
			end
		end
	end)
	local p = {}
	for m, q in ipairs(ITEM_ATTRIBUTE) do
		local r = self:getSpecialValueFor(q)
		if r > 0 then
			p[q] = r
		end
	end
	for s, t in pairs(p) do
		self:addProperty(s, t)
	end
end
function g.prototype.spawn(self) end
function g.prototype.AddCourierBuff(self, u, v)
	local w = PlayerResource:GetSelectedHeroEntity(self.playerID)
	if w then
		local x = w:AddNewModifier(w, w:GetDummyAbility(), u, v)
		local y = self._buff_list
		y[#y + 1] = x
		return x
	end
end
function g.prototype.AddBattleBuff(self, u, v)
	local z = self._battle_buff_info
	z[#z + 1] = { name = u, params = v }
end
function g.prototype._dispose(self)
	if self.modifierEventIDList then
		for A, B in pairs(self.modifierEventIDList) do
			RemoveModifierEvent(B, A)
		end
	end
	if #self._buff_list > 0 then
		d(self._buff_list, function(m, t)
			if IsValid(t) then
				t:Destroy()
			end
		end)
	end
	if #self.propertyList > 0 then
		d(self.propertyList, function(m, t)
			local j = PlayerData:getHero(self.playerID)
			if j then
				j:removeProperty(t.name, t.value)
			end
		end)
	end
	self:dispose()
end
function g.prototype.dispose(self) end
function g.prototype.AddStack(self, C)
	self._stackCount = self._stackCount + C
end
function g.prototype.GetStackCount(self)
	return self._stackCount
end
function g.prototype.PRD(self, D, E)
	if E == nil then
		E = self.name
	end
	local F = PlayerResource:GetSelectedHeroEntity(self.playerID)
	if F == nil then
		return RollPercentage(D)
	end
	return PRD(F, D, E)
end
function g.prototype.getPlayerID(self)
	return self.playerID
end
function g.prototype.getType(self)
	return self.type
end
function g.prototype.ModifierEvent(self, G, H)
	local A = ModifierEvent(G, H, self)
	self.modifierEventIDList[A] = G
	return A
end
function g.prototype.RemoveModifierEvent(self, A)
	if self.modifierEventIDList[A] ~= nil then
		RemoveModifierEvent(self.modifierEventIDList[A], A)
	end
end
function g.prototype.getSpecialValueFor(self, B)
	local I = self.kv
	local J = I and I.AbilityValues
	if J ~= nil then
		J = J[B]
	end
	local K = J
	if K == nil then
		K = 0
	end
	return K
end
function g.prototype.addProperty(self, B, r)
	local L = self.propertyList
	L[#L + 1] = { name = B, value = r }
	local j = PlayerData:getHero(self.playerID)
	if j then
		j:addProperty(B, r)
	end
end
return f