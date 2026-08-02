--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_grimstroke/boss_grimstroke_5"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_grimstroke_5"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.currentAngle = 0
end
function j.prototype.GetChannelAnimation(self)
	return ACT_DOTA_DISABLED
end
function j.prototype.GetNextDirections(self)
	local k = self:GetSpecialValueFor("count")
	local l = {}
	if k <= 0 then
		return l
	end
	local m = 360 / k
	do
		local n = 0
		while n < k do
			local o = self.currentAngle + m * n
			l[#l + 1] = Rotation2D(vec3_top, o, true)
			n = n + 1
		end
	end
	self.currentAngle = (self.currentAngle + 5) % 360
	return l
end
function j.prototype.CreateProjectileEffect(self, p, q, r, s)
	local t = ParticleManager:CreateParticle(
		"particles/units/boss/boss_grimstroke/summon_proj.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(t, 0, p)
	ParticleManager:SetParticleControl(t, 1, q)
	ParticleManager:SetParticleControl(t, 2, Vector(s, 0, 0))
	local u = self:GetSpecialValueFor("damage")
	local v = self:GetSpecialValueFor("radius")
	self:CircleWarning(q, v, r)
	self:StartThink(r, DoUniqueString("index"), function()
		ParticleManager:DestroyParticle(t, false)
		local w = self:GetCaster()
		local x = FindEnemiesInRadius(w, q, v)
		w:DealDamage(x, self, u)
		return -1
	end)
end
function j.prototype.OnAbilityPhaseStart(self)
	local w = self:GetCaster()
	w:EmitSound("Hero_Grimstroke.SoulChain.Cast")
	w:EmitSound("Grimstroke.Ability5")
	return true
end
function j.prototype.OnSpellStart(self)
	local w = self:GetCaster()
	w:EmitSound("Hero_Grimstroke.InkSwell.Cast")
	self.currentAngle = 0
	local t = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_buff.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		w
	)
	ParticleManager:SetParticleControlEnt(t, 3, w, PATTACH_ABSORIGIN_FOLLOW, nil, w:GetAbsOrigin(), true)
	self:AddParticle(t)
	self:StartThink(0.1, "think", function()
		local p = w:GetAttachmentPosition("attach_hitloc")
		local s = RandomInt(200, 1400)
		local r = 1
		local l = self:GetNextDirections()
		do
			local n = 0
			while n < #l do
				local y = l[n + 1]
				local q = w:GetAbsOrigin() + y * s
				self:CreateProjectileEffect(p, q, r, s)
				n = n + 1
			end
		end
		w:EmitSound("Hero_Grimstroke.DarkArtistry.Damage")
	end)
end
function j.prototype.OnChannelFinish(self, z)
	self:StartThink(-1, "think")
	self:DestroyParticles()
end
j = e({ i(nil) }, j)
return f