--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_18"
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
		["13"] = 4,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 6,
		["20"] = 6,
		["21"] = 6,
		["22"] = 7,
		["23"] = 5,
		["24"] = 12,
		["25"] = 21,
		["26"] = 12,
		["27"] = 21,
		["28"] = 30,
		["29"] = 31,
		["30"] = 32,
		["31"] = 33,
		["32"] = 34,
		["33"] = 35,
		["34"] = 36,
		["35"] = 30,
		["36"] = 38,
		["37"] = 39,
		["38"] = 40,
		["40"] = 38,
		["41"] = 43,
		["42"] = 44,
		["43"] = 44,
		["44"] = 44,
		["45"] = 44,
		["46"] = 44,
		["47"] = 44,
		["48"] = 44,
		["49"] = 44,
		["50"] = 43,
		["51"] = 53,
		["52"] = 54,
		["53"] = 53,
		["54"] = 56,
		["55"] = 57,
		["56"] = 56,
		["57"] = 59,
		["58"] = 60,
		["59"] = 59,
		["60"] = 62,
		["61"] = 63,
		["62"] = 62,
		["63"] = 65,
		["64"] = 66,
		["65"] = 65,
		["66"] = 68,
		["67"] = 69,
		["68"] = 68,
		["69"] = 21,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 21,
		["81"] = 21,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_18 = c()
local m = g.greevil_effect_18
m.name = "greevil_effect_18"
d(m, l)
function m.prototype.spawn(self)
	self:addProperty("item_health", self:getSpecialValueFor("health_bonus"))
	self:AddBattleBuff("modifier_greevil_effect_18")
end
g.modifier_greevil_effect_18 = c()
local n = g.modifier_greevil_effect_18
n.name = "modifier_greevil_effect_18"
d(n, i)
function n.prototype.GetAbilitySpecialValue(self)
	self.physical_bonus_pct = self:GetGreevilEffectValueFor("greevil_effect_18", "physical_bonus_pct")
	self.magic_bonus_pct = self:GetGreevilEffectValueFor("greevil_effect_18", "magic_bonus_pct")
	self.physical_reduce_pct = self:GetGreevilEffectValueFor("greevil_effect_18", "physical_reduce_pct")
	self.magic_reduce_pct = self:GetGreevilEffectValueFor("greevil_effect_18", "magic_reduce_pct")
	self.attackspeed_bonus = self:GetGreevilEffectValueFor("greevil_effect_18", "attackspeed_bonus")
	self.mana_reply_bonus = self:GetGreevilEffectValueFor("greevil_effect_18", "mana_reply_bonus")
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
	end
end
function n.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS,
	}
end
function n.prototype.EOM_GetModifierOutgoingPhysicalDamagePercentage(self)
	return self.physical_bonus_pct
end
function n.prototype.EOM_GetModifierOutgoingMagicalDamagePercentage(self)
	return self.magic_bonus_pct
end
function n.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self)
	return -self.physical_reduce_pct
end
function n.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return -self.magic_reduce_pct
end
function n.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self.attackspeed_bonus
end
function n.prototype.EOM_GetModifierManaRegenBonus(self)
	return self.mana_reply_bonus
end
n = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	n
)
g.modifier_greevil_effect_18 = n
return g