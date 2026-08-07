--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_respawn"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_respawn"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsClient() then
		local l = ParticleManager:CreateParticleForce(
			"particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(l, 1, Vector(self:GetDuration(), 0, 0))
		self:AddParticle(l, false, false, -1, false, false)
		local m = ParticleManager:CreateParticleForce(
			"particles/status_fx/status_effect_wraithking_ghosts.vpcf",
			PATTACH_INVALID,
			self:GetParent()
		)
		self:AddParticle(m, false, true, 10, false, false)
	else
		self:GetParent():EmitSound("Hero_Abaddon.BorrowedTime")
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local n = self:GetParent()
		if IsValid(n) then
			Event:Fire("hero_respawn", { playerID = n:GetPlayerOwnerID(), unit = n })
		end
	end
end
function j.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function j.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
	}
end
function j.prototype.GetModifierMoveSpeed_Absolute(self)
	return 300
end
function j.prototype.GetActivityTranslationModifiers(self)
	return "respawn"
end
function j.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_SPAWN
end
function j.prototype.GetVisualZDelta(self)
	local o = self:GetElapsedTime()
	if o <= 1 then
		return 0
	end
	local p = self:GetDuration()
	if p <= 1 or p < 0 then
		return 0
	end
	local q = math.min(1, math.max(0, (o - 1) / (p - 1)))
	local r = 1 - math.abs(2 * q - 1)
	return 100 * r
end
function j.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_STUNNED] = self:GetElapsedTime() < 1,
		[MODIFIER_STATE_ROOTED] = self:GetElapsedTime() < 1,
	}
end
j = e(
	{ i(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	j
)
return f