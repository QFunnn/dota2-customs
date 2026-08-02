--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_division"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "enemy_division"
d(m, k)
function m.prototype.GetIntrinsicModifierName(self)
	return "modifier_enemy_division"
end
m = e({ l(nil) }, m)
local n = c()
n.name = "modifier_enemy_division"
d(n, h)
function n.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.percentage = self:GetAbilitySpecialValueFor("percentage")
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
	end
end
function n.prototype.EventListener(self)
	return {
		entity_killed = function(p, q)
			if IsServer() then
				if q.victim == self.parent then
					local r = self:GetParent()
					if r:IsIllusion() then
						return
					end
					ParticleManager:CreateParticle(
						"particles/units/heroes/hero_broodmother/broodmother_spiderlings_spawn.vpcf",
						PATTACH_POINT,
						r
					)
					do
						local s = 0
						while s < self.count do
							r:SummonUnit(
								"broodmother_spiderling",
								r:GetAbsOrigin() + Rotation2D(vec3_top * 100, 30 * s, true)
							)
							s = s + 1
						end
					end
					EmitSoundOn("Hero_Broodmother.SpawnSpiderlings", r)
				end
			end
		end,
	}
end
n = e(
	{ i(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	n
)
return f