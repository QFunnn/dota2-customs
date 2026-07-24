--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_diffusal_basher", "items/item_diffusal_basher", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_diffusal_basher_debuff", "items/item_diffusal_basher", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_diffusal_basher_cooldown", "items/item_diffusal_basher", LUA_MODIFIER_MOTION_NONE)

item_diffusal_basher = class({})

function item_diffusal_basher:GetIntrinsicModifierName()
	return "modifier_item_diffusal_basher"
end

function item_diffusal_basher:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("purge_slow_duration")
	local target = self:GetCursorTarget()
	if target:IsMagicImmune() then return end
	if target:TriggerSpellAbsorb(self) then return end
	self:GetCaster():EmitSound("DOTA_Item.DiffusalBlade.Activate")
	target:EmitSound("DOTA_Item.DiffusalBlade.Target")
	target:AddNewModifier(self:GetCaster(), self, "modifier_item_diffusal_basher_debuff", {duration = duration * (1 - target:GetStatusResistance())})
end

modifier_item_diffusal_basher = class({})

function modifier_item_diffusal_basher:IsHidden()		return true end
function modifier_item_diffusal_basher:IsPurgable() return false end
function modifier_item_diffusal_basher:IsPurgeException() return false end
function modifier_item_diffusal_basher:RemoveOnDeath()	return false end

function modifier_item_diffusal_basher:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
end

function modifier_item_diffusal_basher:GetModifierPreAttack_BonusDamage()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_damage")
    end
end

function modifier_item_diffusal_basher:GetModifierBonusStats_Agility()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_diffusal_basher:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_diffusal_basher:GetModifierBonusStats_Strength()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_diffusal_basher:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_diffusal_basher:GetModifierProcAttack_BonusDamage_Physical(params)
    if self:GetParent():FindAllModifiersByName("modifier_item_diffusal_basher")[1] ~= self then return end
    if self:GetParent():GetUnitName() == "npc_dota_hero_faceless_void" then return end
    if self:GetParent():HasItemInInventory("item_basher") then return end
    if self:GetParent():HasItemInInventory("item_abyssal_blade") then return end
    if self:GetParent():HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    local target = params.target
    local chance = self:GetAbility():GetSpecialValueFor("chance_melee")
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then
        chance = self:GetAbility():GetSpecialValueFor("chance_range")
    end
    local cooldown_bash = self:GetAbility():GetSpecialValueFor("cooldown_bash")
    if RollPercentage(chance) and not self:GetParent():HasModifier("modifier_item_diffusal_basher_cooldown") and not self:GetParent():IsIllusion() then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_diffusal_basher_cooldown", {duration = cooldown_bash})
        self:GetParent():EmitSound("DOTA_Item.SkullBasher")
        local manaburn_pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControl(manaburn_pfx, 0, target:GetAbsOrigin() )
        ParticleManager:ReleaseParticleIndex(manaburn_pfx)
        local manaBurn = self:GetAbility():GetSpecialValueFor("feedback_mana_burn")
        local manaDamage = self:GetAbility():GetSpecialValueFor("damage_per_burn")
        local stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
        params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = stun_duration * (1 - params.target:GetStatusResistance())})
        local damage = 0
        if (target:GetMana() >= manaBurn) then
            damage = manaBurn * manaDamage
            target:Script_ReduceMana(manaBurn, self:GetAbility())
        else
            damage = target:GetMana() * manaDamage
            target:Script_ReduceMana(manaBurn, self:GetAbility())
        end
        return damage
    end
end

modifier_item_diffusal_basher_debuff = class({
	IsDebuff =            function() return true end,
	GetEffectAttachType = function() return PATTACH_OVERHEAD_FOLLOW end,
	GetEffectName =       function() return "particles/items_fx/diffusal_slow.vpcf" end,
})

function modifier_item_diffusal_basher_debuff:OnCreated()
    self.mv = -100
end

function modifier_item_diffusal_basher_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_diffusal_basher_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.mv
end

modifier_item_diffusal_basher_cooldown = class({})

function modifier_item_diffusal_basher_cooldown:IsHidden() return true end
function modifier_item_diffusal_basher_cooldown:IsPurgable() return false end
function modifier_item_diffusal_basher_cooldown:RemoveOnDeath() return false end