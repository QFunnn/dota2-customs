--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_dungeon_sand_tornado"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_dungeon_sand_tornado"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.moveSpeed = 100
	self.direction = vec3_zero
	self.damageRadius = 260
	self.damageInterval = 0.5
	self.nextDamageTime = 0
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.direction = RandomVector(1):Normalized()
		self:PlayEffects()
		self.nextDamageTime = GameRules:GetGameTime() + self.damageInterval
		if not self:ApplyHorizontalMotionController() then
			self:Destroy()
			return
		end
		self:StartIntervalThink(self.damageInterval)
	end
end
function j.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateDamage()
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local l = self:GetParent()
		l:RemoveHorizontalMotionController(self)
		if IsValid(l) then
			StopSoundOn("TrapSandTornado", l)
			l:Kill(self.ability, l)
		end
	end
end
function j.prototype.PlayEffects(self)
	local l = self:GetParent()
	EmitSoundOn("TrapSandTornado", l)
	local m = ParticleManager:CreateParticle("particles/traps/tornado/tornado_fx.vpcf", PATTACH_ABSORIGIN_FOLLOW, l)
	ParticleManager:SetParticleControlEnt(m, 0, l, PATTACH_ABSORIGIN_FOLLOW, nil, l:GetAbsOrigin(), false)
	ParticleManager:SetParticleControlEnt(m, 1, l, PATTACH_ABSORIGIN_FOLLOW, nil, l:GetAbsOrigin(), false)
	self:AddParticle(m, false, false, -1, false, false)
end
function j.prototype.UpdateHorizontalMotion(self, l, n)
	if not IsServer() or not IsValid(l) then
		return
	end
	if self.direction:Length2D() <= 0 then
		self:TryRefreshDirection(l:GetAbsOrigin())
		return
	end
	local o = l:GetAbsOrigin()
	local p = o + self.direction * self.moveSpeed * n
	if not self:CanMoveTo(p) then
		self:TryRefreshDirection(o)
		return
	end
	l:SetAbsOrigin(p)
end
function j.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function j.prototype.TryRefreshDirection(self, o)
	do
		local q = 0
		while q < 16 do
			do
				local r = RandomVector(1):Normalized()
				local s = o + r * 180
				if not self:CanMoveTo(s) then
					goto t
				end
				self.direction = r
				return true
			end
			::t::
			q = q + 1
		end
	end
	return false
end
function j.prototype.UpdateDamage(self)
	local u = self:GetCaster()
	local l = self:GetParent()
	if not IsValid(u) or not IsValid(l) or self.damageFunc == nil then
		return
	end
	local v = GameRules:GetGameTime()
	if v < self.nextDamageTime then
		return
	end
	self.nextDamageTime = v + self.damageInterval
	local w = FindUnitsInRadius(
		l:GetTeamNumber(),
		l:GetAbsOrigin(),
		nil,
		self.damageRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	do
		local q = 0
		while q < #w do
			do
				local x = w[q + 1]
				if not IsValid(x) or x == l or x == u then
					goto y
				end
				u:DealDamage(x, nil, self:damageFunc(x), nil, EOM_DAMAGE_FLAGS.TRAP)
			end
			::y::
			q = q + 1
		end
	end
end
function j.prototype.CanMoveTo(self, z)
	if not GridNav:IsValidPosition(z) then
		return false
	end
	return GridNav:IsTraversable(z) and not GridNav:IsBlocked(z)
end
function j.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function j.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				GetAttributes = MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	j
)
return f