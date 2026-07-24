--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tower_purge_aura", "abilities/units/tower_purge_aura", LUA_MODIFIER_MOTION_NONE)
tower_purge_aura = class({})

function tower_purge_aura:GetIntrinsicModifierName()
	return "modifier_tower_purge_aura"
end




modifier_tower_purge_aura = class({})


function modifier_tower_purge_aura:IsHidden() return true end


function modifier_tower_purge_aura:OnCreated()
	self.attack_range_override = TEAMS_LAYOUTS[GetMapName()].tower_attack_range
	self.model_scale = GetMapName() == "ot3_necropolis_ffa" and -99 or 25

	if IsClient() then return end

	if (not self.fow) and GetMapName() == "ot3_necropolis_ffa" then
		local parent = self:GetParent()
		self.fow = AddFOWViewer(parent:GetTeamNumber(), parent:GetAbsOrigin(), 1800, -1, false)

		parent:AddNewModifier(parent, nil, "modifier_fountain_rejuvenation_lua", {duration = -1})
		parent:AddNewModifier(parent, nil, "modifier_fountain_movespeed_lua", {duration = -1})
	end


	self:StartIntervalThink(0.1)
end


function modifier_tower_purge_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end


function modifier_tower_purge_aura:GetModifierAttackRangeBonus() return (self.attack_range_override or 850) - 850 end
function modifier_tower_purge_aura:GetModifierModelScale() return self.model_scale or 0 end


function modifier_tower_purge_aura:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

modifier_tower_purge_aura.purge_exceptions = {
	npc_dota_elder_titan_ancestral_spirit = true,
}

function modifier_tower_purge_aura:OnIntervalThink()
	local parent = self:GetParent()
	if not IsValidEntity(parent) then return end

	-- we have to do this because auras do not care about invulnerable flag
	local enemies = FindUnitsInRadius(
		parent:GetTeam(),
		parent:GetAbsOrigin(),
		nil,
		parent:Script_GetAttackRange() + 450,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies or {}) do
		if IsValidEntity(enemy) and enemy:IsAlive() and not self.purge_exceptions[enemy:GetUnitName()] then
			enemy:Purge(true, false, false, false, true)
		end
	end
end