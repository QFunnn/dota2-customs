--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_blacksmith_aura", "modifiers/modifier_custom_blacksmith", LUA_MODIFIER_MOTION_NONE)

if modifier_custom_blacksmith == nil then
	modifier_custom_blacksmith = class({})
end

function modifier_custom_blacksmith:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
	return funcs
end

function modifier_custom_blacksmith:CheckState()
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

function modifier_custom_blacksmith:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_custom_blacksmith:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_custom_blacksmith:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_custom_blacksmith:GetMinHealth()
	return 1
end

function modifier_custom_blacksmith:IsHidden()
	return true
end

function modifier_custom_blacksmith:IsAura()
	return true
end

function modifier_custom_blacksmith:GetModifierAura()
	return "modifier_custom_blacksmith_aura"
end

function modifier_custom_blacksmith:GetAuraRadius()
	return 200
end

function modifier_custom_blacksmith:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_custom_blacksmith:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_custom_blacksmith:GetAuraDuration()
	return 0.1
end

--------------------------------------

if modifier_custom_blacksmith_aura == nil then
	modifier_custom_blacksmith_aura = class({})
end

function modifier_custom_blacksmith_aura:IsHidden()
	return true
end

function modifier_custom_blacksmith_aura:OnCreated(t)
	if IsServer() then
		self.pid = self:GetParent():GetPlayerOwnerID()
		local sid = PlayerResource:GetSteamAccountID(self.pid)
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(self.pid),
			"Upgrade_activate",
			{ items = SearchForItems(self:GetParent()), shop = Shop.pShop[sid][2][14] }
		)
	end
end

function modifier_custom_blacksmith_aura:OnDestroy(t)
	if IsServer() then
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.pid), "Upgrade_deactivate", {})
	end
end

function SearchForItems(hero)
	hero_items = {}
	hero_items["set"] = {}
	for i = 0, 5 do
		local item = hero:GetItemInSlot(i)
		if item then
			if string.find(item:GetAbilityName(), "_set_") then
				hero_items["set"][item:GetAbilityName()] = item:GetLevel()
			end
		end
	end
	return hero_items
end