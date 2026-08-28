--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_bleed"
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
m.name = "item_ice_bleed"
d(m, k)
function m.prototype.EventListener(self)
	return {
		dungeon_room_start = function(n, o)
			local p = self:GetCaster()
			p:AddNewModifier(p, self, "modifier_item_ice_bleed", {})
		end,
	}
end
m = e({ l(nil) }, m)
local q = c()
q.name = "modifier_item_ice_bleed"
d(q, h)
function q.prototype.OnCreated(self, r)
	if IsClient() then
		local s = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_spirit_breaker/spirit_breaker_magnet.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			s,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			s,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetAbsOrigin(),
			true
		)
		self:AddParticle(s, false, false, -1, false, false)
	end
end
function q.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.AVOID_DAMAGE] = function(n, r)
			if r ~= nil and r.damage > 0 then
				self:Destroy()
				self:GetParent():Heal(self:GetAbilitySpecialValueFor("heal"), self:GetAbility())
				return 1
			end
		end,
	}
end
q = e(
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
	q
)
return f