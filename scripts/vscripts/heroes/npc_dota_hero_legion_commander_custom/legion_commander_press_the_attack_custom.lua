--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_legion_commander_press_the_attack_custom_buff", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_press_the_attack_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_press_the_attack_custom_magic_immune", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_press_the_attack_custom", LUA_MODIFIER_MOTION_NONE)

legion_commander_press_the_attack_custom = class({})

function legion_commander_press_the_attack_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_press.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_press_hands.vpcf", context )
    PrecacheResource( "particle", "particles/items_fx/black_king_bar_avatar.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_avatar.vpcf", context )
end

legion_commander_press_the_attack_custom.modifier_legion_commander_15 = {1,2,3}
legion_commander_press_the_attack_custom.modifier_legion_commander_20 = {15,30}
legion_commander_press_the_attack_custom.modifier_legion_commander_18 = {5,10,15}
legion_commander_press_the_attack_custom.modifier_legion_commander_18_radius = 500

function legion_commander_press_the_attack_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_legion_commander_18") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function legion_commander_press_the_attack_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_legion_commander_18") then
        return self.modifier_legion_commander_18_radius
    end
    return 0
end

function legion_commander_press_the_attack_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_legion_commander_16") then
		return 0
	end
    return self.BaseClass.GetManaCost(self, level)
end

function legion_commander_press_the_attack_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_legion_commander_20") then
        return "legion_commander_20"
    end
    return "legion_commander_press_the_attack"
end

function legion_commander_press_the_attack_custom:OnSpellStart()
	if not IsServer() then return end
    local target = self:GetCursorTarget()
    local point = self:GetCursorPosition()
    if self:GetCaster():HasModifier("modifier_legion_commander_18") then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self.modifier_legion_commander_18_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
        for _, unit in pairs(units) do
            self:OnTarget(unit)
        end
        self:OnTarget(self:GetCaster())
    else
        self:OnTarget(target)
    end
end

function legion_commander_press_the_attack_custom:OnTarget(target)
    if not IsServer() then return end
    target:Purge(false , true, false , true, false)
	local duration = self:GetSpecialValueFor("duration")
	if self:GetCaster():HasModifier("modifier_legion_commander_15") then
		duration = duration + self.modifier_legion_commander_15[self:GetCaster():GetTalentLevel("modifier_legion_commander_15")]
	end
	target:EmitSound("Hero_LegionCommander.PressTheAttack")
	target:AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_press_the_attack_custom_buff", {duration = duration})
end

function legion_commander_press_the_attack_custom:OnSpellStartCustom()
	if not IsServer() then return end
	self:OnTarget(self:GetCaster())
end

modifier_legion_commander_press_the_attack_custom_buff = class({})

function modifier_legion_commander_press_the_attack_custom_buff:OnCreated(table)
	self.move_speed = self:GetAbility():GetSpecialValueFor("move_speed")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    if self:GetCaster():HasModifier("modifier_legion_commander_18") then
        self.move_speed = self.move_speed + self:GetAbility().modifier_legion_commander_18[self:GetCaster():GetTalentLevel("modifier_legion_commander_18")]
    end
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_legion_commander/legion_commander_press.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( particle, 1, self:GetParent():GetAbsOrigin() )
	self:AddParticle(particle, false, false, -1, false, false)
	local cast = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_press_hands.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
	ParticleManager:SetParticleControlEnt(cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt(cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt(cast, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true )
	self:AddParticle(cast, false, false, -1, false, false)
end

function modifier_legion_commander_press_the_attack_custom_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_legion_commander_press_the_attack_custom_buff:GetModifierConstantHealthRegen()
	return self.hp_regen
end

function modifier_legion_commander_press_the_attack_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed
end

function modifier_legion_commander_press_the_attack_custom_buff:GetModifierSpellAmplify_Percentage()
	if self:GetCaster():HasModifier("modifier_legion_commander_20") then
		return self:GetAbility().modifier_legion_commander_20[self:GetCaster():GetTalentLevel("modifier_legion_commander_20")]
	end
end

modifier_legion_commander_press_the_attack_custom_magic_immune = class({})

function modifier_legion_commander_press_the_attack_custom_magic_immune:IsPurgable() return false end


function modifier_legion_commander_press_the_attack_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:CheckState()
    return {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:GetTexture()
	return "legion_commander_18"
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_legion_commander_press_the_attack_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end