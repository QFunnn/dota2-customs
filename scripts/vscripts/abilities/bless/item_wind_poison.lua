--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_wind_poison"
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
k.name = "item_wind_poison"
d(k, j)
function k.prototype.OnCreated(self)
	local l = self:GetCaster()
	local m = self:GetSpecialValueFor("poison")
	local n = self:GetSpecialValueFor("radius")
	local o = self:GetSpecialValueFor("interval")
	self:StartThink(o, function()
		local p = FindEnemiesInRadius(l, l:GetAbsOrigin(), 900)
		local q = GetRandomElement(p)
		if IsValid(q) then
			local r = ParticleManager:CreateParticle(
				"particles/units/benediction/abyssal_underlord_firestorm_wave.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(r, 0, q:GetAbsOrigin())
			ParticleManager:SetParticleControl(r, 4, Vector(n, n, n))
			l:EmitSound("Hero_AbyssalUnderlord.Firestorm")
			local s = FindEnemiesInRadius(l, q:GetAbsOrigin(), n)
			for t, u in ipairs(s) do
				l:Poison(u, m)
			end
		end
	end)
end
k = e({ h(nil) }, k)
return f