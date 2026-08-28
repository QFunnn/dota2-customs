--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_bloodletter_1 = item_bloodletter_1 or class({})
item_bloodletter_2 = item_bloodletter_1
item_bloodletter_3 = item_bloodletter_1

LinkLuaModifier("modifier_item_bloodletter", "items/custom_items/item_bloodletter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_bloodletter_prevention",
	"items/custom_items/item_bloodletter.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_bloodletter_active_1",
	"items/custom_items/item_bloodletter.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_bloodletter_active_2",
	"items/custom_items/item_bloodletter.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_bloodletter_active_3",
	"items/custom_items/item_bloodletter.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_bloodletter_corrosion",
	"items/custom_items/item_bloodletter.lua",
	LUA_MODIFIER_MOTION_NONE
)

local function _item_level(item)
	return tonumber(item:GetAbilityName():match("_(%d+)$")) or 1
end

local function _active_mod_name(level)
	return "modifier_item_bloodletter_active_" .. level
end

---------------------------------------------------------------------------------------------------

function item_bloodletter_1:GetIntrinsicModifierName()
	return "modifier_item_bloodletter"
end

function item_bloodletter_1:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if caster:HasModifier("modifier_item_bloodletter_prevention") then
		return
	end
	caster:AddNewModifier(caster, self, "modifier_item_bloodletter_prevention", { duration = 0.05 })

	local active_name = _active_mod_name(_item_level(self))
	caster:EmitSound("DOTA_Item.MaskOfMadness.Activate")
	caster:AddNewModifier(caster, self, active_name, {
		duration = self:GetSpecialValueFor("duration"),
	})
end

function item_bloodletter_1:GetAbilityTextureName()
	local caster = self:GetCaster()
	local level = _item_level(self)
	-- if caster and not caster:IsNull() and caster:HasModifier(_active_mod_name(level)) then
	-- 	return "new/item_bloodletter_active"
	-- end
	return "new/item_bloodletter_" .. level
end

---------------------------------------------------------------------------------------------------

modifier_item_bloodletter = modifier_item_bloodletter or class({})

function modifier_item_bloodletter:IsHidden()
	return true
end
function modifier_item_bloodletter:IsPurgable()
	return false
end
function modifier_item_bloodletter:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_bloodletter:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")
	self.lifesteal = ability:GetSpecialValueFor("lifesteal")
end

function modifier_item_bloodletter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_item_bloodletter:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_bloodletter:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_item_bloodletter:OnTakeDamage(keys)
	if not IsServer() then
		return
	end
	if keys.attacker ~= self:GetParent() then
		return
	end
	if keys.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	if keys.damage <= 0 then
		return
	end

	local heal = keys.damage * (self.lifesteal or 0) / 100
	if heal > 0 then
		self:GetParent():Heal(heal, self:GetAbility())
		local pfx = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_lifesteal.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end

---------------------------------------------------------------------------------------------------

modifier_item_bloodletter_prevention = modifier_item_bloodletter_prevention or class({})

function modifier_item_bloodletter_prevention:IsHidden()
	return true
end
function modifier_item_bloodletter_prevention:IsPurgable()
	return false
end

---------------------------------------------------------------------------------------------------

modifier_item_bloodletter_active_1 = modifier_item_bloodletter_active_1 or class({})
modifier_item_bloodletter_active_2 = modifier_item_bloodletter_active_1
modifier_item_bloodletter_active_3 = modifier_item_bloodletter_active_1

function modifier_item_bloodletter_active_1:IsHidden()
	return false
end
function modifier_item_bloodletter_active_1:IsPurgable()
	return true
end

function modifier_item_bloodletter_active_1:GetTexture()
	return "new/item_bloodletter_active"
end

function modifier_item_bloodletter_active_1:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.active_attack_speed = ability:GetSpecialValueFor("active_attack_speed")
	self.stack_duration = ability:GetSpecialValueFor("stack_duration")
	self.hp_drain_pct = ability:GetSpecialValueFor("hp_drain_pct")
	self.debuff_armor = ability:GetSpecialValueFor("debuff_armor")
end

function modifier_item_bloodletter_active_1:OnRefresh()
	self:OnCreated()
end

function modifier_item_bloodletter_active_1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_item_bloodletter_active_1:CheckState()
	return { [MODIFIER_STATE_SILENCED] = true }
end

function modifier_item_bloodletter_active_1:GetModifierAttackSpeedBonus_Constant()
	return self.active_attack_speed
end

function modifier_item_bloodletter_active_1:GetModifierPhysicalArmorBonus()
	return -(self.debuff_armor or 0)
end

function modifier_item_bloodletter_active_1:OnAttackLanded(keys)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if keys.attacker ~= parent then
		return
	end

	local target = keys.target
	if not target or target:IsNull() or not target:IsAlive() then
		return
	end

	target:AddNewModifier(parent, self:GetAbility(), "modifier_item_bloodletter_corrosion", {
		duration = self.stack_duration,
	})

	local drain = math.floor(parent:GetHealth() * self.hp_drain_pct / 100)
	if drain > 0 then
		parent:SetHealth(math.max(parent:GetHealth() - drain, 1))
	end
end

---------------------------------------------------------------------------------------------------

modifier_item_bloodletter_corrosion = modifier_item_bloodletter_corrosion or class({})

function modifier_item_bloodletter_corrosion:IsHidden()
	return false
end
function modifier_item_bloodletter_corrosion:IsPurgable()
	return true
end
function modifier_item_bloodletter_corrosion:IsDebuff()
	return true
end

function modifier_item_bloodletter_corrosion:GetTexture()
	return "new/item_bloodletter_1"
end

function modifier_item_bloodletter_corrosion:OnCreated()
	self:SetStackCount(1)
end

function modifier_item_bloodletter_corrosion:OnRefresh()
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_item_bloodletter_corrosion:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_item_bloodletter_corrosion:GetModifierPhysicalArmorBonus()
	return -self:GetStackCount()
end