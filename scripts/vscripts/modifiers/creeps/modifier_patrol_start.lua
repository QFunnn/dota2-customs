--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_patrol_start = class({})
function modifier_patrol_start:IsHidden() return true end
function modifier_patrol_start:IsPurgable() return false end
function modifier_patrol_start:CheckState()
return
{
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_DISARMED] = true,
  --[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_patrol_start:OnCreated()
self.speed = 60
end

function modifier_patrol_start:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_patrol_start:GetModifierMoveSpeedBonus_Constant()
return self.speed
end




modifier_patrol_gospawn = class({})

function modifier_patrol_gospawn:IsHidden() return true end
function modifier_patrol_gospawn:IsPurgable() return false end
function modifier_patrol_gospawn:CheckState()
return
{
  [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end
function modifier_patrol_gospawn:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_patrol_gospawn:GetModifierMoveSpeedBonus_Percentage()
return 50 
end




modifier_patrol_death = class({})
function modifier_patrol_death:IsHidden() return true end
function modifier_patrol_death:IsPurgable() return false end
function modifier_patrol_death:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
end




function modifier_patrol_death:DeathEvent(params)
if not IsServer() then return end
if params.unit ~= self.parent then return end

local killer = params.attacker 

if not killer then return end
local killer_table = players[killer:GetId()]
if not killer_table then return end

self.killer = killer_table
end


function modifier_patrol_death:OnDestroy()
if not IsServer() then return end

if self.killer and not self.killer:IsNull() and self.parent.item then 

	self.parent:GenericParticle("particles/neutral_fx/neutral_item_drop_lvl4.vpcf")
	self.killer:GenericParticle("particles/patrol/reward_drop_head.vpcf", nil, true)
	self.parent:EmitSound("Patrol_drop")

	local mod = self.killer:FindModifierByName("modifier_player_main_custom")
	if mod then
		mod:SetReward(self.parent.item)
	end

end

if self.parent.friends == nil then return end

local no_friends = true
local drop_orb = true

for _,friend in pairs(self.parent.friends) do 

	if friend.drop_orb ~= nil then 
		drop_orb = false
	end
	
	if not friend:IsNull() and friend:IsAlive() then 
		no_friends = false
	end
end

if no_friends == true then 
	if self.parent.radiant_patrol == true then 	
		dota1x6.radiant_patrol_alive = false
	else 
		dota1x6.dire_patrol_alive = false
	end

	if self.killer and dota1x6.current_wave >= patrol_wave_2 and drop_orb == true then 

		self.parent.drop_orb = true

		local ids = dota1x6:FindPlayers(self.killer:GetTeamNumber())
		if ids then
			for _,id in pairs(ids) do
				local player = players[id]
				if player then
					dota1x6:CreateUpgradeOrb(player, 1)
				end
			end
		end
	end

end

end