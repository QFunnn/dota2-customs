--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_greater_faerie_fire_custom_debuff", "items/item_greater_faerie_fire_custom", LUA_MODIFIER_MOTION_NONE)

item_greater_faerie_fire_custom = class({})

function item_greater_faerie_fire_custom:OnSpellStart()
	if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_item_greater_faerie_fire_custom_debuff") then
        local heal = self:GetSpecialValueFor("heal")
        local heal_full = self:GetCaster():GetMaxHealth() / 100 * heal
        self:GetCaster():EmitSound("DOTA_Item.FaerieSpark.Activate")
        local nFXIndex = ParticleManager:CreateParticle( "particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
	    self:GetCaster():Heal(heal_full, self)
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_greater_faerie_fire_custom_debuff", {duration = 30})
    end
end

modifier_item_greater_faerie_fire_custom_debuff = class({})
function modifier_item_greater_faerie_fire_custom_debuff:IsPurgable() return false end
function modifier_item_greater_faerie_fire_custom_debuff:IsPurgeException() return false end
function modifier_item_greater_faerie_fire_custom_debuff:RemoveOnDeath() return false end