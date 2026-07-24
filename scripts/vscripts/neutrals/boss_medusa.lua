--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_medusa_split", "neutrals/boss_medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

boss_medusa_split = class({})

function boss_medusa_split:GetIntrinsicModifierName()
	return "modifier_boss_medusa_split"
end

modifier_boss_medusa_split = class({})

function modifier_boss_medusa_split:IsHidden()
	return true
end

function modifier_boss_medusa_split:IsPurgable()
	return false
end

function modifier_boss_medusa_split:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_boss_medusa_split:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_EVENT_ON_ATTACK,
	}
	return funcs
end

function modifier_boss_medusa_split:OnAttack( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end
	if params.no_attack_cooldown then return end
	if params.target:GetTeamNumber()==params.attacker:GetTeamNumber() then return end
	local radius = self:GetParent():Script_GetAttackRange() + 150

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
	local count = 0

	for _,enemy in pairs(enemies) do
		if enemy ~= params.target then
			self:GetParent():PerformAttack( enemy, true, true, true, false, true, false, false )
			count = count + 1
			if count >= self:GetAbility():GetSpecialValueFor("bonus_targets") then break end
		end
	end
end

LinkLuaModifier("modifier_boss_medusa_aura", "neutrals/boss_medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_medusa_aura_aura", "neutrals/boss_medusa", LUA_MODIFIER_MOTION_NONE)

boss_medusa_aura = class({})

function boss_medusa_aura:GetIntrinsicModifierName()
	return "modifier_boss_medusa_aura"
end

modifier_boss_medusa_aura = class({})

function modifier_boss_medusa_aura:IsHidden() return true end
function modifier_boss_medusa_aura:IsPurgable() return false end
function modifier_boss_medusa_aura:IsPurgeException() return false end
function modifier_boss_medusa_aura:IsAuraActiveOnDeath() return false end

function modifier_boss_medusa_aura:IsAura()
    return true
end

function modifier_boss_medusa_aura:GetModifierAura()
    return "modifier_boss_medusa_aura_aura"
end

function modifier_boss_medusa_aura:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_boss_medusa_aura:GetAuraDuration()
    return 0
end

function modifier_boss_medusa_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_boss_medusa_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_boss_medusa_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_boss_medusa_aura_aura = class({})

function modifier_boss_medusa_aura_aura:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end

function modifier_boss_medusa_aura_aura:GetEffectName()
	return "particles/medusa_debuff.vpcf"
end

function modifier_boss_medusa_aura_aura:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_boss_medusa_aura_aura:GetModifierPropertyRestorationAmplification()
	return self:GetAbility():GetSpecialValueFor("heal_reduce")
end

LinkLuaModifier("modifier_boss_medusa_stone", "neutrals/boss_medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_medusa_buff", "neutrals/boss_medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_medusa_buff_visual", "neutrals/boss_medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_medusa_debuff", "neutrals/boss_medusa", LUA_MODIFIER_MOTION_NONE)

boss_medusa_stone = class({})

function boss_medusa_stone:Precache(context)
    PrecacheResource( "particle", "particles/boss_medusa_counterbuff_strength_counter_stack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_medusa/medusa_stone_gaze_facing.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_medusa_stone_gaze.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf", context )
end

function boss_medusa_stone:GetIntrinsicModifierName()
	return "modifier_boss_medusa_buff"
end

modifier_boss_medusa_buff = class({})

function modifier_boss_medusa_buff:IsHidden()
	return true
end

function modifier_boss_medusa_buff:IsPurgable()
	return false
end

function modifier_boss_medusa_buff:IsAuraActiveOnDeath() return false end

function modifier_boss_medusa_buff:IsAura()
    return true
end

function modifier_boss_medusa_buff:GetModifierAura()
    return "modifier_boss_medusa_buff_visual"
end

function modifier_boss_medusa_buff:GetAuraRadius()
    return -1
end

function modifier_boss_medusa_buff:GetAuraDuration()
    return 0
end

function modifier_boss_medusa_buff:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_boss_medusa_buff:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_boss_medusa_buff:IsAuraActiveOnDeath()
	return false
end

modifier_boss_medusa_buff_visual = class({})

function modifier_boss_medusa_buff_visual:IsPurgable() return false end

function modifier_boss_medusa_buff_visual:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_boss_medusa_buff_visual:OnCreated( kv )
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.parent = self:GetParent()
	self.center_unit = self:GetAuraOwner()
	self.stone_angle = 85
	self.facing = false
	self.stoned = 0
	self.effect_cast_2 = ParticleManager:CreateParticle( "particles/boss_medusa_counterbuff_strength_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast_2, 2, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControlEnt(self.effect_cast_2, 3, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, nil , self:GetParent():GetAbsOrigin(), true )
	self:AddParticle(self.effect_cast_2,false, false, -1, false, false)
	self:PlayEffects1()
	self:PlayEffects2()
	self:OnIntervalThink()
	self:StartIntervalThink( 0.03 )
end

function modifier_boss_medusa_buff_visual:OnIntervalThink()
	if not IsServer() then return end
	local vector = self.center_unit:GetOrigin()-self.parent:GetOrigin()
	local center_angle = VectorToAngles( vector ).y
	local facing_angle = VectorToAngles( self.parent:GetForwardVector() ).y
	local distance = vector:Length2D()
	local prev_facing = self.facing
	self.facing = ( math.abs( AngleDiff(center_angle,facing_angle) ) < self.stone_angle )

	if self.facing~=prev_facing then
		self:ChangeEffects( self.facing )
	end

	if self:GetParent():HasModifier("modifier_boss_medusa_debuff") then
		ParticleManager:SetParticleControl( self.effect_cast_2, 2, Vector( 0, 0, 0 ) )
		self.stoned = 0
		return
	end

	if self.facing then
		self.stoned = self.stoned + 0.03
	else
		self.stoned = 0
	end

	ParticleManager:SetParticleControl( self.effect_cast_2, 2, Vector( math.floor(self.stoned), 0, 0 ) )

	if self.stoned >= self:GetAbility():GetSpecialValueFor("delay") then
		self:GetParent():AddNewModifier(self:GetAuraOwner(), self:GetAbility(), "modifier_boss_medusa_debuff", {duration = self:GetAbility():GetSpecialValueFor("duration") * (1-self:GetParent():GetStatusResistance())})
	end
end

function modifier_boss_medusa_buff_visual:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self.center_unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false)
end

function modifier_boss_medusa_buff_visual:PlayEffects2()
	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_facing.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( self.effect_cast, false, false, -1, false, false  )
end

function modifier_boss_medusa_buff_visual:ChangeEffects( IsNowFacing )
	local target = self.parent

	if IsNowFacing then
		target = self.center_unit
		EmitSoundOnClient( "Hero_Medusa.StoneGaze.Target", self:GetParent():GetPlayerOwner() )
	end

	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
end

modifier_boss_medusa_debuff = class({})

function modifier_boss_medusa_debuff:IsPurgable() return false end

function modifier_boss_medusa_debuff:OnCreated( kv )
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:PlayEffects()
end

function modifier_boss_medusa_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_boss_medusa_debuff:GetModifierIncomingDamage_Percentage( params )
	if params.damage_type==DAMAGE_TYPE_PHYSICAL then
		return self:GetAbility():GetSpecialValueFor("damage_bonus")
	end
end

function modifier_boss_medusa_debuff:CheckState()
	return
	{
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_boss_medusa_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_medusa_stone_gaze.vpcf"
end

function modifier_boss_medusa_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_boss_medusa_debuff:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector( 0,0,0 ), true )
	self:AddParticle( effect_cast, false, false, -1, false, false  )
	EmitSoundOnClient( "Hero_Medusa.StoneGaze.Stun", self:GetParent():GetPlayerOwner() )
end