--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_terrorblade_sunder_custom_debuff", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_sunder_custom", LUA_MODIFIER_MOTION_NONE)

terrorblade_sunder_custom = class({})

terrorblade_sunder_custom.modifier_terrorblade_20 = {-40,-80}
terrorblade_sunder_custom.modifier_terrorblade_19 = 525

function terrorblade_sunder_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8.vpcf", context )
end

function terrorblade_sunder_custom:CastFilterResultTarget(target)
	if target == self:GetCaster() then
		return UF_FAIL_CUSTOM
	end
	if target ~= nil and target:IsMagicImmune() then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end
	if target ~= nil and target:HasModifier("modifier_black_king_bar_immune") then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end
    if target ~= nil and target:IsDebuffImmune() then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end
	if target ~= nil and target:HasModifier("modifier_juggernaut_blade_fury_custom") then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end
	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP, self:GetCaster():GetTeamNumber())
end

function terrorblade_sunder_custom:GetCustomCastErrorTarget(target)
	if target == self:GetCaster() then
		return "#dota_hud_error_cant_cast_on_self"
	end
end

function terrorblade_sunder_custom:GetCastRange( location , target)
	local bonus = 0
    if self:GetCaster():HasModifier("modifier_terrorblade_19") then
        bonus = self.modifier_terrorblade_19
    end
    return self.BaseClass.GetCastRange(self, location, target) + bonus
end

function terrorblade_sunder_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then return end

	local caster_health_percent	= self:GetCaster():GetHealthPercent()
	local target_health_percent	= target:GetHealthPercent()

	local caster_mana_percent	= self:GetCaster():GetManaPercent()
	local target_mana_percent	= target:GetManaPercent()

	local current_health = self:GetCaster():GetHealth()

	self:PlayEffect(target)

	local new_health_caster = self:GetCaster():GetMaxHealth() * math.max(target_health_percent, self:GetSpecialValueFor("hit_point_minimum_pct")) * 0.01
	local new_health_target = target:GetMaxHealth() * math.max(caster_health_percent, self:GetSpecialValueFor("hit_point_minimum_pct")) * 0.01

	local new_mana_caster = self:GetCaster():GetMaxMana() * math.max(target_mana_percent, self:GetSpecialValueFor("hit_point_minimum_pct")) * 0.01
	local new_mana_target = target:GetMaxMana() * math.max(caster_mana_percent, self:GetSpecialValueFor("hit_point_minimum_pct")) * 0.01

	self:GetCaster():SetHealth(new_health_caster)
	target:SetHealth(new_health_target)

	if self:GetCaster():HasModifier("modifier_terrorblade_19") then
		self:GetCaster():SetMana(new_mana_caster)
		target:SetMana(new_mana_target)
	end

	if self:GetCaster():HasModifier("modifier_terrorblade_20") and target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		target:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_sunder_custom_debuff", {duration = 5})
	end
end

function terrorblade_sunder_custom:PlayEffect(target)
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Terrorblade.Sunder.Cast")
	target:EmitSound("Hero_Terrorblade.Sunder.Target")

	local effect_name = "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf"

	if self:GetCaster() ~= nil and self:GetCaster():IsHero() then
		local children = self:GetCaster():GetChildren()
		for k,child in pairs(children) do
		    if child:GetClassname() == "dota_item_wearable" then
		        if child:GetModelName() == "models/items/terrorblade/terrorblade_ti8_immortal_back/terrorblade_ti8_immortal_back.vmdl" then
		            effect_name = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8.vpcf"
		            break
		        end
		    end
		end
	end 

	local sunder_particle_1 = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(sunder_particle_1, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(sunder_particle_1, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(sunder_particle_1, 2, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(sunder_particle_1, 15, Vector(0,152,255))
	ParticleManager:SetParticleControl(sunder_particle_1, 16, Vector(1,0,0))
	ParticleManager:ReleaseParticleIndex(sunder_particle_1)

	local sunder_particle_2 = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(sunder_particle_2, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(sunder_particle_2, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(sunder_particle_2, 2, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(sunder_particle_2, 15, Vector(0,152,255))
	ParticleManager:SetParticleControl(sunder_particle_2, 16, Vector(1,0,0))
	ParticleManager:ReleaseParticleIndex(sunder_particle_2)
end

modifier_terrorblade_sunder_custom_debuff = class({})

function modifier_terrorblade_sunder_custom_debuff:IsPurgable() return false end
function modifier_terrorblade_sunder_custom_debuff:IsPurgeException() return false end

function modifier_terrorblade_sunder_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_terrorblade_sunder_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility().modifier_terrorblade_20[self:GetCaster():GetTalentLevel("modifier_terrorblade_20")]
end