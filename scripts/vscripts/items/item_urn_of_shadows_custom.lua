--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_urn_of_shadows_custom = class({})

LinkLuaModifier( "modifier_item_urn_of_shadows_custom", "items/item_urn_of_shadows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_urn_of_shadows_custom_ally", "items/item_urn_of_shadows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_urn_of_shadows_custom_enemy", "items/item_urn_of_shadows_custom", LUA_MODIFIER_MOTION_NONE )

function item_urn_of_shadows_custom:GetIntrinsicModifierName()
	return "modifier_item_urn_of_shadows_custom"
end

function item_urn_of_shadows_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	target:EmitSound("DOTA_Item.UrnOfShadows.Activate")

	local particle_fx = ParticleManager:CreateParticle("particles/items2_fx/urn_of_shadows.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle_fx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_fx, 1, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fx)

	if target:GetTeam() == caster:GetTeam() then
		target:AddNewModifier(caster, self, "modifier_item_urn_of_shadows_custom_ally", {duration = duration })
	else
		target:AddNewModifier(caster, self, "modifier_item_urn_of_shadows_custom_enemy", {duration = duration * (1 - target:GetStatusResistance()) })
	end
end

modifier_item_urn_of_shadows_custom = class({})
function modifier_item_urn_of_shadows_custom:IsHidden() return true end
function modifier_item_urn_of_shadows_custom:IsPurgable() return false end
function modifier_item_urn_of_shadows_custom:IsPurgeException() return false end
function modifier_item_urn_of_shadows_custom:RemoveOnDeath() return false end

function modifier_item_urn_of_shadows_custom:DeclareFunctions()
	local decFuns =
    {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
	return decFuns
end

function modifier_item_urn_of_shadows_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_urn_of_shadows_custom:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_urn_of_shadows_custom:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_urn_of_shadows_custom:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_urn_of_shadows_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

modifier_item_urn_of_shadows_custom_ally = class({})

function modifier_item_urn_of_shadows_custom_ally:IsDebuff() return false end
function modifier_item_urn_of_shadows_custom_ally:IsHidden() return false end
function modifier_item_urn_of_shadows_custom_ally:IsPurgable() return true end

function modifier_item_urn_of_shadows_custom_ally:OnCreated( params )
	if IsServer() then
		if not self:GetAbility() then self:Destroy() return end
	end
	self.health_regen = self:GetAbility():GetSpecialValueFor("soul_heal_amount")
end

function modifier_item_urn_of_shadows_custom_ally:DeclareFunctions()
	local decFuns =
		{
			MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
			 
		}
	return decFuns
end

function modifier_item_urn_of_shadows_custom_ally:GetEffectName()
	return "particles/items2_fx/urn_of_shadows_heal.vpcf"
end

function modifier_item_urn_of_shadows_custom_ally:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_urn_of_shadows_custom_ally:GetModifierConstantHealthRegen()
	return self.health_regen
end

function modifier_item_urn_of_shadows_custom_ally:OnTakeDamage(keys)
	if not keys.attacker or not keys.attacker:IsHero() then return end
	local unit = keys.unit
	local parent = self:GetParent()
    if unit == parent then
        self:Destroy()
    end
end

modifier_item_urn_of_shadows_custom_enemy = class({})

function modifier_item_urn_of_shadows_custom_enemy:IsDebuff() return true end
function modifier_item_urn_of_shadows_custom_enemy:IsHidden() return false end
function modifier_item_urn_of_shadows_custom_enemy:IsPurgable() return true end
function modifier_item_urn_of_shadows_custom_enemy:IsStunDebuff() return false end
function modifier_item_urn_of_shadows_custom_enemy:RemoveOnDeath() return true end

function modifier_item_urn_of_shadows_custom_enemy:GetEffectName()
	return "particles/items2_fx/urn_of_shadows_damage.vpcf"
end

function modifier_item_urn_of_shadows_custom_enemy:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_urn_of_shadows_custom_enemy:OnCreated( params )
	if IsServer() then
		if not self:GetAbility() then self:Destroy() return end
	end
	self.damage_per_second = self:GetAbility():GetSpecialValueFor("soul_damage_amount")
	self:StartIntervalThink(1)
end

function modifier_item_urn_of_shadows_custom_enemy:OnIntervalThink()
	if not IsServer() then return end
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage_per_second,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility()
	}
	ApplyDamage(damageTable)
end


