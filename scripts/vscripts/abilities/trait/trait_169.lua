--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_169"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["31"] = 19,
		["32"] = 21,
		["33"] = 22,
		["34"] = 12,
		["35"] = 24,
		["36"] = 25,
		["37"] = 24,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["41"] = 32,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 33,
		["46"] = 33,
		["47"] = 33,
		["48"] = 33,
		["49"] = 34,
		["50"] = 35,
		["53"] = 28,
		["54"] = 40,
		["55"] = 41,
		["56"] = 40,
		["57"] = 46,
		["58"] = 47,
		["61"] = 48,
		["64"] = 49,
		["67"] = 51,
		["68"] = 52,
		["69"] = 53,
		["70"] = 54,
		["71"] = 55,
		["72"] = 56,
		["74"] = 46,
		["75"] = 19,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 19,
		["85"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_169 = c()
local n = g.trait_169
n.name = "trait_169"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_169"
end
n = e({ j(nil) }, n)
g.trait_169 = n
g.modifier_trait_169 = c()
local o = g.modifier_trait_169
o.name = "modifier_trait_169"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.pending_trait = ""
	self.has_triggered = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.wait_round = self:GetAbilitySpecialValueFor("wait_round")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.wait_round)
		local q = self:GetParent():GetPlayerOwnerID()
		local r = RuneTask:generateRandomRuneList(q, 1, RUNE_TASK_ROUNDS[2], { "trait_170" }, true)
		if r and #r > 0 then
			self.pending_trait = r[1]
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
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
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:setTraitAbility(q, self.pending_trait, 1)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_artifact_ability_sr",
				string_itemname_artifact = "DOTA_Tooltip_ability_trait_169",
				string_ability_name = "DOTA_Tooltip_ability_" .. self.pending_trait,
			}
		)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_169 = o
return g