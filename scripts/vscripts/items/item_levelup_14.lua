--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_14", "items/item_levelup_14", LUA_MODIFIER_MOTION_NONE)

item_levelup_14 = class({})

function item_levelup_14:OnSpellStart()
	local caster = self:GetCaster()
	if not IsValid(caster) then
		return
	end

	local player_id = caster:GetPlayerOwnerID()
	local duration = self:GetSpecialValueFor("duration") or 0
	if not player_id or not wave_manager then
		return
	end

	local applied = wave_manager:ApplyLaneOrdinaryCapBonus(player_id, 5, duration)
	if not applied then
		return
	end

	-- Индикатор-баф на время действия ускорения волн (эффектов не даёт, только
	-- отображается у игрока). Длительность стакается так же, как сам эффект волн.
	local modifier_duration = duration
	local existing = caster:FindModifierByName("modifier_item_levelup_14")
	if existing then
		modifier_duration = existing:GetRemainingTime() + duration
	end
	caster:AddNewModifier(caster, self, "modifier_item_levelup_14", { duration = modifier_duration })

	ConsumeLevelUpItemCharge(caster, self)
end

modifier_item_levelup_14 = class({})
function modifier_item_levelup_14:IsPurgable()
	return false
end
function modifier_item_levelup_14:IsPurgeException()
	return false
end
function modifier_item_levelup_14:RemoveOnDeath()
	return false
end