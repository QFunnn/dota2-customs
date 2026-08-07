--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_103"
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
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 26,
		["36"] = 33,
		["37"] = 34,
		["38"] = 34,
		["39"] = 36,
		["40"] = 36,
		["41"] = 36,
		["42"] = 34,
		["43"] = 34,
		["44"] = 33,
		["45"] = 40,
		["46"] = 41,
		["49"] = 44,
		["50"] = 40,
		["51"] = 47,
		["52"] = 48,
		["55"] = 51,
		["56"] = 52,
		["57"] = 53,
		["58"] = 54,
		["59"] = 54,
		["60"] = 54,
		["61"] = 54,
		["62"] = 54,
		["63"] = 54,
		["64"] = 55,
		["65"] = 56,
		["66"] = 57,
		["67"] = 57,
		["68"] = 57,
		["69"] = 57,
		["70"] = 57,
		["71"] = 57,
		["72"] = 57,
		["74"] = 59,
		["76"] = 47,
		["77"] = 20,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 20,
		["89"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_103 = c()
local n = g.item_equipment_103
n.name = "item_equipment_103"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_103"
end
n = e({ j(nil) }, n)
g.item_equipment_103 = n
g.modifier_item_equipment_103 = c()
local o = g.modifier_item_equipment_103
o.name = "modifier_item_equipment_103"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.heal = self:GetAbilitySpecialValueFor("heal")
	self.ice = self:GetAbilitySpecialValueFor("ice")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	self:SetStackCount(self.count)
end
function o.prototype.OnCustomTakeDamage(self, q)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = self:GetAbility()
	if self:GetStackCount() > 0 and r:GetHealthPercent() <= self.threshold then
		Heal(r, self.heal, s:GetAbilityName(), "Ability")
		local t = q.attacker
		if IsValid(t) and IsInjurable(t) then
			AddIce(r, t, self.ice, s:GetAbilityName(), "Ability")
		end
		self:DecrementStackCount()
	end
end
o = e(
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
	o
)
g.modifier_item_equipment_103 = o
return g