--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ex_machina_custom", "items/ex_machine", LUA_MODIFIER_MOTION_NONE)

item_ex_machina_custom = class({})

item_ex_machina_custom.NotRefresh = {
    ["item_refresher"] = true,
    ["item_refresher_custom"] = true,
    ["item_refresher_shard"] = true,
    ["item_ex_machina_custom"] = true,
    ["item_black_king_bar"] = true,
    ["item_extra_creature_ogreseal"] = true,
    -- Aeon Disk: в ваниле его КД не сбрасывается Ex Machina. У нас диск КАСТОМНЫЙ
    -- (item_aeon_disk_lua; ванильный item_aeon_disk отключён — IsObsolete в
    -- npc_abilities_override.txt), поэтому ванильный блок не действовал и КД сбрасывался.
    ["item_aeon_disk_lua"] = true,
    ["ability_disruptor_aeon"] = true,
    ["ability_undying_reincarnate"] = true
}

function item_ex_machina_custom:NotRefresher( item )
    -- Проверяем стандартный список исключений
    if self.NotRefresh[item:GetName()] then
        return true
    end
    
    return false
end

function item_ex_machina_custom:GetIntrinsicModifierName()
    return "modifier_item_ex_machina_custom"
end

function item_ex_machina_custom:IsRefreshable()
    return false
end

function item_ex_machina_custom:OnSpellStart()
    for i=0,8 do
        local item = self:GetCaster():GetItemInSlot(i)
        if item then
            if not self:NotRefresher( item ) then
                item:EndCooldown()
                if item:GetAbilityName() == "item_hand_of_midas" then
                    if item:GetCurrentAbilityCharges() < 3 and item:GetCurrentCharges() < 3 then
                        item:SetCurrentCharges(item:GetCurrentCharges() + 1)
                        item:SetCurrentAbilityCharges(item:GetCurrentAbilityCharges() + 1)
                    end
                else
                    item:RefreshCharges()
                end
            end
        end
    end

    local item_neutral = self:GetCaster():GetItemInSlot(16)
    if item_neutral then
        if not self:NotRefresher( item_neutral ) then
            item_neutral:EndCooldown()
        end
    end

    self:GetCaster():EmitSound("DOTA_Item.ExMachina.Cast")

    local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_item_ex_machina_custom = class({})

function modifier_item_ex_machina_custom:IsHidden() return true end
function modifier_item_ex_machina_custom:IsPurgable() return false end
function modifier_item_ex_machina_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end
function modifier_item_ex_machina_custom:OnCreated()
    self.ability = self:GetAbility()
    self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
end

function modifier_item_ex_machina_custom:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end