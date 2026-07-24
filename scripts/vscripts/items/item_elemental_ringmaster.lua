--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_elemental_ringmaster", "items/item_elemental_ringmaster", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_elemental_ringmaster_red_buff", "items/item_elemental_ringmaster", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_elemental_ringmaster_blue_buff", "items/item_elemental_ringmaster", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_elemental_ringmaster_purple_buff", "items/item_elemental_ringmaster", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_ring_lua", "modifiers/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)

item_elemental_ringmaster = class({})

function item_elemental_ringmaster:GetAbilityTextureName()
    return "item_elemental_ringmaster_"..(self:GetSecondaryCharges()+1)
end

function item_elemental_ringmaster:GetIntrinsicModifierName()
    if self:GetCaster():IsIllusion() then return end
    return "modifier_item_elemental_ringmaster"
end

function item_elemental_ringmaster:GetCooldown(iLevel)
    if IsClient() then
        return self:GetSpecialValueFor("swap_interval")
    end
end

function item_elemental_ringmaster:ChangeItemEffect()
    if not IsServer() then return end
    local buff_duration = self:GetSpecialValueFor("swap_interval") * self:GetCaster():GetCooldownReduction()
    local heal = self:GetSpecialValueFor("heal")
    local radius = self:GetSpecialValueFor("radius")
    local speed = self:GetSpecialValueFor("speed")
    local damage_percent = self:GetSpecialValueFor("damage_percent")
    if self:GetSecondaryCharges() == 0 then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_elemental_ringmaster_red_buff", {duration = buff_duration})
    elseif self:GetSecondaryCharges() == 1 then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_elemental_ringmaster_blue_buff", {duration = buff_duration})
    elseif self:GetSecondaryCharges() == 2 then
        self:GetCaster():Purge(false, true, false, false, false)
        self:GetCaster():Heal(heal, self)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetCaster(), heal, nil)
		self:GetCaster():EmitSound("Item.GuardianGreaves.Target")
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_drunken_stance_earth.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex(particle)
    elseif self:GetSecondaryCharges() == 3 then
        local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius*2, radius*2, radius*2 ) )
	    ParticleManager:ReleaseParticleIndex( effect_cast )
        local pulse = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_generic_ring_lua", {end_radius = radius, speed = speed, target_team = DOTA_UNIT_TARGET_TEAM_ENEMY, target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC})
        local damage = (self:GetCaster():GetStrength() + self:GetCaster():GetAgility() + self:GetCaster():GetIntellect(false)) / 100 * damage_percent
        self:GetCaster():EmitSound("Hero_VoidSpirit.Pulse")
        if pulse then
            pulse:SetCallback( function( enemy )
                ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
            end)
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_drunken_stance_void.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_elemental_ringmaster_purple_buff", {duration = buff_duration})
    end
end

modifier_item_elemental_ringmaster = class({})
function modifier_item_elemental_ringmaster:IsPurgable() return false end
function modifier_item_elemental_ringmaster:IsHidden() return true end
function modifier_item_elemental_ringmaster:IsPurgeException() return false end
function modifier_item_elemental_ringmaster:RemoveOnDeath() return false end
function modifier_item_elemental_ringmaster:OnCreated()
    self.all_stats = self:GetAbility():GetSpecialValueFor("all_stats")
    self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
    self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
    self.swap_interval = self:GetAbility():GetSpecialValueFor("swap_interval")
    if not IsServer() then return end
    if not self:GetAbility().init then
        self:GetAbility():ChangeItemEffect()
        self:GetAbility().init = true
    end
    self.tick_interval = 0
    self:GetAbility():EndCooldown()
    local cooldown_new = self:GetAbility():GetSpecialValueFor("swap_interval") * self:GetCaster():GetCooldownReduction()
    self:GetAbility():StartCooldown(cooldown_new)
    self:StartIntervalThink(FrameTime())
end

function modifier_item_elemental_ringmaster:OnIntervalThink()
    if not self:GetParent():IsAlive() then return end
    local cooldown_new = self:GetAbility():GetSpecialValueFor("swap_interval") * self:GetCaster():GetCooldownReduction()
    self.tick_interval = self.tick_interval + FrameTime()
    if self.tick_interval >= cooldown_new then
        if self:GetAbility():GetSecondaryCharges() < 3 then
            self:GetAbility():SetSecondaryCharges(self:GetAbility():GetSecondaryCharges() + 1)
        else
            self:GetAbility():SetSecondaryCharges(0)
        end
        self:GetAbility():ChangeItemEffect()
        self.tick_interval = 0
        self:GetAbility():StartCooldown(cooldown_new)
    end
end

function modifier_item_elemental_ringmaster:OnDestroy()
    if not IsServer() then return end
    self:GetAbility():EndCooldown()
end

function modifier_item_elemental_ringmaster:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_item_elemental_ringmaster:GetModifierBonusStats_Strength()
    return self.all_stats
end

function modifier_item_elemental_ringmaster:GetModifierBonusStats_Agility()
    return self.all_stats
end

function modifier_item_elemental_ringmaster:GetModifierBonusStats_Intellect()
    return self.all_stats
end

function modifier_item_elemental_ringmaster:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end

function modifier_item_elemental_ringmaster:GetModifierConstantManaRegen()
    return self.mana_regen
end

function modifier_item_elemental_ringmaster:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_elemental_ringmaster:GetModifierHealthBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_health")
end


modifier_item_elemental_ringmaster_red_buff = class({})
function modifier_item_elemental_ringmaster_red_buff:GetTexture() return "item_elemental_ringmaster_1" end
function modifier_item_elemental_ringmaster_red_buff:OnCreated()
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_drunken_stance_fire.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(self.particle, true, false, -1, false, false)
end
function modifier_item_elemental_ringmaster_red_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end
function modifier_item_elemental_ringmaster_red_buff:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("outgoing_damage")
end


modifier_item_elemental_ringmaster_blue_buff = class({})
function modifier_item_elemental_ringmaster_blue_buff:GetTexture() return "item_elemental_ringmaster_2" end
function modifier_item_elemental_ringmaster_blue_buff:OnCreated()
    self.vision_radius = self:GetAbility():GetSpecialValueFor("vision_radius")
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_drunken_stance_storm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(self.particle, true, false, -1, false, false)
    self:StartIntervalThink(FrameTime())
end
function modifier_item_elemental_ringmaster_blue_buff:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.vision_radius, FrameTime(), false)
end
function modifier_item_elemental_ringmaster_blue_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end
function modifier_item_elemental_ringmaster_blue_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("bonus_speed")
end

modifier_item_elemental_ringmaster_purple_buff = class({})
function modifier_item_elemental_ringmaster_purple_buff:IsPurgable() return false end
function modifier_item_elemental_ringmaster_purple_buff:CustomIncreaseModifierDuration()
	return self:GetAbility():GetSpecialValueFor("debuff_increase")
end