--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_magi_dumb_luck_custom", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_dumb_luck_custom", LUA_MODIFIER_MOTION_NONE )

ogre_magi_dumb_luck_custom = class({})

ogre_magi_dumb_luck_custom.modifier_ogre_magi_6_mana = {1,2,3}
ogre_magi_dumb_luck_custom.modifier_ogre_magi_6_regen = {0.02,0.04,0.06}

function ogre_magi_dumb_luck_custom:GetIntrinsicModifierName()
    return "modifier_ogre_magi_dumb_luck_custom"
end

modifier_ogre_magi_dumb_luck_custom = class({})
function modifier_ogre_magi_dumb_luck_custom:IsHidden() return true end
function modifier_ogre_magi_dumb_luck_custom:IsPurgable() return false end
function modifier_ogre_magi_dumb_luck_custom:RemoveOnDeath() return false end

function modifier_ogre_magi_dumb_luck_custom:OnCreated(table)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.mana_per_str = self.ability:GetSpecialValueFor("mana_per_str_custom")
    self.mana_regen_per_str = self.ability:GetSpecialValueFor("mana_regen_per_str_custom")
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_ogre_magi_dumb_luck_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.parent:HasModifier("modifier_ogre_magi_15") then
        if self.parent:HasModifier("modifier_ogre_magi_dumb_luck") then
            self.parent:RemoveModifierByName("modifier_ogre_magi_dumb_luck")
        end
        return
    end
    if not self.parent:HasModifier("modifier_ogre_magi_dumb_luck") then
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_ogre_magi_dumb_luck", {})
    end
end

function modifier_ogre_magi_dumb_luck_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MANA_BONUS,
	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
}
end

function modifier_ogre_magi_dumb_luck_custom:GetModifierManaBonus()
    if self.parent:HasModifier("modifier_ogre_magi_15") then return 0 end
    local mana_per_str = self.mana_per_str
    if self.parent:HasModifier("modifier_ogre_magi_6") then
        mana_per_str = mana_per_str + self.ability.modifier_ogre_magi_6_mana[self.parent:GetTalentLevel("modifier_ogre_magi_6")]
    end
    return self.parent:GetStrength() * mana_per_str
end

function modifier_ogre_magi_dumb_luck_custom:GetModifierConstantManaRegen()
    if self.parent:HasModifier("modifier_ogre_magi_15") then return 0 end
    local mana_regen_per_str = self.mana_regen_per_str
    if self.parent:HasModifier("modifier_ogre_magi_6") then
        mana_regen_per_str = mana_regen_per_str + self.ability.modifier_ogre_magi_6_regen[self.parent:GetTalentLevel("modifier_ogre_magi_6")]
    end
    return self.parent:GetStrength() * mana_regen_per_str
end