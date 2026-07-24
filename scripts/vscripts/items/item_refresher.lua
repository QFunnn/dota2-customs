--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_refresher_custom", "items/item_refresher", LUA_MODIFIER_MOTION_NONE)

item_refresher_custom = class({})

function item_refresher_custom:GetIntrinsicModifierName()
	return "modifier_item_refresher_custom"
end

function item_refresher_custom:IsRefreshable()
    return false
end

function item_refresher_custom:OnSpellStart()
    local caster = self:GetCaster()

    for i = 0, caster:GetAbilityCount() - 1 do
        local ability = caster:GetAbilityByIndex(i)
        if ability and ability:GetAbilityType() ~= ABILITY_TYPE_ATTRIBUTES and ability ~= self and ability:IsRefreshable() then
            ability:RefreshCharges()
            ability:EndCooldown()
        end
    end

    caster:EmitSound("DOTA_Item.Refresher.Activate")
    local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_item_refresher_custom = class({})

function modifier_item_refresher_custom:IsHidden() return true end
function modifier_item_refresher_custom:IsPurgable() return false end
function modifier_item_refresher_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_refresher_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    }
end

function modifier_item_refresher_custom:GetModifierConstantManaRegen()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_mana_regen") end
end

function modifier_item_refresher_custom:GetModifierConstantHealthRegen()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_health_regen") end
end