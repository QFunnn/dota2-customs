--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_thundergods_wrath_custom_fow", "abilities/zuus_thundergods_vengeance_custom", LUA_MODIFIER_MOTION_NONE)

zuus_thundergods_vengeance_custom = class({})

function zuus_thundergods_vengeance_custom:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Zuus.GodsWrath.PreCast")
	local attack_lock = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1"))
	local attack_lock2 = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack2"))
	self.thundergod_spell_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt( self.thundergod_spell_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin(), true );
	ParticleManager:SetParticleControlEnt( self.thundergod_spell_cast, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetOrigin(), true );
	return true
end

function zuus_thundergods_vengeance_custom:OnAbilityPhaseInterrupted()
	if self.thundergod_spell_cast then
		ParticleManager:DestroyParticle(self.thundergod_spell_cast, true)
		ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
	end
end

function zuus_thundergods_vengeance_custom:OnSpellStart() 
	if not IsServer() then return end
	local ability = self
	local caster = self:GetCaster()
	local true_sight_radius = ability:GetSpecialValueFor("sight_radius_day")
	local sight_radius_day = ability:GetSpecialValueFor("sight_radius_day")
	local sight_radius_night = ability:GetSpecialValueFor("sight_radius_night")
	local sight_duration = ability:GetSpecialValueFor("sight_duration")
	local damage_radius = ability:GetSpecialValueFor("radius")
	local position = self:GetCaster():GetAbsOrigin()	
	if self.thundergod_spell_cast then
		ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
	end
	EmitSoundOnLocationForAllies(self:GetCaster():GetAbsOrigin(), "Hero_Zuus.GodsWrath", self:GetCaster())
    local max_targets = self:GetSpecialValueFor("max_targets")
    local damage = self:GetSpecialValueFor("damage")
    local damage_pct = self:GetSpecialValueFor("damage_pct")

	local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC , DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

	for _,hero in pairs(units) do 
		if hero and not hero:IsNull() then
			local target_point = hero:GetAbsOrigin()
			local vStartPosition = target_point + Vector(0,0,4000)

			local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf", PATTACH_CUSTOMORIGIN, hero )
			ParticleManager:SetParticleControl( nFXIndex, 0, vStartPosition )
			ParticleManager:SetParticleControlEnt( nFXIndex, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetOrigin(), true )
			ParticleManager:DestroyParticle(nFXIndex, false)
			ParticleManager:ReleaseParticleIndex( nFXIndex )

			if (not hero:IsMagicImmune()) and not hero:IsInvulnerable() and not hero:IsOutOfGame() and (not hero:IsInvisible() or caster:CanEntityBeSeenByMyTeam(hero)) then
				local damage_table_original = {attacker = self:GetCaster(), victim = hero, damage = damage, ability = ability, damage_type = DAMAGE_TYPE_MAGICAL }
				local damage_table_original_percent = {attacker = self:GetCaster(), victim = hero, damage = hero:GetMaxHealth() / 100 * damage_pct, ability = ability, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION }
				ApplyDamage(damage_table_original)
				ApplyDamage(damage_table_original_percent)
				hero:AddNewModifier(caster, ability, "modifier_zuus_thundergods_wrath_custom_fow", {duration = sight_duration})
				hero:EmitSound("Hero_Zuus.GodsWrath.Target")
				max_targets = max_targets - 1
				if max_targets <= 0 then
					break
				end
			else
				hero:AddNewModifier(caster, ability, "modifier_zuus_thundergods_wrath_custom_fow", {duration = sight_duration})
			end
		end
	end
end

modifier_zuus_thundergods_wrath_custom_fow = class({})

function modifier_zuus_thundergods_wrath_custom_fow:IsHidden() return true end
function modifier_zuus_thundergods_wrath_custom_fow:IsPurgable() return false end

function modifier_zuus_thundergods_wrath_custom_fow:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.1)
end

function modifier_zuus_thundergods_wrath_custom_fow:OnIntervalThink()
	if not IsServer() then return end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility():GetSpecialValueFor("sight_radius_day"), 0.1 * 2, false)
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = 0.5})
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraRadius()
	return 900
end

function modifier_zuus_thundergods_wrath_custom_fow:GetModifierAura()
    return "modifier_truesight"
end
   
function modifier_zuus_thundergods_wrath_custom_fow:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraDuration()
    return 0.5
end