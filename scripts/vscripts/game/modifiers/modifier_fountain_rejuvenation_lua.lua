--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_fountain_rejuvenation_lua = modifier_fountain_rejuvenation_lua or class({})
LinkLuaModifier("modifier_fountain_rejuvenation_effect_lua", "game/modifiers/modifier_fountain_rejuvenation_lua", LUA_MODIFIER_MOTION_NONE)

function modifier_fountain_rejuvenation_lua:IsHidden() return true end
function modifier_fountain_rejuvenation_lua:IsAura() return true end
function modifier_fountain_rejuvenation_lua:IsPurgable() return false end
function modifier_fountain_rejuvenation_lua:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end


function modifier_fountain_rejuvenation_lua:IsAura() return true end
-- tower attack range + DOTA_HULL_SIZE_TOWER = 850 (or per-map override) + 144 = 994
function modifier_fountain_rejuvenation_lua:GetAuraRadius() return self:GetParent():Script_GetAttackRange() + 144 end
function modifier_fountain_rejuvenation_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_fountain_rejuvenation_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_fountain_rejuvenation_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_fountain_rejuvenation_lua:GetModifierAura() return "modifier_fountain_rejuvenation_effect_lua" end


modifier_fountain_rejuvenation_effect_lua = modifier_fountain_rejuvenation_effect_lua or class({})

modifier_fountain_rejuvenation_effect_lua.interval = 0.5
modifier_fountain_rejuvenation_effect_lua.mana_regen = 25 -- %
modifier_fountain_rejuvenation_effect_lua.health_regen = 25 -- %
modifier_fountain_rejuvenation_effect_lua.status_res = 50 -- %

function modifier_fountain_rejuvenation_effect_lua:GetTexture() return "filler_ability" end

function modifier_fountain_rejuvenation_effect_lua:OnCreated()
	if IsClient() then return end

	local parent = self:GetParent()

	self:RefillBottle(parent)

	parent:Purge(false, true, false, true, true)

	-- this is a bit dirty, but better than listening to unit respawn in separate modifiers
	local shield_modifier = parent:FindModifierByName("modifier_generic_physical_shield_upgrade")
	if shield_modifier and not shield_modifier:IsNull() then shield_modifier:ResetShields() end

	local shield_modifier = parent:FindModifierByName("modifier_generic_magical_shield_upgrade")
	if shield_modifier and not shield_modifier:IsNull() then shield_modifier:ResetShields() end

	if parent:GetUnitName() == "npc_dota_hero_lich" then self.interval = 0.1 end

	self:StartIntervalThink(self.interval)
end

function modifier_fountain_rejuvenation_effect_lua:OnIntervalThink()
	local parent = self:GetParent()
	if not IsValidEntity(parent) then return end
	parent:Purge(false, true, false, true, true)

	if parent:GetUnitName() == "npc_dota_hero_lich" then
		parent:GiveMana(self.interval * self.mana_regen * parent:GetMaxMana() / 100.0)
	end

	self:RefillBottle(parent)
end

function modifier_fountain_rejuvenation_effect_lua:RefillBottle(target)
	local bottle = target:FindItemInInventory("item_bottle")
	if bottle and IsValidEntity(bottle) then
		bottle:SetCurrentCharges(3)
	end
end

function modifier_fountain_rejuvenation_effect_lua:CheckState()
	return {
		[MODIFIER_STATE_DEBUFF_IMMUNE] = true,
	}
end

function modifier_fountain_rejuvenation_effect_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE, -- GetModifierHealthRegenPercentage
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE, -- GetModifierTotalPercentageManaRegen
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING, -- GetModifierStatusResistanceStacking
	}
end


function modifier_fountain_rejuvenation_effect_lua:GetModifierHealthRegenPercentage()
	return self.health_regen
end


function modifier_fountain_rejuvenation_effect_lua:GetModifierTotalPercentageManaRegen()
	return self.mana_regen
end


function modifier_fountain_rejuvenation_effect_lua:GetModifierStatusResistanceStacking()
	return self.status_res
end