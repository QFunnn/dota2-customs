--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_shadowraze_custom_debuff", "abilities/nevermore_shadowraze_custom", LUA_MODIFIER_MOTION_NONE)

nevermore_shadowraze1_custom =  class({})
nevermore_shadowraze2_custom = class({})
nevermore_shadowraze3_custom = class({})

function nevermore_shadowraze1_custom:OnSpellStart(multicast)
	if not IsServer() then return end
	local raze_radius = self:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = self:GetSpecialValueFor("shadowraze_range")
	local raze_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * raze_distance
	CastShadowRazeOnPoint(self:GetCaster(), self, raze_point, raze_radius, multicast)
	self:GetCaster():EmitSound("Hero_Nevermore.Shadowraze")
end

function nevermore_shadowraze2_custom:OnSpellStart(multicast)
	if not IsServer() then return end
	local raze_radius = self:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = self:GetSpecialValueFor("shadowraze_range")
	local raze_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * raze_distance
	CastShadowRazeOnPoint(self:GetCaster(), self, raze_point, raze_radius, multicast)
	self:GetCaster():EmitSound("Hero_Nevermore.Shadowraze")
end

function nevermore_shadowraze3_custom:OnSpellStart(multicast)
	if not IsServer() then return end
	local raze_radius = self:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = self:GetSpecialValueFor("shadowraze_range")
	local raze_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * raze_distance
	CastShadowRazeOnPoint(self:GetCaster(), self, raze_point, raze_radius, multicast)
	self:GetCaster():EmitSound("Hero_Nevermore.Shadowraze")
end

function CastShadowRazeOnPoint(caster, ability, point, radius, multicast)
	if multicast == nil then
		local nevermore_shadowraze1_custom = caster:FindAbilityByName("nevermore_shadowraze1_custom")
		if nevermore_shadowraze1_custom and ability ~= nevermore_shadowraze1_custom and nevermore_shadowraze1_custom:GetCurrentAbilityCharges() > 0 then
			nevermore_shadowraze1_custom:SetCurrentAbilityCharges(nevermore_shadowraze1_custom:GetCurrentAbilityCharges() - 1)
		end
		local nevermore_shadowraze2_custom = caster:FindAbilityByName("nevermore_shadowraze2_custom")
		if nevermore_shadowraze2_custom and ability ~= nevermore_shadowraze2_custom and nevermore_shadowraze2_custom:GetCurrentAbilityCharges() > 0 then
			nevermore_shadowraze2_custom:SetCurrentAbilityCharges(nevermore_shadowraze2_custom:GetCurrentAbilityCharges() - 1)
		end
		local nevermore_shadowraze3_custom = caster:FindAbilityByName("nevermore_shadowraze3_custom")
		if nevermore_shadowraze3_custom and ability ~= nevermore_shadowraze3_custom and nevermore_shadowraze3_custom:GetCurrentAbilityCharges() > 0 then
			nevermore_shadowraze3_custom:SetCurrentAbilityCharges(nevermore_shadowraze3_custom:GetCurrentAbilityCharges() - 1)
		end

	end

	local particle_raze_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_raze_fx, 0, point)
	ParticleManager:SetParticleControl(particle_raze_fx, 1, Vector(radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(particle_raze_fx)

	local enemies = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

	for _,enemy in pairs(enemies) do
		if not enemy:IsMagicImmune()  then
			ApplyShadowRazeDamage(caster, ability, enemy)
		end
	end
end

function ApplyShadowRazeDamage(caster, ability, enemy)
	local damage = ability:GetSpecialValueFor("shadowraze_damage")
	local stack_bonus_damage = ability:GetSpecialValueFor("stack_bonus_damage")

	local duration = ability:GetSpecialValueFor("duration")

	local modifier = enemy:FindModifierByName("modifier_nevermore_shadowraze_custom_debuff")

	if modifier then
		damage = damage + ( stack_bonus_damage * modifier:GetStackCount() )
	end

	if caster:HasTalent("special_bonus_unique_nevermore_raze_procsattacks") then
		caster:PerformAttack(enemy, true, true, true, false, false, false, true)
	end

	ApplyDamage({victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = caster, ability = ability})    
	enemy:AddNewModifier(caster, ability, "modifier_nevermore_shadowraze_custom_debuff", {duration = duration})
end

modifier_nevermore_shadowraze_custom_debuff = class ({})

function modifier_nevermore_shadowraze_custom_debuff:IsDebuff() return true end

function modifier_nevermore_shadowraze_custom_debuff:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_nevermore_shadowraze_custom_debuff:OnRefresh()
	if not IsServer() then return end
	self:IncrementStackCount()
end

function modifier_nevermore_shadowraze_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_nevermore_shadowraze_custom_debuff:OnTooltip()
	return self:GetStackCount() * ( self:GetAbility():GetSpecialValueFor("stack_bonus_damage") )
end

function modifier_nevermore_shadowraze_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_speed_pct") * self:GetStackCount()
end