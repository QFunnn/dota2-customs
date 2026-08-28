--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_octarine_core_lua",
	"items/custom_items/item_octarine_core_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)

item_octarine_core_lua1 = item_octarine_core_lua1 or class({})
item_octarine_core_lua2 = item_octarine_core_lua1 or class({})
item_octarine_core_lua3 = item_octarine_core_lua1 or class({})

function item_octarine_core_lua1:GetIntrinsicModifierName()
	return "modifier_item_octarine_core_lua"
end

function item_octarine_core_lua1:OnSpellStart()
	refresh(self:GetCaster())
end

function item_octarine_core_lua1:GetManaCost(iLevel)
	local caster = self:GetCaster()

	if not caster then
		return 0
	end

	return caster:GetMaxMana() / 2
end

function refresh(caster)
	if not IsServer() then
		return
	end

	local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	local sound_cast = "DOTA_Item.Refresher.Activate"
	-- EmitSoundOnLocationWithCaster(caster:GetOrigin(), sound_cast, caster)
	EmitSoundOn(sound_cast, caster)

	local abilityCount = caster:GetAbilityCount()
	for i = 0, abilityCount - 1 do
		local current_ability = caster:GetAbilityByIndex(i)
		if current_ability and current_ability:GetAbilityName() ~= "hero_rubick_ability" then
			current_ability:EndCooldown()
		end
	end

	for i = 0, abilityCount - 1 do
		local current_item = caster:GetItemInSlot(i)
		local should_refresh = true

		if current_item ~= nil then
			if
				(string.find(current_item:GetName(), "octarine_core") or current_item:GetPurchaser() ~= caster)
				or string.find(current_item:GetName(), "item_ex_machina")
			then
				should_refresh = false
			end
		end

		if current_item and should_refresh then
			current_item:EndCooldown()
		end
	end
end

---------------------------------------------------------------------

modifier_item_octarine_core_lua = class({})

function modifier_item_octarine_core_lua:IsHidden()
	return true
end

function modifier_item_octarine_core_lua:IsPurgable()
	return false
end

function modifier_item_octarine_core_lua:DestroyOnExpire()
	return false
end

function modifier_item_octarine_core_lua:RemoveOnDeath()
	return false
end

function modifier_item_octarine_core_lua:OnCreated()
	local ability = self:GetAbility()
	self.bonus_mana = ability:GetSpecialValueFor("bonus_mana")
	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.bonus_mana_regen = ability:GetSpecialValueFor("bonus_mana_regen")
	self.bonus_cooldown = ability:GetSpecialValueFor("bonus_cooldown")
	self.cast_range_bonus = ability:GetSpecialValueFor("cast_range_bonus")
	self._item_level = ability:GetLevel()
end

function modifier_item_octarine_core_lua:OnRefresh()
	self:OnCreated()
end

local function _unit_has_item(unit, name)
	if not unit.GetItemInSlot then
		return false
	end
	for i = 0, 5 do
		local item = unit:GetItemInSlot(i)
		if item and item:GetName() == name then
			return true
		end
	end
	return false
end

local function _has_trident(unit)
	return unit:HasModifier("modifier_item_trident_of_eternity")
end

local function _has_higher_octarine(unit, level)
	for lvl = level + 1, 3 do
		if _unit_has_item(unit, "item_octarine_core_lua" .. lvl) then
			return true
		end
	end
	return false
end

function modifier_item_octarine_core_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
	}
end

function modifier_item_octarine_core_lua:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_item_octarine_core_lua:GetModifierManaBonus()
	return self.bonus_mana
end

function modifier_item_octarine_core_lua:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end

function modifier_item_octarine_core_lua:GetModifierPercentageCooldown()
	local parent = self:GetParent()
	if parent and not parent:IsNull() then
		if _has_trident(parent) then
			return 0
		end
		if _has_higher_octarine(parent, self._item_level or 0) then
			return 0
		end
	end
	return self.bonus_cooldown
end

function modifier_item_octarine_core_lua:GetModifierCastRangeBonus()
	return self.cast_range_bonus
end