--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_mana_break_custom", "heroes/npc_dota_hero_antimage_custom/antimage_mana_break_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_mana_break_custom_slow", "heroes/npc_dota_hero_antimage_custom/antimage_mana_break_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_mana_break_custom_antimage_16", "heroes/npc_dota_hero_antimage_custom/antimage_mana_break_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_mana_break_custom_antimage_16_stack", "heroes/npc_dota_hero_antimage_custom/antimage_mana_break_custom", LUA_MODIFIER_MOTION_NONE )

antimage_mana_break_custom = class({})

antimage_mana_break_custom.modifier_antimage_2 = {20,40}
antimage_mana_break_custom.modifier_antimage_3 = {12,24}
antimage_mana_break_custom.modifier_antimage_4 = {20,40,60}
antimage_mana_break_custom.modifier_antimage_5_radius = {250,500}

function antimage_mana_break_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/generic_gameplay/generic_manaburn.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_manabreak_slow.vpcf', context )
end

function antimage_mana_break_custom:GetIntrinsicModifierName()
	return "modifier_antimage_mana_break_custom"
end

function antimage_mana_break_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_antimage_5") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function antimage_mana_break_custom:GetCooldown(iLevel)
	if self:GetCaster():HasModifier("modifier_antimage_5") then
		return 15
	end
	return 0
end

function antimage_mana_break_custom:GetCastRange(vLocation, hTarget)
	if self:GetCaster():HasModifier("modifier_antimage_5") then
		return self.modifier_antimage_5_radius[self:GetCaster():GetTalentLevel("modifier_antimage_5")]
	end
	return 0
end

function antimage_mana_break_custom:OnSpellStart()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_antimage_5") then
		self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
		self:GetCaster():StartGesture(ACT_DOTA_ATTACK)
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self.modifier_antimage_5_radius[self:GetCaster():GetTalentLevel("modifier_antimage_5")], DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false )
		for _, enemy in pairs(enemies) do
			self:GetCaster():PerformAttack(enemy, true, true, true, false, false, false, false)
		end
	end
end

modifier_antimage_mana_break_custom = class({})

function modifier_antimage_mana_break_custom:IsHidden()
	return true
end

function modifier_antimage_mana_break_custom:IsPurgable()
	return false
end

function modifier_antimage_mana_break_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_antimage_mana_break_custom:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	local target = params.target
	if not target then return end
	if target:GetMaxMana() == 0 then return end
	if target:IsMagicImmune() then return end
    if target:HasModifier("modifier_kez_shodo_sai_custom") then return end
    if self:GetParent():HasModifier("modifier_antimage_16") then return end
	
	local mana_per_hit = self:GetAbility():GetSpecialValueFor("mana_per_hit")
    local mana_per_hit_pct = self:GetAbility():GetSpecialValueFor("mana_per_hit_pct")
	local illusion_percentage = self:GetAbility():GetSpecialValueFor("illusion_percentage")
	local slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	local percent_damage_per_burn = self:GetAbility():GetSpecialValueFor("percent_damage_per_burn")
    mana_per_hit = mana_per_hit + (target:GetMaxMana() * mana_per_hit_pct / 100)

	if self:GetCaster():HasModifier("modifier_antimage_2") then
		percent_damage_per_burn = percent_damage_per_burn + self:GetAbility().modifier_antimage_2[self:GetCaster():GetTalentLevel("modifier_antimage_2")]
	end

	if self:GetCaster():HasModifier("modifier_antimage_3") then
		mana_per_hit = mana_per_hit + self:GetAbility().modifier_antimage_3[self:GetCaster():GetTalentLevel("modifier_antimage_3")]
	end

	local reduce_mana_full = mana_per_hit

	if self:GetParent():IsIllusion() then
		reduce_mana_full = mana_per_hit / 100 * illusion_percentage
	end

	local mana_burn =  math.min( target:GetMana(), reduce_mana_full )
	target:Script_ReduceMana(mana_burn, self:GetAbility()) 

	local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN, target )
	ParticleManager:ReleaseParticleIndex( particle )

	target:EmitSound("Hero_Antimage.ManaBreak")

	return mana_burn / 100 * percent_damage_per_burn
end

modifier_antimage_mana_break_custom_antimage_16 = class({})

function modifier_antimage_mana_break_custom_antimage_16:IsPurgable() return false end

function modifier_antimage_mana_break_custom_antimage_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_antimage_mana_break_custom_antimage_16:OnIntervalThink()
	if not IsServer() then return end
	local mod = self:GetParent():FindAllModifiersByName("modifier_antimage_mana_break_custom_antimage_16_stack")
	self:SetStackCount(#mod)
end

modifier_antimage_mana_break_custom_antimage_16_stack = class({})
function modifier_antimage_mana_break_custom_antimage_16_stack:IsHidden() return true end
function modifier_antimage_mana_break_custom_antimage_16_stack:IsPurgable() return false end
function modifier_antimage_mana_break_custom_antimage_16_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_antimage_mana_break_custom_antimage_16_stack:OnCreated(kv)
	if not IsServer() then return end
	self:GetCaster():CalculateStatBonus(true)
	self.mana = kv.mana
	self:GetParent():GiveMana(self.mana)
end

function modifier_antimage_mana_break_custom_antimage_16_stack:OnDestroy(kv)
	if not IsServer() then return end
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_antimage_mana_break_custom_antimage_16_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_antimage_mana_break_custom_antimage_16_stack:GetModifierManaBonus()
	return self.mana
end