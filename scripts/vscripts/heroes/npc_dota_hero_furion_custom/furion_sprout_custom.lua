--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_furion_sprout_custom_thinker_damage",  "heroes/npc_dota_hero_furion_custom/furion_sprout_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_sprout_custom_thinker_debuff",  "heroes/npc_dota_hero_furion_custom/furion_sprout_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_sprout_custom_magic_immune",  "heroes/npc_dota_hero_furion_custom/furion_sprout_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_sprout_custom_regen",  "heroes/npc_dota_hero_furion_custom/furion_sprout_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_sprout_custom_trees",  "heroes/npc_dota_hero_furion_custom/furion_sprout_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_sprout_custom_thinker_heal",  "heroes/npc_dota_hero_furion_custom/furion_sprout_custom", LUA_MODIFIER_MOTION_NONE )

furion_sprout_custom = class({}) 

function furion_sprout_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_sprout.vpcf", context )
    PrecacheResource( "particle", "particles/items_fx/black_king_bar_avatar.vpcf", context )
end

furion_sprout_custom.modifier_furion_20 = {8}
furion_sprout_custom.modifier_furion_17_damage = 60

furion_sprout_custom.modifier_furion_16 = {15,30,45}
furion_sprout_custom.modifier_furion_18 = {1,2,3}

furion_sprout_custom.modifier_furion_21 = {1,2,3}
furion_sprout_custom.modifier_furion_21_radius = 1200

furion_sprout_custom.modifier_furion_19 = {2,4}

function furion_sprout_custom:GetIntrinsicModifierName()
	return "modifier_furion_sprout_custom_trees"
end

function furion_sprout_custom:GetAbilityChargeRestoreTime(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_furion_19") then
        bonus = self.modifier_furion_19[self:GetCaster():GetTalentLevel("modifier_furion_19")]
    end
    return self.BaseClass.GetAbilityChargeRestoreTime( self, level ) + bonus
end

function furion_sprout_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor( "duration" )
    local radius = self:GetSpecialValueFor( "radius" )
    local vision_range = self:GetSpecialValueFor( "vision_range" )

    if self:GetCaster():HasModifier("modifier_furion_20") then
    	duration = duration + self.modifier_furion_20[self:GetCaster():GetTalentLevel("modifier_furion_20")]
    end

    local hTarget = self:GetCursorTarget()

    if hTarget == nil or ( hTarget ~= nil and ( not hTarget:TriggerSpellAbsorb( self ) ) ) then
        
        local vTargetPosition = nil

        if hTarget ~= nil then 
            vTargetPosition = hTarget:GetOrigin()
        else
            vTargetPosition = self:GetCursorPosition()
        end

        local r = radius 
        local c = math.sqrt( 2 ) * 0.5 * r 
        local x_offset = { -r, -c, 0.0, c, r, c, 0.0, -c }
        local y_offset = { 0.0, c, r, c, 0.0, -c, -r, -c }

        local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_sprout.vpcf", PATTACH_CUSTOMORIGIN, nil )
        ParticleManager:SetParticleControl( nFXIndex, 0, vTargetPosition )
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 0.0, r, 0.0 ) )
        ParticleManager:ReleaseParticleIndex( nFXIndex )

        for i = 1,8 do
            CreateTempTree( vTargetPosition + Vector( x_offset[i], y_offset[i], 0.0 ), duration )
        end

        for i = 1,8 do
            ResolveNPCPositions( vTargetPosition + Vector( x_offset[i], y_offset[i], 0.0 ), 64.0 )
        end

	    if self:GetCaster():HasModifier("modifier_furion_18") then
            self:GetCaster():Purge(false, true, false, false, false)
	    	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_furion_sprout_custom_magic_immune", {duration = self.modifier_furion_18[self:GetCaster():GetTalentLevel("modifier_furion_18")]})
	    end

        local sprout_damage = self:GetSpecialValueFor("sprout_damage")
        if self:GetCaster():HasModifier("modifier_furion_17") then
            sprout_damage = sprout_damage + self.modifier_furion_17_damage
        end
        local sprout_damage_radius = self:GetSpecialValueFor("sprout_damage_radius")
        local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), vTargetPosition, nil, sprout_damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _, unit in pairs(targets) do
            ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = sprout_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
        end

        AddFOWViewer( self:GetCaster():GetTeamNumber(), vTargetPosition, radius+100, duration, false )
        --CreateModifierThinker( self:GetCaster(), self, "modifier_furion_sprout_custom_thinker_damage", {duration = duration}, vTargetPosition, self:GetCaster():GetTeamNumber(), false )
        EmitSoundOnLocationWithCaster( vTargetPosition, "Hero_Furion.Sprout", self:GetCaster() )
        if self:GetCaster():HasModifier("modifier_furion_16") then
            CreateModifierThinker( self:GetCaster(), self, "modifier_furion_sprout_custom_thinker_heal", {duration = duration}, vTargetPosition, self:GetCaster():GetTeamNumber(), false )
	    end
    end
end

modifier_furion_sprout_custom_thinker_damage = class({})
function modifier_furion_sprout_custom_thinker_damage:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_sprout_damage_aoe.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self:GetAbility():GetSpecialValueFor( "sprout_damage_radius" ), 0,0 ))
    self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_furion_sprout_custom_thinker_damage:IsAura()
    return true
end

function modifier_furion_sprout_custom_thinker_damage:GetModifierAura()
    return "modifier_furion_sprout_custom_thinker_debuff"
end

function modifier_furion_sprout_custom_thinker_damage:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor( "sprout_damage_radius" )
end

function modifier_furion_sprout_custom_thinker_damage:GetAuraDuration()
    return 0
end

function modifier_furion_sprout_custom_thinker_damage:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_furion_sprout_custom_thinker_damage:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_furion_sprout_custom_thinker_damage:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_furion_sprout_custom_thinker_debuff = class({})
function modifier_furion_sprout_custom_thinker_debuff:OnCreated()
    self.sprout_damage = self:GetAbility():GetSpecialValueFor("sprout_damage")
    self.sprout_damage_inteval = self:GetAbility():GetSpecialValueFor("sprout_damage_inteval")
    self.sprout_damage_radius = self:GetAbility():GetSpecialValueFor("sprout_damage_radius")
    if not IsServer() then return end
    self:StartIntervalThink(self.sprout_damage_inteval)
end
function modifier_furion_sprout_custom_thinker_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.sprout_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

modifier_furion_sprout_custom_magic_immune = class({})

function modifier_furion_sprout_custom_magic_immune:IsPurgable() return false end

function modifier_furion_sprout_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_furion_sprout_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_furion_sprout_custom_magic_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_furion_sprout_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_furion_sprout_custom_magic_immune:StatusEffectPriority()
    return 99999
end

modifier_furion_sprout_custom_regen = class({})

function modifier_furion_sprout_custom_regen:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_furion_sprout_custom_regen:GetModifierConstantManaRegen()
	return self:GetAbility().modifier_furion_16[self:GetCaster():GetTalentLevel("modifier_furion_16")]
end

function modifier_furion_sprout_custom_regen:GetModifierConstantHealthRegen()
	return self:GetAbility().modifier_furion_16[self:GetCaster():GetTalentLevel("modifier_furion_16")]
end

modifier_furion_sprout_custom_trees = class({})

function modifier_furion_sprout_custom_trees:IsHidden() return self:GetStackCount() == 0 end

function modifier_furion_sprout_custom_trees:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_furion_sprout_custom_trees:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_furion_21") then return end
	local trees = GridNav:GetAllTreesAroundPoint(self:GetCaster():GetAbsOrigin(), self:GetAbility().modifier_furion_21_radius, false)
	self:SetStackCount(#trees * self:GetAbility().modifier_furion_21[self:GetCaster():GetTalentLevel("modifier_furion_21")])
end

function modifier_furion_sprout_custom_trees:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE 
	}
end

function modifier_furion_sprout_custom_trees:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount()
end

modifier_furion_sprout_custom_thinker_heal = class({})
function modifier_furion_sprout_custom_thinker_heal:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_sprout_healing_aoe.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self:GetAbility():GetSpecialValueFor( "radius" ), 0,0 ))
    self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_furion_sprout_custom_thinker_heal:IsAura()
    return true
end

function modifier_furion_sprout_custom_thinker_heal:GetModifierAura()
    return "modifier_furion_sprout_custom_regen"
end

function modifier_furion_sprout_custom_thinker_heal:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_furion_sprout_custom_thinker_heal:GetAuraDuration()
    return 0
end

function modifier_furion_sprout_custom_thinker_heal:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_furion_sprout_custom_thinker_heal:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_furion_sprout_custom_thinker_heal:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end