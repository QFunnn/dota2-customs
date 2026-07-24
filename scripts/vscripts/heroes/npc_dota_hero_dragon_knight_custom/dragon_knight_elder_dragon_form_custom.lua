--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_1", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_elder_dragon_form_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_2", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_elder_dragon_form_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_3", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_elder_dragon_form_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_4", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_elder_dragon_form_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_corrosive", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_elder_dragon_form_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_frost", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_elder_dragon_form_custom", LUA_MODIFIER_MOTION_NONE )

dragon_knight_elder_dragon_form_custom = class({})

dragon_knight_elder_dragon_form_custom.modifier_dragon_knight_1 = {25,50}
dragon_knight_elder_dragon_form_custom.modifier_dragon_knight_1_radius = {175}
dragon_knight_elder_dragon_form_custom.modifier_dragon_knight_8 = {5,10,15}
dragon_knight_elder_dragon_form_custom.modifier_dragon_knight_15 = {-5,-10,-15}
dragon_knight_elder_dragon_form_custom.modifier_dragon_knight_15_attack = {-10,-20,-30}
dragon_knight_elder_dragon_form_custom.modifier_dragon_knight_15_duration = {2}

function dragon_knight_elder_dragon_form_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_green.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_red.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_corrosion_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_frost.vpcf", context )
end

function dragon_knight_elder_dragon_form_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_dragon_knight_7") then 
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_14") then 
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_21") then 
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
    if self:GetCaster():HasModifier("modifier_dragon_knight_1") and self:GetCaster():HasModifier("modifier_dragon_knight_8") and self:GetCaster():HasModifier("modifier_dragon_knight_15") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function dragon_knight_elder_dragon_form_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_dragon_knight_7") then 
		return 0
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_14") then 
		return 0
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_21") then 
		return 0
	end
    if self:GetCaster():HasModifier("modifier_dragon_knight_1") and self:GetCaster():HasModifier("modifier_dragon_knight_8") and self:GetCaster():HasModifier("modifier_dragon_knight_15") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function dragon_knight_elder_dragon_form_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_dragon_knight_7") then 
		return 0
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_14") then 
		return 0
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_21") then 
		return 0
	end
    if self:GetCaster():HasModifier("modifier_dragon_knight_1") and self:GetCaster():HasModifier("modifier_dragon_knight_8") and self:GetCaster():HasModifier("modifier_dragon_knight_15") then
        return 0
    end
    return self.BaseClass.GetCooldown(self, iLevel)
end

function dragon_knight_elder_dragon_form_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_dragon_knight_7") then 
		return "dragon_knight_7"
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_14") then 
		return "dragon_knight_14"
	end
	if self:GetCaster():HasModifier("modifier_dragon_knight_21") then 
		return "dragon_knight_21"
	end
	return "dragon_knight_elder_dragon_form"
end

function dragon_knight_elder_dragon_form_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
    for i=1,4 do
        caster:RemoveModifierByName("modifier_dragon_knight_elder_dragon_form_custom_"..i)
    end
    if self:GetLevel() >= 1 then 
		mod_name = "modifier_dragon_knight_elder_dragon_form_custom_1"
	end
	if self:GetLevel() >= 2 then 
		mod_name = "modifier_dragon_knight_elder_dragon_form_custom_2"
	end
	if self:GetLevel() >= 3 then 
		mod_name = "modifier_dragon_knight_elder_dragon_form_custom_3"
	end
    if self:GetLevel() >= 4 then 
		mod_name = "modifier_dragon_knight_elder_dragon_form_custom_4"
	end
	self:GetCaster():AddNewModifier( self:GetCaster(), self, mod_name, { duration = duration } )
end

function dragon_knight_elder_dragon_form_custom:AttackTargetSplash(target, damage)
    if self:GetLevel() < 2 and not self:GetCaster():HasModifier("modifier_dragon_knight_1") then
        return
    end

    local start_width = self:GetSpecialValueFor("ranged_splash_radius")
    local end_width = self:GetSpecialValueFor("ranged_splash_radius")
    local range_cleave = self:GetSpecialValueFor("ranged_splash_radius")
    local cleave_damage = self:GetSpecialValueFor("ranged_splash_damage_pct")

    if self:GetLevel() < 2 and self:GetCaster():HasModifier("modifier_dragon_knight_1") then
        local talent_level = self:GetCaster():GetTalentLevel("modifier_dragon_knight_1")
        range_cleave = self.modifier_dragon_knight_1_radius[talent_level] or self.modifier_dragon_knight_1_radius[1] or range_cleave
        start_width = range_cleave
        end_width = range_cleave
    end

    if self:GetCaster():HasModifier("modifier_dragon_knight_1") then
        cleave_damage = cleave_damage + self.modifier_dragon_knight_1[self:GetCaster():GetTalentLevel("modifier_dragon_knight_1")]
    end
    local end_damage = damage / 100 * cleave_damage
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, range_cleave, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
    for _,enemy in pairs(enemies) do
        if enemy ~= target then
            ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = end_damage, damage_type = DAMAGE_TYPE_PHYSICAL})
            self:CorrosiveTarget(enemy)
            self:ColdTarget(enemy)
        end
    end
end

function dragon_knight_elder_dragon_form_custom:CorrosiveTarget(target)
    local corrosion_duration = self:GetSpecialValueFor("corrosive_duration")
    target:AddNewModifier(self:GetCaster(), self, "modifier_dragon_knight_elder_dragon_form_custom_corrosive", {duration = corrosion_duration * (1-target:GetStatusResistance())}) 
end

function dragon_knight_elder_dragon_form_custom:ColdTarget(target)
    if self:GetLevel() < 3 and not self:GetCaster():HasModifier("modifier_dragon_knight_15") then
        return
    end

    local slow_duration = self:GetSpecialValueFor("frost_duration")

    if self:GetLevel() < 3 and self:GetCaster():HasModifier("modifier_dragon_knight_15") then
        local talent_level = self:GetCaster():GetTalentLevel("modifier_dragon_knight_15")
        slow_duration = self.modifier_dragon_knight_15_duration[talent_level] or self.modifier_dragon_knight_15_duration[1] or slow_duration
    end

    target:AddNewModifier(self:GetCaster(), self, "modifier_dragon_knight_elder_dragon_form_custom_frost", {duration = slow_duration}) 
end

modifier_dragon_knight_elder_dragon_form_custom_1 = class({})
function modifier_dragon_knight_elder_dragon_form_custom_1:IsPurgable() return false end
function modifier_dragon_knight_elder_dragon_form_custom_1:RemoveOnDeath() 
    return not (self:GetParent():HasModifier("modifier_dragon_knight_21") or self:GetParent():HasModifier("modifier_dragon_knight_7") or self:GetParent():HasModifier("modifier_dragon_knight_14") or (self:GetParent():HasModifier("modifier_dragon_knight_1") and self:GetParent():HasModifier("modifier_dragon_knight_8") and self:GetParent():HasModifier("modifier_dragon_knight_15"))) 
end

function modifier_dragon_knight_elder_dragon_form_custom_1:OnCreated( kv )
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.bonus_ability_cast_range = self:GetAbility():GetSpecialValueFor( "bonus_ability_cast_range" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_RANGED_ATTACK )
	self.parent:SetSkin(0)
	Timers:CreateTimer(FrameTime(), function()
		self.parent:SetSkin(0)
	end)
	self.projectile = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf"
	self.attack_sound = "Hero_DragonKnight.ElderDragonShoot1.Attack"
	self:StartIntervalThink(FrameTime())
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm")
end

function modifier_dragon_knight_elder_dragon_form_custom_1:OnIntervalThink( kv )
	if not IsServer() then return end
	self.parent:SetSkin(0)
end

function modifier_dragon_knight_elder_dragon_form_custom_1:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dragon_knight_elder_dragon_form_custom_1:OnDestroy()
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm.Revert")
end

function modifier_dragon_knight_elder_dragon_form_custom_1:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    self:GetAbility():AttackTargetSplash(params.target, params.damage)
    self:GetAbility():CorrosiveTarget(params.target)
    self:GetAbility():ColdTarget(params.target)
end

function modifier_dragon_knight_elder_dragon_form_custom_1:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_dragon_knight_elder_dragon_form_custom_1:CheckState()
    return
    {
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil
    }
end

function modifier_dragon_knight_elder_dragon_form_custom_1:GetModifierModelScale()
	return self:GetAbility():GetSpecialValueFor("model_scale")
end

function modifier_dragon_knight_elder_dragon_form_custom_1:GetModifierCastRangeBonus()
	return self.bonus_ability_cast_range
end

function modifier_dragon_knight_elder_dragon_form_custom_1:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_dragon_knight_elder_dragon_form_custom_1:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_dragon_knight_elder_dragon_form_custom_1:GetModifierModelChange()
	return "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
end

function modifier_dragon_knight_elder_dragon_form_custom_1:GetAttackSound()
	return self.attack_sound
end

function modifier_dragon_knight_elder_dragon_form_custom_1:GetModifierProjectileName()
	return self.projectile
end

function modifier_dragon_knight_elder_dragon_form_custom_1:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_green.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dragon_knight_elder_dragon_form_custom_2 = class({})
function modifier_dragon_knight_elder_dragon_form_custom_2:IsPurgable() return false end
function modifier_dragon_knight_elder_dragon_form_custom_2:RemoveOnDeath() 
    return not (self:GetParent():HasModifier("modifier_dragon_knight_21") or self:GetParent():HasModifier("modifier_dragon_knight_7") or self:GetParent():HasModifier("modifier_dragon_knight_14") or (self:GetParent():HasModifier("modifier_dragon_knight_1") and self:GetParent():HasModifier("modifier_dragon_knight_8") and self:GetParent():HasModifier("modifier_dragon_knight_15"))) 
end
function modifier_dragon_knight_elder_dragon_form_custom_2:OnCreated( kv )
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.bonus_ability_cast_range = self:GetAbility():GetSpecialValueFor( "bonus_ability_cast_range" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_RANGED_ATTACK )
	Timers:CreateTimer(FrameTime(), function()
		self.parent:SetSkin(1)
	end)
	self.projectile = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf"
	self.attack_sound = "Hero_DragonKnight.ElderDragonShoot2.Attack"
	self:StartIntervalThink(FrameTime())
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm")
end

function modifier_dragon_knight_elder_dragon_form_custom_2:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dragon_knight_elder_dragon_form_custom_2:OnIntervalThink( kv )
	if not IsServer() then return end
	self.parent:SetSkin(1)
end

function modifier_dragon_knight_elder_dragon_form_custom_2:OnDestroy()
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm.Revert")
end

function modifier_dragon_knight_elder_dragon_form_custom_2:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    self:GetAbility():AttackTargetSplash(params.target, params.damage)
    self:GetAbility():CorrosiveTarget(params.target)
    self:GetAbility():ColdTarget(params.target)
end

function modifier_dragon_knight_elder_dragon_form_custom_2:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_dragon_knight_elder_dragon_form_custom_2:CheckState()
    return
    {
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil
    }
end

function modifier_dragon_knight_elder_dragon_form_custom_2:GetModifierModelScale()
	return self:GetAbility():GetSpecialValueFor("model_scale")
end

function modifier_dragon_knight_elder_dragon_form_custom_2:GetModifierCastRangeBonus()
	return self.bonus_ability_cast_range
end

function modifier_dragon_knight_elder_dragon_form_custom_2:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_dragon_knight_elder_dragon_form_custom_2:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_dragon_knight_elder_dragon_form_custom_2:GetModifierModelChange()
	return "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
end

function modifier_dragon_knight_elder_dragon_form_custom_2:GetAttackSound()
	return self.attack_sound
end

function modifier_dragon_knight_elder_dragon_form_custom_2:GetModifierProjectileName()
	return self.projectile
end

function modifier_dragon_knight_elder_dragon_form_custom_2:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dragon_knight_elder_dragon_form_custom_3 = class({})
function modifier_dragon_knight_elder_dragon_form_custom_3:IsPurgable() return false end
function modifier_dragon_knight_elder_dragon_form_custom_3:RemoveOnDeath() 
    return not (self:GetParent():HasModifier("modifier_dragon_knight_21") or self:GetParent():HasModifier("modifier_dragon_knight_7") or self:GetParent():HasModifier("modifier_dragon_knight_14") or (self:GetParent():HasModifier("modifier_dragon_knight_1") and self:GetParent():HasModifier("modifier_dragon_knight_8") and self:GetParent():HasModifier("modifier_dragon_knight_15"))) 
end
function modifier_dragon_knight_elder_dragon_form_custom_3:OnCreated( kv )
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.bonus_ability_cast_range = self:GetAbility():GetSpecialValueFor( "bonus_ability_cast_range" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_RANGED_ATTACK )
	self.parent:SetSkin(2)
	Timers:CreateTimer(FrameTime(), function()
		self.parent:SetSkin(2)
	end)
	self.projectile = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf"
	self.attack_sound = "Hero_DragonKnight.ElderDragonShoot3.Attack"
	self:StartIntervalThink(FrameTime())
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm")
end

function modifier_dragon_knight_elder_dragon_form_custom_3:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dragon_knight_elder_dragon_form_custom_3:OnIntervalThink( kv )
	if not IsServer() then return end
	self.parent:SetSkin(2)
end

function modifier_dragon_knight_elder_dragon_form_custom_3:OnDestroy()
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm.Revert")
end

function modifier_dragon_knight_elder_dragon_form_custom_3:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    self:GetAbility():AttackTargetSplash(params.target, params.damage)
    self:GetAbility():CorrosiveTarget(params.target)
    self:GetAbility():ColdTarget(params.target)
end

function modifier_dragon_knight_elder_dragon_form_custom_3:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_dragon_knight_elder_dragon_form_custom_3:CheckState()
    return
    {
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil
    }
end

function modifier_dragon_knight_elder_dragon_form_custom_3:GetModifierModelScale()
	return self:GetAbility():GetSpecialValueFor("model_scale")
end

function modifier_dragon_knight_elder_dragon_form_custom_3:GetModifierCastRangeBonus()
	return self.bonus_ability_cast_range
end

function modifier_dragon_knight_elder_dragon_form_custom_3:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_dragon_knight_elder_dragon_form_custom_3:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_dragon_knight_elder_dragon_form_custom_3:GetModifierModelChange()
	return "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
end

function modifier_dragon_knight_elder_dragon_form_custom_3:GetAttackSound()
	return self.attack_sound
end

function modifier_dragon_knight_elder_dragon_form_custom_3:GetModifierProjectileName()
	return self.projectile
end

function modifier_dragon_knight_elder_dragon_form_custom_3:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dragon_knight_elder_dragon_form_custom_4 = class({})
function modifier_dragon_knight_elder_dragon_form_custom_4:IsPurgable() return false end
function modifier_dragon_knight_elder_dragon_form_custom_4:RemoveOnDeath() 
    return not (self:GetParent():HasModifier("modifier_dragon_knight_21") or self:GetParent():HasModifier("modifier_dragon_knight_7") or self:GetParent():HasModifier("modifier_dragon_knight_14") or (self:GetParent():HasModifier("modifier_dragon_knight_1") and self:GetParent():HasModifier("modifier_dragon_knight_8") and self:GetParent():HasModifier("modifier_dragon_knight_15"))) 
end
function modifier_dragon_knight_elder_dragon_form_custom_4:OnCreated( kv )
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.bonus_ability_cast_range = self:GetAbility():GetSpecialValueFor( "bonus_ability_cast_range" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_RANGED_ATTACK )
	self.parent:SetSkin(3)
	Timers:CreateTimer(FrameTime(), function()
		self.parent:SetSkin(3)
	end)
	self.projectile = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_attack_black.vpcf"
	self.attack_sound = "Hero_DragonKnight.ElderDragonShoot3.Attack"
	self:StartIntervalThink(FrameTime())
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm")
end

function modifier_dragon_knight_elder_dragon_form_custom_4:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dragon_knight_elder_dragon_form_custom_4:OnIntervalThink( kv )
	if not IsServer() then return end
	self.parent:SetSkin(3)
end

function modifier_dragon_knight_elder_dragon_form_custom_4:OnDestroy()
	if not IsServer() then return end
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )
	self:PlayEffects()
	self:GetParent():EmitSound("Hero_DragonKnight.ElderDragonForm.Revert")
end

function modifier_dragon_knight_elder_dragon_form_custom_4:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    self:GetAbility():AttackTargetSplash(params.target, params.damage)
    self:GetAbility():CorrosiveTarget(params.target)
    self:GetAbility():ColdTarget(params.target)
end

function modifier_dragon_knight_elder_dragon_form_custom_4:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_dragon_knight_elder_dragon_form_custom_4:CheckState()
    return
    {
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = self:GetAbility():GetSpecialValueFor("flying_movement") >= 1 or nil
    }
end

function modifier_dragon_knight_elder_dragon_form_custom_4:GetModifierModelScale()
	return self:GetAbility():GetSpecialValueFor("model_scale")
end

function modifier_dragon_knight_elder_dragon_form_custom_4:GetModifierCastRangeBonus()
	return self.bonus_ability_cast_range
end

function modifier_dragon_knight_elder_dragon_form_custom_4:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_dragon_knight_elder_dragon_form_custom_4:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_dragon_knight_elder_dragon_form_custom_4:GetModifierModelChange()
	return "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
end

function modifier_dragon_knight_elder_dragon_form_custom_4:GetAttackSound()
	return self.attack_sound
end

function modifier_dragon_knight_elder_dragon_form_custom_4:GetModifierProjectileName()
	return self.projectile
end

function modifier_dragon_knight_elder_dragon_form_custom_4:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_black.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dragon_knight_elder_dragon_form_custom_corrosive = class({})

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:UpdateDamage()
    self.damage_per_second = self:GetAbility():GetSpecialValueFor("corrosive_damage_per_second")
    if self:GetCaster():HasModifier("modifier_dragon_knight_8") then
        self.damage_per_second = self.damage_per_second + self:GetAbility().modifier_dragon_knight_8[self:GetCaster():GetTalentLevel("modifier_dragon_knight_8")]
    end
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:OnCreated( kv )
    self:UpdateDamage()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_dragon_knight_14") then
        self:SetStackCount(1)
        Timers:CreateTimer(self:GetDuration(), function()
            self:DecrementStackCount()
        end)
    end
    self:StartIntervalThink(1)
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:OnRefresh()
    self:UpdateDamage()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_dragon_knight_14") then
        self:IncrementStackCount()
        Timers:CreateTimer(self:GetDuration(), function()
            self:DecrementStackCount()
        end)
    end
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:OnIntervalThink()
	if not IsServer() then return end
    local stack = 1
    if self:GetCaster():HasModifier("modifier_dragon_knight_14") then
        stack = self:GetStackCount()
    end
    ApplyDamage({ attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = self.damage_per_second * stack, damage_type = DAMAGE_TYPE_MAGICAL})
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:GetEffectName()
	return "particles/units/heroes/hero_dragon_knight/dragon_knight_corrosion_debuff.vpcf"
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_dragon_knight_elder_dragon_form_custom_frost = class({})

function modifier_dragon_knight_elder_dragon_form_custom_frost:OnCreated( kv )
    self.slow = self:GetAbility():GetSpecialValueFor("frost_bonus_movement_speed")
    self.slow_attack_speed = self:GetAbility():GetSpecialValueFor("frost_bonus_attack_speed")
    if self:GetCaster():HasModifier("modifier_dragon_knight_15") then
        self.slow = self.slow + self:GetAbility().modifier_dragon_knight_15[self:GetCaster():GetTalentLevel("modifier_dragon_knight_15")]
        self.slow_attack_speed = self.slow_attack_speed + self:GetAbility().modifier_dragon_knight_15_attack[self:GetCaster():GetTalentLevel("modifier_dragon_knight_15")]
    end
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:GetModifierAttackSpeedBonus_Constant()
	return self.slow_attack_speed
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end