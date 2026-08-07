--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_30"
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
		["40"] = 29,
		["41"] = 34,
		["42"] = 35,
		["43"] = 36,
		["44"] = 37,
		["46"] = 37,
		["47"] = 37,
		["49"] = 37,
		["50"] = 38,
		["51"] = 39,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 40,
		["56"] = 40,
		["57"] = 40,
		["58"] = 40,
		["59"] = 40,
		["61"] = 45,
		["63"] = 45,
		["66"] = 34,
		["67"] = 20,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 20,
		["78"] = 20,
		["79"] = 50,
		["80"] = 51,
		["81"] = 50,
		["82"] = 51,
		["83"] = 52,
		["84"] = 53,
		["85"] = 54,
		["86"] = 55,
		["87"] = 56,
		["88"] = 57,
		["89"] = 58,
		["91"] = 60,
		["92"] = 61,
		["93"] = 52,
		["94"] = 51,
		["95"] = 50,
		["96"] = 51,
		["98"] = 51,
		["99"] = 65,
		["100"] = 75,
		["101"] = 65,
		["102"] = 75,
		["103"] = 78,
		["104"] = 79,
		["105"] = 80,
		["106"] = 78,
		["107"] = 82,
		["108"] = 83,
		["109"] = 84,
		["111"] = 82,
		["112"] = 87,
		["113"] = 88,
		["114"] = 87,
		["115"] = 75,
		["116"] = 65,
		["117"] = 65,
		["118"] = 65,
		["119"] = 65,
		["120"] = 65,
		["121"] = 65,
		["122"] = 65,
		["123"] = 65,
		["124"] = 65,
		["125"] = 65,
		["126"] = 75,
		["128"] = 75,
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
g.neutral_talent_30 = c()
local q = g.neutral_talent_30
q.name = "neutral_talent_30"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_30"
end
q = e({ j(nil) }, q)
g.neutral_talent_30 = q
g.modifier_neutral_talent_30 = c()
local r = g.modifier_neutral_talent_30
r.name = "modifier_neutral_talent_30"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent() } }
end
function r.prototype.OnIceGained(self)
	local s = self:GetParent()
	local t = s:GetEnemy()
	local u = IsInjurable(t)
	if u then
		local v = self:GetAbility()
		u = v and v:IsCooldownReady()
	end
	if u and self:PRD(self.chance) then
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 200)
		if IsInjurable(t) then
			DamageSystem:performAttack(
				s,
				t,
				{ damage = GetAttackDamage(s) * self.damage_pct * 0.01, ability = self:GetAbility() }
			)
		end
		local w = self:GetAbility()
		if w ~= nil then
			w:StartCooldown(self.interval)
		end
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
g.modifier_neutral_talent_30 = r
g.neutral_ult_30 = c()
local x = g.neutral_ult_30
x.name = "neutral_ult_30"
d(x, o)
function x.prototype.OnSpellStart(self)
	local y = self:GetCaster()
	local z = y:GetEnemy()
	local A = z:FindModifierByName("modifier_ice_custom")
	local B = 0
	if IsValid(A) then
		B = A:GetStackCount()
	end
	local C = self:GetSpecialValueFor("duration")
	y:AddNewModifier(y, self, "modifier_neutral_ult_30", { duration = C, iStackCounts = B })
end
x = e({ p(nil) }, x)
g.neutral_ult_30 = x
g.modifier_neutral_ult_30 = c()
local D = g.modifier_neutral_ult_30
D.name = "modifier_neutral_ult_30"
d(D, l)
function D.prototype.GetAbilitySpecialValue(self)
	self.atk_bonus_ice = self:GetAbilitySpecialValueFor("atk_bonus_ice")
	self.base_attack = self:GetAbilitySpecialValueFor("base_attack")
end
function D.prototype.OnCreated(self, E)
	if IsServer() then
		self:SetStackCount(E.iStackCounts)
	end
end
function D.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.base_attack
			+ self:GetStackCount() * self.atk_bonus_ice * 0.01,
	}
end
D = e(
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
	D
)
g.modifier_neutral_ult_30 = D
return g