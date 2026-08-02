--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_solar_flare_1 = item_solar_flare_1 or class({})
item_solar_flare_2 = item_solar_flare_1 or class({})
item_solar_flare_3 = item_solar_flare_1 or class({})

LinkLuaModifier("modifier_item_solar_flare", "items/custom_items/item_solar_flare.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_solar_flare_aura", "items/custom_items/item_solar_flare.lua", LUA_MODIFIER_MOTION_NONE)

function item_solar_flare_1:Precache(context)
	PrecacheResource("particle", "particles/items2_fx/radiance.vpcf", context)
end

function item_solar_flare_1:GetIntrinsicModifierName()
	return "modifier_item_solar_flare"
end

---------------------------------------------------------------------------------------------------

modifier_item_solar_flare = modifier_item_solar_flare or class({})

function modifier_item_solar_flare:IsHidden()
	return true
end
function modifier_item_solar_flare:IsPurgable()
	return false
end
function modifier_item_solar_flare:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_solar_flare:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_strength = ability:GetSpecialValueFor("bonus_strength")
	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.health_regen_pct = ability:GetSpecialValueFor("health_regen_pct")
end

function modifier_item_solar_flare:OnRefresh()
	self:OnCreated()
end

function modifier_item_solar_flare:IsAura()
	return true
end
function modifier_item_solar_flare:GetModifierAura()
	return "modifier_item_solar_flare_aura"
end
function modifier_item_solar_flare:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_solar_flare:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_item_solar_flare:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_solar_flare:GetAuraDuration()
	return 0.3
end
function modifier_item_solar_flare:GetAuraRadius()
	local ability = self:GetAbility()
	if not ability then
		return 0
	end
	return ability:GetSpecialValueFor("aura_radius")
end

function modifier_item_solar_flare:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_item_solar_flare:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage or 0
end

function modifier_item_solar_flare:GetModifierBonusStats_Strength()
	return self.bonus_strength or 0
end

function modifier_item_solar_flare:GetModifierHealthBonus()
	return self.bonus_health or 0
end

function modifier_item_solar_flare:GetModifierHealthRegenPercentage()
	return self.health_regen_pct or 0
end

---------------------------------------------------------------------------------------------------

modifier_item_solar_flare_aura = modifier_item_solar_flare_aura or class({})

function modifier_item_solar_flare_aura:IsHidden()
	return true
end
function modifier_item_solar_flare_aura:IsPurgable()
	return false
end

function modifier_item_solar_flare_aura:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	if not IsServer() then
		return
	end

	if not self.pfx then
		self.pfx = ParticleManager:CreateParticle(
			"particles/items2_fx/radiance.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
	end

	self:StartIntervalThink(1.0)
end

function modifier_item_solar_flare_aura:OnRefresh()
	self:OnCreated()
end

function modifier_item_solar_flare_aura:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end

function modifier_item_solar_flare_aura:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end

	local victim = self:GetParent()
	if not victim or victim:IsNull() or not victim:IsAlive() then
		return
	end

	ApplyDamage({
		attacker = caster,
		victim = victim,
		ability = self:GetAbility(),
		damage = caster:GetStrength(),
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
	})
end