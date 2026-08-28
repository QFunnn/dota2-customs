--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_23"
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
		["72"] = 45,
		["73"] = 41,
		["74"] = 40,
		["75"] = 39,
		["76"] = 40,
		["78"] = 40,
		["79"] = 49,
		["80"] = 59,
		["81"] = 49,
		["82"] = 59,
		["83"] = 63,
		["84"] = 64,
		["85"] = 65,
		["86"] = 66,
		["87"] = 63,
		["88"] = 68,
		["89"] = 69,
		["90"] = 70,
		["92"] = 68,
		["93"] = 73,
		["94"] = 74,
		["95"] = 75,
		["96"] = 76,
		["97"] = 77,
		["98"] = 78,
		["99"] = 78,
		["100"] = 78,
		["101"] = 78,
		["102"] = 78,
		["103"] = 78,
		["106"] = 73,
		["107"] = 59,
		["108"] = 49,
		["109"] = 49,
		["110"] = 49,
		["111"] = 49,
		["112"] = 49,
		["113"] = 49,
		["114"] = 49,
		["115"] = 49,
		["116"] = 49,
		["117"] = 49,
		["118"] = 59,
		["120"] = 59,
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
g.neutral_talent_23 = c()
local q = g.neutral_talent_23
q.name = "neutral_talent_23"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_23"
end
q = e({ j(nil) }, q)
g.neutral_talent_23 = q
g.modifier_neutral_talent_23 = c()
local r = g.modifier_neutral_talent_23
r.name = "modifier_neutral_talent_23"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.shield = self:GetAbilitySpecialValueFor("shield")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function r.prototype.OnCustomTakeDamage(self, s)
	if self:PRD(self.chance) then
		AddShield(self:GetParent(), self.shield, self:GetAbility():GetAbilityName(), "Ability")
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
g.modifier_neutral_talent_23 = r
g.neutral_ult_23 = c()
local t = g.neutral_ult_23
t.name = "neutral_ult_23"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = self:GetSpecialValueFor("duration")
	u:AddNewModifier(u, self, "modifier_neutral_ult_23", { duration = v })
end
t = e({ p(nil) }, t)
g.neutral_ult_23 = t
g.modifier_neutral_ult_23 = c()
local w = g.modifier_neutral_ult_23
w.name = "modifier_neutral_ult_23"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.shield_pct = self:GetAbilitySpecialValueFor("shield_pct")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function w.prototype.OnCreated(self, x)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function w.prototype.OnIntervalThink(self)
	if IsServer() then
		local y = self:GetParent()
		local z = y:GetEnemy()
		if IsInjurable(z) then
			y:DealDamage(
				z,
				self:GetAbility(),
				self.base_damage + GetShield(y) * self.shield_pct * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
			)
		end
	end
end
w = e(
	{
		m(
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
	w
)
g.modifier_neutral_ult_23 = w
return g