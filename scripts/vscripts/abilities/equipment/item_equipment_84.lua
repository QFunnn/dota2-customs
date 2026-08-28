--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_84"
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
		["32"] = 26,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["36"] = 33,
		["37"] = 30,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 38,
		["42"] = 38,
		["43"] = 37,
		["44"] = 37,
		["45"] = 40,
		["46"] = 40,
		["47"] = 40,
		["48"] = 37,
		["49"] = 37,
		["50"] = 36,
		["51"] = 44,
		["52"] = 45,
		["53"] = 44,
		["54"] = 48,
		["55"] = 49,
		["56"] = 48,
		["57"] = 52,
		["58"] = 53,
		["59"] = 54,
		["60"] = 55,
		["61"] = 56,
		["62"] = 56,
		["63"] = 56,
		["64"] = 56,
		["65"] = 56,
		["66"] = 56,
		["68"] = 58,
		["69"] = 52,
		["70"] = 61,
		["71"] = 62,
		["72"] = 63,
		["73"] = 64,
		["76"] = 61,
		["77"] = 68,
		["78"] = 69,
		["79"] = 68,
		["80"] = 73,
		["81"] = 74,
		["82"] = 73,
		["83"] = 20,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 11,
		["91"] = 11,
		["92"] = 11,
		["93"] = 20,
		["95"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_84 = c()
local n = g.item_equipment_84
n.name = "item_equipment_84"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_84"
end
n = e({ j(nil) }, n)
g.item_equipment_84 = n
g.modifier_item_equipment_84 = c()
local o = g.modifier_item_equipment_84
o.name = "modifier_item_equipment_84"
d(o, l)
function o.prototype.OnCreated(self, p)
	self.damage_pool = 0
end
function o.prototype.GetAbilitySpecialValue(self)
	self.long_shield_count = self:GetAbilitySpecialValueFor("long_shield_count")
	self.convert_pct = self:GetAbilitySpecialValueFor("convert_pct")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self, p)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	if self.damage_pool > 0 then
		local q = self:GetParent()
		local r = self.damage_pool * self.convert_pct * 0.01
		AddShield(q, r, self:GetAbility():GetAbilityName(), "Ability")
	end
	self.damage_pool = 0
end
function o.prototype.OnCustomTakeDamage(self, s)
	if IsServer() then
		if s.damage > 0 then
			self.damage_pool = self.damage_pool + s.damage
		end
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
function o.prototype.EOM_GetModifierShieldPermanent(self, p)
	return self.long_shield_count
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
g.modifier_item_equipment_84 = o
return g