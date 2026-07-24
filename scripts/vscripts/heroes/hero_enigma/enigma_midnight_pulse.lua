--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


enigma_midnight_pulse_custom = class({})

LinkLuaModifier( "modifier_enigma_midnight_pulse_custom", "heroes/hero_enigma/enigma_midnight_pulse", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_damage_custom", "heroes/hero_enigma/enigma_midnight_pulse", LUA_MODIFIER_MOTION_NONE )

function enigma_midnight_pulse_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", context)
end

function enigma_midnight_pulse_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function enigma_midnight_pulse_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration") + self:GetCaster():FindTalentValue("special_bonus_unique_enigma_8")
	CreateModifierThinker( caster, self, "modifier_enigma_midnight_pulse_custom", { duration = duration }, point, caster:GetTeamNumber(), false )
end

modifier_enigma_midnight_pulse_custom = class({})

function modifier_enigma_midnight_pulse_custom:IsHidden()
	return true
end

function modifier_enigma_midnight_pulse_custom:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) + self:GetCaster():FindTalentValue("special_bonus_unique_enigma_9")
	self.damage = self:GetAbility():GetSpecialValueFor( "damage_percent" )
	if IsServer() then
		GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.radius, true )
		self:PlayEffects()
	end
end

function modifier_enigma_midnight_pulse_custom:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_enigma_midnight_pulse_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	self:AddParticle( effect_cast, false, false, -1, false,  false )
	self:GetParent():EmitSound("Hero_Enigma.Midnight_Pulse")
end

function modifier_enigma_midnight_pulse_custom:GetAuraRadius()
	return self.radius
end

function modifier_enigma_midnight_pulse_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_enigma_midnight_pulse_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_enigma_midnight_pulse_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_enigma_midnight_pulse_custom:GetModifierAura()
	return "modifier_enigma_midnight_pulse_damage_custom"
end

function modifier_enigma_midnight_pulse_custom:IsAura()
	return true
end

modifier_enigma_midnight_pulse_damage_custom = class({})

function modifier_enigma_midnight_pulse_damage_custom:IsHidden() return false end
function modifier_enigma_midnight_pulse_damage_custom:IsPurgable() return false end
function modifier_enigma_midnight_pulse_damage_custom:IsDebuff() return true end
function modifier_enigma_midnight_pulse_damage_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_enigma_midnight_pulse_damage_custom:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) + self:GetCaster():FindTalentValue("special_bonus_unique_enigma_9")
	self.damage = self:GetAbility():GetSpecialValueFor( "damage_percent" )
	local interval = 1

	if IsServer() then
		self.damageTable = {
			attacker = self:GetCaster(),
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(),
		}
		self:StartIntervalThink( interval )
	end
end

function modifier_enigma_midnight_pulse_damage_custom:OnIntervalThink()
	local base = self:GetAbility():GetSpecialValueFor("base_damage")
	self.damageTable.victim = self:GetParent()
	if self:GetParent():IsAncient() then
		-- [#25] Ancient (Roshan/Nian): только БАЗОВЫЙ (флат) урон, без % от макс. HP
		-- (% от их огромного HP = оверкилл). Раньше для ancient скипался ВЕСЬ урон → 0.
		if base and base > 0 then
			self.damageTable.damage = base
			ApplyDamage( self.damageTable )
		end
	else
		-- Обычные юниты: % от макс. HP + базовый.
		self.damageTable.damage = (self:GetParent():GetMaxHealth() * self.damage / 100) + base
		ApplyDamage( self.damageTable )
	end
end