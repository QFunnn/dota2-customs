--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_25"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 23,
		["37"] = 27,
		["38"] = 28,
		["39"] = 27,
		["40"] = 32,
		["41"] = 33,
		["42"] = 32,
		["43"] = 20,
		["44"] = 12,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 20,
		["54"] = 20,
		["55"] = 37,
		["56"] = 38,
		["57"] = 37,
		["58"] = 38,
		["59"] = 39,
		["60"] = 40,
		["61"] = 41,
		["62"] = 42,
		["63"] = 39,
		["64"] = 38,
		["65"] = 37,
		["66"] = 38,
		["68"] = 38,
		["69"] = 46,
		["70"] = 56,
		["71"] = 46,
		["72"] = 56,
		["73"] = 58,
		["74"] = 59,
		["75"] = 58,
		["76"] = 61,
		["77"] = 62,
		["78"] = 61,
		["79"] = 56,
		["80"] = 46,
		["81"] = 46,
		["82"] = 46,
		["83"] = 46,
		["84"] = 46,
		["85"] = 46,
		["86"] = 46,
		["87"] = 46,
		["88"] = 46,
		["89"] = 46,
		["90"] = 56,
		["92"] = 56,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.neutral_talent_25 = c()
local q = g.neutral_talent_25
q.name = "neutral_talent_25"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_25"
end
q = e({ j(nil) }, q)
g.neutral_talent_25 = q
g.modifier_neutral_talent_25 = c()
local r = g.modifier_neutral_talent_25
r.name = "modifier_neutral_talent_25"
d(r, m)
function r.prototype.GetAbilitySpecialValue(self)
	self.hp_loss = self:GetAbilitySpecialValueFor("hp_loss")
	self.atk_speed_bonus = self:GetAbilitySpecialValueFor("atk_speed_bonus")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function r.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return math.floor((self:GetParent():GetMaxHealth() - self:GetParent():GetHealth()) / self.hp_loss)
		* self.atk_speed_bonus
end
r = e(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	r
)
g.modifier_neutral_talent_25 = r
g.neutral_ult_25 = c()
local s = g.neutral_ult_25
s.name = "neutral_ult_25"
d(s, o)
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = self:GetSpecialValueFor("duration")
	t:AddNewModifier(t, self, "modifier_neutral_ult_25", { duration = u })
end
s = e({ p(nil) }, s)
g.neutral_ult_25 = s
g.modifier_neutral_ult_25 = c()
local v = g.modifier_neutral_ult_25
v.name = "modifier_neutral_ult_25"
d(v, m)
function v.prototype.GetAbilitySpecialValue(self)
	self.attack_bonus = self:GetAbilitySpecialValueFor("attack_bonus")
end
function v.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack_bonus }
end
v = e(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	v
)
g.modifier_neutral_ult_25 = v
return g