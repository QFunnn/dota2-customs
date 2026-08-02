--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_poison_pool"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_poison_pool"
d(j, h)
function j.prototype.IsAura(self)
	return true
end
function j.prototype.GetAuraRadius(self)
	return self.radius
end
function j.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function j.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function j.prototype.GetModifierAura(self)
	return "modifier_poison_pool_buff"
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.poison = k.stack
		self.radius = k.radius
		self.entIndex = k.entIndex
		self:StartIntervalThink(1)
		self.parent:EmitSound("Hero_Viper.Nethertoxin.Cast")
		local l = ParticleManager:CreateParticle(
			"particles/units/benediction/poison_pool.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControl(l, 1, Vector(self.radius, 0, 0))
		self:AddParticle(l, false, false, -1, false, false)
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
function j.prototype.OnIntervalThink(self)
	local m = self:GetCaster()
	if IsValid(m) then
		local n = FindUnitsInRadius(
			m:GetTeamNumber(),
			self.parent:GetAbsOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for o, p in ipairs(n) do
			m:Poison(p, self.poison)
		end
	end
end
j = e(
	{ i(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	j
)
local q = c()
q.name = "modifier_poison_pool_buff"
d(q, h)
function q.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
end
function q.prototype.StaticProperty(self)
	local m = self:GetCaster()
	local r = self:GetParent()
	if not IsValid(m) then
		return {}
	end
	return {
		[PropertyFunction.SHIELD_ATTENUATION_INTERVAL_AMPLIFY] = m:IsFriendly(r)
				and GetPoisonPoolShieldAttenuationIntervalAmplify(m)
			or 0,
		[PropertyFunction.INCOMING_DAMAGE_AMPLIFY] = not m:IsFriendly(r) and GetPoisonPoolIncomingDamageAmplify(m) or 0,
	}
end
q = e(
	{ i(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
return f