--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_mob_thinker = class({})
function modifier_mob_thinker:IsHidden() return false end
function modifier_mob_thinker:IsPurgable() return false end

function modifier_mob_thinker:CheckState()
return {
    [MODIFIER_STATE_UNSELECTABLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
}
end

function modifier_mob_thinker:RemoveOnDeath() return false end

function modifier_mob_thinker:OnCreated(table)
if not IsServer() then return end 

self.max_per_tick = 6
self.limit = 0
self.end_spawn = false
self.spawn_table = {}

self.interval = 0.03

if _G.TestMode == false then return end 
self:StartIntervalThink(self.interval)
end


function modifier_mob_thinker:OnIntervalThink()
if not IsServer() then return end

self.limit = 0
self.end_spawn = false

while self.end_spawn == false do 
	local callback = self.spawn_table[1]
	
	if not callback then 
		if _G.TestMode == false then
			return self:StartIntervalThink(-1)
		else
			self.end_spawn = true
		end
	else
		table.remove(self.spawn_table, 1)
		callback()
	end

	self.limit = self.limit + 1
	if self.limit >= self.max_per_tick then 
		self.end_spawn = true
	end
end

if _G.TestMode == false then return end
if _G.WtfMode == false then return end 

for _,player in pairs(players) do
	dota1x6:RefreshCooldowns(player)
end

end 


function modifier_mob_thinker:StartSpawnThink()
if not IsServer() then return end
self:StartIntervalThink(self.interval)
end




