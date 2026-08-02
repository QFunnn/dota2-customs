--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_treant/boss_treant_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_treant_3"
d(j, h)
function j.prototype.OnSpellStart(self)
	self:Callback()
	self:StartThink(1, "channel", function()
		self:Callback()
	end)
end
function j.prototype.Callback(self)
	local k = self:GetCaster()
	local l = k:GetAbsOrigin()
	local m = self:GetSpecialValueFor("radius")
	local n = self:GetSpecialValueFor("damage")
	local o = self:GetSpecialValueFor("count")
	local p = {}
	Bullet:SplitAction(RandomVector(1), o, 360 / o, function(q, r, s)
		local t = l + r * RandomInt(200, 1200)
		p[#p + 1] = t
		self:CircleWarning(t, m, 1)
	end)
	self:StartThink(1, DoUniqueString("1"), function()
		for q, t in ipairs(p) do
			local u = ParticleManager:CreateParticle(
				"particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_cast.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(u, 0, t)
			ParticleManager:ReleaseParticleIndex(u)
			local v = FindEnemiesInRadius(k, t, m)
			for q, w in ipairs(v) do
				k:DealDamage(w, nil, n)
			end
		end
		k:EmitSound("Treant.Ability3")
		return -1
	end)
end
function j.prototype.OnChannelFinish(self, x)
	self:StartThink(-1, "channel")
end
j = e({ i(nil, {}) }, j)
return f