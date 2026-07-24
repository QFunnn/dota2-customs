--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_Head_of_the_Fallen", "item_ability/item_Head_of_the_Fallen.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_Head_of_the_Fallen_effect", "item_ability/item_Head_of_the_Fallen.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_Head_of_the_Fallen_Active", "item_ability/item_Head_of_the_Fallen.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_Head_of_the_Fallen_burn", "item_ability/item_Head_of_the_Fallen.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_Head_of_the_Fallen == nil then
	item_Head_of_the_Fallen = class({})
end
function item_Head_of_the_Fallen:IsRefreshable()
	return false
end
function item_Head_of_the_Fallen:OnSpellStart()
	local hCaster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	if IsValid(hCaster) then
		hCaster:AddNewModifier(hCaster, self, "modifier_item_Head_of_the_Fallen_Active", { duration = duration })
	end
end
function item_Head_of_the_Fallen:GetIntrinsicModifierName()
	return "modifier_item_Head_of_the_Fallen"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_Head_of_the_Fallen == nil then
	modifier_item_Head_of_the_Fallen = class({})
end
function modifier_item_Head_of_the_Fallen:IsHidden()
	return true
end
function modifier_item_Head_of_the_Fallen:IsDebuff()
	return false
end
function modifier_item_Head_of_the_Fallen:IsPurgable()
	return false
end
function modifier_item_Head_of_the_Fallen:IsPurgeException()
	return false
end
function modifier_item_Head_of_the_Fallen:AllowIllusionDuplicate()
	return false
end
function modifier_item_Head_of_the_Fallen:IsAura()
	return true
end
function modifier_item_Head_of_the_Fallen:GetAuraRadius()
	return self.radius
end
function modifier_item_Head_of_the_Fallen:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_item_Head_of_the_Fallen:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_Head_of_the_Fallen:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER
end
function modifier_item_Head_of_the_Fallen:GetModifierAura()
	return "modifier_item_Head_of_the_Fallen_effect"
end
function modifier_item_Head_of_the_Fallen:GetAuraEntityReject(hEntity)
	if hEntity:HasAttackCapability() then
		return false
	else
		return true
	end
end
function modifier_item_Head_of_the_Fallen:OnCreated(params)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_hp_regen = self:GetAbilitySpecialValueFor("bonus_hp_regen")
	if IsServer() then
	end
end
function modifier_item_Head_of_the_Fallen:OnRefresh(params)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_hp_regen = self:GetAbilitySpecialValueFor("bonus_hp_regen")
	if IsServer() then
	end
end
function modifier_item_Head_of_the_Fallen:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end
function modifier_item_Head_of_the_Fallen:GetModifierBonusStats_Strength()
	return self.all_stats
end
function modifier_item_Head_of_the_Fallen:GetModifierBonusStats_Agility()
	return self.all_stats
end
function modifier_item_Head_of_the_Fallen:GetModifierBonusStats_Intellect()
	return self.all_stats
end
function modifier_item_Head_of_the_Fallen:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_item_Head_of_the_Fallen:GetModifierConstantHealthRegen()
	return self.bonus_hp_regen
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_Head_of_the_Fallen_effect == nil then
	modifier_item_Head_of_the_Fallen_effect = class({})
end
function modifier_item_Head_of_the_Fallen_effect:IsHidden()
	return false
end
function modifier_item_Head_of_the_Fallen_effect:IsDebuff()
	return false
end
function modifier_item_Head_of_the_Fallen_effect:IsPurgable()
	return false
end
function modifier_item_Head_of_the_Fallen_effect:IsPurgeException()
	return false
end
function modifier_item_Head_of_the_Fallen_effect:IsAura()
	return true
end
function modifier_item_Head_of_the_Fallen_effect:GetAuraRadius()
	return self.burn_radius
end
function modifier_item_Head_of_the_Fallen_effect:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_Head_of_the_Fallen_effect:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_Head_of_the_Fallen_effect:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_item_Head_of_the_Fallen_effect:GetModifierAura()
	return "modifier_item_Head_of_the_Fallen_burn"
end
function modifier_item_Head_of_the_Fallen_effect:OnCreated(params)
	local hParent = self:GetParent()
	if hParent:IsRealHero() or hParent:IsIllusion() then
		self.creep_mult = 100
	else
		self.creep_mult = self:GetAbilitySpecialValueFor("creep_mult")
	end
	self.life_steal_pct = self:GetAbilitySpecialValueFor("life_steal_pct") * self.creep_mult * 0.01
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed") * self.creep_mult * 0.01
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed") * self.creep_mult * 0.01
	self.magical_resistance = self:GetAbilitySpecialValueFor("magical_resistance") * self.creep_mult * 0.01
	self.evasion = self:GetAbilitySpecialValueFor("evasion") * self.creep_mult * 0.01
	self.spell_amp = self:GetAbilitySpecialValueFor("spell_amp") * self.creep_mult * 0.01
	self.burn_radius = self:GetAbilitySpecialValueFor("burn_radius")
	if IsServer() then
		self.bActive = false
	end
end
function modifier_item_Head_of_the_Fallen_effect:OnRefresh(params)
	local hParent = self:GetParent()
	if hParent:IsRealHero() or hParent:IsIllusion() then
		self.creep_mult = 100
	else
		self.creep_mult = self:GetAbilitySpecialValueFor("creep_mult")
	end
	self.life_steal_pct = self:GetAbilitySpecialValueFor("life_steal_pct") * self.creep_mult * 0.01
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed") * self.creep_mult * 0.01
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed") * self.creep_mult * 0.01
	self.magical_resistance = self:GetAbilitySpecialValueFor("magical_resistance") * self.creep_mult * 0.01
	self.evasion = self:GetAbilitySpecialValueFor("evasion") * self.creep_mult * 0.01
	self.spell_amp = self:GetAbilitySpecialValueFor("spell_amp") * self.creep_mult * 0.01
	self.burn_radius = self:GetAbilitySpecialValueFor("burn_radius")
	if IsServer() then
	end
end
function modifier_item_Head_of_the_Fallen_effect:OnDestroy()
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, true)
		ParticleManager:ReleaseParticleIndex(self.particleID)
	end
end
function modifier_item_Head_of_the_Fallen_effect:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_item_Head_of_the_Fallen_effect:OnAttackLanded(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker

	if IsValid(hParent) and hParent:IsAlive() and IsValid(hAttacker) and hParent == hAttacker and params.damage > 0 then
		local iParticleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:ReleaseParticleIndex(iParticleID)
		local heal_amount = 1
		if not hParent:IsOther() then
			heal_amount = params.damage * self.life_steal_pct * 0.01
		end
		hParent:HealWithParams(heal_amount, self:GetAbility(), true, true, hParent, false)
	end
end
function modifier_item_Head_of_the_Fallen_effect:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end
function modifier_item_Head_of_the_Fallen_effect:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_movespeed
end
function modifier_item_Head_of_the_Fallen_effect:GetModifierMagicalResistanceBonus()
	return self.magical_resistance
end
function modifier_item_Head_of_the_Fallen_effect:GetModifierEvasion_Constant()
	return self.evasion
end
function modifier_item_Head_of_the_Fallen_effect:GetModifierSpellAmplify_Percentage()
	return self.spell_amp
end
function modifier_item_Head_of_the_Fallen_effect:OnTooltip()
	return self.life_steal_pct
end
function modifier_item_Head_of_the_Fallen_effect:CheckState()
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if IsValid(hCaster) and hCaster:HasModifier("modifier_item_Head_of_the_Fallen_Active") then
		if not self.bActive then
			self.bActive = true
			if self.particleID ~= nil then
				ParticleManager:DestroyParticle(self.particleID, true)
				ParticleManager:ReleaseParticleIndex(self.particleID)
			end
			EmitSoundOn("DOTA_Item.BlackKingBar.Activate", hParent)
			self.particleID = ParticleManager:CreateParticle("particles/items/head_of_the_fallen.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		end
		return {
			[MODIFIER_STATE_CANNOT_MISS] = true,
			[MODIFIER_STATE_DEBUFF_IMMUNE] = true,
		}
	else
		if self.particleID ~= nil then
			ParticleManager:DestroyParticle(self.particleID, true)
			ParticleManager:ReleaseParticleIndex(self.particleID)
		end
		self.bActive = false
	end
end
function modifier_item_Head_of_the_Fallen_effect:GetEffectName()
	return "particles/items/head_of_the_fallen_burn.vpcf"
end
function modifier_item_Head_of_the_Fallen_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_Head_of_the_Fallen_Active == nil then
	modifier_item_Head_of_the_Fallen_Active = class({})
end
function modifier_item_Head_of_the_Fallen_Active:IsHidden()
	return false
end
function modifier_item_Head_of_the_Fallen_Active:IsDebuff()
	return false
end
function modifier_item_Head_of_the_Fallen_Active:IsPurgable()
	return false
end
function modifier_item_Head_of_the_Fallen_Active:IsPurgeException()
	return false
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_Head_of_the_Fallen_burn == nil then
	modifier_item_Head_of_the_Fallen_burn = class({})
end
function modifier_item_Head_of_the_Fallen_burn:IsHidden()
	return false
end
function modifier_item_Head_of_the_Fallen_burn:IsDebuff()
	return true
end
function modifier_item_Head_of_the_Fallen_burn:IsPurgable()
	return false
end
function modifier_item_Head_of_the_Fallen_burn:IsPurgeException()
	return false
end
function modifier_item_Head_of_the_Fallen_burn:OnCreated()
	local hParent = self:GetParent()
	self.burn_damage = self:GetAbilitySpecialValueFor("burn_damage")
	self.burn_interval = self:GetAbilitySpecialValueFor("burn_interval")
	if IsServer() then
		local hAttacker = self:GetAuraOwner()
		self:StartIntervalThink(self.burn_interval)
		local particleID = ParticleManager:CreateParticle("particles/econ/events/ti8/radiance_ti8.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(particleID, 1, hAttacker, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
		self:AddParticle(particleID, false, false, -1, false, false)
	end
end
function modifier_item_Head_of_the_Fallen_burn:OnRefresh()
	self.burn_damage = self:GetAbilitySpecialValueFor("burn_damage")
	self.burn_interval = self:GetAbilitySpecialValueFor("burn_interval")
	if IsServer() then
	end
end
function modifier_item_Head_of_the_Fallen_burn:OnIntervalThink()
	local hAttacker = self:GetAuraOwner()
	local hParent = self:GetParent()
	ApplyDamage({
		victim = hParent,
		attacker = hAttacker,
		damage = self.burn_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end
function modifier_item_Head_of_the_Fallen_burn:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end