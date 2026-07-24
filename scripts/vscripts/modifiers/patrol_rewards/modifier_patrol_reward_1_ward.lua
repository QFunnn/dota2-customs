--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_patrol_reward_1_ward = class(mod_visible)
function modifier_patrol_reward_1_ward:GetTexture() return "item_ward_observer" end
function modifier_patrol_reward_1_ward:RemoveOnDeath() return false end
function modifier_patrol_reward_1_ward:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddDeathEvent(self, true)

self.radius = self.parent:GetTalentValue("modifier_patrol_reward_ward", "radius")
self.max = self.parent:GetTalentValue("modifier_patrol_reward_ward", "max")
self.gold = self.parent:GetTalentValue("modifier_patrol_reward_ward", "gold")

EmitSoundOnEntityForPlayer("Item.SeerStone", self.parent, self.parent:GetPlayerOwnerID())

self:SetStackCount(self.max)

self.interval = 0.3

self.wards_found = {}
self.wards_count = 0

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_patrol_reward_1_ward:OnIntervalThink()
if not IsServer() then return end

local targets = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER,false)

for _,target in pairs(targets) do
	if target:GetUnitName() == "npc_dota_observer_wards" then

		if not self.wards_found[target] and self.wards_count < self.max then
			self.wards_found[target] = true
			self.wards_count = self.wards_count + 1
		end

		if self.wards_found[target] then
			AddFOWViewer(self.parent:GetTeamNumber(), target:GetAbsOrigin(), 20, self.interval*2, false)
			target:AddNewModifier(self.parent, nil, "modifier_truesight", {duration = self.interval*2})
		end
	end
end

end



function modifier_patrol_reward_1_ward:DeathEvent(params)
if not IsServer() then return end
local attacker = params.attacker

if not attacker then return end
if attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then return end
if not self.wards_found[params.unit] then return end

self:DecrementStackCount()
self.parent:GiveGold(self.gold, true)

if self:GetStackCount() <= 0 then
	self:Destroy()
end

end

