--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_96"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 23,
		["33"] = 27,
		["34"] = 28,
		["35"] = 27,
		["36"] = 33,
		["37"] = 34,
		["38"] = 33,
		["39"] = 39,
		["40"] = 40,
		["41"] = 39,
		["42"] = 43,
		["43"] = 44,
		["44"] = 45,
		["45"] = 46,
		["46"] = 47,
		["47"] = 48,
		["48"] = 49,
		["50"] = 52,
		["54"] = 43,
		["55"] = 58,
		["56"] = 59,
		["57"] = 58,
		["58"] = 20,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 20,
		["70"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_96 = c()
local n = g.item_equipment_96
n.name = "item_equipment_96"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_96"
end
n = e({ j(nil) }, n)
g.item_equipment_96 = n
g.modifier_item_equipment_96 = c()
local o = g.modifier_item_equipment_96
o.name = "modifier_item_equipment_96"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.bonus_attack = self:GetAbilitySpecialValueFor("bonus_attack")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function o.prototype.OnBattleStart(self, p)
	self:StartIntervalThink(0)
end
function o.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	if IsValid(q) and q.GetEnemy then
		local r = q:GetEnemy()
		if IsValid(r) then
			if r:GetHealth() > q:GetHealth() then
				self:SetStackCount(1)
			else
				self:SetStackCount(0)
			end
		end
	end
end
function o.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount() * self.bonus_attack
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
g.modifier_item_equipment_96 = o
return g