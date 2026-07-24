--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_orchid_custom", "items/item_orchid_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_orchid_custom_active", "items/item_orchid_custom", LUA_MODIFIER_MOTION_NONE )

item_orchid_custom = class({})

function item_orchid_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("silence_duration")
    local silence_damage_percent = self:GetSpecialValueFor("silence_damage_percent")
	local target = self:GetCursorTarget()
    if target:IsMagicImmune() then return end
    if target:TriggerSpellAbsorb(self) then return end
    target:EmitSound("DOTA_Item.Bloodthorn.Activate")
	target:AddNewModifier(self:GetCaster(), self, "modifier_item_orchid_custom_active", {duration = duration * (1 - target:GetStatusResistance())})
end

function item_orchid_custom:GetIntrinsicModifierName() 
    return "modifier_item_orchid_custom"
end

modifier_item_orchid_custom = class({})

function modifier_item_orchid_custom:IsHidden()
    return true
end

function modifier_item_orchid_custom:IsPurgable() return false end
function modifier_item_orchid_custom:IsPurgeException() return false end

function modifier_item_orchid_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_orchid_custom:DeclareFunctions()
    return  
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_item_orchid_custom:GetModifierPreAttack_BonusDamage()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_damage")
	end
end

function modifier_item_orchid_custom:GetModifierConstantManaRegen()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor('bonus_mana_regen')
	end
end

function modifier_item_orchid_custom:GetModifierAttackSpeedBonus_Constant()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	end
end

function modifier_item_orchid_custom:GetModifierConstantHealthRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
    end
end

function modifier_item_orchid_custom:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_intellect")
    end
end

function modifier_item_orchid_custom:GetModifierPreAttack_CriticalStrike( params )
    local passive_crit_chance = self:GetAbility():GetSpecialValueFor("passive_crit_chance")
    local passive_crit = self:GetAbility():GetSpecialValueFor("passive_crit")

    if not IsServer() then return end

    if params.target:IsOther() then
        return nil
    end

    if RollPercentage(passive_crit_chance) then
        return passive_crit
    end

    return 0
end

modifier_item_orchid_custom_active = class({})

function modifier_item_orchid_custom_active:GetEffectName()
    return "particles/items2_fx/orchid.vpcf"
end

function modifier_item_orchid_custom_active:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_item_orchid_custom_active:CheckState()
    return 
    {
        [MODIFIER_STATE_SILENCED] = true,
    }
end

function modifier_item_orchid_custom_active:OnCreated()
    if IsServer() then
        self.damage = 0
    end
end

function modifier_item_orchid_custom_active:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    self.damage = self.damage + params.damage
end

function modifier_item_orchid_custom_active:OnDestroy()
    if not IsServer() then return end
    if not self:GetAbility() then return end
    if self:GetRemainingTime() <= 0 then
        local damage = self.damage * self:GetAbility():GetSpecialValueFor("silence_damage_percent") * 0.01
        ParticleManager:SetParticleControl(ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent()), 1, Vector(damage))
        if damage > 0 then
            ApplyDamage({ attacker = self:GetCaster(), victim = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, ability = self:GetAbility() })
        end
    end
end