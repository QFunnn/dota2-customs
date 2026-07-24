--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skywrath_mage_ancient_seal_custom", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE )

skywrath_mage_ancient_seal_custom = class({})

skywrath_mage_ancient_seal_custom.modifier_skywrath_mage_18_heal = {-25,-50}

function skywrath_mage_ancient_seal_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_skywrath_mage.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_skywrath_mage.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_skywrath_mage.vpcf", context)
end

function skywrath_mage_ancient_seal_custom:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor( "seal_duration" )

	target:AddNewModifier( caster, self, "modifier_skywrath_mage_ancient_seal_custom", { duration = duration } )

	if caster:HasScepter() then
		local scepter_radius = self:GetSpecialValueFor( "scepter_radius" )

		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetOrigin(), nil, scepter_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false )

		local target_2 = nil
		for _,enemy in pairs(enemies) do
			if enemy~=target and enemy:IsHero() then
				target_2 = enemy
				break
			end
		end

		if not target_2 then
			target_2 = enemies[1]
			if target_2==target then
				target_2 = enemies[2]
			end
		end

		if target_2 then
			target_2:AddNewModifier( caster, self, "modifier_skywrath_mage_ancient_seal_custom", { duration = duration } )
		end
	end
end

modifier_skywrath_mage_ancient_seal_custom = class({})

function modifier_skywrath_mage_ancient_seal_custom:IsHidden()
	return false
end

function modifier_skywrath_mage_ancient_seal_custom:IsDebuff()
	return true
end

function modifier_skywrath_mage_ancient_seal_custom:IsStunDebuff()
	return false
end

function modifier_skywrath_mage_ancient_seal_custom:IsPurgable()
	return true
end

function modifier_skywrath_mage_ancient_seal_custom:OnCreated( kv )
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "resist_debuff" )
	if not IsServer() then return end
	self:PlayEffects()
end

function modifier_skywrath_mage_ancient_seal_custom:OnRefresh( kv )
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "resist_debuff" )
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_SkywrathMage.AncientSeal.Target")
end

function modifier_skywrath_mage_ancient_seal_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}

	return funcs
end

function modifier_skywrath_mage_ancient_seal_custom:GetModifierPropertyRestorationAmplification()
	if self:GetCaster():HasModifier("modifier_skywrath_mage_18") then
		return self:GetAbility().modifier_skywrath_mage_18_heal[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_18")]
	end
	return 0
end

function modifier_skywrath_mage_ancient_seal_custom:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end

function modifier_skywrath_mage_ancient_seal_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_SILENCED] = true,
	}
	return state
end

function modifier_skywrath_mage_ancient_seal_custom:PlayEffects()
	local parent = self:GetParent()

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, parent, PATTACH_OVERHEAD_FOLLOW, "", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, parent, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0,0,0), true )

	self:AddParticle( effect_cast, false, false,  -1, false,  false )
	parent:EmitSound("Hero_SkywrathMage.AncientSeal.Target")
end