--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_hellmask_lua_active", "items/custom_items/item_hellmask_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_hellmask_lua", "items/custom_items/item_hellmask_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_hellmask_lua_aura_buff", "items/custom_items/item_hellmask_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_hellmask_lua_aura_debuff", "items/custom_items/item_hellmask_lua", LUA_MODIFIER_MOTION_NONE)

item_hellmask_lua_1 = item_hellmask_lua_1 or class({})
item_hellmask_lua_2 = item_hellmask_lua_1 or class({})
item_hellmask_lua_3 = item_hellmask_lua_1 or class({})

function item_hellmask_lua_1:GetIntrinsicModifierName()
	return "modifier_hellmask_lua"
end

function item_hellmask_lua_1:OnSpellStart()
	self:GetCaster():Purge(false, true, false, false, false)
	EmitSoundOn("DOTA_Item.Satanic.Activate", self:GetCaster())
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_hellmask_lua_active",
		{ duration = self:GetSpecialValueFor("unholy_duration") }
	)
end

-------------------------------------------------------------------------------

modifier_hellmask_lua_active = class({})

function modifier_hellmask_lua_active:IsPurgable()
	return false
end

function modifier_hellmask_lua_active:GetEffectName()
	return "particles/items2_fx/satanic_buff.vpcf"
end

function modifier_hellmask_lua_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_hellmask_lua_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_hellmask_lua_active:OnCreated()
	local ability = self:GetAbility()

	self.unholy_lifesteal_percent = ability:GetSpecialValueFor("unholy_lifesteal_percent")
end

function modifier_hellmask_lua_active:OnTooltip()
	return self.unholy_lifesteal_percent
end

-------------------------------------------------------------------------------

modifier_hellmask_lua = class({})

function modifier_hellmask_lua:IsHidden()
	return true
end
function modifier_hellmask_lua:IsPurgable()
	return false
end
function modifier_hellmask_lua:RemoveOnDeath()
	return false
end

function modifier_hellmask_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_hellmask_lua:OnTooltip()
	return self.lifesteal_percent
end

function modifier_hellmask_lua:OnCreated()
	local ability = self:GetAbility()

	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")
	self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
	self.bonus_strength = ability:GetSpecialValueFor("bonus_strength")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.lifesteal_percent = ability:GetSpecialValueFor("lifesteal_percent")

	self.unholy_lifesteal_percent = ability:GetSpecialValueFor("unholy_lifesteal_percent")

	self.auraRadius = ability:GetSpecialValueFor("aura_radius")
end

function modifier_hellmask_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_hellmask_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_hellmask_lua:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if parent ~= params.attacker then
		return
	end

	if parent:HasModifier("modifier_hellmask_lua_active") then
		heal = params.damage * self.unholy_lifesteal_percent / 100
	else
		heal = params.damage * self.lifesteal_percent / 100
	end

	self:GetParent():Heal(heal, self:GetAbility())
	self:PlayEffects(self:GetParent())
end

function modifier_hellmask_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_hellmask_lua:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_hellmask_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_hellmask_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_hellmask_lua:GetModifierAura()
	return self.auraModifierName
end
function modifier_hellmask_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_hellmask_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING
end
function modifier_hellmask_lua:GetAuraRadius()
	return self.auraRadius
end
function modifier_hellmask_lua:GetAuraEntityReject(target)
	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		self.auraModifierName = "modifier_hellmask_lua_aura_buff"
	else
		self.auraModifierName = "modifier_hellmask_lua_aura_debuff"
	end

	return false
end
function modifier_hellmask_lua:IsAura()
	local caster = self:GetCaster()

	return not caster:PassivesDisabled() and not caster:IsIllusion()
end

-------------------------------------------------------------------------------

modifier_hellmask_lua_aura_buff = class({})

function modifier_hellmask_lua_aura_buff:IsHidden()
	return false
end
function modifier_hellmask_lua_aura_buff:IsPurgable()
	return false
end
function modifier_hellmask_lua_aura_buff:IsDebuff()
	return false
end

function modifier_hellmask_lua_aura_buff:OnCreated()
	local ability = self:GetAbility()

	self.aura_attack_speed = ability:GetSpecialValueFor("aura_attack_speed")
	self.aura_positive_armor = ability:GetSpecialValueFor("aura_positive_armor")
end
function modifier_hellmask_lua_aura_buff:OnRefresh()
	self:OnCreated()
end

function modifier_hellmask_lua_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_hellmask_lua_aura_buff:GetModifierAttackSpeedBonus_Constant()
	return self.aura_attack_speed
end

function modifier_hellmask_lua_aura_buff:GetModifierPhysicalArmorBonus()
	return self.aura_positive_armor
end

-------------------------------------------------------------------------------

modifier_hellmask_lua_aura_debuff = class({})

function modifier_hellmask_lua_aura_debuff:OnCreated()
	local ability = self:GetAbility()

	self.aura_negative_armor = -ability:GetSpecialValueFor("aura_negative_armor")
end
function modifier_hellmask_lua_aura_debuff:OnRefresh()
	self:OnCreated()
end

function modifier_hellmask_lua_aura_debuff:IsHidden()
	return false
end
function modifier_hellmask_lua_aura_debuff:IsPurgable()
	return false
end
function modifier_hellmask_lua_aura_debuff:IsDebuff()
	return true
end

function modifier_hellmask_lua_aura_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_hellmask_lua_aura_debuff:GetModifierPhysicalArmorBonus()
	return self.aura_negative_armor
end