--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tidehunter_anchor_smash_custom = class({})

LinkLuaModifier( "modifier_tidehunter_anchor_smash_custom", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_anchor_smash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tidehunter_anchor_smash_custom_buff", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_anchor_smash_custom", LUA_MODIFIER_MOTION_NONE )

tidehunter_anchor_smash_custom.modifier_tidehunter_8_cooldown = {-0.5,-1}
--tidehunter_anchor_smash_custom.modifier_tidehunter_9 = {-10,-20}
tidehunter_anchor_smash_custom.modifier_tidehunter_11 = {25,50,75}
tidehunter_anchor_smash_custom.modifier_tidehunter_13 = {-10,-20,-30}
tidehunter_anchor_smash_custom.modifier_tidehunter_10_manacost = 50

function tidehunter_anchor_smash_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_anchor_hero.vpcf", context )
end

function tidehunter_anchor_smash_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_tidehunter_10") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function tidehunter_anchor_smash_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_tidehunter_10") then
        return self.BaseClass.GetManaCost(self, level) / 100 * self.modifier_tidehunter_10_manacost
    end
    return self.BaseClass.GetManaCost(self, level)
end

function tidehunter_anchor_smash_custom:GetCooldown( level )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_tidehunter_8") then
		bonus = self.modifier_tidehunter_8_cooldown[self:GetCaster():GetTalentLevel("modifier_tidehunter_8")]
	end	
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function tidehunter_anchor_smash_custom:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("radius") + self:GetCaster():Script_GetAttackRange()
end

function tidehunter_anchor_smash_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local reduction_radius = self:GetSpecialValueFor("radius") + self:GetCaster():Script_GetAttackRange()
	local reduction_duration = self:GetSpecialValueFor("reduction_duration")
	local bonus_damage = self:GetSpecialValueFor("attack_damage")

	if self:GetCaster():HasModifier("modifier_tidehunter_11") then
		bonus_damage = bonus_damage + self.modifier_tidehunter_11[self:GetCaster():GetTalentLevel("modifier_tidehunter_11")]
	end

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		nil,
		reduction_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	local mod = caster:AddNewModifier( caster, self, "modifier_tidehunter_anchor_smash_custom_buff", { bonus = bonus_damage } )

	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier( caster, self, "modifier_tidehunter_anchor_smash_custom", { duration = reduction_duration } )
		caster:PerformAttack( enemy, true, true, true, true, false, false, true )
	end

	mod:Destroy()
	self:PlayEffects(reduction_radius)
end

function tidehunter_anchor_smash_custom:PlayEffects(radius)
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tidehunter/tidehunter_anchor_hero.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_Tidehunter.AnchorSmash")
end

modifier_tidehunter_anchor_smash_custom_buff = class({})

function modifier_tidehunter_anchor_smash_custom_buff:IsHidden()
	return true
end

function modifier_tidehunter_anchor_smash_custom_buff:IsDebuff()
	return false
end

function modifier_tidehunter_anchor_smash_custom_buff:IsPurgable()
	return false
end

function modifier_tidehunter_anchor_smash_custom_buff:OnCreated( kv )
	if not IsServer() then return end
	self.bonus = kv.bonus
end

function modifier_tidehunter_anchor_smash_custom_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SUPPRESS_CLEAVE,
	}
	return funcs
end

function modifier_tidehunter_anchor_smash_custom_buff:GetModifierPreAttack_BonusDamage()
	return self.bonus
end

function modifier_tidehunter_anchor_smash_custom_buff:GetSuppressCleave()
	return 1
end

modifier_tidehunter_anchor_smash_custom = class({})

function modifier_tidehunter_anchor_smash_custom:IsDebuff()
	return true
end

function modifier_tidehunter_anchor_smash_custom:OnCreated( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
end

function modifier_tidehunter_anchor_smash_custom:OnRefresh( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
end

function modifier_tidehunter_anchor_smash_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
	return funcs
end

function modifier_tidehunter_anchor_smash_custom:GetModifierBaseDamageOutgoing_Percentage()
	local bonus = 0
	--if self:GetCaster():HasModifier("modifier_tidehunter_9") then
	--	bonus = self:GetAbility().modifier_tidehunter_9[self:GetCaster():GetTalentLevel("modifier_tidehunter_9")]
	--end	
	return self.reduction + bonus
end

function modifier_tidehunter_anchor_smash_custom:GetModifierSpellAmplify_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_tidehunter_13") then
		bonus = self:GetAbility().modifier_tidehunter_13[self:GetCaster():GetTalentLevel("modifier_tidehunter_13")]
	end	
	return bonus
end