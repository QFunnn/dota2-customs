--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_void_hammer_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_void_hammer_3"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.chance = self:GetSpecialValueFor("chance")
	self.stun_duration = self:GetSpecialValueFor("stun_duration")
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			if
				l.attacker == self:GetCaster()
				and l.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
				and self:PRD(self.chance)
			then
				local m = ParticleManager:CreateParticle(
					"particles/econ/items/faceless_void/faceless_void_arcana/faceless_void_arcana_time_lock_v2_tentacle_bash.vpcf",
					PATTACH_ABSORIGIN,
					l.target
				)
				ParticleManager:SetParticleControlEnt(
					m,
					1,
					l.target,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					l.target:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(m)
				local n = l.attacker
				local o = l.target
				self:StartThink(0.35, DoUniqueString("void_hammer"), function()
					n:EmitSound("Hero_FacelessVoid.TimeLockImpact")
					o:Stun(n, self, self.stun_duration)
					n:DealDamage(o, self, self:GetSpecialValueFor("damage"), EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
					return -1
				end)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f