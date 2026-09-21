--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_void_hammer_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_void_hammer_1"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.chance = self:GetSpecialValueFor("chance")
	self.stun_duration = self:GetSpecialValueFor("stun_duration")
	self.nextProcTime = GameRules:GetGameTime()
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = GameRules:GetGameTime()
			if m < self.nextProcTime then
				return
			end
			if
				l.attacker == self:GetCaster()
				and l.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
				and self:PRD(self.chance)
			then
				self.nextProcTime = m + 1
				local n = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf",
					PATTACH_ABSORIGIN,
					l.target
				)
				ParticleManager:SetParticleControlEnt(
					n,
					1,
					l.target,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					l.target:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(n)
				local o = l.attacker
				local p = l.target
				self:StartThink(0.35, DoUniqueString("void_hammer"), function()
					o:EmitSound("Hero_FacelessVoid.TimeLockImpact")
					p:Stun(o, self, self.stun_duration)
					o:DealDamage(p, self, self:GetSpecialValueFor("damage"), EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
					return -1
				end)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f