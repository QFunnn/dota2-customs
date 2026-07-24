--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_shadowraze_custom_debuff", "heroes/npc_dota_hero_nevermore_custom/nevermore_shadowraze_custom", LUA_MODIFIER_MOTION_NONE)

nevermore_shadowraze1_custom =  class({})
nevermore_shadowraze1_custom.modifier_nevermore_16 = {30,60}
nevermore_shadowraze1_custom.modifier_nevermore_17 = {-1,-3,-5}
nevermore_shadowraze1_custom.modifier_nevermore_17_debuff = {-1,-2,-3}
nevermore_shadowraze1_custom.modifier_nevermore_16_slow = {-6,-12}

function nevermore_shadowraze1_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", context )
end

function nevermore_shadowraze1_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_nevermore_17") then
		bonus = self.modifier_nevermore_17[self:GetCaster():GetTalentLevel("modifier_nevermore_17")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function nevermore_shadowraze1_custom:OnSpellStart()
	if not IsServer() then return end
	local raze_radius = self:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = self:GetSpecialValueFor("shadowraze_range")
	local raze_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * raze_distance
	CastShadowRazeOnPoint(self:GetCaster(), self, raze_point, raze_radius)
	self:GetCaster():EmitSound("Hero_Nevermore.Shadowraze")
end

function CastShadowRazeOnPoint(caster, ability, point, radius)

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
    local damage_per_soul = ability:GetSpecialValueFor("damage_per_soul")

	if caster:HasModifier("modifier_nevermore_16") then
		stack_bonus_damage = stack_bonus_damage + ability.modifier_nevermore_16[caster:GetTalentLevel("modifier_nevermore_16")]
	end

	local duration = ability:GetSpecialValueFor("duration")
    if caster:HasModifier("modifier_nevermore_17") then
        duration = duration + ability.modifier_nevermore_17_debuff[caster:GetTalentLevel("modifier_nevermore_17")]
    end

    local modifier_nevermore_necromastery_custom = caster:FindModifierByName("modifier_nevermore_necromastery_custom")
    if modifier_nevermore_necromastery_custom then
        damage = damage + ( damage_per_soul * modifier_nevermore_necromastery_custom:GetStackCount() )
    end

	local modifier = enemy:FindModifierByName("modifier_nevermore_shadowraze_custom_debuff")
	if modifier then
		damage = damage + ( stack_bonus_damage * modifier:GetStackCount() )
	end

	if caster:HasModifier("modifier_nevermore_21") then
		caster:PerformAttack(enemy, true, true, true, false, false, false, true)
	end

	ApplyDamage({victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = caster, ability = ability})    
	enemy:AddNewModifier(caster, ability, "modifier_nevermore_shadowraze_custom_debuff", {duration = duration * (1 - enemy:GetStatusResistance())})
end

modifier_nevermore_shadowraze_custom_debuff = class ({})

function modifier_nevermore_shadowraze_custom_debuff:IsDebuff() return true end
function modifier_nevermore_shadowraze_custom_debuff:IsPurgable() return not self:GetCaster():HasModifier("modifier_nevermore_17") end

function modifier_nevermore_shadowraze_custom_debuff:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_nevermore_shadowraze_custom_debuff:OnRefresh()
	if not IsServer() then return end
    if self:GetStackCount() < 10 then
	    self:IncrementStackCount()
    end
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
    if self:GetCaster():HasModifier("modifier_nevermore_16") then
        return self:GetAbility().modifier_nevermore_16_slow[self:GetCaster():GetTalentLevel("modifier_nevermore_16")] * self:GetStackCount()
    end
end

nevermore_shadowraze2_custom = nevermore_shadowraze1_custom
nevermore_shadowraze3_custom = nevermore_shadowraze1_custom