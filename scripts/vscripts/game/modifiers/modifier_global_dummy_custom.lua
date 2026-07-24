--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_global_dummy_custom = class({})


function modifier_global_dummy_custom:IsHidden() return false end


function modifier_global_dummy_custom:CheckState()
	return {
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end


function modifier_global_dummy_custom:GetModifierInvisibilityLevel()
	return 4
end


function modifier_global_dummy_custom:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end


function modifier_global_dummy_custom:OnTakeDamage(event)
	if not IsServer() then return end
	if event.original_damage <= 0 then return end
	-- check for `nan` (in case ability deals 0 damage, original_damage will be nan for some reason)
	-- `nan` is not equal to anything, even itself
	if event.original_damage ~= event.original_damage then
		return
	end
	local target = event.unit
	if not target or target:IsNull() or not target:IsRealHero() or target:IsIllusion() then return end

	local target_id = target.GetPlayerOwnerID and target:GetPlayerOwnerID()
	if not target_id or not EndGameStats.stats[target_id] then return end

	local attacker = event.attacker

	if attacker and not attacker:IsNull() and attacker.IsTower and attacker:IsTower() then return end

	EndGameStats:Add_DamageTaken(target_id,  event.original_damage)
end