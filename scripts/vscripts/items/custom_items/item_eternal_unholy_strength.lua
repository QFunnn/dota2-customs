--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_eternal_unholy_strength_1 = item_eternal_unholy_strength_1 or class({})
item_eternal_unholy_strength_2 = item_eternal_unholy_strength_1 or class({})
item_eternal_unholy_strength_3 = item_eternal_unholy_strength_1 or class({})

LinkLuaModifier(
	"modifier_item_eternal_unholy_strength",
	"items/custom_items/item_eternal_unholy_strength.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_eternal_unholy_str_active_1",
	"items/custom_items/item_eternal_unholy_strength.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_eternal_unholy_str_active_2",
	"items/custom_items/item_eternal_unholy_strength.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_eternal_unholy_str_active_3",
	"items/custom_items/item_eternal_unholy_strength.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_eternal_unholy_str_toggle_prevent",
	"items/custom_items/item_eternal_unholy_strength.lua",
	LUA_MODIFIER_MOTION_NONE
)

local function _active_name(level)
	return "modifier_item_eternal_unholy_str_active_" .. level
end

local function _find_item_active(unit, name)
	for slot = 0, 5 do
		local item = unit:GetItemInSlot(slot)
		if item and not item:IsNull() and item:GetName() == name then
			return item
		end
	end
	return nil
end

local function _has_higher_tier(unit, current_level)
	for lvl = current_level + 1, 3 do
		if _find_item_active(unit, "item_eternal_unholy_strength_" .. lvl) then
			return true
		end
	end
	return false
end

---------------------------------------------------------------------------------------------------

function item_eternal_unholy_strength_1:GetIntrinsicModifierName()
	return "modifier_item_eternal_unholy_strength"
end

function item_eternal_unholy_strength_1:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local level = self:GetLevel()

	if _has_higher_tier(caster, level) then
		return
	end

	if caster:HasModifier("modifier_item_eternal_unholy_str_toggle_prevent") then
		return
	end

	caster:AddNewModifier(caster, self, "modifier_item_eternal_unholy_str_toggle_prevent", { duration = 0.05 })

	local mod_name = _active_name(level)
	if caster:HasModifier(mod_name) then
		caster:EmitSound("DOTA_Item.Armlet.Activate")
		caster:RemoveModifierByName(mod_name)
	else
		caster:EmitSound("DOTA_Item.Armlet.DeActivate")
		caster:AddNewModifier(caster, self, mod_name, {})
	end
end

function item_eternal_unholy_strength_1:GetAbilityTextureName()
	local caster = self:GetCaster()
	if caster and not caster:IsNull() and caster:HasModifier(_active_name(self:GetLevel())) then
		return "new/item_eternal_unholy_strength_active"
	end
	return "new/item_eternal_unholy_strength_" .. self:GetLevel()
end

---------------------------------------------------------------------------------------------------

modifier_item_eternal_unholy_strength = modifier_item_eternal_unholy_strength or class({})

function modifier_item_eternal_unholy_strength:IsHidden()
	return true
end
function modifier_item_eternal_unholy_strength:IsPurgable()
	return false
end
function modifier_item_eternal_unholy_strength:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_eternal_unholy_strength:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self._item_level = ability:GetLevel()
	self.bonus_strength = ability:GetSpecialValueFor("bonus_strength")
	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.health_regen_pct = ability:GetSpecialValueFor("health_regen_pct")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")
	self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
	self._blocked = false

	if IsServer() then
		self:StartIntervalThink(1.0)
	end
end

function modifier_item_eternal_unholy_strength:OnRefresh()
	self:OnCreated()
end

function modifier_item_eternal_unholy_strength:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or parent:IsNull() then
		return
	end

	self._blocked = _has_higher_tier(parent, self._item_level or 0)
end

function modifier_item_eternal_unholy_strength:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_item_eternal_unholy_strength:GetModifierPreAttack_BonusDamage()
	if self._blocked then
		return 0
	end
	return self.bonus_damage or 0
end

function modifier_item_eternal_unholy_strength:GetModifierAttackSpeedBonus_Constant()
	if self._blocked then
		return 0
	end
	return self.bonus_attack_speed or 0
end

function modifier_item_eternal_unholy_strength:GetModifierPhysicalArmorBonus()
	if self._blocked then
		return 0
	end
	return self.bonus_armor or 0
end

function modifier_item_eternal_unholy_strength:GetModifierBonusStats_Strength()
	if self._blocked then
		return 0
	end
	return self.bonus_strength or 0
end

function modifier_item_eternal_unholy_strength:GetModifierHealthBonus()
	if self._blocked then
		return 0
	end
	return self.bonus_health or 0
end

function modifier_item_eternal_unholy_strength:GetModifierHealthRegenPercentage()
	if self._blocked then
		return 0
	end
	local parent = self:GetParent()
	if parent and not parent:IsNull() and parent:HasModifier(_active_name(self._item_level or 0)) then
		return 0
	end
	return self.health_regen_pct or 0
end

---------------------------------------------------------------------------------------------------

modifier_item_eternal_unholy_str_active_1 = modifier_item_eternal_unholy_str_active_1 or class({})
modifier_item_eternal_unholy_str_active_2 = modifier_item_eternal_unholy_str_active_1
modifier_item_eternal_unholy_str_active_3 = modifier_item_eternal_unholy_str_active_1

function modifier_item_eternal_unholy_str_active_1:IsHidden()
	return true
end
function modifier_item_eternal_unholy_str_active_1:IsPurgable()
	return false
end

function modifier_item_eternal_unholy_str_active_1:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self._item_level = ability:GetLevel()
	self.health_regen_pct = ability:GetSpecialValueFor("health_regen_pct")
	self.missing_hp_per_str = ability:GetSpecialValueFor("missing_hp_per_str")
	self.str_per_missing_stack = ability:GetSpecialValueFor("str_per_missing_stack")

	self:SetStackCount(0)

	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_item_eternal_unholy_str_active_1:OnRefresh()
	self:OnCreated()
end

function modifier_item_eternal_unholy_str_active_1:OnIntervalThink()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if not parent or parent:IsNull() then
		return
	end

	if _has_higher_tier(parent, self._item_level or 0) then
		self:Destroy()
		return
	end

	if not _find_item_active(parent, "item_eternal_unholy_strength_" .. (self._item_level or 1)) then
		self:Destroy()
		return
	end

	local drain = parent:GetMaxHealth() * (self.health_regen_pct or 0) * 0.01 * 0.1
	parent:SetHealth(math.max(parent:GetHealth() - drain, 1))

	local missing_hp = parent:GetMaxHealth() - parent:GetHealth()
	local threshold = (self.missing_hp_per_str and self.missing_hp_per_str > 0) and self.missing_hp_per_str or 200
	self:SetStackCount(math.floor(missing_hp / threshold))
end

function modifier_item_eternal_unholy_str_active_1:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATS_STRENGTH_BONUS }
end

function modifier_item_eternal_unholy_str_active_1:GetModifierBonusStats_Strength()
	return self:GetStackCount() * (self.str_per_missing_stack or 0)
end

---------------------------------------------------------------------------------------------------

modifier_item_eternal_unholy_str_toggle_prevent = modifier_item_eternal_unholy_str_toggle_prevent or class({})

function modifier_item_eternal_unholy_str_toggle_prevent:IsHidden()
	return true
end
function modifier_item_eternal_unholy_str_toggle_prevent:IsPurgable()
	return false
end