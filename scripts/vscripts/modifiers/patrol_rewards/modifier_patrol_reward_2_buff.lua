--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_patrol_reward_2_buff = class({})
function modifier_patrol_reward_2_buff:IsHidden() return false end
function modifier_patrol_reward_2_buff:GetTexture() return "rune_doubledamage" end
function modifier_patrol_reward_2_buff:RemoveOnDeath() return false end
function modifier_patrol_reward_2_buff:IsPurgable() return false end

function modifier_patrol_reward_2_buff:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

self.damage_inc = self.parent:GetTalentValue("modifier_patrol_reward_buff", "damage_inc")
self.damage_out = self.parent:GetTalentValue("modifier_patrol_reward_buff", "damage_out")

self:SetStackCount(self.damage_out)

self.parent:EmitSound("Patrol.Buff_damage")
end


function modifier_patrol_reward_2_buff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_patrol_reward_2_buff:GetModifierIncomingDamage_Percentage()
return self:GetStackCount()*-1
end

function modifier_patrol_reward_2_buff:GetModifierDamageOutgoing_Percentage()
return self:GetStackCount()
end

function modifier_patrol_reward_2_buff:GetModifierSpellAmplify_Percentage()
return self:GetStackCount()
end

function modifier_patrol_reward_2_buff:GetEffectName()
return "particles/generic_gameplay/rune_doubledamage_owner.vpcf"
end