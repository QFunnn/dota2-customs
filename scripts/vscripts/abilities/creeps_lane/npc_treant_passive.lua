--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


npc_treant_passive = class({})

function npc_treant_passive:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context)
end

function npc_treant_passive:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.heal = self:GetLevelSpecialValueFor("heal", 1) / 100
end

function npc_treant_passive:OnSpellStart()
	local target = self:GetCursorTarget()

	self.caster:EmitSound("Hero_Treant.LivingArmor.Cast")
	target:EmitSound("Hero_Treant.LivingArmor.Target")

	target:GenericHeal((target:GetMaxHealth() - target:GetHealth()) * self.heal, self)
	target:GenericParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf")
end