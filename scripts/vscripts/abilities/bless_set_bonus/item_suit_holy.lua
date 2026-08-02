--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless_set_bonus/item_suit_holy"
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
k.name = "item_suit_holy"
d(k, j)
function k.prototype.OnCreated(self)
	self.particleID = ParticleManager:CreateParticle(
		"particles/econ/items/omniknight/frenzied_sun/frenzied_sun_weapon_ambient.vpcf",
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