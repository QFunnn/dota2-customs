--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_players_summary = class({})

function modifier_players_summary:IsHidden()
	return true
end
function modifier_players_summary:IsPurgable()
	return false
end
function modifier_players_summary:RemoveOnDeath()
	return false
end
function modifier_players_summary:IsPermanent()
	return true
end

function modifier_players_summary:OnCreated()
	self.parent = self:GetParent()
	self.blacklistUnits = {
		["npc_unit_damage_challenge"] = true,
		["npc_dota_hero_target_dummy"] = true,
		["npc_dummy_unit"] = true,
		["breakable_container"] = true,
		["npc_dota_crate"] = true,
		["npc_dota_crate2"] = true,
		["npc_dota_vase"] = true,
		["minebox"] = true,
		["ultra_box"] = true,
		["big_box"] = true,
		["middle_box"] = true,
		["small_box"] = true,
		["invis_box"] = true,
		["npc_zone_9_creep_2_minion"] = true,
		["npc_zone_9_tomb_minion"] = true,
	}
end

function modifier_players_summary:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end

function modifier_players_summary:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_players_summary:OnTakeDamage(data)
	if not IsServer() then
		return
	end

	local parent = self.parent

	local attacker = data.attacker
	if attacker == parent then
		return
	end

	local target = data.unit
	if target == parent then
		return
	end

	if attacker == target then
		return
	end

	if target:IsTower() or target:IsBuilding() or target:IsOther() then
		return
	end

	if self.blacklistUnits[target:GetUnitName()] then
		return
	end

	local lastHealth

	if not target.__playersSummaryLastHealth then
		lastHealth = target:GetMaxHealth()
		target.__playersSummaryLastHealth = target:GetHealth()
	else
		lastHealth = target.__playersSummaryLastHealth
		target.__playersSummaryLastHealth = target:GetHealth()
	end

	local damage = math.floor(math.min(lastHealth, data.damage))
	local originalDamage = math.min(lastHealth, data.original_damage)

	if damage > originalDamage then
		originalDamage = damage
	else
		originalDamage = math.floor(originalDamage)
	end

	if attacker then
		if attacker:IsRealHero() then
			PlayersSummary:HandleDamage(
				PLAYER_SUMMARY_DAMAGE_HANDLE_TYPE.DEAL,
				attacker:GetPlayerOwnerID(),
				damage,
				data.damage_type,
				originalDamage
			)
		else
			local attackerOwner = attacker:GetPlayerOwner()
			if attackerOwner then
				local attackerOwnerHero = attackerOwner:GetAssignedHero()
				if attackerOwnerHero then
					PlayersSummary:HandleDamage(
						PLAYER_SUMMARY_DAMAGE_HANDLE_TYPE.DEAL,
						attackerOwnerHero:GetPlayerOwnerID(),
						damage,
						data.damage_type,
						originalDamage
					)
				end
			end
		end
	end

	if target:IsRealHero() then
		PlayersSummary:HandleDamage(
			PLAYER_SUMMARY_DAMAGE_HANDLE_TYPE.RECEIVE,
			target:GetPlayerOwnerID(),
			damage,
			data.damage_type,
			originalDamage
		)
	end
end

function modifier_players_summary:OnDeath(data)
	if not IsServer() then
		return
	end

	local parent = self.parent

	local attacker = data.attacker
	if attacker == parent then
		return
	end

	local target = data.unit
	if target == parent then
		return
	end

	if attacker == target then
		return
	end

	if target:IsTower() or target:IsBuilding() or target:IsOther() then
		return
	end

	if self.blacklistUnits[target:GetUnitName()] then
		return
	end

	if not attacker or not attacker:IsRealHero() then
		return
	end

	PlayersSummary:HandleKill(attacker:GetPlayerOwnerID())
end