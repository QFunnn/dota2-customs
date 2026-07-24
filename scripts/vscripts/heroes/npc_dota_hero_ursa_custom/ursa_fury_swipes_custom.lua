--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ursa_fury_swipes_custom", "heroes/npc_dota_hero_ursa_custom/ursa_fury_swipes_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ursa_fury_swipes_custom_debuff", "heroes/npc_dota_hero_ursa_custom/ursa_fury_swipes_custom", LUA_MODIFIER_MOTION_NONE )

ursa_fury_swipes_custom = class({})
ursa_fury_swipes_custom.modifier_ursa_9 = {3,6,9}
ursa_fury_swipes_custom.modifier_ursa_6 = -0.5

function ursa_fury_swipes_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf", context )
end

function ursa_fury_swipes_custom:GetIntrinsicModifierName()
	return "modifier_ursa_fury_swipes_custom"
end

modifier_ursa_fury_swipes_custom = class({})
function modifier_ursa_fury_swipes_custom:IsHidden() return true end
function modifier_ursa_fury_swipes_custom:IsPurgable() return false end
function modifier_ursa_fury_swipes_custom:IsPurgeException() return false end
function modifier_ursa_fury_swipes_custom:RemoveOnDeath() return false end
function modifier_ursa_fury_swipes_custom:OnCreated()
	self.bonus_reset_time = self:GetAbility():GetSpecialValueFor("bonus_reset_time")
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
end
function modifier_ursa_fury_swipes_custom:OnRefresh()
	self.bonus_reset_time = self:GetAbility():GetSpecialValueFor("bonus_reset_time")
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
end
function modifier_ursa_fury_swipes_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        --MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end
function modifier_ursa_fury_swipes_custom:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end
	local target = params.target
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
    if self:GetParent():IsIllusion() then return end
    local damage = self.damage_per_stack
    if self:GetCaster():HasModifier("modifier_ursa_9") then
        damage = damage + self:GetAbility().modifier_ursa_9[self:GetCaster():GetTalentLevel("modifier_ursa_9")]
    end
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
    local modifier_ursa_fury_swipes_custom_debuff = target:FindModifierByName("modifier_ursa_fury_swipes_custom_debuff")
    if modifier_ursa_fury_swipes_custom_debuff then
        if not self:GetParent():PassivesDisabled() then
            target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ursa_fury_swipes_custom_debuff", {duration = self.bonus_reset_time * (1-target:GetStatusResistance())})
        end
        local stack_count = modifier_ursa_fury_swipes_custom_debuff:GetStackCount()
        return damage * stack_count
    else
        local stack_count = 1
        if not self:GetParent():PassivesDisabled() then
            target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ursa_fury_swipes_custom_debuff", {duration = self.bonus_reset_time * (1-target:GetStatusResistance())})
        end
        return damage * stack_count
    end
end

function modifier_ursa_fury_swipes_custom:GetModifierPreAttack_BonusDamage( params )
	if not IsServer() then return end
	local target = params.target
    if target then
        if self:GetParent():IsIllusion() then return end
        local damage = self.damage_per_stack
        if self:GetCaster():HasModifier("modifier_ursa_9") then
            damage = damage + self:GetAbility().modifier_ursa_9[self:GetCaster():GetTalentLevel("modifier_ursa_9")]
        end
        if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
        local modifier_ursa_fury_swipes_custom_debuff = target:FindModifierByName("modifier_ursa_fury_swipes_custom_debuff")
        if modifier_ursa_fury_swipes_custom_debuff then
            local stack_count = modifier_ursa_fury_swipes_custom_debuff:GetStackCount()
            return damage * stack_count
        end
    end
end

modifier_ursa_fury_swipes_custom_debuff = class({})
function modifier_ursa_fury_swipes_custom_debuff:IsPurgable() return false end
function modifier_ursa_fury_swipes_custom_debuff:OnCreated()
    if not IsServer() then return end
    self:IncrementStackCount()
end
function modifier_ursa_fury_swipes_custom_debuff:OnRefresh()
    if not IsServer() then return end
    local max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
    if self:GetStackCount() < max_stacks then
        self:IncrementStackCount()
    end
end
function modifier_ursa_fury_swipes_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf"
end
function modifier_ursa_fury_swipes_custom_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_ursa_fury_swipes_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_ursa_fury_swipes_custom_debuff:GetModifierPhysicalArmorBonus()
    if not self:GetCaster():HasModifier("modifier_ursa_6") then return 0 end
	return self:GetAbility().modifier_ursa_6 * self:GetStackCount()
end