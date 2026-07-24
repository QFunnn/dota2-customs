--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_patrol_reward_2_portal = class({})
function modifier_patrol_reward_2_portal:IsHidden() return false end
function modifier_patrol_reward_2_portal:GetTexture() return "buffs/warp_amulet" end
function modifier_patrol_reward_2_portal:RemoveOnDeath() return false end
function modifier_patrol_reward_2_portal:IsPurgable() return false end

function modifier_patrol_reward_2_portal:OnCreated(table)
self.parent = self:GetParent()

if not IsServer() then return end
self.parent:EmitSound("Patrol.Portal_start")

local item = self.parent:FindItemInInventory("item_tpscroll_custom")
if item then
    item:EndCd(0)
end

end

function modifier_patrol_reward_2_portal:OnRefresh(table)
self:OnCreated()
end
