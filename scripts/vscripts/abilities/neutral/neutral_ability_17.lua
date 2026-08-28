--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_17"
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
		["39"] = 29,
		["40"] = 29,
		["41"] = 28,
		["42"] = 27,
		["43"] = 32,
		["44"] = 33,
		["45"] = 34,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 34,
		["50"] = 34,
		["52"] = 32,
		["53"] = 20,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 20,
		["64"] = 20,
		["65"] = 39,
		["66"] = 40,
		["67"] = 39,
		["68"] = 40,
		["69"] = 41,
		["70"] = 42,
		["71"] = 43,
		["72"] = 41,
		["73"] = 40,
		["74"] = 39,
		["75"] = 40,
		["77"] = 40,
		["78"] = 47,
		["79"] = 55,
		["80"] = 47,
		["81"] = 55,
		["82"] = 59,
		["83"] = 60,
		["84"] = 61,
		["85"] = 62,
		["86"] = 59,
		["87"] = 64,
		["88"] = 65,
		["89"] = 66,
		["90"] = 67,
		["92"] = 64,
		["93"] = 70,
		["94"] = 71,
		["95"] = 72,
		["97"] = 70,
		["98"] = 75,
		["99"] = 76,
		["100"] = 75,
		["101"] = 80,
		["102"] = 81,
		["103"] = 80,
		["104"] = 87,
		["105"] = 88,
		["106"] = 89,
		["107"] = 89,
		["108"] = 88,
		["109"] = 87,
		["110"] = 92,
		["111"] = 93,
		["112"] = 94,
		["113"] = 95,
		["115"] = 92,
		["116"] = 55,
		["117"] = 47,
		["118"] = 47,
		["119"] = 47,
		["120"] = 47,
		["121"] = 47,
		["122"] = 47,
		["123"] = 47,
		["124"] = 47,
		["125"] = 55,
		["127"] = 55,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.neutral_talent_17 = c()
local q = g.neutral_talent_17
q.name = "neutral_talent_17"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_17"
end
q = e({ j(nil) }, q)
g.neutral_talent_17 = q
g.modifier_neutral_talent_17 = c()
local r = g.modifier_neutral_talent_17
r.name = "modifier_neutral_talent_17"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAttackLanded(self, s)
	if s and self:PRD(self.chance) and IsInjurable(s.target) then
		self:GetParent():DealDamage(s.target, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	end
end
r = e(
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
			}
		),
	},
	r
)
g.modifier_neutral_talent_17 = r
g.neutral_ult_17 = c()
local t = g.neutral_ult_17
t.name = "neutral_ult_17"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	u:AddNewModifier(u, self, "modifier_neutral_ult_17", nil)
end
t = e({ p(nil) }, t)
g.neutral_ult_17 = t
g.modifier_neutral_ult_17 = c()
local v = g.modifier_neutral_ult_17
v.name = "modifier_neutral_ult_17"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.atk_speed_bonus = self:GetAbilitySpecialValueFor("atk_speed_bonus")
	self.attack_bonus = self:GetAbilitySpecialValueFor("attack_bonus")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function v.prototype.OnCreated(self, w)
	local x = self:GetParent()
	if IsServer() then
		self:SetStackCount(self.count)
	end
end
function v.prototype.OnRefresh(self, w)
	if IsServer() then
		self:IncrementStackCount(self.count)
	end
end
function v.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function v.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack_bonus,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.atk_speed_bonus,
	}
end
function v.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function v.prototype.OnCustomAttackLanded(self, s)
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
v = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	v
)
g.modifier_neutral_ult_17 = v
return g