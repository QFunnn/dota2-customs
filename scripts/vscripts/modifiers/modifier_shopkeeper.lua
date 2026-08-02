--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_shopkeeper_aura", "modifiers/modifier_shopkeeper.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shop", "modifiers/modifier_shopkeeper.lua", LUA_MODIFIER_MOTION_NONE)

modifier_shopkeeper = class({})

function modifier_shopkeeper:DeclareFunctions()
	local funcs = {
		--MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}

	return funcs
end

function modifier_shopkeeper:CheckState()
	local state = {
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}

	return state
end

function modifier_shopkeeper:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_shopkeeper:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_shopkeeper:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_shopkeeper:GetMinHealth()
	return 1
end

function modifier_shopkeeper:IsHidden()
	return false --true
end

modifier_shop = class({}) --Аура магазина

function modifier_shop:IsAura()
	return true
end

function modifier_shop:GetModifierAura()
	return "modifier_shopkeeper_aura"
end

function modifier_shop:GetAuraRadius()
	return 300
end

function modifier_shop:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_shop:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_shop:GetAuraDuration()
	return 0.2
end

modifier_shopkeeper_aura = class({})

function modifier_shopkeeper_aura:IsHidden()
	return true
end

function modifier_shopkeeper_aura:OnCreated(t) --вызов активации магазина
	if IsServer() then
		self.pid = self:GetParent():GetPlayerOwnerID()
		--	self:GetParent().res['activeshops'][self:GetCaster():GetUnitName()] = true
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(self.pid),
			"ActivateShop",
			{ name = self:GetCaster():GetUnitName() }
		)
	end
end

function modifier_shopkeeper_aura:OnDestroy(t) --соответсвенно деактивации
	if IsServer() then
		--	self:GetParent().res['activeshops'][self:GetCaster():GetUnitName()] = false
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.pid), "DeactivateShop", {})
	end
end