--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_spirit_vessel_custom = class({})

LinkLuaModifier( "modifier_item_spirit_vessel_custom", "items/item_spirit_vessel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_spirit_vessel_custom_active_ally", "items/item_spirit_vessel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_spirit_vessel_custom_active_enemy", "items/item_spirit_vessel_custom", LUA_MODIFIER_MOTION_NONE )

function item_spirit_vessel_custom:GetIntrinsicModifierName()
	return "modifier_item_spirit_vessel_custom"
end

function item_spirit_vessel_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	target:EmitSound("DOTA_Item.UrnOfShadows.Activate")

	local particle_fx = ParticleManager:CreateParticle("particles/items4_fx/spirit_vessel_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle_fx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_fx, 1, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fx)

	if target:GetTeam() == caster:GetTeam() then
		target:AddNewModifier(caster, self, "modifier_item_spirit_vessel_custom_active_ally", {duration = duration })
	else
		target:AddNewModifier(caster, self, "modifier_item_spirit_vessel_custom_active_enemy", {duration = duration * (1 - target:GetStatusResistance()) })
	end
end

modifier_item_spirit_vessel_custom = class({})

function modifier_item_spirit_vessel_custom:IsHidden() return true end
function modifier_item_spirit_vessel_custom:IsPurgable() return false end
function modifier_item_spirit_vessel_custom:RemoveOnDeath()	return false end
function modifier_item_spirit_vessel_custom:IsPurgeException() return false end

function modifier_item_spirit_vessel_custom:DeclareFunctions()
	local decFuns =
    {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL
    }
	return decFuns
end

function modifier_item_spirit_vessel_custom:GetModifierProperty_MagicalLifesteal(params)
    return self:GetAbility():GetSpecialValueFor("lifesteal_magical")
end

function modifier_item_spirit_vessel_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_spirit_vessel_custom:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_spirit_vessel_custom:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_spirit_vessel_custom:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_spirit_vessel_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_spirit_vessel_custom:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

modifier_item_spirit_vessel_custom_active_ally = class({})

function modifier_item_spirit_vessel_custom_active_ally:IsDebuff() return false end
function modifier_item_spirit_vessel_custom_active_ally:IsHidden() return false end
function modifier_item_spirit_vessel_custom_active_ally:IsPurgable() return true end

function modifier_item_spirit_vessel_custom_active_ally:OnCreated( params )
	self.soul_heal_amount = self:GetAbility():GetSpecialValueFor("soul_heal_amount")
	if not IsServer() then return end
	if not self:GetAbility() then self:Destroy() return end
end

function modifier_item_spirit_vessel_custom_active_ally:DeclareFunctions()
	local decFuns =
	{
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		 
	}
	return decFuns
end

function modifier_item_spirit_vessel_custom_active_ally:GetEffectName()
	return "particles/items2_fx/urn_of_shadows_heal.vpcf"
end

function modifier_item_spirit_vessel_custom_active_ally:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_spirit_vessel_custom_active_ally:GetModifierConstantHealthRegen()
	return self.soul_heal_amount
end

function modifier_item_spirit_vessel_custom_active_ally:OnTakeDamage(keys)
	if not keys.attacker or not keys.attacker:IsHero() then return end
	local unit = keys.unit
	local parent = self:GetParent()
    if  unit == parent then
        self:Destroy()
    end
end

modifier_item_spirit_vessel_custom_active_enemy = class({})

function modifier_item_spirit_vessel_custom_active_enemy:IsDebuff() return true end
function modifier_item_spirit_vessel_custom_active_enemy:IsHidden() return false end
function modifier_item_spirit_vessel_custom_active_enemy:IsPurgable() return true end
function modifier_item_spirit_vessel_custom_active_enemy:IsStunDebuff() return false end
function modifier_item_spirit_vessel_custom_active_enemy:RemoveOnDeath() return true end

function modifier_item_spirit_vessel_custom_active_enemy:GetEffectName()
	return "particles/items4_fx/spirit_vessel_damage.vpcf"
end

function modifier_item_spirit_vessel_custom_active_enemy:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_spirit_vessel_custom_active_enemy:OnCreated( params )
	if IsServer() then
		if not self:GetAbility() then self:Destroy() return end
	end
	self.soul_damage_amount = self:GetAbility():GetSpecialValueFor("soul_damage_amount")
	self.hp_regen_reduction_enemy = self:GetAbility():GetSpecialValueFor("hp_regen_reduction_enemy")
	self.soul_damage_percent = self:GetAbility():GetSpecialValueFor("soul_damage_percent")
    self.heal_from_target_damage = self:GetAbility():GetSpecialValueFor("heal_from_target_damage") / 100
	self:StartIntervalThink(1)
end

function modifier_item_spirit_vessel_custom_active_enemy:OnIntervalThink()
	if not IsServer() then return end
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.soul_damage_amount + (self:GetParent():GetMaxHealth() / 100 * self.soul_damage_percent),
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility()
	}
	local damage_count = ApplyDamage(damageTable)
    self:GetCaster():Heal(damage_count * self.heal_from_target_damage, self:GetAbility())
end

function modifier_item_spirit_vessel_custom_active_enemy:DeclareFunctions()
	return 
    {
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    }
end

function modifier_item_spirit_vessel_custom_active_enemy:GetModifierPropertyRestorationAmplification()
    return self.hp_regen_reduction_enemy
end