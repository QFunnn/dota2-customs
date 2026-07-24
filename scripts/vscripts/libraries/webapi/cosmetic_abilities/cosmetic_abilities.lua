--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


CosmeticAbilities = CosmeticAbilities or {}


function CosmeticAbilities:Init()
	EventStream:Listen("CosmeticAbilities:get_dummy_caster", CosmeticAbilities.SendDummyCaster, CosmeticAbilities)

	CosmeticAbilities.dummies = {}

	CosmeticAbilities.default_abilities = {
		high_five_custom = 2,
		default_cosmetic_ability = -1,
		spray_custom = 0,
	}
end


function CosmeticAbilities:PrepareForHero(player_id, hero)
	if CosmeticAbilities.dummies[player_id] then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local dummy = CreateUnitByName("npc_dummy_cosmetic_caster", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeam())

	dummy:SetControllableByPlayer(hero:GetPlayerOwnerID(), true)
	dummy:SetOwner(hero)
	dummy:SetOrigin(hero:GetAbsOrigin())
	dummy:FollowEntity(hero, true)
	dummy:AddNewModifier(dummy, nil, "modifier_dummy_caster", {duration = -1})

	for ability_name, override_cooldown in pairs(CosmeticAbilities.default_abilities) do
		CosmeticAbilities:AddAbility(dummy, ability_name, override_cooldown)
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "CosmeticAbilities:update_dummy_caster", {
		dummy_entity_index = dummy:GetEntityIndex()
	})

	CosmeticAbilities.dummies[player_id] = dummy
end


function CosmeticAbilities:AddAbility(unit, ability_name, override_cooldown)
	if not IsValidEntity(unit) then return end
	if unit:HasAbility(ability_name) then return end
	local new_ability = unit:AddAbility(ability_name)
	new_ability:SetLevel(1)
	new_ability:SetHidden(false)
	new_ability.is_cosmetic = true
	if override_cooldown and override_cooldown >= 0 then
		new_ability:StartCooldown(override_cooldown)
	end
end


function CosmeticAbilities:GetDummyCaster(player_id)
	return CosmeticAbilities.dummies[player_id] or nil
end


function CosmeticAbilities:SendDummyCaster(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local dummy = CosmeticAbilities.dummies[player_id]
	if not dummy then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "CosmeticAbilities:update_dummy_caster", {
		dummy_entity_index = dummy:GetEntityIndex()
	})
end


CosmeticAbilities:Init()