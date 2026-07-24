--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_patrol_reward_2_gem = class(mod_visible)
function modifier_patrol_reward_2_gem:RemoveOnDeath() return false end
function modifier_patrol_reward_2_gem:GetTexture() return "item_third_eye" end
function modifier_patrol_reward_2_gem:OnCreated(table)
self.parent = self:GetParent()
self.radius = self.parent:GetTalentValue("modifier_patrol_reward_gem", "radius", treant_overgrowth)

if not IsServer() then return end

EmitSoundOnEntityForPlayer("Item.SeerStone", self.parent, self.parent:GetPlayerOwnerID())
self.interval = 0.3
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_patrol_reward_2_gem:OnIntervalThink()
if not IsServer() then return end

for _,player in pairs(players) do
	if player ~= self.parent and (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius and player:IsAlive() and player:GetTeamNumber() ~= self.parent:GetTeamNumber() then
    	AddFOWViewer(self.parent:GetTeamNumber(), player:GetAbsOrigin(), 10, self.interval + 0.1, false)
	end
end

end
