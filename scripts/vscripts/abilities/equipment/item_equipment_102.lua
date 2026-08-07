--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_102"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 9,
		["22"] = 10,
		["23"] = 9,
		["24"] = 5,
		["25"] = 4,
		["26"] = 5,
		["28"] = 5,
		["29"] = 14,
		["30"] = 23,
		["31"] = 14,
		["32"] = 23,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 28,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["41"] = 36,
		["42"] = 35,
		["43"] = 34,
		["44"] = 40,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["48"] = 43,
		["49"] = 44,
		["51"] = 44,
		["53"] = 45,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["60"] = 40,
		["61"] = 23,
		["62"] = 14,
		["63"] = 14,
		["64"] = 14,
		["65"] = 14,
		["66"] = 14,
		["67"] = 14,
		["68"] = 14,
		["69"] = 14,
		["70"] = 14,
		["71"] = 23,
		["73"] = 23,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_102 = c()
local n = g.item_equipment_102
n.name = "item_equipment_102"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_102"
end
function n.prototype.GetCooldown(self, o)
	return self:GetSpecialValueFor("text_cd")
end
n = e({ j(nil) }, n)
g.item_equipment_102 = n
g.modifier_item_equipment_102 = c()
local p = g.modifier_item_equipment_102
p.name = "modifier_item_equipment_102"
d(p, l)
function p.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.mana_burn = self:GetAbilitySpecialValueFor("mana_burn")
	self.text_cd = self:GetAbilitySpecialValueFor("text_cd")
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function p.prototype.OnCustomAttackLanded(self, q)
	if IsServer() then
		local r = q.target
		local s = self:GetAbility()
		if s and s:IsCooldownReady() and self:PRD(self.chance) then
			local t = self:GetAbility()
			if t ~= nil then
				t:StartCooldown(-1)
			end
			ReduceMana(r, self.mana_burn, self:GetAbility())
		end
	end
end
p = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	p
)
g.modifier_item_equipment_102 = p
return g