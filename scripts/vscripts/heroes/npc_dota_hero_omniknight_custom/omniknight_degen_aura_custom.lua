--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_omniknight_degen_aura_custom", "heroes/npc_dota_hero_omniknight_custom/omniknight_degen_aura_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_degen_aura_custom_debuff", "heroes/npc_dota_hero_omniknight_custom/omniknight_degen_aura_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_degen_aura_custom_active", "heroes/npc_dota_hero_omniknight_custom/omniknight_degen_aura_custom" , LUA_MODIFIER_MOTION_NONE)

omniknight_degen_aura_custom = class({})

function omniknight_degen_aura_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_degen_aura_debuff.vpcf", context )
end

omniknight_degen_aura_custom.modifier_omniknight_17_damage = {10,15,20}
omniknight_degen_aura_custom.modifier_omniknight_18_radius = {100,200,300}
omniknight_degen_aura_custom.modifier_omniknight_19_manacost = 14
omniknight_degen_aura_custom.modifier_omniknight_19_damage = 3

function omniknight_degen_aura_custom:GetCastRange(location, target)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_omniknight_18") then
        bonus = self.modifier_omniknight_18_radius[self:GetCaster():GetTalentLevel("modifier_omniknight_18")]
    end
    return self.BaseClass.GetCastRange(self, location, target) + bonus
end

function omniknight_degen_aura_custom:GetIntrinsicModifierName()
	if self:GetCaster():IsIllusion() then return end
	return "modifier_omniknight_degen_aura_custom"
end

function omniknight_degen_aura_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_omniknight_19") then
        local behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
        return behavior + 562949953421312
	end
	local behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE
    return behavior + 562949953421312
end

function omniknight_degen_aura_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_omniknight_19") then
		return self:GetCaster():GetMaxMana() / 100 * self.modifier_omniknight_19_manacost
	end
    return self.BaseClass.GetManaCost(self, level)
end

function omniknight_degen_aura_custom:OnToggle()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_omniknight_19") then return end

	local caster = self:GetCaster()
	local toggle = self:GetToggleState()

	if toggle then
		self.modifier = caster:AddNewModifier( caster, self, "modifier_omniknight_degen_aura_custom_active", {} )
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end

	self:StartCooldown(1)
end

modifier_omniknight_degen_aura_custom_active = class({})

function modifier_omniknight_degen_aura_custom_active:IsPurgable() return false end

function modifier_omniknight_degen_aura_custom_active:OnCreated( kv )
	if not IsServer() then return end
	self:StartIntervalThink( 1 )
end

function modifier_omniknight_degen_aura_custom_active:OnIntervalThink()
	self:GetParent():SpendMana( self:GetAbility():GetEffectiveManaCost(self:GetAbility():GetLevel()), self:GetAbility() )
	local mana = self:GetParent():GetMana()
	if mana < self:GetAbility():GetEffectiveManaCost(self:GetAbility():GetLevel()) then
		if self:GetAbility():GetToggleState() then
			self:GetAbility():ToggleAbility()
			self:Destroy()
		end
	end
end

function modifier_omniknight_degen_aura_custom_active:GetEffectName()
    return "particles/omni_2021_immortal_2.vpcf"
end

function modifier_omniknight_degen_aura_custom_active:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

modifier_omniknight_degen_aura_custom = class({})

function modifier_omniknight_degen_aura_custom:IsHidden()
	return true
end

function modifier_omniknight_degen_aura_custom:IsDebuff()
	return false
end

function modifier_omniknight_degen_aura_custom:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_custom:IsAura()
	if self:GetParent():PassivesDisabled() then return false end
	return true
end

function modifier_omniknight_degen_aura_custom:GetModifierAura()
	return "modifier_omniknight_degen_aura_custom_debuff"
end

function modifier_omniknight_degen_aura_custom:GetAuraRadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_omniknight_18") then
		bonus = self:GetAbility().modifier_omniknight_18_radius[self:GetCaster():GetTalentLevel("modifier_omniknight_18")]
	end
	return self:GetAbility():GetSpecialValueFor( "radius" ) + bonus
end

function modifier_omniknight_degen_aura_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_omniknight_degen_aura_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_omniknight_degen_aura_custom:GetAuraSearchFlags()
	return 0
end

function modifier_omniknight_degen_aura_custom:GetAuraDuration()
	return 0.5
end

modifier_omniknight_degen_aura_custom_debuff = class({})

function modifier_omniknight_degen_aura_custom_debuff:IsHidden()
	return false
end

function modifier_omniknight_degen_aura_custom_debuff:IsDebuff()
	return true
end

function modifier_omniknight_degen_aura_custom_debuff:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_custom_debuff:OnCreated( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_omniknight_degen_aura_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_omniknight_17") then
		local damage = self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_omniknight_17_damage[self:GetCaster():GetTalentLevel("modifier_omniknight_17")]
		if self:GetCaster():HasModifier("modifier_omniknight_degen_aura_custom_active") then
			damage = damage * self:GetAbility().modifier_omniknight_19_damage
		end
		ApplyDamage({ attacker = self:GetCaster(), victim = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
	end
    if self:GetCaster():HasModifier("modifier_omniknight_21") then
        if self:GetStackCount() < 20 then
            self:IncrementStackCount()
        end
    end
end

function modifier_omniknight_degen_aura_custom_debuff:OnRefresh( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_omniknight_degen_aura_custom_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}

	return funcs
end

function modifier_omniknight_degen_aura_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_omniknight_degen_aura_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_degen_aura_debuff.vpcf"
end

function modifier_omniknight_degen_aura_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_omniknight_degen_aura_custom_debuff:GetModifierIncomingDamage_Percentage(params)
    if params.attacker ~= self:GetCaster() then return end
    return self:GetStackCount()
end