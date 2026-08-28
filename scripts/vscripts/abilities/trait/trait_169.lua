--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_169"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
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
		["32"] = 19,
		["33"] = 21,
		["34"] = 22,
		["35"] = 12,
		["36"] = 24,
		["37"] = 25,
		["38"] = 24,
		["39"] = 28,
		["40"] = 29,
		["41"] = 30,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["46"] = 35,
		["47"] = 36,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 36,
		["53"] = 36,
		["54"] = 37,
		["55"] = 38,
		["56"] = 39,
		["59"] = 28,
		["60"] = 44,
		["61"] = 45,
		["62"] = 44,
		["63"] = 50,
		["64"] = 51,
		["67"] = 52,
		["70"] = 53,
		["73"] = 55,
		["74"] = 56,
		["75"] = 57,
		["76"] = 58,
		["77"] = 59,
		["78"] = 60,
		["80"] = 50,
		["81"] = 19,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 12,
		["87"] = 12,
		["88"] = 12,
		["89"] = 19,
		["91"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_169 = c()
local o = h.trait_169
o.name = "trait_169"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_169"
end
o = e({ k(nil) }, o)
h.trait_169 = o
h.modifier_trait_169 = c()
local p = h.modifier_trait_169
p.name = "modifier_trait_169"
d(p, m)
function p.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.pending_trait = ""
	self.has_triggered = false
end
function p.prototype.GetAbilitySpecialValue(self)
	self.wait_round = self:GetAbilitySpecialValueFor("wait_round")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self:SetStackCount(self.wait_round)
		local r = { "trait_170", "trait_150", "trait_144", "trait_159" }
		if not f(AbilityShop.pickList, "sect_crit") then
			r[#r + 1] = "trait_187"
		end
		local s = self:GetParent():GetPlayerOwnerID()
		local t = RuneTask:generateRandomRuneList(s, 1, RUNE_TASK_ROUNDS[2], r, true)
		if t and #t > 0 then
			self.pending_trait = t[1]
			RuneTask:addRepeatKey(s, self.pending_trait)
		end
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function p.prototype.OnRoundChange(self, q)
	if not IsServer() then
		return
	end
	if self.has_triggered then
		return
	end
	if self.pending_trait == "" then
		return
	end
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self.has_triggered = true
		local s = self:GetParent():GetPlayerOwnerID()
		PlayerData:setTraitAbility(s, self.pending_trait, 1)
		Notification:combatToPlayer(
			s,
			{
				message = "notify_artifact_ability_sr",
				string_itemname_artifact = "DOTA_Tooltip_ability_trait_169",
				string_ability_name = "DOTA_Tooltip_ability_" .. self.pending_trait,
			}
		)
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_169 = p
return h