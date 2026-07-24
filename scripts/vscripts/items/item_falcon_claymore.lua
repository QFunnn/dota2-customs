--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_falcon_claymore", "items/item_falcon_claymore", LUA_MODIFIER_MOTION_NONE)

item_falcon_claymore = class({})

function item_falcon_claymore:GetIntrinsicModifierName()
	return "modifier_item_falcon_claymore"
end

modifier_item_falcon_claymore = class({})

function modifier_item_falcon_claymore:IsHidden() return true end

function modifier_item_falcon_claymore:IsPurgable() return false end
function modifier_item_falcon_claymore:IsPurgeException() return false end

function modifier_item_falcon_claymore:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		 
	}
end

function modifier_item_falcon_claymore:GetModifierPreAttack_BonusDamage()
	return  self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_falcon_claymore:GetModifierHealthBonus()
	return  self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_falcon_claymore:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_falcon_claymore:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_falcon_claymore:OnAttackLanded(params)
	if params.attacker == self:GetParent() then
        if params.target:IsOther() then
            return nil
        end

        if self:GetParent():IsIllusion() then
            return nil
        end

        if not self:GetAbility():IsFullyCastable() then
        	return nil
        end

        if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then
        	return nil
        end
        
        if self:GetParent():FindAllModifiersByName("modifier_item_falcon_claymore")[1] ~= self then return end

        local splash = self:GetAbility():GetSpecialValueFor("splash")

        local splash_radius = self:GetAbility():GetSpecialValueFor("splash_radius")

        self:GetParent():EmitSound("DOTA_Item.BattleFury")

        DoCleaveAttack( params.attacker, params.target, self:GetAbility(), (params.damage / 100 * splash), splash_radius, splash_radius, splash_radius, "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf" )

        self:GetAbility():UseResources(false, false, false, true)
    end
end