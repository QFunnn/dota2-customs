--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless_set_bonus/item_suit_ice"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_suit_ice"
d(k, j)
function k.prototype.OnCreated(self)
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_jakiro/jakiro_liquid_ice_ready.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(
		self.particleID,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetAbsOrigin(),
		true
	)
end
function k.prototype.OnDestroy(self)
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, false)
		self.particleID = nil
	end
end
k = e({ h(nil) }, k)
return f