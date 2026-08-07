--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_59"
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
		["28"] = 21,
		["29"] = 12,
		["30"] = 21,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 24,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["39"] = 29,
		["40"] = 28,
		["41"] = 33,
		["42"] = 34,
		["44"] = 34,
		["45"] = 34,
		["47"] = 34,
		["48"] = 35,
		["50"] = 35,
		["52"] = 36,
		["53"] = 36,
		["54"] = 36,
		["55"] = 36,
		["56"] = 36,
		["57"] = 36,
		["58"] = 36,
		["59"] = 37,
		["60"] = 37,
		["61"] = 37,
		["62"] = 37,
		["63"] = 37,
		["64"] = 37,
		["65"] = 37,
		["67"] = 33,
		["68"] = 40,
		["69"] = 41,
		["70"] = 40,
		["71"] = 45,
		["72"] = 46,
		["74"] = 46,
		["75"] = 46,
		["77"] = 46,
		["78"] = 47,
		["80"] = 45,
		["81"] = 21,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 12,
		["87"] = 12,
		["88"] = 12,
		["89"] = 12,
		["90"] = 12,
		["91"] = 21,
		["93"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_59 = c()
local n = g.item_equipment_59
n.name = "item_equipment_59"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_59"
end
n = e({ j(nil) }, n)
g.item_equipment_59 = n
g.modifier_item_equipment_59 = c()
local o = g.modifier_item_equipment_59
o.name = "modifier_item_equipment_59"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
	self.hit_bonus = self:GetAbilitySpecialValueFor("hit_bonus")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomTakeDamage(self, p)
	local q = p
	if q then
		local r = self:GetAbility()
		q = r and r:IsCooldownReady()
	end
	if q and p.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		local s = self:GetAbility()
		if s ~= nil then
			s:StartCooldown(-1)
		end
		self:GetParent():DealDamage(
			p.target,
			self:GetAbility(),
			self.damage_bonus,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			DamageFlags.DAMAGE_FLAG_NO_CRIT
		)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, p.target, self.damage_bonus, nil)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION }
end
function o.prototype.EOM_GetModifierIgnoreEvasion(self, t)
	local u = t.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
	if u then
		local v = self:GetAbility()
		u = v and v:IsCooldownReady()
	end
	if u then
		return self.hit_bonus
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
g.modifier_item_equipment_59 = o
return g