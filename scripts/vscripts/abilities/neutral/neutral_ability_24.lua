--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_24"
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
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 24,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 30,
		["43"] = 29,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 39,
		["51"] = 41,
		["52"] = 42,
		["53"] = 42,
		["54"] = 42,
		["55"] = 42,
		["56"] = 42,
		["57"] = 42,
		["58"] = 43,
		["59"] = 43,
		["60"] = 43,
		["61"] = 43,
		["62"] = 43,
		["63"] = 43,
		["65"] = 34,
		["66"] = 20,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 20,
		["77"] = 20,
		["78"] = 48,
		["79"] = 49,
		["80"] = 48,
		["81"] = 49,
		["82"] = 50,
		["83"] = 51,
		["84"] = 52,
		["85"] = 54,
		["86"] = 50,
		["87"] = 49,
		["88"] = 48,
		["89"] = 49,
		["91"] = 49,
		["92"] = 58,
		["93"] = 68,
		["94"] = 58,
		["95"] = 68,
		["96"] = 71,
		["97"] = 72,
		["98"] = 73,
		["99"] = 71,
		["100"] = 75,
		["101"] = 76,
		["102"] = 77,
		["104"] = 75,
		["105"] = 80,
		["106"] = 81,
		["107"] = 80,
		["108"] = 68,
		["109"] = 58,
		["110"] = 58,
		["111"] = 58,
		["112"] = 58,
		["113"] = 58,
		["114"] = 58,
		["115"] = 58,
		["116"] = 58,
		["117"] = 58,
		["118"] = 58,
		["119"] = 68,
		["121"] = 68,
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
g.neutral_talent_24 = c()
local q = g.neutral_talent_24
q.name = "neutral_talent_24"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_24"
end
q = e({ j(nil) }, q)
g.neutral_talent_24 = q
g.modifier_neutral_talent_24 = c()
local r = g.modifier_neutral_talent_24
r.name = "modifier_neutral_talent_24"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.stun_duration = self:GetAbilitySpecialValueFor("stun_duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAttackLanded(self, s)
	local t = self.chance
	local u = self:GetParent()
	local v = u:FindModifierByName("modifier_neutral_ult_24")
	if IsValid(v) and v:GetStackCount() > 0 then
		t = t * v:GetStackCount()
	end
	if self:PRD(t) and IsInjurable(s.target) then
		AddStun(s.attacker, s.target, self:GetAbility(), self.stun_duration)
		s.attacker:DealDamage(s.target, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
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
g.modifier_neutral_talent_24 = r
g.neutral_ult_24 = c()
local w = g.neutral_ult_24
w.name = "neutral_ult_24"
d(w, o)
function w.prototype.OnSpellStart(self)
	local x = self:GetCaster()
	local y = self:GetSpecialValueFor("duration")
	x:AddNewModifier(x, self, "modifier_neutral_ult_24", { duration = y })
end
w = e({ p(nil) }, w)
g.neutral_ult_24 = w
g.modifier_neutral_ult_24 = c()
local z = g.modifier_neutral_ult_24
z.name = "modifier_neutral_ult_24"
d(z, l)
function z.prototype.GetAbilitySpecialValue(self)
	self.atk_speed_bonus = self:GetAbilitySpecialValueFor("atk_speed_bonus")
	self.talent_param = self:GetAbilitySpecialValueFor("talent_param")
end
function z.prototype.OnCreated(self, A)
	if IsServer() then
		self:SetStackCount(self.talent_param)
	end
end
function z.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.atk_speed_bonus }
end
z = e(
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
	z
)
g.modifier_neutral_ult_24 = z
return g