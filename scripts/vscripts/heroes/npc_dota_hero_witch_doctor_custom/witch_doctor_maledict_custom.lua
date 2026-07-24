--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_maledict_custom", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_maledict_custom", LUA_MODIFIER_MOTION_NONE)

witch_doctor_maledict_custom = class({})

witch_doctor_maledict_custom.modifier_witch_doctor_17 = {30,60}
witch_doctor_maledict_custom.modifier_witch_doctor_18 = {50,150}

function witch_doctor_maledict_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_maledict.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_witch_doctor.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_witch_doctor.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_witch_doctor.vpcf", context)
end

function witch_doctor_maledict_custom:OnSpellStart()
	local vPosition = self:GetCursorPosition()
	
	local radius = self:GetSpecialValueFor("radius")

	if self:GetCaster():HasModifier("modifier_witch_doctor_18") then
		radius = radius + self.modifier_witch_doctor_18[self:GetCaster():GetTalentLevel("modifier_witch_doctor_18")]
	end
	
	local duration = self:GetSpecialValueFor("duration")

	local flag = DOTA_UNIT_TARGET_HERO
    if self:GetCaster():HasModifier("modifier_witch_doctor_18") then
        flag = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    end
	
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), vPosition, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, flag, 0, 0, false)
	
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

function witch_doctor_maledict_custom:GetAOERadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_witch_doctor_18") then
		bonus = self.modifier_witch_doctor_18[self:GetCaster():GetTalentLevel("modifier_witch_doctor_18")]
	end
	return self:GetSpecialValueFor("radius") + bonus
end

modifier_witch_doctor_maledict_custom = class({})

function modifier_witch_doctor_maledict_custom:IsPurgable() return false end
function modifier_witch_doctor_maledict_custom:IsPurgeException() return false end

function modifier_witch_doctor_maledict_custom:OnCreated()
	if not IsServer() then return end
	self.damage = self:GetAbility():GetSpecialValueFor("damage")

	if self:GetCaster():HasModifier("modifier_witch_doctor_17") then
		self.damage = self.damage + self:GetAbility().modifier_witch_doctor_17[self:GetCaster():GetTalentLevel("modifier_witch_doctor_17")]
	end
    self.max_health = self:GetParent():GetHealth()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.ticks = self:GetAbility():GetSpecialValueFor("ticks")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.tick_to_damage = 0
	self.ticks_damage_time = 4
	self:StartIntervalThink( 1 )

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_witchdoctor/witchdoctor_maledict.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ticks_damage_time, 0, 0))

	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_witch_doctor_maledict_custom:OnRefresh()
	if not IsServer() then return end
	self.damage = self:GetAbility():GetSpecialValueFor("damage")

	if self:GetCaster():HasModifier("modifier_witch_doctor_17") then
		self.damage = self.damage + self:GetAbility().modifier_witch_doctor_17[self:GetCaster():GetTalentLevel("modifier_witch_doctor_17")]
	end

	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.ticks = self:GetAbility():GetSpecialValueFor("ticks")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_witch_doctor_maledict_custom:OnDestroy()
	if not IsServer() then return end
end

function modifier_witch_doctor_maledict_custom:OnIntervalThink()
	if not IsServer() then return end
	self.tick_to_damage = self.tick_to_damage + 1
	
	if not self:GetParent():IsMagicImmune() then
		ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
	end
	
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
    local damage = (self.max_health - self:GetParent():GetHealth()) / 100 * self:GetAbility():GetSpecialValueFor("bonus_damage")
    if damage > 0 then
        ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    end
    self:GetParent():EmitSound("Hero_WitchDoctor.Maledict_Tick")
end