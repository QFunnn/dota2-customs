--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_heaven_shield", "items/item_heaven_shield", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_heaven_shield_active", "items/item_heaven_shield", LUA_MODIFIER_MOTION_NONE)

item_heaven_shield = class({})

function item_heaven_shield:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("disarm_melee")

	if target:IsRangedAttacker() and not target:HasModifier("modifier_vengefulspirit_retribution") then
		duration = self:GetSpecialValueFor("disarm_range")
	end

	if target:TriggerSpellAbsorb(self) then return end

	target:EmitSound("DOTA_Item.HeavensHalberd.Activate")
	target:AddNewModifier(self:GetCaster(), self, "modifier_item_heaven_shield_active", {duration = duration * (1 - target:GetStatusResistance())})
end

function item_heaven_shield:GetIntrinsicModifierName()
	return "modifier_item_heaven_shield"
end

modifier_item_heaven_shield = class({})

function modifier_item_heaven_shield:IsHidden() return true end
function modifier_item_heaven_shield:IsPurgable() return false end
function modifier_item_heaven_shield:IsPurgeException() return false end

function modifier_item_heaven_shield:OnCreated()
    if not IsServer() then return end
    self.mod = self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_sange", {})
end

function modifier_item_heaven_shield:OnDestroy()
    if not IsServer() then return end
    if self.mod then
        self.mod:Destroy()
    end
end

function modifier_item_heaven_shield:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
        --MODIFIER_PROPERTY_MOVESPEED_REDUCTION_PERCENTAGE,
	}
end

function modifier_item_heaven_shield:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_heaven_shield:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_evasion")
end

function modifier_item_heaven_shield:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_heaven_shield:GetModifierLifestealRegenAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("hp_regen_amp")
end

function modifier_item_heaven_shield:GetModifierHealAmplify_PercentageTarget()
	return self:GetAbility():GetSpecialValueFor("hp_regen_amp")
end

function modifier_item_heaven_shield:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("hp_bonus")
end

function modifier_item_heaven_shield:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_heaven_shield:GetModifierPhysical_ConstantBlock()
    if self:GetAbility() then
    	if self:GetParent():FindAllModifiersByName("modifier_item_heaven_shield")[1] ~= self then return end
        if RollPercentage(self:GetAbility():GetSpecialValueFor("block_chance")) then
            if not self:GetParent():IsRangedAttacker() then
                return self:GetAbility():GetSpecialValueFor("block_damage_melee")
            else
                return self:GetAbility():GetSpecialValueFor("block_damage_ranged")
            end
        end
    end
end

function modifier_item_heaven_shield:GetModifierHPRegenAmplify_Percentage()
    if self:GetCaster():HasModifier("modifier_item_sange")
    or self:GetCaster():HasModifier("modifier_item_sange_and_yasha")
    or self:GetCaster():HasModifier("modifier_item_heavens_halberd")
    or self:GetCaster():HasModifier("modifier_item_moon_sange")
    or self:GetCaster():HasModifier("modifier_item_kaya_and_sange") then return end
    return self:GetAbility():GetSpecialValueFor("hp_regen_amp")
end

modifier_item_heaven_shield_active = class({})

function modifier_item_heaven_shield_active:IsPurgable() return false end
function modifier_item_heaven_shield_active:IsPurgeException() return false end

function modifier_item_heaven_shield_active:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_disarm.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end


function modifier_item_heaven_shield_active:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true
	}
end

function modifier_item_heaven_shield_active:GetEffectName()
	return "particles/items2_fx/heavens_halberd_debuff.vpcf"
end

function modifier_item_heaven_shield_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end