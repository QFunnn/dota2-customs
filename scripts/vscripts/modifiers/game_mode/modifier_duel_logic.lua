--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_duel_hero_start", "modifiers/game_mode/modifier_duel_logic", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_duel_hero_end", "modifiers/game_mode/modifier_duel_logic", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_duel_field_hero_effect", "modifiers/game_mode/modifier_duel_logic", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_duel_field_active_thinker", "modifiers/game_mode/modifier_duel_logic", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_duel_field_active_hide_neutrals", "modifiers/game_mode/modifier_duel_logic", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_duel_field_active_spawn_blocker", "modifiers/game_mode/modifier_duel_logic", LUA_MODIFIER_MOTION_NONE)

modifier_duel_field_thinker = class(mod_hidden)
function modifier_duel_field_thinker:OnCreated(table)
self.parent = self:GetParent()
self.center = self.parent:GetAbsOrigin()

self.interval_slow = 0.5
self.interval_fast = 0.1
self.interval = self.interval_slow

self.thinker_vision = 650

self.teams_indside = {}
self.state = 0

self.delay_max = 3

if not IsServer() then return end
self.index = table.index
self.height = dota1x6.duel_arenas[self.index].height
self.radius = dota1x6.duel_arenas[self.index].radius
self.vision_abs = dota1x6.duel_arenas[self.index].vision_abs
self.vision_radius = self.radius - 200

self.sides = 0
if dota1x6.duel_arenas[self.index].sides then
	self.sides = dota1x6.duel_arenas[self.index].sides
end

self.is_solo = IsSoloMode()

self:StartIntervalThink(self.interval)
end

function modifier_duel_field_thinker:CheckPos(pos)
if not IsServer() then return end
return ((pos - self.center):Length2D() <= self.radius and GetGroundHeight(pos, nil) >= self.height)
end

function modifier_duel_field_thinker:CheckPosition(unit, is_allowed)
if unit:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
if unit:GetUnitName() == "npc_dota_donate_item_illusion" then return end
if unit:IsInvulnerable() then return end
if unit:HasModifier("modifier_primal_beast_pulverize_custom_debuff") then return end
if not unit:IsAlive() then return end
if unit:IsUnselectable() then return end

local change = false 

if is_allowed then
	if not self:CheckPos(unit:GetAbsOrigin()) or (GetGroundHeight(unit:GetAbsOrigin(), nil) >= self.height + 200) then
		change = true
	end  
else 
	if self:CheckPos(unit:GetAbsOrigin()) then
		change = true
	end
end 

if change == true then 
	if unit.owner and unit.owner:HasModifier("modifier_duel_hero_start") then
		unit:Kill(nil, nil)
		return
	end
	unit:WallKnock(self.center, self.radius, self.height, is_allowed)
end

end 


function modifier_duel_field_thinker:OnIntervalThink()
if not IsServer() then return end

self:UpdateParticle()

if self.vision_abs then
	for _,pos in pairs(self.vision_abs) do
		local units = FindUnitsInRadius(self.parent:GetTeamNumber(), pos, nil, self.thinker_vision, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + MODIFIER_STATE_INVULNERABLE, FIND_CLOSEST, false)
		for _,unit in pairs(units) do
			if unit:IsRealHero() and self:CheckPos(unit:GetAbsOrigin()) then
				AddFOWViewer(unit:GetTeamNumber(), pos, self.thinker_vision, self.interval_slow + 0.1, false)
			end
		end
	end
end

local duel_mod = self.parent:FindModifierByName("modifier_duel_field_active_thinker")

if duel_mod then
	self.state = 0
	self.teams_indside = {}

	for _,team in pairs(duel_mod.teams) do 
		if (not dota1x6.NIGHT_STALKER_TEAM or dota1x6.NIGHT_STALKER_TEAM == team or not duel_mod.teams_check[dota1x6.NIGHT_STALKER_TEAM]) then
			AddFOWViewer(team, self.parent:GetAbsOrigin(), 1400, self.interval_fast*2, true)
		end
	end

	local all_units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

	for _,unit in pairs(all_units) do 
		if not unit:IsCourier() and unit:GetUnitName() ~= "npc_teleport" and unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS and unit:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5 then 
			local is_allowed = false
			for _,team in pairs(duel_mod.teams) do
				if team == unit:GetTeamNumber() then
					is_allowed = true
					break
				end 
			end
			self:CheckPosition(unit, is_allowed)
		end 
	end 

	self:StartIntervalThink(self.interval_fast)
	return
end

if dota1x6.TargetCurrentActive then
	self.state = 0
end

if self.is_solo and not dota1x6.TargetCurrentActive then
	local current_inside = 0
	local team_count = 0

	for team,timer in pairs(self.teams_indside) do
		if not towers[team] then
			self.teams_indside[team] = nil
		else
			current_inside = current_inside + 1
		end
	end

	for team,tower in pairs(towers) do
		local ids = tower.ids
		if ids then
			local has_players = false
			for _,id in pairs(ids) do
				if players[id] then
					local status = self:CheckPos(players[id]:GetAbsOrigin()) and (players[id]:IsAlive() or players[id]:IsReincarnating())
					if status then
						has_players = true
					end
				end
			end
			if has_players then
				if self.state == 0 then
					if not self.teams_indside[team] then
						self.teams_indside[team] = self.delay_max
						current_inside = current_inside + 1
						if current_inside >= 2 then
							self.state = 1
						end
					end
				else
					if self.teams_indside[team] then
						self.teams_indside[team] = self.delay_max
					end
				end
			else
				if self.state == 0 then
					self.teams_indside[team] = nil
				elseif self.teams_indside[team] then
					self.teams_indside[team] = self.teams_indside[team] - self.interval
					if self.teams_indside[team] <= 0 then
						self.teams_indside[team] = nil
					end
				end
			end
		end
	end

	for team,timer in pairs(self.teams_indside) do
		team_count = team_count + 1
	end

	if team_count >= 2 and self.state == 0 then
		self.state = 1
	end

	if team_count < 2 and self.state == 1 then
		self.state = 0
	end

	if self.state == 1 then
		for team,timer in pairs(self.teams_indside) do
			if (not dota1x6.NIGHT_STALKER_TEAM or dota1x6.NIGHT_STALKER_TEAM == team or not self.teams_indside[dota1x6.NIGHT_STALKER_TEAM]) then
				AddFOWViewer(team, self.center, self.vision_radius, self.interval_fast*3, true)
			end
		end

		local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.center, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
		for _,unit in pairs(units) do
			if players[unit:GetId()] and not self.teams_indside[unit:GetTeamNumber()] and GetGroundHeight(unit:GetAbsOrigin(), nil) >= self.height and unit:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5 then
				unit:WallKnock(self.center, self.radius, self.height, false)
			end
		end
	end
	self.interval = team_count == 0 and self.interval_slow or self.interval_fast
else
	self.interval = self.interval_slow
end

self:StartIntervalThink(self.interval)
end


function modifier_duel_field_thinker:UpdateParticle()
if not IsServer() then return end
if not dota1x6.duel_arenas[self.index] or not dota1x6.duel_arenas[self.index].walls then return end

if (self.state == 1 or self.parent:HasModifier("modifier_duel_field_active_thinker")) and not self.effect_active then
	self.effect_active = {}
	for i,data in pairs(dota1x6.duel_arenas[self.index].walls) do

		local wall_effect = "particles/generic/duel_wall.vpcf"
		if self.sides and self.sides[i] and self.sides[i] == 1 then
			wall_effect = "particles/generic/duel_wall_dire.vpcf"
		end

	    self.effect_active[i] = ParticleManager:CreateParticle(wall_effect, PATTACH_WORLDORIGIN, nil)
	    ParticleManager:SetParticleControl(self.effect_active[i], 0, data.start_pos)
	    ParticleManager:SetParticleControl(self.effect_active[i], 1, data.end_pos)
	    self:AddParticle(self.effect_active[i], false, false, -1, false, false)

	    EmitSoundOnLocationWithCaster(data.start_pos, "UI.Tower_wall", self.parent)
	end
end

if self.state == 0 and not self.parent:HasModifier("modifier_duel_field_active_thinker") and self.effect_active then
	for _,effect in pairs(self.effect_active) do
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		effect = nil
	end
	self.effect_active = nil
end

end

function modifier_duel_field_thinker:IsAura() return self.state == 1 end
function modifier_duel_field_thinker:GetAuraDuration() return 0 end
function modifier_duel_field_thinker:GetAuraRadius() return self.radius end
function modifier_duel_field_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end
function modifier_duel_field_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_duel_field_thinker:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_duel_field_thinker:GetModifierAura() return "modifier_duel_field_hero_effect" end
function modifier_duel_field_thinker:GetAuraEntityReject(unit)
if not players[unit:GetId()] then return true end
if not self.teams_indside[unit:GetTeamNumber()] then return true end
if GetGroundHeight(unit:GetAbsOrigin(), nil) < self.height then return true end
return false
end


modifier_duel_field_hero_effect = class(mod_hidden)
function modifier_duel_field_hero_effect:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.aura_owner = self:GetAuraOwner()

self.parent.field_invun_mod = self

if not self.aura_owner then return end
self.aura_mod = self.aura_owner:FindModifierByName("modifier_duel_field_thinker")
end

function modifier_duel_field_hero_effect:NoDamage(unit)
if not IsServer() then return end
if not self.aura_owner or not self.aura_mod then return 0 end
if not unit then return 0 end  
if self.aura_mod.state ~= 1 then return 0 end
if not players[unit:GetId()] then return 0 end
if self.aura_mod.teams_indside[unit:GetTeamNumber()] then return 0 end
	
return 1
end

function modifier_duel_field_hero_effect:OnDestroy()
if not IsServer() then return end

if self.parent.field_invun_mod == self then
	self.parent.field_invun_mod = nil
end

end

function modifier_duel_field_hero_effect:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
	MODIFIER_PROPERTY_ABSORB_SPELL,
}
end

function modifier_duel_field_hero_effect:GetAbsoluteNoDamagePure(params)
if params.damage <= 0 then return end
return self:NoDamage(params.attacker)
end

function modifier_duel_field_hero_effect:GetAbsoluteNoDamageMagical(params)
if params.damage <= 0 then return end
return self:NoDamage(params.attacker)
end

function modifier_duel_field_hero_effect:GetAbsoluteNoDamagePhysical(params)
if params.damage <= 0 then return end
return self:NoDamage(params.attacker)
end

function modifier_duel_field_hero_effect:GetAbsorbSpell(params)
if not IsServer() then return end
if self.parent:IsInvulnerable() then return end
local caster = params.ability:GetCaster()

if not caster then return end
if caster:IsNull() then return end
if caster:GetTeamNumber() == self.parent:GetTeamNumber() then return 0 end

if self:NoDamage(caster) == 1 then 
	local particle = ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)
	self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
	return 1
end 	
return 0
end


modifier_duel_field_active_thinker = class(mod_hidden)
function modifier_duel_field_active_thinker:OnCreated(params)
if not IsServer() then return end
self.parent = self:GetParent()
self.index = params.index
self.thinker_mod = self.parent:FindModifierByName("modifier_duel_field_thinker")

if not self.thinker_mod then return end
if not duel_data[self.index] then return end 
if not duel_data[self.index].field then return end 

duel_data[self.index].stage = duel_data[self.index].stage + 1

dota1x6.duel_arenas[self.thinker_mod.index].is_active = true

self.field_array = duel_data[self.index].field

self.teams = {duel_data[self.index].tower1:GetTeamNumber(), duel_data[self.index].tower2:GetTeamNumber()}
self.teams_check = {}
self.teams_check[self.teams[1]] = true
self.teams_check[self.teams[2]] = true

duel_data[self.index].tower1.last_enemy = duel_data[self.index].tower2:GetTeamNumber()
duel_data[self.index].tower2.last_enemy = duel_data[self.index].tower1:GetTeamNumber()

self.heroes = {}

self.winner = nil
self.start_points = {}

self.start_points[1] = {} 
self.start_points[1][1] = self.field_array.start_pos[1][1]

self.start_points[2] = {} 
self.start_points[2][1] = self.field_array.start_pos[2][1]

if self.field_array.start_pos[1][2] then
	self.start_points[1][2] = self.field_array.start_pos[1][2]
	self.start_points[2][2] = self.field_array.start_pos[2][2]
else
	self.start_points[1][2] = self.field_array.start_pos[1][1]
	self.start_points[2][2] = self.field_array.start_pos[2][1]
end

local start_dir = {}
start_dir[1] = (self.start_points[2][1] - self.start_points[1][1]):Normalized()
start_dir[2] = (self.start_points[1][1] - self.start_points[2][1]):Normalized()

self.spawner_blockers = {}
if self.field_array.spawners then
	for _,pos in pairs(self.field_array.spawners) do
		local unit = CreateUnitByName("npc_dummy_unit", pos + Vector(0, 0, 80), false, nil, nil, DOTA_TEAM_CUSTOM_5)
		unit:AddNewModifier(unit, nil, "modifier_duel_field_active_spawn_blocker", {})
		table.insert(self.spawner_blockers, unit)
	end
end

for i,team in pairs(self.teams) do
	if duel_data[self.index].top3 then 
		towers[team].won_duel = -1
	end 
	local ids = dota1x6:FindPlayers(team)
	if ids then
		local count = 1

		for _,id in pairs(ids) do
			local hero = players[id]
			if hero then
				self.heroes[hero] = 1

				dota1x6:EndAllCooldowns(hero)

				if duel_data[self.index].final_duel == 1 then 
					dota1x6:Destroy_All_Units(hero)
					hero:RemoveModifierByName("modifier_patrol_reward_2_buff")
					hero:RemoveModifierByName("modifier_patrol_reward_2_portal")
					hero:RemoveModifierByName("modifier_patrol_vision")
				end

				local point = self.start_points[i][count]
				count = count + 1

				if hero:IsAlive() then
					hero:SetHealth(hero:GetMaxHealth())
					hero:SetMana(hero:GetMaxMana())
					hero:Purge(false, true, false, true, true)
				end

				if not hero:IsAlive() then 
					hero:RespawnHero(false, false)
				end

				hero:StopSound("UI.Duel_teleport_loop")
				hero:RemoveModifierByName("modifier_duel_hero_teleport")

				hero:SetAbsOrigin(point)
				FindClearSpaceForUnit(hero, point, false)
				hero:SetForwardVector(start_dir[i])
				hero:FaceTowards(hero:GetAbsOrigin() + start_dir[i]*10)

				self:SetStart(hero, point)
			end
		end
	end
end

if duel_data[self.index].final_duel == 1 then
	GameRules:SpawnNeutralCreeps()
end

self.parent:AddDeathEvent(self)
end 


function modifier_duel_field_active_thinker:SetStart(hero, point)
if not IsServer() then return end

PlayerResource:SetCameraTarget(hero:GetId(), hero)

hero:AddNewModifier(hero, nil, "modifier_duel_hero_thinker", {team_1 = self.teams[1], team_2 = self.teams[2], x = point.x, y = point.y})
hero:AddNewModifier(hero, nil, "modifier_duel_hero_start", {duration = duel_start})

local mod = hero:FindModifierByName("modifier_custom_necromastery_souls")
if mod then 
	mod:SetMax()
end

Timers:CreateTimer(1, function()
	PlayerResource:SetCameraTarget(hero:GetId(), nil)
end)

end




function modifier_duel_field_active_thinker:DeathEvent(params)
if not IsServer() then return end 
local unit = params.unit

if unit:IsReincarnating() then return end 
if not self.heroes[unit] or self.heroes[unit] == 0 then return end
self.heroes[unit] = 0
unit.died_on_duel = true

local timer = 100
local data = duel_data[self.index]
if data.max_timer and data.timer then
	timer = data.max_timer - data.timer + 1
end

if players[unit:GetId()] then
	unit:SetTimeUntilRespawn(timer)
end

local team_count = {}

for hero,alive in pairs(self.heroes) do
	local team = hero:GetTeamNumber()
	if not team_count[team] then
		team_count[team] = 0
	end
	if alive == 1 then
		team_count[team] = team_count[team] + 1
	end
end

local winner = nil

for team,count in pairs(team_count) do
	if count > 0 then
		if winner == nil then
			winner = team
		else
			return
		end
	end
end

self.winner = winner
self:Destroy()
end 


function modifier_duel_field_active_thinker:FinishDuel()
if not IsServer() then return end

if not self.winner then 
	if not towers[self.teams[1]] then 
		self.winner = self.teams[2]
	else 
		if not towers[self.teams[2]] then 
			self.winner = self.teams[1]
		end 
	end 
end 

local alive = {0, 0}
local percent = {0, 0}
local health = {0, 0}

if not self.winner then 
	for i,team in pairs(self.teams) do
		local ids = dota1x6:FindPlayers(team)
		if ids then
			for _,id in pairs(ids) do
				local hero = players[id]
				if hero and self.heroes[hero] then
					alive[i] = alive[i] + self.heroes[hero]

					local unit = hero
					if unit.infest_creep then
						unit = unit.infest_creep
					end
					percent[i] = percent[i] + unit:GetHealthPercent()
					health[i] = health[i] + unit:GetHealth()
				end
			end
		end
	end

	if alive[1] > alive[2] then
		self.winner = self.teams[1]
	elseif alive[2] > alive[1] then
		self.winner = self.teams[2]
	end
end

if not self.winner then
	if percent[1] > percent[2] then
		self.winner = self.teams[1]
	elseif percent[2] > percent[1] then
		self.winner = self.teams[2]
	end
end

if not self.winner then
	if health[1] >= health[2] then
		self.winner = self.teams[1]
	else
		self.winner = self.teams[2]
	end
end

if not self.winner then return end

if duel_data[self.index].top3 == 1 then 
	local tower = towers[self.winner]
	if tower then
		tower.won_duel = 1
	end
end 
	
local all_units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
for _,unit in pairs(all_units) do
	if unit.owner and not unit:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") and unit:GetUnitName() ~= "npc_dota_donate_item_illusion" then
		for hero,_ in pairs(self.heroes) do
			if hero == unit.owner then
				unit:Kill(nil, nil)
			end
		end
	end
end

local finish = duel_data[self.index].final_duel

for hero,_ in pairs(self.heroes) do
	local team = hero:GetTeamNumber()	

	start_quest:CheckQuest({id = hero:GetId(), quest_name = "Quest_11"})

	if team == self.winner then
		hero:GenericParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", nil, true)
		hero:EmitSound("UI.Duel_victory")
	end

	if finish == 1 then
		hero:RemoveModifierByName("modifier_duel_hero_thinker")

		if hero:IsAlive() then
			hero:AddNewModifier(hero, nil, "modifier_invulnerable", {duration = 5})
		else
			if players[hero:GetId()] then
				hero:SetTimeUntilRespawn(5)
			end
		end
	else
		local mod = hero:FindModifierByName("modifier_duel_hero_thinker")
		if mod and not mod.ended then
			mod:SetEnd(self.winner == team)
		end

		if not hero:IsAlive() and players[hero:GetId()] then
			hero:SetTimeUntilRespawn(2)
		end

		hero:ModifyGoldFiltered(300, true, DOTA_ModifyGold_Unspecified)

		Timers:CreateTimer(0.1, function()
			dota1x6:EndAllCooldowns(hero)
		end)
	end
end  

if finish == 0 then
	duel_data[self.index].finished = 1

	local hero = nil
	local ids = dota1x6:FindPlayers(self.winner)
	if ids then
		hero = players[ids[RandomInt(1, #ids)]]
	end

	for _,team in pairs(self.teams) do
		if towers[team] then
			towers[team].duel_data = -1
		end
	end

	if hero then
		hero.razor_count = hero.razor_count + 1
		local item = CreateItem("item_patrol_razor", hero, hero)
		if hero:GetNumItemsInInventory() < 10 then
			hero:AddItem(item)
		else
			CreateItemOnPositionSync(GetGroundPosition(hero:GetAbsOrigin(), hero), item)
		end
	end

else
	duel_data[self.index].field_created = 0
	duel_data[self.index].stage = 1
	duel_data[self.index].timer = 0
	duel_data[self.index].new_round = true

	if self.winner == self.teams[1] then 
		duel_data[self.index].wins1 = duel_data[self.index].wins1 + 1

		if duel_data[self.index].wins1 >= 2 then 
			self:EndGame(self.teams[2])
		end 
	else 
		duel_data[self.index].wins2 = duel_data[self.index].wins2 + 1

		if duel_data[self.index].wins2 >= 2 then 
			self:EndGame(self.teams[1])
		end 
	end 
end

end 

function modifier_duel_field_active_thinker:EndGame(loser)
if not IsServer() then return end
dota1x6:WinAnimation(loser)
duel_data[self.index].finished = 1
end 

function modifier_duel_field_active_thinker:OnDestroy()
if not IsServer() then return end

dota1x6.duel_arenas[self.thinker_mod.index].is_active = false

for _,unit in pairs(self.spawner_blockers) do
	if IsValid(unit) then
		unit:RemoveSelf()
	end
end

self:FinishDuel()
end 

function modifier_duel_field_active_thinker:IsAura() return true end
function modifier_duel_field_active_thinker:GetAuraDuration() return 2 end
function modifier_duel_field_active_thinker:GetAuraRadius() return self.thinker_mod.radius end
function modifier_duel_field_active_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end
function modifier_duel_field_active_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC end
function modifier_duel_field_active_thinker:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_duel_field_active_thinker:GetModifierAura() return "modifier_duel_field_active_hide_neutrals" end
function modifier_duel_field_active_thinker:GetAuraEntityReject(unit)
if unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then return true end
if not unit:IsCreep() then return end
if unit:HasModifier("modifier_duel_field_active_spawn_blocker") then return true end
if not self.thinker_mod:CheckPos(unit:GetAbsOrigin()) then return true end
return false
end



modifier_duel_hero_thinker = class({})
function modifier_duel_hero_thinker:IsHidden() return true end
function modifier_duel_hero_thinker:IsPurgable() return false end
function modifier_duel_hero_thinker:RemoveOnDeath() return false end
function modifier_duel_hero_thinker:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)
self.team_1 = table.team_1
self.team_2 = table.team_2

self.parent.field_invun_mod = self

self.ended = false
self.winner = false
self:StartIntervalThink(duel_start)
end 

function modifier_duel_hero_thinker:OnIntervalThink()
if not IsServer() then return end 
self.parent:Purge(false, true, false, true, true)
self.parent:SetAbsOrigin(self.point)
FindClearSpaceForUnit(self.parent, self.point, false)
self.parent:StopSound("UI.Duel_teleport_loop")

self:StartIntervalThink(-1)
end 

function modifier_duel_hero_thinker:SetEnd(winner)
if not IsServer() then return end 
self.ended = true
self.winner = winner
self:SetDuration(2, true)
end 

function modifier_duel_hero_thinker:CheckState()
if not self.ended then return end
return
{
	[MODIFIER_STATE_INVULNERABLE] = true
}
end 


function modifier_duel_hero_thinker:OnDestroy()
if not IsServer() then return end 

if self.parent.field_invun_mod == self then
	self.parent.field_invun_mod = nil
end

if not self.ended then return end

if towers[self.parent:GetTeamNumber()] then

	local point = towers[self.parent:GetTeamNumber()]:GetAbsOrigin() + RandomVector(300)
	self.parent:Purge(false, true, false, true, true)
	self.parent:SetAbsOrigin(point)
	FindClearSpaceForUnit(self.parent, point, false)

	self.parent:AddNewModifier(self.parent, nil, "modifier_invulnerable", {duration = 3})

	local id = self.parent:GetPlayerOwnerID()

	PlayerResource:SetCameraTarget(id, self.parent)
	Timers:CreateTimer(0.5, function()
		PlayerResource:SetCameraTarget(id, nil)
	end)
end 

if self.winner then 
	dota1x6:CreateUpgradeOrb(self.parent, 1)
end 

self.parent:Purge(false, true, false, true, true)
self.parent:SetHealth(self.parent:GetMaxHealth())
self.parent:SetMana(self.parent:GetMaxMana())
end 

function modifier_duel_hero_thinker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    MODIFIER_PROPERTY_ABSORB_SPELL,
}
end

function modifier_duel_hero_thinker:NoDamage(unit)
if not IsServer() then return end
if not unit then return end  
if not self.team_1 or not self.team_2 then return end
if self.ended then return end

if self.team_1 ~= unit:GetTeamNumber() and self.team_2 ~= unit:GetTeamNumber() then 
	return 1
end 	
return 0
end

function modifier_duel_hero_thinker:GetAbsorbSpell(params)
if not IsServer() then return end
if self.parent:HasModifier("modifier_antimage_counterspell_custom_active") then return 0 end
if self.parent:IsInvulnerable() then return end
local caster = params.ability:GetCaster()

if not caster then return end
if caster:IsNull() then return end
if caster:GetTeamNumber() == self.parent:GetTeamNumber() then return 0 end

if self:NoDamage(caster) == 1 then 
	local particle = ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)
	self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
	return 1
end 	
return 0
end

function modifier_duel_hero_thinker:GetAbsoluteNoDamagePhysical(params)
if not IsServer() then return end
return self:NoDamage(params.attacker)
end 

function modifier_duel_hero_thinker:GetAbsoluteNoDamageMagical(params)
if not IsServer() then return end
return self:NoDamage(params.attacker)
end 

function modifier_duel_hero_thinker:GetAbsoluteNoDamagePure(params)
if not IsServer() then return end
return self:NoDamage(params.attacker)
end 





modifier_duel_hero_start = class(mod_hidden)
function modifier_duel_hero_start:GetTexture() return "legion_commander_duel" end
function modifier_duel_hero_start:CheckState() 
return 
{
	[MODIFIER_STATE_INVULNERABLE] = true, 
	[MODIFIER_STATE_STUNNED] = true
} 
end

function modifier_duel_hero_start:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:EmitSound("UI.Duel_start")
local point = self.parent:GetAbsOrigin()

local duel_particle = ParticleManager:CreateParticle("particles/legion_duel_ring.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(duel_particle, 0, point)
ParticleManager:SetParticleControl(duel_particle, 7, point)

self:AddParticle(duel_particle, false, false, -1, false, false)

self.t = -1
self.timer = self:GetRemainingTime()*2 
self:StartIntervalThink(0.5)
self:OnIntervalThink()
end

function modifier_duel_hero_start:OnDestroy()
if not IsServer() then return end
self.parent:Stop()
self.parent:EmitSound("UI.Duel_horn")

dota1x6:EndAllCooldowns(self.parent)

local items = 
{
	["item_blink_custom"] = true,
	["item_overwhelming_blink_custom"] = true,
	["item_swift_blink_custom"] = true,
	["item_arcane_blink_custom"] = true,
}

for item,_ in pairs(items) do
	local ability = self.parent:FindItemInInventory(item)
	if ability then
		ability:EndCooldown()
		ability:StartCooldown(4)
	end
end

end


function modifier_duel_hero_start:OnIntervalThink()
if not IsServer() then return end

self.t = self.t + 1
local caster = self:GetParent()
local number = (self.timer-self.t)/2 

local int = number

if number % 1 ~= 0 then 
	int = number - 0.5  
end

local digits = math.floor(math.log10(number)) + 2

local decimal = number % 1

if decimal == 0.5 then
    decimal = 8
else 
    decimal = 1
end

local particle = ParticleManager:CreateParticle("particles/duel_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, caster)
ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)
end




modifier_duel_hero_end = class({})
function modifier_duel_hero_end:IsHidden() return true end
function modifier_duel_hero_end:IsPurgable() return false end 
function modifier_duel_hero_end:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.winner = table.winner
end 

function modifier_duel_hero_end:CheckState()
return
{
	[MODIFIER_STATE_INVULNERABLE] = true
}
end 


function modifier_duel_hero_end:OnDestroy()
if not IsServer() then return end 

if towers[self.parent:GetTeamNumber()] then

	local point = towers[self.parent:GetTeamNumber()]:GetAbsOrigin() + RandomVector(300)
	self.parent:Purge(false, true, false, true, true)
	self.parent:SetAbsOrigin(point)
	FindClearSpaceForUnit(self.parent, point, false)

	local id = self.parent:GetPlayerOwnerID()

	PlayerResource:SetCameraTarget(id, self.parent)
	Timers:CreateTimer(0.5, function()
		PlayerResource:SetCameraTarget(id, nil)
	end)
end 

if self.winner == 1 then 
	local name = "item_patrol_razor" 
	self.parent.razor_count = self.parent.razor_count + 1
	local item = CreateItem(name, self.parent, self.parent)
	if self.parent:GetNumItemsInInventory() < 10 then
		self.parent:AddItem(item)
	else
		CreateItemOnPositionSync(GetGroundPosition(self.parent:GetAbsOrigin(),  self.parent), item)
	end

	dota1x6:CreateUpgradeOrb(self.parent, 1)
end 

self.parent:Purge(false, true, false, true, true)
self.parent:SetHealth(self.parent:GetMaxHealth())
self.parent:SetMana(self.parent:GetMaxMana())

end 



modifier_duel_hero_teleport = class({})
function modifier_duel_hero_teleport:IsHidden() return true end
function modifier_duel_hero_teleport:IsPurgable() return false end 
function modifier_duel_hero_teleport:GetEffectName() return "particles/units/heroes/hero_chen/chen_teleport.vpcf" end 
function modifier_duel_hero_teleport:OnCreated()
if not IsServer() then return end 
self.parent = self:GetParent()
self.parent:EmitSound("UI.Duel_teleport_loop")
end 


function modifier_duel_hero_teleport:OnDestroy()
if not IsServer() then return end 
self.parent:StopSound("UI.Duel_teleport_loop")
self.parent:GenericParticle("particles/units/heroes/hero_chen/chen_teleport_flash.vpcf")
EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "UI.Duel_teleport_end", self.parent)
end 



modifier_duel_field_active_hide_neutrals = class(mod_hidden)
function modifier_duel_field_active_hide_neutrals:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddNoDraw()
end

function modifier_duel_field_active_hide_neutrals:OnDestroy()
if not IsServer() then return end
self.parent:RemoveNoDraw()
end

function modifier_duel_field_active_hide_neutrals:CheckState()
return
{
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_OUT_OF_GAME] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
}
end


modifier_duel_field_active_spawn_blocker = class(mod_hidden)
function modifier_duel_field_active_spawn_blocker:CheckState()
return
{
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_OUT_OF_GAME] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_UNSELECTABLE] = true,
	[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
}
end



