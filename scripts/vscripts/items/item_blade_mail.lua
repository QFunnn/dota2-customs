--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_blade_mail = item_blade_mail or class({})
modifier_item_blade_mail_lua = modifier_item_blade_mail_lua or class({})
modifier_item_blade_mail_lua_unique_passive = modifier_item_blade_mail_lua_unique_passive or class({})
modifier_item_blade_mail_lua_dummy_modifier = modifier_item_blade_mail_lua_dummy_modifier or class({})

LinkLuaModifier("modifier_item_blade_mail_lua", "items/item_blade_mail", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_blade_mail_lua_unique_passive", "items/item_blade_mail", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_blade_mail_lua_dummy_modifier", "items/item_blade_mail", LUA_MODIFIER_MOTION_NONE)

-- Ability
function item_blade_mail:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:EmitSound("DOTA_Item.BladeMail.Activate")
	local unique_passive = caster:FindModifierByName("modifier_item_blade_mail_lua_unique_passive")

	if unique_passive then
		unique_passive:Activate(duration)
	end
end
--

-- Intrinsic modifier
function item_blade_mail:GetIntrinsicModifierName()
	return "modifier_item_blade_mail_lua"
end

function modifier_item_blade_mail_lua:IsHidden()
	return true
end
function modifier_item_blade_mail_lua:IsPurgable()
	return false
end
function modifier_item_blade_mail_lua:RemoveOnDeath()
	return false
end
function modifier_item_blade_mail_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_item_blade_mail_lua:OnCreated()
	local ability = self:GetAbility()

	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")

	if IsClient() then
		return
	end

	local parent = self:GetParent()

	parent:AddNewModifier(parent, ability, "modifier_item_blade_mail_lua_unique_passive", {})
end

function modifier_item_blade_mail_lua:OnRemoved()
	if IsServer() then
		self:GetParent():RemoveModifierByName("modifier_item_blade_mail_lua_unique_passive")
	end
end

function modifier_item_blade_mail_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_item_blade_mail_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_blade_mail_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
--

-- Unique passive modifier
function modifier_item_blade_mail_lua_unique_passive:IsHidden()
	return true
end
function modifier_item_blade_mail_lua_unique_passive:IsPurgable()
	return false
end
function modifier_item_blade_mail_lua_unique_passive:RemoveOnDeath()
	return false
end
function modifier_item_blade_mail_lua_unique_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_item_blade_mail_lua_unique_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.passive_reflection_constant = self.ability:GetSpecialValueFor("passive_reflection_constant")
	self.passive_reflection_pct = self.ability:GetSpecialValueFor("passive_reflection_pct") * 0.01
	self.active_reflection_pct = self.ability:GetSpecialValueFor("active_reflection_pct") * 0.01

	self.active = false
end

function modifier_item_blade_mail_lua_unique_passive:Activate(duration)
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_item_blade_mail_lua_dummy_modifier",
		{ duration = duration }
	)
	self.active = true

	Timers:CreateTimer(duration, function()
		self.active = false
	end)
end

function modifier_item_blade_mail_lua_unique_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_AVOID_DAMAGE,
	}
end

function modifier_item_blade_mail_lua_unique_passive:GetModifierAvoidDamage(keys)
	if
		bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION
		or bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS
		or keys.attacker:IsBuilding()
		or keys.attacker:IsMagicImmune()
		or keys.attacker == self.parent
	then
		return 0
	end

	local damage = keys.original_damage * (self.active and self.active_reflection_pct or 0)

	if keys.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		damage = damage + keys.original_damage * self.passive_reflection_pct + self.passive_reflection_constant
	end

	ApplyDamage({
		victim = keys.attacker,
		attacker = self.parent,
		damage = damage,
		damage_type = keys.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self.ability,
	})

	return 0
end
--

-- Dummy modifier to show duration and tooltip
function modifier_item_blade_mail_lua_dummy_modifier:IsHidden()
	return false
end
function modifier_item_blade_mail_lua_dummy_modifier:IsPurgable()
	return false
end
function modifier_item_blade_mail_lua_dummy_modifier:RemoveOnDeath()
	return true
end
function modifier_item_blade_mail_lua_dummy_modifier:GetEffectName()
	return "particles/items_fx/blademail.vpcf"
end