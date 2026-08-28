--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon", "heroes/hero_dragon/dragon_2_skill/dragon_2_skill", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_2_skill", "heroes/hero_dragon/dragon_2_skill/dragon_2_skill", LUA_MODIFIER_MOTION_NONE)

dragon_2_skill = class({})

function dragon_2_skill:GetIntrinsicModifierName()
	return "modifier_dragon"
end

----------------------------------------------------------------

modifier_dragon = class({})

function modifier_dragon:IsHidden()
	return true
end

function modifier_dragon:IsPurgable()
	return false
end

function modifier_dragon:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_dragon:GetModifierProcAttack_Feedback(params)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_8")
	if talent and talent:GetLevel() > 0 then
		self.duration = self.duration + 1
	end

	if IsServer() then
		params.target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_dragon_2_skill",
			{ duration = self.duration }
		)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

modifier_dragon_2_skill = class({})

function modifier_dragon_2_skill:IsHidden()
	return false
end

function modifier_dragon_2_skill:IsDebuff()
	return true
end

function modifier_dragon_2_skill:IsStunDebuff()
	return false
end

function modifier_dragon_2_skill:IsPurgable()
	return false
end

function modifier_dragon_2_skill:OnCreated(kv)
	local damage = self:GetAbility():GetSpecialValueFor("damage") / 2
	local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_5")
	if talent and talent:GetLevel() > 0 then
		damage = damage + 45
	end

	self.mag_resist = self:GetAbility():GetSpecialValueFor("mag_resist")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_1")
	if talent and talent:GetLevel() > 0 then
		self.mag_resist = self.mag_resist + 8
	end

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}
	self:StartIntervalThink(0.5)
end

function modifier_dragon_2_skill:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_dragon_2_skill:GetModifierMagicalResistanceBonus()
	return -self.mag_resist
end

function modifier_dragon_2_skill:GetModifierPhysicalArmorBonus()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_2")
	if talent and talent:GetLevel() > 0 then
		return -self.mag_resist / 2
	end
	return 0
end

function modifier_dragon_2_skill:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_dragon_2_skill:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_dragon_2_skill:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end