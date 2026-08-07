--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_7"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["38"] = 31,
		["39"] = 30,
		["40"] = 29,
		["41"] = 34,
		["42"] = 35,
		["44"] = 35,
		["45"] = 35,
		["47"] = 35,
		["48"] = 36,
		["50"] = 36,
		["52"] = 37,
		["53"] = 37,
		["54"] = 37,
		["55"] = 37,
		["56"] = 37,
		["57"] = 37,
		["58"] = 37,
		["59"] = 38,
		["60"] = 38,
		["61"] = 38,
		["62"] = 38,
		["63"] = 38,
		["64"] = 38,
		["65"] = 38,
		["66"] = 39,
		["67"] = 40,
		["68"] = 40,
		["69"] = 40,
		["70"] = 40,
		["71"] = 40,
		["72"] = 40,
		["75"] = 34,
		["76"] = 20,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 20,
		["88"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_7 = c()
local n = g.item_equipment_7
n.name = "item_equipment_7"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_7"
end
n = e({ j(nil) }, n)
g.item_equipment_7 = n
g.modifier_item_equipment_7 = c()
local o = g.modifier_item_equipment_7
o.name = "modifier_item_equipment_7"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	local q = p
	if q then
		local r = self:GetAbility()
		q = r and r:IsCooldownReady()
	end
	if q and self:PRD(self.chance) then
		local s = self:GetAbility()
		if s ~= nil then
			s:StartCooldown(-1)
		end
		self:GetParent():DealDamage(
			p.target,
			self:GetAbility(),
			self.damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			DamageFlags.DAMAGE_FLAG_NO_CRIT
		)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, p.target, self.damage, nil)
		if IsInjurable(p.target) then
			AddSilence(self:GetParent(), p.target, self:GetAbility(), self.duration)
		end
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
g.modifier_item_equipment_7 = o
return g