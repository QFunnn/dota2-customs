--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_culling_blade_custom", "heroes/npc_dota_hero_axe_custom/axe_culling_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_culling_blade_custom_handler", "heroes/npc_dota_hero_axe_custom/axe_culling_blade_custom", LUA_MODIFIER_MOTION_NONE )

axe_culling_blade_custom = class({})
axe_culling_blade_custom.modifier_axe_5 = {200,350,500}
axe_culling_blade_custom.modifier_axe_4 = {-12,-24,-36}
axe_culling_blade_custom.modifier_axe_6_radius = 300
axe_culling_blade_custom.modifier_axe_6_range = 225
axe_culling_blade_custom.modifier_axe_2 = 0.5
axe_culling_blade_custom.mods_list_invul =
{
    "modifier_dazzle_shallow_grave_custom",
    "modifier_furion_force_of_nature_custom_immortal",
    "modifier_muerta_pierce_the_veil_custom",
    "modifier_oracle_change_of_fate",
    "modifier_oracle_false_promise_custom",
    "modifier_item_helm_of_the_undying_custom_buff",
    "modifier_dragon_knight_13_buff",
    "modifier_huskar_1_buff",
    "modifier_lion_11_buff",
    "modifier_vengefulspirit_10_buff",
    "modifier_modifier_windrunner_20_buff",
    "modifier_winter_wyvern_19_buff",
    "modifier_dazzle_shallow_grave",
    "modifier_necrolyte_reapers_scythe_custom",
}

function axe_culling_blade_custom:GetCastRange(location, target)
	local bonus = 0
    if self:GetCaster():HasModifier("modifier_axe_6") then
        bonus = bonus + self.modifier_axe_6_range
    end
    return self.BaseClass.GetCastRange(self, location, target) + bonus
end

function axe_culling_blade_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_axe_4") then
        bonus = self.modifier_axe_4[self:GetCaster():GetTalentLevel("modifier_axe_4")]
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function axe_culling_blade_custom:GetAOERadius()
    return self:GetCaster():GetAoeBonus(self.modifier_axe_6_radius)
end

function axe_culling_blade_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_axe_6") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function axe_culling_blade_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_culling_blade.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/ti6/blink_dagger_end_ti6.vpcf", context)
end

function axe_culling_blade_custom:GetIntrinsicModifierName()
    return "modifier_axe_culling_blade_custom_handler"
end

function axe_culling_blade_custom:OnSpellStart()
    if not IsServer() then return end
	local target = self:GetCursorTarget()
    local point = self:GetCursorPosition()
    if self:GetCaster():HasModifier("modifier_axe_6") then
        local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        EmitSoundOnLocationWithCaster( self:GetCaster():GetAbsOrigin(), "DOTA_Item.BlinkDagger.Activate" , self:GetCaster() )
        FindClearSpaceForUnit(self:GetCaster(), point, true)
        local particle_end = ParticleManager:CreateParticle("particles/econ/events/ti6/blink_dagger_end_ti6.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle_end, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle_end)
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetCaster():GetAoeBonus(self.modifier_axe_6_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _, unit in pairs(units) do
            self:CullingTarget(unit)
        end
        self:GetCaster():EmitSound("DOTA_Item.BlinkDagger.Activate")
    else
        if target:TriggerSpellAbsorb(self) then return end
        self:CullingTarget(target)
    end
end

function axe_culling_blade_custom:CullingTarget(target)
    local particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade.vpcf"
	local sound_cast = "Hero_Axe.Culling_Blade_Fail"
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_axe_5") then
        damage = damage + (self.modifier_axe_5[self:GetCaster():GetTalentLevel("modifier_axe_5")] * self:GetCaster():GetPhysicalArmorValue(false) / 100)
    end
    local success = false
	if target:GetHealth() <= damage and (target:IsHero() or self:GetCaster():HasModifier("modifier_axe_4")) then 
        success = true 
    end
    if target:IsAncient() then
        success = false
    end
    if success then
        if target and not target:IsNull() then
            target:Kill(self, self:GetCaster())
            if self.mods_list_invul then
                for _, mod_name in pairs(self.mods_list_invul) do
                    local modifier = target:FindModifierByName(mod_name)
                    if modifier then
                        modifier:Destroy()
                    end
                end
            end
            if target:IsAlive() then
                target:Kill(self, self:GetCaster())
            end
            if target:IsRealHero() and not target:IsAlive() then
                local modifier_axe_culling_blade_custom_handler = self:GetCaster():FindModifierByName("modifier_axe_culling_blade_custom_handler")
                if modifier_axe_culling_blade_custom_handler then
                    modifier_axe_culling_blade_custom_handler:AddStackCount(1)
                end
            end
            self:DeathSuccess(target)
            particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf"
            sound_cast = "Hero_Axe.Culling_Blade_Success"
            if target:IsRealHero() then
                self.kills_counter = (self.kills_counter or 0) + 1
            end
        end
    else
        ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self})
        if not target:IsAlive() and (target:IsHero() or self:GetCaster():HasModifier("modifier_axe_4")) then
            self:DeathSuccess(target)
            if target:IsRealHero() then
                self.kills_counter = (self.kills_counter or 0) + 1
            end
            sound_cast = "Hero_Axe.Culling_Blade_Success"
            if target:IsRealHero() and not target:IsAlive() then
                local modifier_axe_culling_blade_custom_handler = self:GetCaster():FindModifierByName("modifier_axe_culling_blade_custom_handler")
                if modifier_axe_culling_blade_custom_handler then
                    modifier_axe_culling_blade_custom_handler:AddStackCount(1)
                end
            end
        end
    end
    local direction = (target:GetOrigin() - self:GetCaster():GetOrigin()):Normalized()
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 4, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 3, direction )
	ParticleManager:SetParticleControlForward( effect_cast, 4, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOn( sound_cast, target )
end

function axe_culling_blade_custom:DeathSuccess(target)
    self:EndCooldown()
    if not target:IsHero() then return end
    local radius = self:GetSpecialValueFor("speed_aoe")
    local duration = self:GetSpecialValueFor("speed_duration")
    local allies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0, false)
    for _, target in pairs(allies) do
        target:AddNewModifier(self:GetCaster(), self, "modifier_axe_culling_blade_custom", { duration = duration })
    end
end

modifier_axe_culling_blade_custom = class({})

function modifier_axe_culling_blade_custom:OnCreated( kv )
	self.armor_bonus = self:GetAbility():GetSpecialValueFor( "armor_bonus" )
	self.speed_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_axe_culling_blade_custom:OnRefresh( kv )
	self.armor_bonus = self:GetAbility():GetSpecialValueFor( "armor_bonus" )
	self.speed_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_axe_culling_blade_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_axe_culling_blade_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.speed_bonus
end

function modifier_axe_culling_blade_custom:GetModifierPhysicalArmorBonus()
	return self.armor_bonus
end

function modifier_axe_culling_blade_custom:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf"
end

function modifier_axe_culling_blade_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


modifier_axe_culling_blade_custom_handler = class({})
function modifier_axe_culling_blade_custom_handler:IsPurgable() return false end
function modifier_axe_culling_blade_custom_handler:IsPurgeException() return false end
function modifier_axe_culling_blade_custom_handler:RemoveOnDeath() return false end

function modifier_axe_culling_blade_custom_handler:OnCreated()
    self.armor_per_stack = self:GetAbility():GetSpecialValueFor("armor_per_stack")
end

function modifier_axe_culling_blade_custom_handler:OnRefresh()
    self.armor_per_stack = self:GetAbility():GetSpecialValueFor("armor_per_stack")
end

function modifier_axe_culling_blade_custom_handler:AddStackCount(count)
    if not IsServer() then return end
    self:SetStackCount(self:GetStackCount()+count)
end

function modifier_axe_culling_blade_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end

function modifier_axe_culling_blade_custom_handler:GetModifierPhysicalArmorBonus()
    local bonus = 0
    if self:GetParent():HasModifier("modifier_axe_2") then
        bonus = self:GetAbility().modifier_axe_2
    end
    return self:GetStackCount() * (self.armor_per_stack + bonus)
end