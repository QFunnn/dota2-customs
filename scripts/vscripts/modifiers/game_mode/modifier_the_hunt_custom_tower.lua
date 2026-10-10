--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_the_hunt_custom_hero",
	"modifiers/game_mode/modifier_the_hunt_custom_tower",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_the_hunt_custom_speed",
	"modifiers/game_mode/modifier_the_hunt_custom_tower",
	LUA_MODIFIER_MOTION_NONE
)

modifier_the_hunt_custom_tower = class({})
function modifier_the_hunt_custom_tower:IsHidden()
	return true
end
function modifier_the_hunt_custom_tower:IsPurgable()
	return false
end
function modifier_the_hunt_custom_tower:OnCreated()
	self.parent = self:GetParent()

	self.team = self.parent:GetTeamNumber()
	self.damage_inc = 15

	if not IsServer() then
		return
	end

	dota1x6.TargetCurrentActive = true

	self.vision_radius = 1000

	self.alert_delay = 8
	self.alert_time = GameRules:GetGameTime() + self.alert_delay
	self.heroes = {}
	self.heroes_names = {}

	local ids = dota1x6:FindPlayers(self.team)
	if ids then
		for _, id in pairs(ids) do
			local player = players[id]
			if player then
				self.heroes[player] = true
				table.insert(self.heroes_names, player:GetUnitName())
				player:RemoveModifierByName("modifier_smoke_of_deceit")
			end
		end
	end

	for _, tower in pairs(towers) do
		local barrier = tower:FindModifierByName("modifier_backdoor_knock_aura")
		if barrier and (tower == self.parent or barrier.target_team == self.team) then
			barrier:Destroy()
		end
	end

	CustomGameEventManager:Send_ServerToAllClients(
		"TargetAttack",
		{ heroes = self.heroes_names, delay = self.alert_delay }
	)

	self.interval = 0.5
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_the_hunt_custom_tower:GetNet(team)
	if not IsServer() then
		return
	end
	local net = 0

	local ids = dota1x6:FindPlayers(team)
	if ids then
		for _, id in pairs(ids) do
			net = net + players[id].networth -- PlayerResource:GetNetWorth(id)
		end
	end
	return net
end

function modifier_the_hunt_custom_tower:OnIntervalThink()
	if not IsServer() then
		return
	end

	local net_target = self:GetNet(self.team)
	local in_duel = dota1x6:TeamInDuel(self.team)

	if in_duel ~= self.in_duel then
		if self.in_duel then
			self:SetDuration(self:GetRemainingTime() + Target_duel_extend, true)
		end
		self.in_duel = in_duel
	end

	if in_duel then
		self:SetDuration(self:GetRemainingTime() + self.interval, true)
	end

	for hero, _ in pairs(self.heroes) do
		if hero and not hero:IsNull() then
			if in_duel then
				hero:RemoveModifierByName("modifier_the_hunt_custom_hero")
			elseif hero:IsAlive() and not hero:HasModifier("modifier_the_hunt_custom_hero") then
				hero:AddNewModifier(
					hero,
					nil,
					"modifier_the_hunt_custom_hero",
					{ duration = self:GetRemainingTime(), gold = Target_k }
				)
			end
		end
	end

	for team, tower in pairs(towers) do
		local net = self:GetNet(team)
		local bonus_gold = 0

		local ids = dota1x6:FindPlayers(team)

		if not in_duel then
			for hero, _ in pairs(self.heroes) do
				AddFOWViewer(team, hero:GetAbsOrigin(), self.vision_radius, self.interval + 0.1, false)
			end
		end

		if ids and team ~= self.team then
			bonus_gold = dota1x6:KillGoldTeam(net_target, net, #ids, Target_k)
		end
		local time = math.floor(self:GetRemainingTime())

		if GameRules:GetGameTime() >= self.alert_time then
			local is_target = team == self.team
			if ids then
				for _, id in pairs(ids) do
					CustomGameEventManager:Send_ServerToPlayer(
						PlayerResource:GetPlayer(id),
						"TargetTimer_change",
						{
							damage_inc = self.damage_inc,
							gold = bonus_gold,
							is_target = is_target,
							heroes = self.heroes_names,
							time = time,
							duel = in_duel and 1 or 0,
						}
					)
				end
			end
		end
	end
end

function modifier_the_hunt_custom_tower:TargetKilled(unit, attacker)
	if not IsServer() then
		return
	end

	if not self.heroes[unit] then
		return
	end
	if unit.died_on_duel then
		return
	end
	if attacker and attacker:GetTeamNumber() == unit:GetTeamNumber() then
		return
	end
	if attacker and not players[attacker:GetId()] then
		return
	end
	if unit:IsReincarnating() then
		return
	end

	self.heroes[unit] = nil
	--unit:RemoveModifierByName("modifier_the_hunt_custom_hero")

	for i, name in pairs(self.heroes_names) do
		if name == unit:GetUnitName() then
			table.remove(self.heroes_names, i)
			break
		end
	end

	local ended = #self.heroes_names <= 0

	if not ended then
		return
	end

	for id, player in pairs(players) do
		local team = player:GetTeamNumber()

		if team ~= self.team then
			if
				(
					(player:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() <= Target_radius
					or player:HasCd("hunt_damage", Target_damage_cd)
				) and (not attacker or id ~= attacker:GetId())
			then
				player:AddPoints("purple", 1)
			end

			EmitSoundOnEntityForPlayer("Hunt.End", player, id)
		end
	end

	self:Destroy()
end

function modifier_the_hunt_custom_tower:OnDestroy()
	if not IsServer() then
		return
	end

	for hero, _ in pairs(self.heroes) do
		if hero and not hero:IsNull() then
			hero:RemoveModifierByName("modifier_the_hunt_custom_hero")
		end
	end

	dota1x6.TargetCurrentActive = false
	dota1x6.TargetCurrentCd = Target_cd

	CustomGameEventManager:Send_ServerToAllClients("TargetTimer_delete", {})
end

modifier_the_hunt_custom_hero = class({})
function modifier_the_hunt_custom_hero:IsHidden()
	return false
end
function modifier_the_hunt_custom_hero:IsPurgable()
	return false
end
function modifier_the_hunt_custom_hero:IsDebuff()
	return true
end
function modifier_the_hunt_custom_hero:RemoveOnDeath()
	return false
end
function modifier_the_hunt_custom_hero:GetTexture()
	return "buffs/odds_fow"
end
function modifier_the_hunt_custom_hero:GetEffectName()
	return "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail.vpcf"
end
function modifier_the_hunt_custom_hero:IsAura()
	return true
end
function modifier_the_hunt_custom_hero:GetAuraRadius()
	return self.speed_radius
end
function modifier_the_hunt_custom_hero:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_the_hunt_custom_hero:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end
function modifier_the_hunt_custom_hero:GetModifierAura()
	return "modifier_the_hunt_custom_speed"
end
function modifier_the_hunt_custom_hero:OnCreated(params)
	self.parent = self:GetParent()

	self.damage_inc = 15
	self.speed_radius = 1200
	if not IsServer() then
		return
	end
	self.gold = params.gold * 100
	self:SetHasCustomTransmitterData(true)
end

function modifier_the_hunt_custom_hero:AddCustomTransmitterData()
	return {
		gold = self.gold,
	}
end

function modifier_the_hunt_custom_hero:HandleCustomTransmitterData(data)
	self.gold = data.gold
end

function modifier_the_hunt_custom_hero:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_the_hunt_custom_hero:GetModifierIncomingDamage_Percentage(params)
	if IsClient() then
		return self.damage_inc
	end

	local attacker = params.attacker
	if not attacker then
		return
	end
	local player = players[attacker:GetId()]

	if not player then
		return
	end
	if attacker:IsBuilding() then
		return
	end

	if (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= Target_radius then
		player:StartCd("hunt_damage", Target_damage_cd)
	end

	return self.damage_inc
end

function modifier_the_hunt_custom_hero:OnTooltip()
	return self.gold
end

modifier_the_hunt_custom_speed = class(mod_visible)
function modifier_the_hunt_custom_speed:GetTexture()
	return "buffs/odds_fow"
end
function modifier_the_hunt_custom_speed:GetEffectName()
	return "particles/generic_gameplay/rune_haste_owner.vpcf"
end
function modifier_the_hunt_custom_speed:IsDebuff()
	return false
end
function modifier_the_hunt_custom_speed:OnCreated()
	self.speed = 15
end

function modifier_the_hunt_custom_speed:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_the_hunt_custom_speed:GetModifierMoveSpeedBonus_Percentage()
	return self.speed
end