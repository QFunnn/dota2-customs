--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_steelflame_armor"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_artifact_steelflame_armor"
d(m, k)
function m.prototype.EventListener(self)
	return {
		ability_cast_complete = function(n, o)
			if o.caster == self:GetCaster() and o.abilityTag == AbilityTag.Ultimate then
				o.caster:AddNewModifier(
					o.caster,
					self,
					"modifier_item_artifact_steelflame_armor_buff",
					{ duration = self:GetSpecialValueFor("duration") }
				)
			end
		end,
	}
end
m = e({ l(nil) }, m)
local p = c()
p.name = "modifier_item_artifact_steelflame_armor_buff"
d(p, h)
function p.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	else
		local r = ParticleManager:CreateParticle(
			"particles/econ/events/fall_2022/radiance/radiance_owner_fall2022.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(r, false, false, -1, false, false)
	end
end
function p.prototype.OnIntervalThink(self)
	local s = self:GetCaster()
	if not IsValid(s) then
		return
	end
	local t = FindEnemiesInRadius(s, s:GetAbsOrigin(), self.radius)
	for u, v in ipairs(t) do
		s:DealDamage(v, nil, self.damage)
	end
end
p = e(
	{
		i(
			a,
			{
				IsHidden = false,
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