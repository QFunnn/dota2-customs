--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if modifier_wearable_material_effect == nil then
	modifier_wearable_material_effect = class({})
end

local public = modifier_wearable_material_effect

function public:IsHidden()
	return true
end
function public:IsDebuff()
	return false
end
function public:IsPurgable()
	return false
end
function public:IsPurgeException()
	return false
end
function public:AllowIllusionDuplicate()
	return false
end
function public:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function public:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function public:OnCreated(params)
	if IsServer() then
		AddModifierEvents(MODIFIER_EVENT_ON_ABILITY_EXECUTED, self)
		AddModifierEvents(MODIFIER_EVENT_ON_ABILITY_START, self)
	end
end
function public:OnDestroy()
	if IsServer() then
		RemoveModifierEvents(MODIFIER_EVENT_ON_ABILITY_EXECUTED, self)
		RemoveModifierEvents(MODIFIER_EVENT_ON_ABILITY_START, self)
	end
end
function public:CheckState()
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end
function public:DeclareFunctions()
	-- return {
	-- 	MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	-- 	MODIFIER_EVENT_ON_ABILITY_START,
	-- }
end
function public:OnAbilityStart(params)
	local hUnit = params.unit
	local hAbility = params.ability
	if IsValid(hUnit) and IsValid(hAbility) then
		local sAbilityName = hAbility:GetAbilityName()
		if hAbility:IsItem() then
			Wearable_System:PlayItemEffect(hUnit:GetPlayerOwnerID(), hUnit, sAbilityName, MODIFIER_EVENT_ON_ABILITY_START, {
				hTarget = hAbility:GetCursorTarget(),
				vPos = hAbility:GetCursorPosition(),
			})
		else

		end
	end
end
function public:OnAbilityExecuted(params)
	local hUnit = params.unit
	local hAbility = params.ability

	if IsValid(hUnit) and IsValid(hAbility) and hUnit == hUnit then
		local sAbilityName = hAbility:GetAbilityName()
		if hAbility:IsItem() then
			Wearable_System:PlayItemEffect(hUnit:GetPlayerOwnerID(), hUnit, sAbilityName, MODIFIER_EVENT_ON_ABILITY_EXECUTED, {
				hTarget = hAbility:GetCursorTarget(),
				vPos = hAbility:GetCursorPosition(),
			})
		else

		end
	end
end