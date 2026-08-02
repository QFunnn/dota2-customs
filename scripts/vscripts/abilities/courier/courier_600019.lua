--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600019"
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
local m = require("abilities.courier.courier_base")
local n = m.CourierModifierBase
local o = m.CourierBuffConfig
local p = m.CourierMainConfig
local q = "modifier_courier_600019_buff"
local r = c()
r.name = "courier_600019"
d(r, k)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600019"
end
r = e({ l(nil) }, r)
local s = c()
s.name = "modifier_courier_600019"
d(s, n)
function s.prototype.GetBuffModifierName(self)
	return "modifier_courier_600019_buff"
end
s = e({ i(a, p) }, s)
local t = c()
t.name = "modifier_courier_600019_buff"
d(t, h)
function t.prototype.GetAbilitySpecialValue(self)
	self.damage_up_pct = self:GetAbilitySpecialValueFor("damage_up_pct")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
end
function t.prototype.OnCreated(self)
	if IsServer() then
		self.particleID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lina/lina_fiery_soul.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(self.particleID, 1, Vector(self:GetStackCount(), 0, 0))
		self:AddParticle(self.particleID, false, false, -1, false, false)
	end
end
function t.prototype.OnStackCountChanged(self, u)
	if IsServer() and self.particleID ~= nil then
		ParticleManager:SetParticleControl(self.particleID, 1, Vector(self:GetStackCount(), 0, 0))
	end
end
function t.prototype.EventListener(self)
	return {
		dungeon_room_start = function()
			self:SetStackCount(0)
			self:RemoveDamageBoost()
		end,
		damage_event = function(v, w)
			local x = self:GetParent()
			if
				w.attacker ~= x
				or not IsValid(w.ability)
				or w.ability:GetAbilityTag() ~= AbilityTag.Skill
				or w.damage <= 0
				or not IsValid(w.target)
			then
				return
			end
			if self:GetStackCount() < self.max_stack then
				self:IncrementStackCount()
				PropertySystem:AddStaticProperty(
					x:entindex(),
					"damage_boost_mult",
					q,
					self.damage_up_pct * self:GetStackCount()
				)
			end
		end,
	}
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		self:RemoveDamageBoost()
	end
end
function t.prototype.RemoveDamageBoost(self)
	local x = self:GetParent()
	if not IsValid(x) then
		return
	end
	PropertySystem:RemoveStaticPropertyEx(q, x:GetPlayerOwnerID(), x:entindex(), "damage_boost_mult")
end
t = e({ i(a, o) }, t)
return f