--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_guardian_greaves_lua",
	"items/custom_items/item_guardian_greaves_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_guardian_greaves_lua_aura_emitter",
	"items/custom_items/item_guardian_greaves_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_guardian_greaves_lua_aura",
	"items/custom_items/item_guardian_greaves_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_guardian_greaves_lua_heal",
	"items/custom_items/item_guardian_greaves_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)

item_guardian_greaves_lua1 = item_guardian_greaves_lua1 or class({})
item_guardian_greaves_lua2 = item_guardian_greaves_lua1 or class({})
item_guardian_greaves_lua3 = item_guardian_greaves_lua1 or class({})

function item_guardian_greaves_lua1:GetIntrinsicModifierName()
	return "modifier_item_guardian_greaves_lua"
end

function item_guardian_greaves_lua1:OnSpellStart()
	local heal_amount = self:GetSpecialValueFor("replenish_health")
		* (1 + self:GetCaster():GetSpellAmplification(false) * 0.01)
	local mana_amount = self:GetSpecialValueFor("replenish_mana")
		+ self:GetSpecialValueFor("mend_mana_pct") * self:GetCaster():GetMaxMana() * 0.01
	local heal_radius = self:GetSpecialValueFor("aura_radius")
	local heal_duration = self:GetSpecialValueFor("mend_duration")

	GreavesActivate(self:GetCaster(), self, heal_amount, mana_amount, heal_radius, heal_duration)
end

--------------------------------------------------------------------------------------------------------------------------------------------

modifier_item_guardian_greaves_lua = class({})

function modifier_item_guardian_greaves_lua:IsHidden()
	return true
end
function modifier_item_guardian_greaves_lua:IsPurgable()
	return false
end
function modifier_item_guardian_greaves_lua:RemoveOnDeath()
	return false
end
function modifier_item_guardian_greaves_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_guardian_greaves_lua:OnCreated(keys)
	self.bonus_movement = self:GetAbility():GetSpecialValueFor("bonus_movement")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.bonus_mana = self:GetAbility():GetSpecialValueFor("bonus_mana")

	if not self:GetAbility() then
		self:Destroy()
		return
	end
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent:HasModifier("modifier_item_guardian_greaves_lua_aura_emitter") then
		parent:AddNewModifier(parent, self:GetAbility(), "modifier_item_guardian_greaves_lua_aura_emitter", {})
	end

	self:OnIntervalThink()
	self:StartIntervalThink(1.0)
end

function modifier_item_guardian_greaves_lua:OnDestroy(keys)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent:HasModifier("modifier_item_guardian_greaves_lua") then
		parent:RemoveModifierByName("modifier_item_guardian_greaves_lua_aura_emitter")
	end
end

function modifier_item_guardian_greaves_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MANA_BONUS,
	}
end

function modifier_item_guardian_greaves_lua:GetModifierMoveSpeedBonus_Special_Boots()
	return self.bonus_movement
end

function modifier_item_guardian_greaves_lua:GetModifierManaBonus()
	return self.bonus_mana
end

function modifier_item_guardian_greaves_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

modifier_item_guardian_greaves_lua_aura_emitter = class({})
function modifier_item_guardian_greaves_lua_aura_emitter:IsAura()
	return true
end
function modifier_item_guardian_greaves_lua_aura_emitter:IsHidden()
	return true
end
function modifier_item_guardian_greaves_lua_aura_emitter:IsDebuff()
	return false
end
function modifier_item_guardian_greaves_lua_aura_emitter:IsPurgable()
	return false
end

function modifier_item_guardian_greaves_lua_aura_emitter:OnCreated()
	self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
	self.aura_bonus_threshold = self:GetAbility():GetSpecialValueFor("aura_bonus_threshold")
	self.replenish_health = self:GetAbility():GetSpecialValueFor("replenish_health")
	self.replenish_mana = self:GetAbility():GetSpecialValueFor("replenish_mana")
	self.mend_mana_pct = self:GetAbility():GetSpecialValueFor("mend_mana_pct")
	self.mend_duration = self:GetAbility():GetSpecialValueFor("mend_duration")
end

function modifier_item_guardian_greaves_lua_aura_emitter:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_guardian_greaves_lua_aura_emitter:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_item_guardian_greaves_lua_aura_emitter:GetModifierAura()
	if self:GetParent():IsAlive() then
		return "modifier_item_guardian_greaves_lua_aura"
	else
		return nil
	end
end

function modifier_item_guardian_greaves_lua_aura_emitter:GetAuraRadius()
	return self.aura_radius
end

function modifier_item_guardian_greaves_lua_aura_emitter:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_item_guardian_greaves_lua_aura_emitter:OnTakeDamage(keys)
	if IsServer() then
		local owner = self:GetParent()
		if owner ~= keys.unit then
			return
		end

		if owner:IsIllusion() then
			return
		end

		local ability = self:GetAbility()
		if
			owner:GetHealthPercent() <= self.aura_bonus_threshold
			and owner:GetHealthPercent() > 0
			and ability:IsCooldownReady()
			and owner:GetMana() >= ability:GetManaCost(-1)
		then
			GreavesActivate(
				owner,
				ability,
				self.replenish_health,
				self.replenish_mana + self.mend_mana_pct * owner:GetMaxMana() * 0.01,
				self.aura_radius,
				self.mend_duration
			)
		end
	end
end

modifier_item_guardian_greaves_lua_aura = class({})
function modifier_item_guardian_greaves_lua_aura:IsHidden()
	return false
end
function modifier_item_guardian_greaves_lua_aura:IsDebuff()
	return false
end
function modifier_item_guardian_greaves_lua_aura:IsPurgable()
	return false
end

function modifier_item_guardian_greaves_lua_aura:OnCreated(keys)
	local ability = self:GetAbility()

	self.aura_health_regen = ability:GetSpecialValueFor("aura_health_regen")
	self.aura_armor = ability:GetSpecialValueFor("aura_armor")
	self.aura_health_regen_bonus = ability:GetSpecialValueFor("aura_health_regen_bonus")
	self.aura_armor_bonus = ability:GetSpecialValueFor("aura_armor_bonus")
	self.aura_bonus_threshold = ability:GetSpecialValueFor("aura_bonus_threshold")
end
function modifier_item_guardian_greaves_lua_aura:OnRefresh()
	self:OnCreated()
end

function modifier_item_guardian_greaves_lua_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_guardian_greaves_lua_aura:GetModifierPhysicalArmorBonus()
	local owner = self:GetParent()

	if owner:IsRealHero() then
		local bonus_power = (1 - math.max(owner:GetHealthPercent(), self.aura_bonus_threshold) * 0.01)
			/ (1 - self.aura_bonus_threshold * 0.01)
		return self.aura_armor + (self.aura_armor_bonus - self.aura_armor) * bonus_power
	end

	return self.aura_armor
end

function modifier_item_guardian_greaves_lua_aura:GetModifierConstantHealthRegen()
	local owner = self:GetParent()

	if owner:IsRealHero() then
		local bonus_power = (1 - math.max(owner:GetHealthPercent(), self.aura_bonus_threshold) * 0.01)
			/ (1 - self.aura_bonus_threshold * 0.01)
		return self.aura_health_regen + (self.aura_health_regen_bonus - self.aura_health_regen) * bonus_power
	end

	return self.aura_health_regen
end

modifier_item_guardian_greaves_lua_heal = class({})
function modifier_item_guardian_greaves_lua_heal:IsHidden()
	return false
end
function modifier_item_guardian_greaves_lua_heal:IsDebuff()
	return false
end
function modifier_item_guardian_greaves_lua_heal:IsPurgable()
	return true
end

function modifier_item_guardian_greaves_lua_heal:OnCreated(keys)
	self.mend_regen = self:GetAbility():GetSpecialValueFor("mend_regen")
end

function modifier_item_guardian_greaves_lua_heal:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_item_guardian_greaves_lua_heal:GetModifierHealthRegenPercentage()
	return self.mend_regen
end

function GreavesActivate(caster, ability, heal_amount, mana_amount, heal_radius, heal_duration)
	caster:Purge(false, true, false, false, false)

	caster:EmitSound("Item.GuardianGreaves.Activate")

	local cast_pfx =
		ParticleManager:CreateParticle("particles/items3_fx/warmage.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(cast_pfx)

	local nearby_allies = FindUnitsInRadius(
		caster:GetTeam(),
		caster:GetAbsOrigin(),
		nil,
		heal_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, ally in pairs(nearby_allies) do
		ally:Heal(heal_amount, caster)
		ally:GiveMana(mana_amount)

		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, ally, heal_amount, nil)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, ally, mana_amount, nil)

		ally:EmitSound("Item.GuardianGreaves.Target")

		local particle_name = "particles/items3_fx/warmage_mana_nonhero.vpcf"
		local particle_name_hero = "particles/items3_fx/warmage_recipient.vpcf"

		local particle_target = particle_name
		if ally:IsHero() then
			particle_target = particle_name_hero
		end

		local target_pfx = ParticleManager:CreateParticle(particle_target, PATTACH_ABSORIGIN_FOLLOW, ally)
		ParticleManager:SetParticleControl(target_pfx, 0, ally:GetAbsOrigin())

		ally:AddNewModifier(caster, ability, "modifier_item_guardian_greaves_lua_heal", { duration = 40 })

		ability:UseResources(true, false, false, true)
	end
end