--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_patrol_reward_1_gold = class({})
function modifier_patrol_reward_1_gold:IsHidden() return false end
function modifier_patrol_reward_1_gold:GetTexture() return "item_hand_of_midas" end
function modifier_patrol_reward_1_gold:RemoveOnDeath() return false end
function modifier_patrol_reward_1_gold:IsPurgable() return false end
function modifier_patrol_reward_1_gold:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.gold = self.parent:GetTalentValue("modifier_patrol_reward_gold", "gold")/100
EmitSoundOnEntityForPlayer("DOTA_Item.Hand_Of_Midas", self.parent, self.parent:GetPlayerOwnerID())
end

