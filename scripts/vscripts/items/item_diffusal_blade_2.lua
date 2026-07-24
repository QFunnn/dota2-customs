--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_diffusal_blade_2_custom", "items/item_diffusal_blade_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_diffusal_blade_2_custom_debuff", "items/item_diffusal_blade_2", LUA_MODIFIER_MOTION_NONE)

item_diffusal_blade_2_custom = class({})

function item_diffusal_blade_2_custom:GetIntrinsicModifierName()
	return "modifier_item_diffusal_blade_2_custom"
end

function item_diffusal_blade_2_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("purge_slow_duration")
	local target = self:GetCursorTarget()
	if target:IsMagicImmune() then return end
	if target:TriggerSpellAbsorb(self) then return end
	self:GetCaster():EmitSound("DOTA_Item.DiffusalBlade.Activate")
	target:EmitSound("DOTA_Item.DiffusalBlade.Target")
	target:AddNewModifier(self:GetCaster(), self, "modifier_item_diffusal_blade_2_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})
    if not target:IsDebuffImmune() then
	    target:Purge(true, false, false, false, false)
    end
end

modifier_item_diffusal_blade_2_custom = class({})

function modifier_item_diffusal_blade_2_custom:IsHidden()		return true end
function modifier_item_diffusal_blade_2_custom:IsPurgable() return false end
function modifier_item_diffusal_blade_2_custom:IsPurgeException() return false end
function modifier_item_diffusal_blade_2_custom:RemoveOnDeath()	return false end
function modifier_item_diffusal_blade_2_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_diffusal_blade_2_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
end

function modifier_item_diffusal_blade_2_custom:GetModifierBonusStats_Agility()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_agility")
    end
end

function modifier_item_diffusal_blade_2_custom:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
    end
end

function modifier_item_diffusal_blade_2_custom:GetModifierProcAttack_BonusDamage_Physical(keys)
    local target = keys.target
    if self:GetParent():FindAllModifiersByName("modifier_item_diffusal_blade_2_custom")[1] ~= self then return end
    if self:GetParent():HasItemInInventory("item_disperser") then return end
    local manaburn_pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(manaburn_pfx, 0, target:GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex(manaburn_pfx)
    local manaBurn = self:GetAbility():GetSpecialValueFor("feedback_mana_burn")
    local manaDamage = self:GetAbility():GetSpecialValueFor("damage_per_burn")
    local feedback_mana_burn_illusion = self:GetAbility():GetSpecialValueFor("feedback_mana_burn_illusion")
    if self:GetParent():HasItemInInventory("item_diffusal_blade") then
        feedback_mana_burn_illusion = 0
        manaBurn = 8
    end
    local damage = 0
    if not target:IsMagicImmune() then
        if(target:GetMana() >= manaBurn) then
            damage = manaBurn * manaDamage
            if not self:GetParent():IsIllusion() then
                target:Script_ReduceMana(manaBurn, self:GetAbility())
            else
                target:Script_ReduceMana(feedback_mana_burn_illusion, self:GetAbility())
                damage = feedback_mana_burn_illusion * manaDamage
            end
        else
            damage = target:GetMana() * manaDamage
            if not self:GetParent():IsIllusion() then
                target:Script_ReduceMana(manaBurn, self:GetAbility())
            else
                target:Script_ReduceMana(feedback_mana_burn_illusion, self:GetAbility())
            end
        end
        return damage
    end
end

modifier_item_diffusal_blade_2_custom_debuff = class({
	IsDebuff =            function() return true end,
	GetEffectAttachType = function() return PATTACH_OVERHEAD_FOLLOW end,
	GetEffectName =       function() return "particles/items_fx/diffusal_slow.vpcf" end,
})

function modifier_item_diffusal_blade_2_custom_debuff:OnCreated()
    self.mv = -100
end

function modifier_item_diffusal_blade_2_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_diffusal_blade_2_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.mv
end