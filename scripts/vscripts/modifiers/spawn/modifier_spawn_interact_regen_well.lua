--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_interact_regen_well"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_interact_regen_well"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enabled = true
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		l:SetForwardVector(vec3_bottom)
		l:SetHullRadius(128)
		self.particleID = ParticleManager:CreateParticleForce(
			"particles/hw_fx/candy_well_idle.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(self.particleID, false, false, -1, false, false)
	end
end
function j.prototype.Activity(self)
	if not self.enabled then
		return
	end
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, false)
		self.particleID = nil
	end
	Game:EachPlayer(function(m, n)
		local o = Player:GetHero(n)
		if IsValid(o) then
			o:AddNewModifier(o, nil, "modifier_spawn_interact_regen_well_heal", { duration = 2 })
			Event:Fire("regen_well_trigger", { caster = self.parent, target = o })
		end
	end)
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
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	j
)
local p = c()
p.name = "modifier_spawn_interact_regen_well_heal"
d(p, h)
function p.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.regen_pct = 50
end
function p.prototype.OnCreated(self, k)
	if IsServer() then
		self.parent:EmitSound("Hero_Oracle.FalsePromise.Healed")
		self:StartIntervalThink(0.1)
	else
		local q = ParticleManager:CreateParticleForce(
			"particles/econ/events/ti7/bottle_ti7.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(q, false, false, -1, false, false)
	end
end
function p.prototype.OnIntervalThink(self)
	if IsServer() then
		local r = self.regen_pct * self.parent:GetMaxHealth() * 0.01 * 0.05
		self.parent:Heal(r, self:GetAbility())
	end
end
p = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	p
)
return f