--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_boss_shrink"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_boss_shrink"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.shrinkStarted = false
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.currentRadius = BOSS_SHRINK_START_RADIUS
		self:StartIntervalThink(BOSS_MAX_TIME)
	end
end
function j.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not self.shrinkStarted then
		self.shrinkStarted = true
		local l = self:GetParent()
		local m = GetGroundPosition(l:GetAbsOrigin(), l)
		self.particleID = ParticleManager:CreateParticle(
			"particles/rebuild/gameplay/battle_ring/effect_radius_fringe_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(self.particleID, 0, m)
		ParticleManager:SetParticleControl(self.particleID, 3, m)
		ParticleManager:SetParticleControl(
			self.particleID,
			4,
			Vector(self.currentRadius, BOSS_SHRINK_RADIUS_PER_SECOND, 0)
		)
		ParticleManager:SetParticleControl(
			self.particleID,
			6,
			Vector(self.currentRadius, BOSS_SHRINK_RADIUS_PER_SECOND, 0)
		)
		ParticleManager:SetParticleControl(
			self.particleID,
			7,
			Vector(self.currentRadius, BOSS_SHRINK_RADIUS_PER_SECOND, 0)
		)
		ParticleManager:SetParticleControl(self.particleID, 8, Vector(self.currentRadius, 0, 0))
		ParticleManager:SetParticleControl(
			self.particleID,
			9,
			Vector(BOSS_SHRINK_START_RADIUS / BOSS_SHRINK_RADIUS_PER_SECOND, 0, 0)
		)
		self:AddParticle(self.particleID, false, false, -1, false, false)
		self:StartIntervalThink(BOSS_SHRINK_TICK_INTERVAL)
		return
	end
	self.currentRadius = self.currentRadius - BOSS_SHRINK_RADIUS_PER_SECOND
	ParticleManager:SetParticleControl(self.particleID, 8, Vector(math.max(100, self.currentRadius), 0, 0))
	if self.currentRadius <= 0 then
		self.currentRadius = 0
	end
	local l = self:GetParent()
	local m = l:GetAbsOrigin()
	Game:EachPlayer(function(n, o)
		local p = PlayerResource:GetSelectedHeroEntity(o)
		if
			IsValid(p)
			and p:IsAlive()
			and not p:HasState(StateEnum.SMOKE_IMMUNE)
			and (self.currentRadius <= 0 or CalcDistance(m, p) > self.currentRadius)
		then
			local q = p:GetMaxHealth() * BOSS_SHRINK_OUTSIDE_DAMAGE_PCT * 0.01
			if p:GetHealth() > q then
				p:HealthCost(-q)
			else
				p:Kill(nil, l)
			end
		end
	end)
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
return f