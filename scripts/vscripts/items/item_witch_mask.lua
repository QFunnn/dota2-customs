--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_witch_mask", "items/item_witch_mask", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_witch_mask_debuff", "items/item_witch_mask", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_witch_mask_buff", "items/item_witch_mask", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_witch_mask_cooldown", "items/item_witch_mask", LUA_MODIFIER_MOTION_NONE)

item_witch_mask = class({})

function item_witch_mask:GetIntrinsicModifierName()
	return "modifier_item_witch_mask"
end

function item_witch_mask:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_item_witch_mask_buff", {duration = duration} )
end

modifier_item_witch_mask = class({})

function modifier_item_witch_mask:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_witch_mask:IsHidden() return true end
function modifier_item_witch_mask:IsPurgable() return false end
function modifier_item_witch_mask:IsPurgeException() return false end

function modifier_item_witch_mask:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		 
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		 
	}
end

function modifier_item_witch_mask:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_witch_mask:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_witch_mask:OnTakeDamage(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent() == params.unit then return end
    if params.unit:IsBuilding() then return end
    if params.inflictor == nil and not self:GetParent():IsIllusion() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then 
        if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
    	if self:GetParent():FindAllModifiersByName("modifier_item_witch_mask")[1] ~= self then return end
        local heal = self:GetAbility():GetSpecialValueFor("lifesteal_percent") / 100 * params.damage
        self:GetParent():Heal(heal, nil)
    end
    if not self:GetParent():IsRealHero() then return end
	if params.inflictor == nil then return end
	if params.inflictor == self:GetAbility() then return end
	if params.inflictor:IsItem() then return end
	if params.damage < self:GetAbility():GetSpecialValueFor("min_damage_to_activate") then return end
	if self:GetParent():FindAllModifiersByName("modifier_item_witch_mask")[1] ~= self then return end
	if (self:GetParent():GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > 1200 then return end
	if self:GetParent():HasModifier("modifier_item_witch_mask_cooldown") then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_witch_mask_cooldown", {duration = self:GetAbility():GetSpecialValueFor("debuff_cooldown")})
	params.unit:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_witch_mask_debuff", {duration = self:GetAbility():GetSpecialValueFor("slow_duration")})
end

function modifier_item_witch_mask:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_witch_mask:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_witch_mask:GetModifierProjectileSpeedBonus()
	return self:GetAbility():GetSpecialValueFor("attack_speed_proj")
end

modifier_item_witch_mask_buff = class({})

function modifier_item_witch_mask_buff:IsPurgable()
	return false
end

function modifier_item_witch_mask_buff:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/econ/items/faceless_void/faceless_void_arcana/faceless_void_arcana_mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("DOTA_Item.MaskOfMadness.Activate")
end

function modifier_item_witch_mask_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_witch_mask_buff:CheckState()
	return
	{
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_item_witch_mask_buff:GetModifierMagicalResistanceBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("magical_resist")
end

function modifier_item_witch_mask_buff:GetModifierSpellAmplify_Percentage()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("spell_amplify")
end

function modifier_item_witch_mask_buff:GetEffectName()
	return "particles/generic_gameplay/generic_disarm.vpcf"
end

function modifier_item_witch_mask_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

modifier_item_witch_mask_debuff = class({})

function modifier_item_witch_mask_debuff:OnCreated()
	self.int_damage_multiplier = self:GetAbility():GetSpecialValueFor('int_damage_multiplier')
	self.slow = self:GetAbility():GetSpecialValueFor('slow')
	if not IsServer() then return end
	self:StartIntervalThink(1)
	self:GetParent():RemoveModifierByName("modifier_item_witch_blade_slow")
end

function modifier_item_witch_mask_debuff:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetCaster():GetIntellect(false) * self.int_damage_multiplier
	ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
	self:GetParent():RemoveModifierByName("modifier_item_witch_blade_slow")
end

function modifier_item_witch_mask_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_item_witch_mask_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_item_witch_mask_debuff:GetEffectName()
	return "particles/items3_fx/witch_blade_debuff.vpcf"
end

function modifier_item_witch_mask_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


modifier_item_witch_mask_cooldown = class({})
function modifier_item_witch_mask_cooldown:IsPurgable() return false end
function modifier_item_witch_mask_cooldown:IsPurgeException() return false end
function modifier_item_witch_mask_cooldown:RemoveOnDeath() return false end
function modifier_item_witch_mask_cooldown:IsDebuff() return true end
function modifier_item_witch_mask_cooldown:GetTexture() return "item_witch_mask" end