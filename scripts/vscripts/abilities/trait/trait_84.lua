--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_84"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 19,
		["29"] = 12,
		["30"] = 19,
		["31"] = 28,
		["32"] = 29,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["36"] = 28,
		["37"] = 34,
		["38"] = 35,
		["39"] = 36,
		["40"] = 37,
		["41"] = 38,
		["43"] = 34,
		["44"] = 41,
		["45"] = 42,
		["46"] = 43,
		["47"] = 44,
		["48"] = 45,
		["51"] = 41,
		["52"] = 49,
		["53"] = 50,
		["54"] = 49,
		["55"] = 54,
		["56"] = 55,
		["57"] = 54,
		["58"] = 60,
		["59"] = 61,
		["60"] = 62,
		["61"] = 63,
		["62"] = 64,
		["64"] = 67,
		["65"] = 68,
		["66"] = 69,
		["67"] = 70,
		["68"] = 71,
		["69"] = 72,
		["70"] = 73,
		["72"] = 75,
		["73"] = 76,
		["74"] = 77,
		["75"] = 78,
		["76"] = 78,
		["77"] = 78,
		["78"] = 79,
		["79"] = 80,
		["81"] = 78,
		["82"] = 78,
		["83"] = 83,
		["84"] = 84,
		["86"] = 86,
		["87"] = 86,
		["88"] = 86,
		["89"] = 86,
		["90"] = 86,
		["91"] = 87,
		["93"] = 88,
		["94"] = 88,
		["95"] = 89,
		["96"] = 89,
		["97"] = 89,
		["98"] = 89,
		["99"] = 89,
		["100"] = 89,
		["101"] = 89,
		["102"] = 89,
		["103"] = 94,
		["104"] = 88,
		["107"] = 96,
		["108"] = 97,
		["110"] = 60,
		["111"] = 100,
		["112"] = 101,
		["113"] = 102,
		["114"] = 103,
		["115"] = 104,
		["117"] = 100,
		["118"] = 19,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 12,
		["125"] = 12,
		["126"] = 19,
		["128"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_84 = c()
local o = h.trait_84
o.name = "trait_84"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_84"
end
o = e({ k(nil) }, o)
h.trait_84 = o
h.modifier_trait_84 = c()
local p = h.modifier_trait_84
p.name = "modifier_trait_84"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.base = self:GetAbilitySpecialValueFor("base")
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.round_reduce = self:GetAbilitySpecialValueFor("round_reduce")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self.record = 0
		local r = AbilityShop:getAbilityPoolNew("sr", nil, nil, false)
		self.abilityList = r.tName
	end
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		local s = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if self.tempData then
			s:modifyTempAbilityUpgrade(self.tempData, true)
		end
	end
end
function p.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_LEGEND_CHANCE_OVERRIDE] = 0 }
end
function p.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = { -1, -1 },
	}
end
function p.prototype.OnRoundChange(self, q)
	self.record = self.record + 1
	if self.record >= self.round then
		self.record = self.record - self.round
		self:IncrementStackCount()
	end
	local t = self.base + self:GetStackCount() * self.count
	if t > 0 then
		local u = self:GetParent():GetPlayerOwnerID()
		local s = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if self.tempData then
			s:modifyTempAbilityUpgrade(self.tempData, true)
			self.tempData = nil
		end
		local v = {}
		local w = s:getAbilityUpgradeData()
		local x = s:getTempAbilityUpgrade()
		f(self.abilityList, function(y, z)
			if w[z] == nil and x[z] == nil then
				v[#v + 1] = z
			end
		end)
		if #v < t then
			v = self.abilityList
		end
		local A = PickList(v, math.min(#v, t), false)
		local B = {}
		do
			local C = 0
			while C < #A do
				Notification:combatToPlayer(
					u,
					{
						message = "notify_temp_ability_sr",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. A[C + 1],
					}
				)
				B[A[C + 1]] = 1
				C = C + 1
			end
		end
		s:modifyTempAbilityUpgrade(B)
		self.tempData = B
	end
end
function p.prototype.OnPlayerKilled(self, D)
	self.record = self.record + 1
	if self.record >= self.round then
		self.record = self.record - self.round
		self:IncrementStackCount()
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_84 = p
return h