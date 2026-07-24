--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_item_moon_shard_buff_custom = class({})
function modifier_item_moon_shard_buff_custom:IsPurgable() return false end
function modifier_item_moon_shard_buff_custom:IsHidden() return true end
function modifier_item_moon_shard_buff_custom:IsPurgeException() return false end
function modifier_item_moon_shard_buff_custom:RemoveOnDeath() return false end
function modifier_item_moon_shard_buff_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION_UNIQUE
    }
end
function modifier_item_moon_shard_buff_custom:GetModifierAttackSpeedBonus_Constant()
    return 60
end
function modifier_item_moon_shard_buff_custom:GetBonusNightVisionUnique()
    return 200
end