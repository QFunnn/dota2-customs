--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_maledict_custom", "abilities/witch_doctor_maledict_custom", LUA_MODIFIER_MOTION_NONE)

witch_doctor_maledict_custom = class({})

function witch_doctor_maledict_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_maledict.vpcf", context )
end

function witch_doctor_maledict_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function witch_doctor_maledict_custom:OnSpellStart()
	local vPosition = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), vPosition, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	local aoe_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_aoe.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl( aoe_pfx, 0, vPosition )
	ParticleManager:SetParticleControl( aoe_pfx, 1, Vector(radius, radius, radius) )
	if #enemies > 0 then
		self:GetCaster():EmitSound("Hero_WitchDoctor.Maledict_Cast")
		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_witch_doctor_maledict_custom", {duration = duration + (FrameTime())})
		end
	else
		self:GetCaster():EmitSound("Hero_WitchDoctor.Maledict_CastFail")
	end
end

modifier_witch_doctor_maledict_custom = class({})

function modifier_witch_doctor_maledict_custom:IsPurgable() return false end
function modifier_witch_doctor_maledict_custom:IsPurgeException() return false end

function modifier_witch_doctor_maledict_custom:OnCreated()
	if not IsServer() then return end
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.ticks = self:GetAbility():GetSpecialValueFor("ticks")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.tick_to_damage = 0
	self.ticks_damage_time = 4
	self.initial_health = self:GetParent():GetHealth()
	self:StartIntervalThink( 1 )
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_witchdoctor/witchdoctor_maledict.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ticks_damage_time, 0, 0))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_witch_doctor_maledict_custom:OnRefresh()
	if not IsServer() then return end
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.ticks = self:GetAbility():GetSpecialValueFor("ticks")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	-- Не обновляем self.initial_health, чтобы сохранить накопленный урон
end

function modifier_witch_doctor_maledict_custom:OnIntervalThink()
	if not IsServer() then return end
	self.tick_to_damage = self.tick_to_damage + 1
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
	if self.tick_to_damage >= self.ticks_damage_time then
		self.tick_to_damage = 0
		self:DealHPBurstDamage()
	end
end

function modifier_witch_doctor_maledict_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_maledict.vpcf"
end

function modifier_witch_doctor_maledict_custom:StatusEffectPriority()
	return 5
end

function modifier_witch_doctor_maledict_custom:DealHPBurstDamage()
	local healthLost = math.max(0, self.initial_health - self:GetParent():GetHealth())
	local damage = healthLost / 100 * self:GetAbility():GetSpecialValueFor("bonus_damage")
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
	self:GetParent():EmitSound("Hero_WitchDoctor.Maledict_Tick")
end