--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_keeper_of_the_light_radiant_bind_custom", "heroes/hero_keeper/keeper_of_the_light_radiant_bind_custom", LUA_MODIFIER_MOTION_NONE )

keeper_of_the_light_radiant_bind_custom = class({})

function keeper_of_the_light_radiant_bind_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function keeper_of_the_light_radiant_bind_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	if target then
		if not target:TriggerSpellAbsorb(self) then
			self:effectstart(target)
			target:AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_radiant_bind_custom", {duration = duration})
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
			for _, enemy in pairs(enemies) do
				if enemy ~= target then
					self:effectstart(enemy)
					enemy:AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_radiant_bind_custom", {duration = duration})
				end
			end
		end
	end
end

function keeper_of_the_light_radiant_bind_custom:effectstart(target)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_radiant_bind_cast.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_keeper_of_the_light_radiant_bind_custom = class({})

function modifier_keeper_of_the_light_radiant_bind_custom:OnCreated()
	self.resistance = self:GetAbility():GetSpecialValueFor("magic_resistance") * -1
end

function modifier_keeper_of_the_light_radiant_bind_custom:OnRefresh()
	self.resistance = self:GetAbility():GetSpecialValueFor("magic_resistance") * -1
end

function modifier_keeper_of_the_light_radiant_bind_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,

	}
end

function modifier_keeper_of_the_light_radiant_bind_custom:GetModifierMoveSpeedBonus_Percentage()
	return -100
end

function modifier_keeper_of_the_light_radiant_bind_custom:GetModifierMagicalResistanceBonus()
	return self.resistance
end

function modifier_keeper_of_the_light_radiant_bind_custom:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_radiant_bind_debuff.vpcf"
end

function modifier_keeper_of_the_light_radiant_bind_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_keeper_of_the_light_radiant_bind_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_spirit_bind_debuff.vpcf"
end

function modifier_keeper_of_the_light_radiant_bind_custom:StatusEffectPriority()
	return 10
end