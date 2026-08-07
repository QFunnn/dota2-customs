--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_poison_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 4,
		["12"] = 12,
		["13"] = 4,
		["14"] = 12,
		["15"] = 13,
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["19"] = 17,
		["20"] = 17,
		["21"] = 17,
		["22"] = 17,
		["24"] = 20,
		["25"] = 20,
		["26"] = 20,
		["27"] = 20,
		["28"] = 20,
		["29"] = 21,
		["30"] = 21,
		["31"] = 21,
		["32"] = 21,
		["33"] = 21,
		["34"] = 21,
		["35"] = 21,
		["36"] = 21,
		["38"] = 13,
		["39"] = 24,
		["40"] = 25,
		["41"] = 26,
		["43"] = 24,
		["44"] = 29,
		["45"] = 30,
		["46"] = 31,
		["47"] = 31,
		["48"] = 30,
		["49"] = 29,
		["50"] = 34,
		["51"] = 35,
		["52"] = 36,
		["54"] = 34,
		["55"] = 39,
		["56"] = 39,
		["57"] = 39,
		["59"] = 40,
		["60"] = 41,
		["61"] = 42,
		["62"] = 43,
		["63"] = 44,
		["64"] = 45,
		["65"] = 45,
		["66"] = 45,
		["67"] = 45,
		["68"] = 45,
		["69"] = 45,
		["71"] = 47,
		["72"] = 47,
		["73"] = 47,
		["74"] = 47,
		["75"] = 47,
		["76"] = 47,
		["77"] = 48,
		["78"] = 50,
		["79"] = 51,
		["80"] = 51,
		["81"] = 51,
		["82"] = 51,
		["83"] = 51,
		["84"] = 52,
		["85"] = 52,
		["86"] = 52,
		["87"] = 52,
		["88"] = 52,
		["89"] = 52,
		["90"] = 52,
		["91"] = 52,
		["92"] = 52,
		["94"] = 55,
		["95"] = 56,
		["96"] = 57,
		["98"] = 59,
		["99"] = 62,
		["100"] = 62,
		["101"] = 62,
		["102"] = 62,
		["103"] = 63,
		["104"] = 64,
		["105"] = 65,
		["106"] = 66,
		["107"] = 67,
		["110"] = 39,
		["111"] = 12,
		["112"] = 4,
		["113"] = 4,
		["114"] = 4,
		["115"] = 4,
		["116"] = 4,
		["117"] = 4,
		["118"] = 4,
		["119"] = 4,
		["120"] = 12,
		["122"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_poison_custom = c()
local k = g.modifier_poison_custom
k.name = "modifier_poison_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self:SetStackCount(l.iStackCount)
		self:StartIntervalThink(
			POISON_INTERVAL
				+ GetModifierProperty(self:GetCaster(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_INTERVAL)
		)
	else
		local n = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_venomancer/venomancer_poison_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(n, false, false, -1, false, false)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:IncrementStackCount(l.iStackCount)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function k.prototype.OnBattleEnd(self, l)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function k.prototype.OnIntervalThink(self, o, p, q)
	if q == nil then
		q = false
	end
	local r = self:GetParent()
	local s = self:GetCaster()
	if IsValid(s) then
		local t = self:GetStackCount() * (1 + GetPoisonDamagePercent(s) * 0.01)
			+ GetPoisonDamage(s)
			+ GetPoisonDamageTarget(r)
		if o then
			Heal(s, t * o * 0.01, p:GetAbilityName(), "Ability")
		end
		s:DealDamage(r, s:FindAbilityByName("sect_poison"), t, EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON)
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE, { damage = t }, s, r)
		local u = ParticleManager:CreateParticle("particles/msg_fx/msg_sect_poison.vpcf", PATTACH_ABSORIGIN, r)
		ParticleManager:SetParticleControl(u, 1, Vector(0, t, 5))
		ParticleManager:SetParticleControl(u, 2, Vector(1, #tostring(math.floor(t)) + 1, 0))
	end
	local v = math.ceil(self:GetStackCount() * POISON_ATTENUATION.Percentage) + POISON_ATTENUATION.Const
	if q then
		v = 0
	end
	local w = 1
		+ GetModifierProperty(
				r,
				EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_ATTENUATION_PERCENTAGE,
				{ unit = r }
			)
			* 0.01
	v = math.max(0, math.ceil(v * w))
	if v > 0 then
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_POISON_LOSS, { iCount = v }, s, r)
		self:DecrementStackCount(v)
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_poison_custom = k
return g