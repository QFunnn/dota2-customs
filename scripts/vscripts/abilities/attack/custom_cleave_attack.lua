--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/attack/custom_cleave_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "custom_cleave_attack"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.warningParticleID = {}
	self.angle = 90
end
function j.prototype.Spawn(self)
	if self.attackPlaybackRate == nil then
		local k = KeyValues:GetUnitData(self:GetCaster(), "AttackPlaybackRate")
		if k ~= nil and k > 0 then
			self.attackPlaybackRate = k
		else
			self.attackPlaybackRate = 1
		end
	end
end
function j.prototype.GetCastRange(self, l, m)
	return self:GetCaster():Script_GetAttackRange()
end
function j.prototype.GetCooldown(self, n)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function j.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function j.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	local p = o:GetAbsOrigin()
	local q = self:GetCursorPosition()
	local r = (q - p):Normalized()
	local s = o:Script_GetAttackRange() + 50
	local t = ParticleManager:CreateParticle("particles/warning/creep_sector_waring_fx.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(t, 0, p, r)
	ParticleManager:SetParticleControl(t, 2, Vector(s, self:GetCastPoint(), 0))
	local u = self.warningParticleID
	u[#u + 1] = t
	o:EmitSound(KeyValues:GetAttackSoundSet(o, "SoundSet") .. ".PreAttack")
	Event:Fire("pre_attack_event", { attacker = o, position = q })
	return true
end
function j.prototype.DestroyWarningParticle(self, v)
	if v == nil then
		v = false
	end
	for w, x in ipairs(self.warningParticleID) do
		ParticleManager:DestroyParticle(x, v)
		ParticleManager:ReleaseParticleIndex(x)
	end
	self.warningParticleID = {}
end
function j.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle(true)
end
function j.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local o = self:GetCaster()
	o:SimulateCast({ duration = 0.8 })
	o:StartGesture(ACT_SCRIPT_CUSTOM_21)
	local p = o:GetAbsOrigin()
	local q = self:GetCursorPosition()
	local r = CalcDirection2D(q, p)
	local s = o:Script_GetAttackRange() + 50
	local y = FindEnemiesInTruncatedSector(o, p - r * 300, 300, s + 300, r, self.angle * 0.4)
	for z, m in ipairs(y) do
		o:Attack(m)
	end
	o:EmitSound(KeyValues:GetAttackSoundSet(o, "SoundSet") .. ".Attack")
	Event:Fire("attack_event", { attacker = o, position = q })
end
j = e({ i(nil) }, j)
return f