--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if modifier_ogre_multicast_lua_bonus == nil then
	modifier_ogre_multicast_lua_bonus = class({}) ---@class CDOTA_Modifier_Lua
end
function modifier_ogre_multicast_lua_bonus:IsHidden()
	return true
end
function modifier_ogre_multicast_lua_bonus:IsDebuff()
	return false
end
function modifier_ogre_multicast_lua_bonus:IsPurgable()
	return false
end
function modifier_ogre_multicast_lua_bonus:IsPurgeException()
	return false
end
function modifier_ogre_multicast_lua_bonus:IsStunDebuff()
	return false
end
function modifier_ogre_multicast_lua_bonus:AllowIllusionDuplicate()
	return true
end
function modifier_ogre_multicast_lua_bonus:GetPriority()
	return 99999
end
function modifier_ogre_multicast_lua_bonus:OnCreated(params)
	if IsServer() then
		self.abilityindex = params.abilityindex
		self:StartIntervalThink(0.3)
	end
end
function modifier_ogre_multicast_lua_bonus:CheckState()
	return {
		-- [MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		-- [MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end
function modifier_ogre_multicast_lua_bonus:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_ogre_multicast_lua_bonus:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	local hAbility = EntIndexToHScript(self.abilityindex) ---@cast hAbility CDOTABaseAbility
	if not IsValid(hAbility) then
		self:Destroy()
	elseif hAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_CHANNELLED) and ((not hParent:IsChanneling()) or (not hCaster:IsChanneling())) then
		self:Destroy()
	end
end
function modifier_ogre_multicast_lua_bonus:OnDestroy()
	local hParent = self:GetParent()
	if IsServer() then
		hParent:InterruptChannel()
		hParent:MakeIllusion()
		hParent:ForceKill(false)
	end
end
function modifier_ogre_multicast_lua_bonus:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_SUPER_ILLUSION_WITH_ULTIMATE,
		MODIFIER_PROPERTY_SUPER_ILLUSION,
		MODIFIER_PROPERTY_STRONG_ILLUSION,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_IS_ILLUSION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end
function modifier_ogre_multicast_lua_bonus:GetIsIllusion()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierPercentageCasttime()
	return 100
end
function modifier_ogre_multicast_lua_bonus:GetModifierInvisibilityLevel()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierCastRangeBonusStacking()
	return 99999
end
function modifier_ogre_multicast_lua_bonus:GetModifierSuperIllusionWithUltimate()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierSuperIllusion()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierStrongIllusion()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetModifierPercentageManacostStacking()
	return 100
end
function modifier_ogre_multicast_lua_bonus:GetModifierIgnoreCastAngle()
	return 1
end
function modifier_ogre_multicast_lua_bonus:GetOverrideAnimation()
	return ACT_DOTA_GENERIC_CHANNEL_1
end
function modifier_ogre_multicast_lua_bonus:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end