--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_outworld_devourer_flux_lua",
	"heroes/hero_outworld_devourer/outworld_devourer_flux_lua/outworld_devourer_flux_lua",
	LUA_MODIFIER_MOTION_NONE
)

outworld_devourer_flux_lua = class({})

function outworld_devourer_flux_lua:GetIntrinsicModifierName()
	return "modifier_outworld_devourer_flux_lua"
end

--------------------------------------------------
modifier_outworld_devourer_flux_lua = class({})

function modifier_outworld_devourer_flux_lua:IsHidden()
	return true
end
function modifier_outworld_devourer_flux_lua:IsPurgable()
	return false
end
function modifier_outworld_devourer_flux_lua:RemoveOnDeath()
	return false
end

function modifier_outworld_devourer_flux_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ABILITY_FULLY_CAST }
end

function modifier_outworld_devourer_flux_lua:OnAbilityFullyCast(keys)
	if keys.unit == self:GetParent() and not keys.ability:IsToggle() and not keys.ability:IsItem() then
		local abil = self:GetCaster():FindAbilityByName("special_bonus_outworld_devourer_tal2")
		local chance = self:GetAbility():GetSpecialValueFor("chance")
		if abil ~= nil and abil:GetLevel() > 0 then
			chance = self:GetAbility():GetSpecialValueFor("chance") + 10
		end
		if RandomInt(1, 100) < chance then
			self.proc_particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			ParticleManager:SetParticleControlEnt(
				self.proc_particle,
				0,
				self:GetParent(),
				PATTACH_ABSORIGIN_FOLLOW,
				"attach_hitloc",
				self:GetParent():GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(self.proc_particle)
			self:GetParent()
				:GiveMana(self:GetParent():GetMaxMana() * self:GetAbility():GetSpecialValueFor("mp_back") * 0.01)
		end
	end
end