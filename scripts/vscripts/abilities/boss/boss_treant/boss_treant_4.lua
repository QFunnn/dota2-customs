--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_treant/boss_treant_4"
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
local m = c()
m.name = "boss_treant_4"
d(m, k)
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	n:AddNewModifier(n, self, "modifier_boss_treant_4", { duration = self:GetChannelTime() })
end
function m.prototype.OnChannelFinish(self, o)
	local n = self:GetCaster()
	n:RemoveModifierByName("modifier_boss_treant_4")
end
m = e({ l(nil, {}) }, m)
local p = c()
p.name = "modifier_boss_treant_4"
d(p, h)
function p.prototype.GetAbilitySpecialValue(self)
	self.heal = self:GetAbilitySpecialValueFor("heal")
end
function p.prototype.OnCreated(self, q)
	local r = self:GetParent()
	if IsServer() then
		r:EmitSound("Hero_Treant.LivingArmor.Cast")
		self:StartIntervalThink(1)
	else
		local s = ParticleManager:CreateParticle(
			"particles/units/boss/boss_treant/living_armor_regen.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			r
		)
		ParticleManager:SetParticleControl(s, 1, r:GetAbsOrigin())
		self:AddParticle(s, false, false, -1, false, false)
	end
end
function p.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	local t = self:GetAbility()
	r:Heal(self.heal, t)
end
function p.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_REDUCTION] = 80 }
end
p = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	p
)
return f