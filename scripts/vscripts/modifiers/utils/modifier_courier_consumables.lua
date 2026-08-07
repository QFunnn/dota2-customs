--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier_consumables"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySort
local f = b.__TS__ArrayForEach
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 3,
		["14"] = 11,
		["15"] = 3,
		["16"] = 11,
		["18"] = 11,
		["19"] = 15,
		["20"] = 3,
		["21"] = 18,
		["22"] = 19,
		["23"] = 20,
		["24"] = 21,
		["25"] = 22,
		["26"] = 23,
		["27"] = 24,
		["29"] = 18,
		["30"] = 27,
		["31"] = 28,
		["32"] = 29,
		["33"] = 30,
		["34"] = 27,
		["35"] = 32,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["46"] = 48,
		["47"] = 49,
		["49"] = 32,
		["50"] = 52,
		["51"] = 53,
		["52"] = 54,
		["53"] = 54,
		["54"] = 54,
		["55"] = 54,
		["56"] = 54,
		["57"] = 54,
		["58"] = 54,
		["60"] = 77,
		["61"] = 77,
		["62"] = 77,
		["63"] = 77,
		["64"] = 78,
		["65"] = 78,
		["66"] = 78,
		["67"] = 82,
		["68"] = 78,
		["69"] = 78,
		["70"] = 90,
		["71"] = 91,
		["73"] = 52,
		["74"] = 94,
		["75"] = 95,
		["76"] = 96,
		["77"] = 96,
		["78"] = 96,
		["79"] = 96,
		["80"] = 96,
		["81"] = 96,
		["82"] = 96,
		["83"] = 97,
		["84"] = 98,
		["85"] = 98,
		["86"] = 98,
		["87"] = 99,
		["88"] = 100,
		["89"] = 101,
		["90"] = 102,
		["91"] = 103,
		["92"] = 104,
		["93"] = 105,
		["94"] = 106,
		["96"] = 108,
		["97"] = 109,
		["98"] = 110,
		["102"] = 116,
		["103"] = 117,
		["104"] = 118,
		["105"] = 119,
		["106"] = 120,
		["107"] = 121,
		["108"] = 122,
		["109"] = 122,
		["110"] = 123,
		["113"] = 98,
		["114"] = 98,
		["115"] = 94,
		["116"] = 128,
		["117"] = 129,
		["118"] = 130,
		["119"] = 131,
		["122"] = 128,
		["123"] = 135,
		["124"] = 136,
		["125"] = 137,
		["126"] = 137,
		["127"] = 136,
		["128"] = 135,
		["129"] = 140,
		["130"] = 141,
		["131"] = 142,
		["132"] = 143,
		["133"] = 144,
		["134"] = 148,
		["135"] = 149,
		["138"] = 140,
		["139"] = 11,
		["140"] = 3,
		["141"] = 3,
		["142"] = 3,
		["143"] = 3,
		["144"] = 3,
		["145"] = 3,
		["146"] = 3,
		["147"] = 3,
		["148"] = 11,
		["150"] = 11,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
i.modifier_courier_consumables = c()
local m = i.modifier_courier_consumables
m.name = "modifier_courier_consumables"
d(m, k)
function m.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.consumableInited = false
end
function m.prototype.OnCreated(self, n)
	if IsServer() then
		self.ConsumablesAbilityList = {}
		self.TempConsumablesList = {}
		self.playerID = self:GetParent():GetPlayerOwnerID()
		self:OverrideConsumablesAbilityList(NetData:getPlayerTableValue(self.playerID, "player_consumable_slots"))
		self:StartIntervalThink(1)
	end
end
function m.prototype.OnIntervalThink(self)
	self.consumableInited = true
	self:changeConsumablesAbility()
	self:StartIntervalThink(-1)
end
function m.prototype.OnThink(self, o)
	local p = self:GetParent()
	local q = p:GetPlayerOwnerID()
	if o == "consumables" then
		for r, s in pairs(self.TempConsumablesList) do
			local t = tonumber(r)
			local u = s
			if type(t) == "number" and u > 0 then
				CommonService:CallAction("consumable_use", q, { cid = t, amounts = u })
			end
		end
		self.TempConsumablesList = {}
		self:StartThink(-1, o)
	end
end
function m.prototype.OverrideConsumablesAbilityList(self, v)
	if not v then
		v = { { cid = 9300006, slot = 1 }, { cid = 9300002, slot = 2 }, { cid = 9300003, slot = 3 }, {
			cid = 9300004,
			slot = 4,
		}, {
			cid = 9300005,
			slot = 5,
		} }
	end
	v = e(v, function(w, x, y)
		return x.slot - y.slot
	end)
	f(v, function(w, z, A)
		self.ConsumablesAbilityList[z.slot] = self:getConsumableName(z.cid)
	end)
	if self.consumableInited then
		self:changeConsumablesAbility()
	end
end
function m.prototype.changeConsumablesAbility(self)
	local B = NetData:getPlayerTableValue(self.playerID, "player_consumables")
	local C = { 0, 1, 2, 3, 5 }
	local p = self:GetParent()
	f(C, function(w, D, A)
		local E = p:GetAbilityByIndex(D)
		if IsValid(E) then
			local F = E:GetAbilityName()
			local G = self.ConsumablesAbilityList[A + 1]
			if G ~= nil and F ~= G then
				local H = p:FindAbilityByName(G)
				if IsValid(H) then
					p:SwapAbilities(F, G, true, true)
				else
					H = p:AddAbility(G, 1)
					p:SwapAbilities(F, G, false, true)
					p:RemoveAbility(F)
				end
			end
		end
		local I = p:GetAbilityByIndex(D)
		if IsValid(I) then
			local J = I:GetAbilityName()
			local K = KeyValues.ConsumablesKv[J]
			if K then
				local r = tonumber(K.Id)
				local L = B and B[tostring(r)]
				local s = L and L.amounts or 0
				I:SetCurrentAbilityCharges(s)
			end
		end
	end)
end
function m.prototype.getConsumableName(self, M)
	for N, z in pairs(KeyValues.ConsumablesKv) do
		if z.Id == M then
			return N
		end
	end
end
function m.prototype.EDeclareEvents(self)
	return { [MODIFIER_EVENT_ON_ABILITY_EXECUTED] = { self:GetParent(), -1 } }
end
function m.prototype.OnAbilityExecuted(self, O)
	if IsServer() and IsValid(O.ability) then
		local J = O.ability:GetAbilityName()
		if KeyValues.ConsumablesKv[J] ~= nil then
			local r = tostring(KeyValues.ConsumablesKv[J].Id)
			self.TempConsumablesList[r] = (self.TempConsumablesList[r] or 0) + 1
			self:StartThink(3, "consumables")
		end
	end
end
m = g(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	m
)
i.modifier_courier_consumables = m
return i