--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_bath"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.eom_ability")
local m = l.EOMItem
local n = c()
n.name = "item_bleed_bath"
d(n, m)
function n.prototype.EventListener(self)
	return {
		ability_cast_complete = function(o, p)
			local q = self:GetCaster()
			if q == p.caster and p.abilityTag == AbilityTag.Ultimate then
				q:AddNewModifier(
					q,
					self,
					"modifier_item_bleed_bath",
					{ duration = self:GetSpecialValueFor("duration") }
				)
			end
		end,
	}
end
n = e({ h(nil) }, n)
local r = c()
r.name = "modifier_item_bleed_bath"
d(r, j)
function r.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(1)
	else
		local t = self:GetParent()
		local u =
			ParticleManager:CreateParticle("particles/generic_gameplay/bleed_bath.vpcf", PATTACH_ABSORIGIN_FOLLOW, t)
		ParticleManager:SetParticleControl(u, 1, Vector(self.radius, 0, 0))
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function r.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local v = FindEnemiesInRadius(t, t:GetAbsOrigin(), self.radius)
	local w = self:GetAbilitySpecialValueFor("damage")
	for x, y in ipairs(v) do
		t:Bleed(y, w)
	end
end
r = e(
	{
		k(
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
	r
)
return f