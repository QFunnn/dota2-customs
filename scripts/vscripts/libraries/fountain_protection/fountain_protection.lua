--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


FountainProtection = {}

FountainProtection.ENABLE_IDLE_INVULNERABILITY = true
FountainProtection.DISABLE_FOUNTAIN_CASTS = false

FountainProtection.DISABLE_FOUNTAIN_CAST_RANGE = 1750
FountainProtection.INVULNERABILITY_IDLE_TIME = 15

FountainProtection.ORDERS = {
	[DOTA_UNIT_ORDER_CAST_POSITION] = true,
	[DOTA_UNIT_ORDER_CAST_TARGET] = true,
	[DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
}

function FountainProtection:OrderFilter(order_type, ability, target, unit)
	if self.DISABLE_FOUNTAIN_CASTS and self.ORDERS[order_type] then
		local order_vector

		if order_type == DOTA_UNIT_ORDER_CAST_TARGET then
			-- Allow cast abilities on friendly units
			if target:GetTeam() == unit:GetTeam() then
				return
			end

			order_vector = target:GetAbsOrigin()
		elseif order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET then
			order_vector = unit:GetAbsOrigin()
		end

		local team = unit:GetOpposingTeamNumber()
		local fountain

		if team == DOTA_TEAM_GOODGUYS then
			fountain = Entities:FindByName(nil, "ent_dota_fountain_good")
		else
			fountain = Entities:FindByName(nil, "ent_dota_fountain_bad")
		end

		if order_vector and fountain:IsPositionInRange(order_vector, self.DISABLE_FOUNTAIN_CAST_RANGE) then
			DisplayError(unit:GetPlayerOwnerID(), "#hud_error_fountain_cast")
			return true
		end
	end

	unit.last_order_time = GameRules:GetGameTime()
	unit:RemoveModifierByName("modifier_fountain_invulnerability_custom")
end

function FountainProtection:OnSpawn(event)
	local hero = EntIndexToHScript(event.entindex)
	if not hero or not hero:IsRealHero() or hero:IsReincarnating() or hero:IsTempestDouble() then
		return
	end

	if event.is_respawn == 1 then
		hero:RemoveModifierByName("modifier_fountain_invulnerability")
		hero:AddNewModifier(hero, nil, "modifier_fountain_invulnerability_custom", nil)
		return
	end

	hero.last_order_time = 0
	hero:SetContextThink("fountain_idle", function(hero)
		return FountainProtection:IdleChecker(hero)
	end, 0.5)
end

function FountainProtection:IdleChecker(hero)
	local idle_long_enough = hero:IsIdle()
		and GameRules:GetGameTime() - hero:GetLastIdleChangeTime() >= self.INVULNERABILITY_IDLE_TIME
		and GameRules:GetGameTime() - (hero.last_order_time or 0) >= self.INVULNERABILITY_IDLE_TIME

	--print(hero:IsIdle(), hero:GetLastIdleChangeTime(), idle_long_enough)

	if hero:HasModifier("modifier_fountain_aura_buff") and not hero:IsTempestDouble() and idle_long_enough then
		hero:AddNewModifier(hero, nil, "modifier_fountain_invulnerability_custom", nil)
	end

	return 0.5
end

if FountainProtection.ENABLE_IDLE_INVULNERABILITY then
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(FountainProtection, "OnSpawn"), FountainProtection)
end