--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_madness_blade_mail", "items/item_madness_blade_mail", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_madness_blade_mail_buff", "items/item_madness_blade_mail", LUA_MODIFIER_MOTION_NONE)

item_madness_blade_mail = class({})

function item_madness_blade_mail:GetIntrinsicModifierName()
	return "modifier_item_madness_blade_mail"
end

function item_madness_blade_mail:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_item_madness_blade_mail_buff", {duration = duration} )
    self:GetCaster():EmitSound("DOTA_Item.BladeMail.Activate")
end

modifier_item_madness_blade_mail = class({})

function modifier_item_madness_blade_mail:IsHidden()
    return true
end

function modifier_item_madness_blade_mail:IsPurgable() return false end
function modifier_item_madness_blade_mail:IsPurgeException() return false end

function modifier_item_madness_blade_mail:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_madness_blade_mail:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
	}
end

function modifier_item_madness_blade_mail:GetModifierPhysicalArmorBonus()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor('bonus_armor')
	end
end

function modifier_item_madness_blade_mail:GetModifierPreAttack_BonusDamage()
    if self:GetAbility() then
    	return self:GetAbility():GetSpecialValueFor('bonus_damage')
	end
end

function modifier_item_madness_blade_mail:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() and params.target == self:GetParent() and not params.attacker:IsMagicImmune() then
		if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
		if params.attacker:IsMagicImmune() then return end
		local damage_return = self:GetAbility():GetSpecialValueFor("damage_return_passive_perc") * params.original_damage / 100 + self:GetAbility():GetSpecialValueFor("damage_return_passive")
		ApplyDamage({victim = params.attacker, attacker = self:GetParent(), damage = damage_return, damage_type = params.damage_type,  damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION, ability = self:GetAbility()})
	end
end

function modifier_item_madness_blade_mail:GetModifierProperty_PhysicalLifesteal(params)
    return self:GetAbility():GetSpecialValueFor("bonus_lifesteal")
end

modifier_item_madness_blade_mail_buff = class({})

function modifier_item_madness_blade_mail_buff:IsPurgable()
	return false
end

function modifier_item_madness_blade_mail_buff:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("DOTA_Item.MaskOfMadness.Activate")
end

function modifier_item_madness_blade_mail_buff:GetEffectName()
	return "particles/econ/items/spectre/spectre_arcana/spectre_arcana_blademail_v2.vpcf"
end

function modifier_item_madness_blade_mail_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_blademail.vpcf"
end

function modifier_item_madness_blade_mail_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
	}
end

function modifier_item_madness_blade_mail_buff:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true
	}
end

function modifier_item_madness_blade_mail_buff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():EmitSound("DOTA_Item.BladeMail.Deactivate")
end

function modifier_item_madness_blade_mail_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attack_speed_active") 
end

function modifier_item_madness_blade_mail_buff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movespeed_active") 
end

function modifier_item_madness_blade_mail_buff:GetModifierSlowResistance_Stacking()
    return self:GetAbility():GetSpecialValueFor("slow_resistance") 
end

function modifier_item_madness_blade_mail_buff:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("minus_armor_active") 
end

function modifier_item_madness_blade_mail_buff:OnTakeDamage(keys)
	if not IsServer() then return end
	local attacker = keys.attacker
	local target = keys.unit
	local original_damage = keys.original_damage
	local damage_type = keys.damage_type
	local damage_flags = keys.damage_flags
	if keys.unit == self:GetParent() and not keys.attacker:IsBuilding() and keys.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() and bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS and bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION and not attacker:IsMagicImmune() then	
		if not keys.unit:IsOther() then
			EmitSoundOnClient("DOTA_Item.BladeMail.Damage", keys.attacker:GetPlayerOwner())
			local damageTable = {
				victim			= keys.attacker,
				damage			= keys.original_damage / 100 * self:GetAbility():GetSpecialValueFor("damage_return_active"),
				damage_type		= keys.damage_type,
				damage_flags 	= DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				attacker		= self:GetParent(),
				ability			= self:GetAbility()
			}
			ApplyDamage(damageTable)
		end
	end
end