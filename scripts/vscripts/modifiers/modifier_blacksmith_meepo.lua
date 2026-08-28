--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_blacksmith_meepo_aura", "modifiers/modifier_blacksmith_meepo", LUA_MODIFIER_MOTION_NONE)

if modifier_blacksmith_meepo == nil then
	modifier_blacksmith_meepo = class({})
end

function modifier_blacksmith_meepo:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
	return funcs
end

function modifier_blacksmith_meepo:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = false,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = false,
	}
	return state
end

function modifier_blacksmith_meepo:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_blacksmith_meepo:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_blacksmith_meepo:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_blacksmith_meepo:GetMinHealth()
	return 1
end

function modifier_blacksmith_meepo:IsHidden()
	return true
end

function modifier_blacksmith_meepo:IsAura()
	return true
end

function modifier_blacksmith_meepo:GetModifierAura()
	return "modifier_blacksmith_meepo_aura"
end

function modifier_blacksmith_meepo:GetAuraRadius()
	return 250
end

function modifier_blacksmith_meepo:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_blacksmith_meepo:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_blacksmith_meepo:GetAuraDuration()
	return 0.1
end

------------------------------------

if modifier_blacksmith_meepo_aura == nil then
	modifier_blacksmith_meepo_aura = class({})
end

function modifier_blacksmith_meepo_aura:IsHidden()
	return true
end

function modifier_blacksmith_meepo_aura:OnCreated(t)
	if IsServer() then
		self.pid = self:GetParent():GetPlayerOwnerID()
		-- CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.pid),"ActivateBlacksmith",{})
	end
end

function modifier_blacksmith_meepo_aura:OnDestroy(t)
	if IsServer() then
		-- CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.pid),"DeactivateBlacksmith",{})
	end
end