--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_cosmic_focus", "items/custom_items/item_cosmic_focus", LUA_MODIFIER_MOTION_NONE)

item_cosmic_focus_1 = item_cosmic_focus_1 or class({})
item_cosmic_focus_2 = item_cosmic_focus_1 or class({})
item_cosmic_focus_3 = item_cosmic_focus_1 or class({})

function item_cosmic_focus_1:GetIntrinsicModifierName()
	return "modifier_item_cosmic_focus"
end

---------------------------------------------------------------------------------------------------

modifier_item_cosmic_focus = class({})

function modifier_item_cosmic_focus:IsHidden()
	return true
end
function modifier_item_cosmic_focus:IsPurgable()
	return false
end
function modifier_item_cosmic_focus:RemoveOnDeath()
	return false
end

local function IsOwnItem(item, hero)
	local purchaser = item:GetPurchaser()
	return purchaser == nil or purchaser == hero
end

local function GetPrimaryCosmicFocus(hero)
	local best, bestLevel = nil, 0
	for i = 0, 8 do
		local item = hero:GetItemInSlot(i)
		if item and string.find(item:GetName(), "item_cosmic_focus") and IsOwnItem(item, hero) then
			local lvl = item:GetLevel()
			if lvl > bestLevel then
				bestLevel = lvl
				best = item
			end
		end
	end
	return best
end

local function MergeChargesToPrimary(hero)
	local primary = GetPrimaryCosmicFocus(hero)
	if not primary then
		return
	end

	local total = 0
	for i = 0, 8 do
		local item = hero:GetItemInSlot(i)
		if item and string.find(item:GetName(), "item_cosmic_focus") and IsOwnItem(item, hero) then
			total = total + item:GetCurrentCharges()
		end
	end

	for i = 0, 8 do
		local item = hero:GetItemInSlot(i)
		if item and string.find(item:GetName(), "item_cosmic_focus") and IsOwnItem(item, hero) then
			item:SetCurrentCharges(item == primary and total or 0)
		end
	end
end

function modifier_item_cosmic_focus:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.bonus_mana = ability:GetSpecialValueFor("bonus_mana")
	self.mana_regen = ability:GetSpecialValueFor("mana_regen")
	self.cast_range_bonus = ability:GetSpecialValueFor("cast_range_bonus")
	self.bonus_intellect = ability:GetSpecialValueFor("bonus_intellect")
	self.spell_amp = ability:GetSpecialValueFor("spell_amp")
	self.mana_regen_multiplier = ability:GetSpecialValueFor("mana_regen_multiplier")
	self.spell_lifesteal_amp = ability:GetSpecialValueFor("spell_lifesteal_amp")
	self.int_per_kill = ability:GetSpecialValueFor("int_per_kill")

	if IsServer() then
		local parent = self:GetParent()
		local savedCharges = parent.charges or 0
		MergeChargesToPrimary(parent)
		local primary = GetPrimaryCosmicFocus(parent)
		if primary and primary:GetCurrentCharges() == 0 and savedCharges > 0 then
			primary:SetCurrentCharges(savedCharges)
		end
	end
end

function modifier_item_cosmic_focus:OnRefresh()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.bonus_mana = ability:GetSpecialValueFor("bonus_mana")
	self.mana_regen = ability:GetSpecialValueFor("mana_regen")
	self.cast_range_bonus = ability:GetSpecialValueFor("cast_range_bonus")
	self.bonus_intellect = ability:GetSpecialValueFor("bonus_intellect")
	self.spell_amp = ability:GetSpecialValueFor("spell_amp")
	self.mana_regen_multiplier = ability:GetSpecialValueFor("mana_regen_multiplier")
	self.spell_lifesteal_amp = ability:GetSpecialValueFor("spell_lifesteal_amp")
	self.int_per_kill = ability:GetSpecialValueFor("int_per_kill")
end

function modifier_item_cosmic_focus:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_item_cosmic_focus:GetModifierManaBonus()
	return self.bonus_mana or 0
end
function modifier_item_cosmic_focus:GetModifierConstantManaRegen()
	return self.mana_regen or 0
end
function modifier_item_cosmic_focus:GetModifierCastRangeBonus()
	return self.cast_range_bonus or 0
end
function modifier_item_cosmic_focus:GetModifierSpellAmplify_Percentage()
	return self.spell_amp or 0
end
function modifier_item_cosmic_focus:GetModifierMPRegenAmplify_Percentage()
	return self.mana_regen_multiplier or 0
end
function modifier_item_cosmic_focus:GetModifierSpellLifestealRegenAmplify_Percentage()
	return self.spell_lifesteal_amp or 0
end

function modifier_item_cosmic_focus:GetModifierBonusStats_Intellect()
	local perma = 0
	if self.int_per_kill and self.int_per_kill > 0 then
		local ability = self:GetAbility()
		if ability then
			perma = ability:GetCurrentCharges() * self.int_per_kill
		end
	end
	return (self.bonus_intellect or 0) + perma
end

function modifier_item_cosmic_focus:OnTakeDamage(keys)
	if not IsServer() then
		return
	end
	if not keys or not keys.unit or not keys.attacker then
		return
	end

	local victim = keys.unit
	if victim:IsAlive() then
		return
	end

	local parent = self:GetParent()
	if not IsMyKilledBadGuys2(parent, keys) then
		return
	end

	if victim._cosmic_focus_awarded then
		return
	end
	victim._cosmic_focus_awarded = true

	local primary = GetPrimaryCosmicFocus(parent)
	if self:GetAbility() ~= primary then
		return
	end

	primary:SetCurrentCharges(primary:GetCurrentCharges() + 1)
	parent.charges = primary:GetCurrentCharges()
end

function IsMyKilledBadGuys2(hero, params)
	if params.unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
		return false
	end
	local attacker = params.attacker
	if hero ~= attacker or attacker:HasModifier("modifier_guild_event") then
		return false
	end
	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return false
	end
	return true
end