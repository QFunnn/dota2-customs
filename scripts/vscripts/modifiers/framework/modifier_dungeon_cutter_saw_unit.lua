--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_dungeon_cutter_saw_unit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_dungeon_cutter_saw_unit"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.moveSpeed = 300
	self.waitDuration = 1
	self.damageRadius = 96
	self.damageInterval = 0.3
	self.segmentStartPosition = vec3_zero
	self.segmentEndPosition = vec3_zero
	self.direction = vec3_zero
	self.waitEndTime = 0
	self.hitRecord = {}
end
function j.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	self.segmentStartPosition = k.start_position ~= nil and StringToVector(k.start_position) or vec3_zero
	self.segmentEndPosition = k.end_position ~= nil and StringToVector(k.end_position) or vec3_zero
	self.direction = (self.segmentEndPosition - self.segmentStartPosition):Normalized()
	local l = self:GetParent()
	l:SetAbsOrigin(self.segmentStartPosition)
	l:Stop()
	if not self:ApplyHorizontalMotionController() then
		print("[CutterSawUnit] ApplyHorizontalMotionController failed")
		self:Destroy()
		return
	end
	self:StartIntervalThink(self.damageInterval)
	EmitSoundOn("TrapSawUnit", l)
end
function j.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateDamage()
end
function j.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local l = self:GetParent()
	l:RemoveHorizontalMotionController(self)
	if IsValid(l) then
		StopSoundOn("TrapSawUnit", l)
		l:Kill(self.ability, l)
	end
end
function j.prototype.UpdateHorizontalMotion(self, l, m)
	if not IsServer() or not IsValid(l) then
		return
	end
	local n = GameRules:GetGameTime()
	if self.waitEndTime > 0 then
		if n < self.waitEndTime then
			return
		end
		self.waitEndTime = 0
	end
	local o = l:GetAbsOrigin()
	local p = self.moveSpeed * m
	local q = (self.segmentEndPosition - o):Length2D()
	if q <= p then
		l:SetAbsOrigin(self.segmentEndPosition)
		self:StartWaitingAtEndpoint()
		return
	end
	local r = o + self.direction * p
	l:SetAbsOrigin(r)
end
function j.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	print("[CutterSawUnit] horizontal motion interrupted")
	self:Destroy()
end
function j.prototype.StartWaitingAtEndpoint(self)
	local s = self.segmentEndPosition
	self.segmentEndPosition = self.segmentStartPosition
	self.segmentStartPosition = s
	self.direction = (self.segmentEndPosition - self.segmentStartPosition):Normalized()
	self.hitRecord = {}
	self.waitEndTime = GameRules:GetGameTime() + self.waitDuration
end
function j.prototype.PlayEffects(self)
	local l = self:GetParent()
	local t = ParticleManager:CreateParticle("particles/traps/tornado/tornado_fx.vpcf", PATTACH_ABSORIGIN_FOLLOW, l)
	ParticleManager:SetParticleControlEnt(t, 0, l, PATTACH_ABSORIGIN_FOLLOW, nil, l:GetAbsOrigin(), false)
	ParticleManager:SetParticleControlEnt(t, 1, l, PATTACH_ABSORIGIN_FOLLOW, nil, l:GetAbsOrigin(), false)
	self:AddParticle(t, false, false, -1, false, false)
end
function j.prototype.UpdateDamage(self)
	if self.waitEndTime > 0 then
		return
	end
	local u = self:GetCaster()
	local l = self:GetParent()
	if not IsValid(u) or not IsValid(l) or self.damageFunc == nil then
		return
	end
	local v = FindUnitsInRadius(
		l:GetTeamNumber(),
		l:GetAbsOrigin(),
		nil,
		self.damageRadius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	do
		local w = 0
		while w < #v do
			do
				local x = v[w + 1]
				if not IsValid(x) or x == l or x == u then
					goto y
				end
				local z = x:GetEntityIndex()
				if self.hitRecord[z] then
					goto y
				end
				self.hitRecord[z] = true
				u:DealDamage(x, nil, self:damageFunc(x), nil, EOM_DAMAGE_FLAGS.TRAP)
			end
			::y::
			w = w + 1
		end
	end
end
function j.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
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