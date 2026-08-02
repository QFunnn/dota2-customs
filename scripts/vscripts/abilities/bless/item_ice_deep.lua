--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_deep"
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
k.name = "item_ice_deep"
d(k, j)
function k.prototype.OnCreated(self)
	local l = self:GetCaster()
	local m = self:GetSpecialValueFor("radius")
	local n = self:GetSpecialValueFor("interval")
	self:StartThink(n, function()
		local o = self:GetSpecialValueFor("frozen")
		local p = self:GetSpecialValueFor("damage")
		local q = FindEnemiesInRadius(l, l:GetAbsOrigin(), m)
		for r, s in ipairs(q) do
			l:Frozen(s, o)
			l:DealDamage(s, nil, p, nil, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
		end
		return self:GetSpecialValueFor("interval")
	end)
	self.particleID =
		ParticleManager:CreateParticle("particles/generic_gameplay/ice_deep.vpcf", PATTACH_ABSORIGIN_FOLLOW, l)
	ParticleManager:SetParticleControl(self.particleID, 1, Vector(m, 0, 0))
end
function k.prototype.OnDestroy(self)
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, false)
		self.particleID = nil
	end
end
k = e({ h(nil) }, k)
return f