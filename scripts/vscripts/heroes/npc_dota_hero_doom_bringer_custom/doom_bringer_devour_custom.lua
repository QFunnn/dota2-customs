--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_doom_bringer_devour_custom", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_devour_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_doom_bringer_devour_custom_handler", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_devour_custom", LUA_MODIFIER_MOTION_NONE)

doom_bringer_devour_custom = class({})

doom_bringer_devour_custom.modifier_doom_bringer_9 = {30,60}
doom_bringer_devour_custom.modifier_doom_bringer_16 = {2,4}
doom_bringer_devour_custom.modifier_doom_bringer_18 = {5,10}
doom_bringer_devour_custom.modifier_doom_bringer_19 = {25,50}
doom_bringer_devour_custom.modifier_doom_bringer_20 = {5,10,15}

function doom_bringer_devour_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_doom_bringer.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_doom_bringer.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_doom_bringer.vpcf", context)
end

function doom_bringer_devour_custom:CastFilterResultTarget( target )

	if target:HasModifier("modifier_wodacreepchampion") then
		return UF_FAIL_ANCIENT
	end

	if target:HasModifier("modifier_wodacreepchampionred") then
		return UF_FAIL_ANCIENT
	end

    if not self:GetCaster():HasModifier("modifier_doom_bringer_20") then
		if target:GetLevel() > self:GetSpecialValueFor("creep_level") then
			return UF_FAIL_CUSTOM
		end
	end

	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end


function doom_bringer_devour_custom:GetCustomCastErrorTarget( target )
	if not self:GetCaster():HasModifier("modifier_doom_bringer_20") then
		if target:GetLevel() > self:GetSpecialValueFor("creep_level") then
			return "#dota_hud_error_cant_cast_creep_level"
		end
	end
	return ""
end

function doom_bringer_devour_custom:GetAbilityChargeRestoreTime(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_doom_bringer_16") then
		bonus = bonus - 5
	end
	if self:GetCaster():HasModifier("modifier_doom_bringer_18") then
		bonus = bonus - 5
	end
	if self:GetCaster():HasModifier("modifier_doom_bringer_19") then
		bonus = bonus - 5
	end
	if self:GetCaster():HasModifier("modifier_doom_bringer_20") then
		bonus = bonus - self.modifier_doom_bringer_20[self:GetCaster():GetTalentLevel("modifier_doom_bringer_20")]
	end
    return self.BaseClass.GetAbilityChargeRestoreTime( self, level ) + bonus
end

--function doom_bringer_devour_custom:GetIntrinsicModifierName()
--    return "modifier_doom_bringer_devour_custom_handler"
--end

function doom_bringer_devour_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_doom_bringer_21") then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end

function doom_bringer_devour_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	if self:GetCaster():HasModifier("modifier_doom_bringer_21") and target == nil then
		target = CreateUnitByName("npc_dota_creep_badguys_melee", self:GetCursorPosition(), true, nil, nil, self:GetCaster():GetTeamNumber())
		target:SetOriginalModel("models/heroes/nerubian_assassin/nerubian_assassin.vmdl")
		target:SetModel("models/heroes/nerubian_assassin/nerubian_assassin.vmdl")
		target:SetMaximumGoldBounty(0)
		target:SetMinimumGoldBounty(0)
		target:SetDeathXP(0)
		target:StartGesture(ACT_DOTA_DIE)
		local duration = self:GetSpecialValueFor( "duration" )
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_devour_custom", { duration = duration } )
		self:PlayEffects( target )
		target:Kill(self, self:GetCaster())
		return
	end

	if target:HasModifier("modifier_wodacreepchampionred") or target:HasModifier("modifier_wodacreepchampion") then
		return
	end

	if not self:GetCaster():HasModifier("modifier_doom_bringer_20") then
		if target:GetLevel() > self:GetSpecialValueFor("creep_level") then
			return
		end
	end

	if not target:IsAlive() then
		return
	end
	
	local duration = self:GetSpecialValueFor( "duration" )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_devour_custom", { duration = duration } )
	self:PlayEffects( target )
	target:SetOrigin( target:GetOrigin() + Vector( 0, 0, -200 ) )
	target:Kill(self, self:GetCaster())
end

function doom_bringer_devour_custom:PlayEffects( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_DoomBringer.Devour")
	target:EmitSound("Hero_DoomBringer.DevourCast")
end

modifier_doom_bringer_devour_custom = class({})

function modifier_doom_bringer_devour_custom:IsPurgable()
	return false
end

function modifier_doom_bringer_devour_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_doom_bringer_devour_custom:RemoveOnDeath()
	return false
end

function modifier_doom_bringer_devour_custom:OnCreated( kv )
	self.bonus_gold = self:GetAbility():GetSpecialValueFor( "bonus_gold" )
	self.armor = self:GetAbility():GetSpecialValueFor( "armor" )
    if not IsServer() then return end
    self.modifier_doom_bringer_devour_custom_handler = self:GetParent():FindModifierByName("modifier_doom_bringer_devour_custom_handler")
    if self.modifier_doom_bringer_devour_custom_handler then
        self.modifier_doom_bringer_devour_custom_handler:IncrementStackCount()
    end
end

function modifier_doom_bringer_devour_custom:OnDestroy()
	if not IsServer() then return end
	if self:GetParent():IsAlive() then
		PlayerResource:ModifyGold( self:GetParent():GetPlayerOwnerID(), self.bonus_gold, false, DOTA_ModifyGold_Unspecified )
	end
    if self.modifier_doom_bringer_devour_custom_handler then
        self.modifier_doom_bringer_devour_custom_handler:DecrementStackCount()
    end
end

function modifier_doom_bringer_devour_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		--MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
        MODIFIER_PROPERTY_AOE_BONUS_CONSTANT_STACKING
	}
	return funcs
end

function modifier_doom_bringer_devour_custom:GetModifierPhysicalArmorBonus()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_doom_bringer_16") then
		bonus = self:GetAbility().modifier_doom_bringer_16[self:GetCaster():GetTalentLevel("modifier_doom_bringer_16")]
	end
	return self.armor + bonus
end

--function modifier_doom_bringer_devour_custom:GetModifierAttackSpeedBonus_Constant()
--	local bonus = 0
--	if self:GetCaster():HasModifier("modifier_doom_bringer_9") then
--		bonus = self:GetAbility().modifier_doom_bringer_9[self:GetCaster():GetTalentLevel("modifier_doom_bringer_9")]
--	end
--	return bonus
--end

function modifier_doom_bringer_devour_custom:GetModifierSpellAmplify_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_doom_bringer_18") then
		bonus = self:GetAbility().modifier_doom_bringer_18[self:GetCaster():GetTalentLevel("modifier_doom_bringer_18")]
	end
	return bonus
end

function modifier_doom_bringer_devour_custom:GetModifierAoEBonusConstantStacking()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_doom_bringer_19") then
		bonus = self:GetAbility().modifier_doom_bringer_19[self:GetCaster():GetTalentLevel("modifier_doom_bringer_19")]
	end
	return bonus
end

modifier_doom_bringer_devour_custom_handler = class({})
function modifier_doom_bringer_devour_custom_handler:IsHidden() return true end
function modifier_doom_bringer_devour_custom_handler:IsPurgable() return false end
function modifier_doom_bringer_devour_custom_handler:IsPurgeException() return false end
function modifier_doom_bringer_devour_custom_handler:RemoveOnDeath() return false end

function modifier_doom_bringer_devour_custom_handler:DeclareFunctions()
	local funcs = 
	{
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
	}
	return funcs
end

function modifier_doom_bringer_devour_custom_handler:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "doom_bringer_scorched_earth_custom" and data.ability_special_value == "radius" and self:GetParent():HasModifier("modifier_doom_bringer_19") then
        return 1
    end
end

function modifier_doom_bringer_devour_custom_handler:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "doom_bringer_scorched_earth_custom" and data.ability_special_value == "radius" and self:GetParent():HasModifier("modifier_doom_bringer_19") then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + (self:GetAbility().modifier_doom_bringer_19[self:GetCaster():GetTalentLevel("modifier_doom_bringer_19")] * self:GetStackCount())
    end
end