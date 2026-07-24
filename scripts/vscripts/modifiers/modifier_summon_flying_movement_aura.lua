--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_summon_flying_movement_aura", "modifiers/modifier_summon_flying_movement_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_summon_flying_movement_buff", "modifiers/modifier_summon_flying_movement_aura", LUA_MODIFIER_MOTION_NONE)

-- Аура на владельце предмета: даёт подконтрольным юнитам в радиусе 1000 беспрепятственное передвижение
-- Модификатор неснимаемый, не отключается заглушением/дагоном и т.д.

modifier_summon_flying_movement_aura = class({})

function modifier_summon_flying_movement_aura:IsHidden() return false end
function modifier_summon_flying_movement_aura:GetTexture() return "item_helm_of_the_overlord" end
function modifier_summon_flying_movement_aura:IsPurgable() return false end
function modifier_summon_flying_movement_aura:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_summon_flying_movement_aura:IsAura() return true end
function modifier_summon_flying_movement_aura:GetModifierAura() return "modifier_summon_flying_movement_buff" end
function modifier_summon_flying_movement_aura:GetAuraRadius() return 1000 end
function modifier_summon_flying_movement_aura:GetAuraDuration() return 0.5 end
function modifier_summon_flying_movement_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_summon_flying_movement_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC end
function modifier_summon_flying_movement_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED end

function modifier_summon_flying_movement_aura:GetAuraEntityReject(target)
    -- A6: варды (серпент-варды и т.п.) — не армейские призывы, бонусы для них не должны действовать.
    -- IsWardUnit — по имени, т.к. движковый IsWard() для крип-вардов = false.
    if IsWardUnit(target) then return true end
    -- Только подконтрольные юниты этого игрока
    if target == self:GetParent() then return true end
    if target:GetPlayerOwnerID() ~= self:GetParent():GetPlayerOwnerID() then return true end
    return false
end

-- Бафф на подконтрольном юните: беспрепятственное передвижение
modifier_summon_flying_movement_buff = class({})

function modifier_summon_flying_movement_buff:IsHidden() return false end
function modifier_summon_flying_movement_buff:IsPurgable() return false end
function modifier_summon_flying_movement_buff:IsPurgeException() return false end
function modifier_summon_flying_movement_buff:IsDebuff() return false end
function modifier_summon_flying_movement_buff:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_summon_flying_movement_buff:GetTexture() return "item_helm_of_the_overlord" end

function modifier_summon_flying_movement_buff:CheckState()
    return {
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
    }
end