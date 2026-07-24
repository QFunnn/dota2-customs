--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_windrunner_gale_force_custom", "heroes/npc_dota_hero_windrunner_custom/windrunner_gale_force_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_windrunner_gale_force_custom_aura", "heroes/npc_dota_hero_windrunner_custom/windrunner_gale_force_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_windrunner_gale_force_custom_debuff", "heroes/npc_dota_hero_windrunner_custom/windrunner_gale_force_custom", LUA_MODIFIER_MOTION_NONE)

windrunner_gale_force_custom = class({})

function windrunner_gale_force_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_gale_force_owner.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_gale_force.vpcf", context )
end

windrunner_gale_force_custom.modifier_windrunner_4_str_damage = {50,100}
windrunner_gale_force_custom.modifier_windrunner_6_bonus_duration = {3,6,9}

function windrunner_gale_force_custom:OnVectorCastStart(vStartLocation, vDirection)
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	if self:GetCaster():HasModifier("modifier_windrunner_6") then
		duration = duration + self.modifier_windrunner_6_bonus_duration[self:GetCaster():GetTalentLevel("modifier_windrunner_6")]
	end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), vStartLocation, self:GetSpecialValueFor('radius'), duration, false)
	local mod = CreateModifierThinker(self:GetCaster(), self, "modifier_windrunner_gale_force_custom", {duration = duration, x = vDirection.x, y = vDirection.y, z = vDirection.z,}, vStartLocation, self:GetCaster():GetTeamNumber(), false)
end

modifier_windrunner_gale_force_custom = class({})

function modifier_windrunner_gale_force_custom:OnCreated(kv)
	if not IsServer() then return end

	self.direction = Vector(kv.x,kv.y,kv.z)
	direction = RotatePosition( Vector(0,0,0), QAngle(0, -90, 0), self.direction )

	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/windrunner_gale_force_owner.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.particle, 1, Vector(0,self:GetAbility():GetSpecialValueFor('radius'),0))
	ParticleManager:SetParticleControlForward(self.particle, 3,direction)

	self:AddParticle(self.particle, false, false, -1, false, false)

	self:StartIntervalThink(FrameTime())
end

function modifier_windrunner_gale_force_custom:OnIntervalThink()
	if not IsServer() then return end
	if self.direction == nil then return end

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self:GetAbility():GetSpecialValueFor('radius'), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
	for _, enemy in pairs(enemies) do
		if not enemy:IsCurrentlyHorizontalMotionControlled() then
			enemy:AddNewModifier(enemy, self:GetAbility(), "modifier_windrunner_gale_force_custom_debuff", {duration = 0.1, x = self.direction.x, y = self.direction.y})
		end
	end
end

function modifier_windrunner_gale_force_custom:IsAura()
    return true
end

function modifier_windrunner_gale_force_custom:GetModifierAura()
    return "modifier_windrunner_gale_force_custom_aura"
end

function modifier_windrunner_gale_force_custom:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor('radius')
end

function modifier_windrunner_gale_force_custom:GetAuraDuration()
    return 0.1
end

function modifier_windrunner_gale_force_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_windrunner_gale_force_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_windrunner_gale_force_custom_aura = class({})

function modifier_windrunner_gale_force_custom_aura:IsHidden() return true end

function modifier_windrunner_gale_force_custom_aura:OnCreated()
	if not IsServer() then return end
		
	local normalized = (self:GetAuraOwner():GetAbsOrigin() - self:GetParent():GetAbsOrigin())
	normalized.z = 0
	normalized = normalized:Normalized()
	normalized = RotatePosition( Vector(0,0,0), QAngle(0, -90, 0), normalized )

	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/windrunner_gale_force.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlForward(self.particle, 1, normalized)
	self:AddParticle(self.particle, false, false, -1, false, false)
	self:StartIntervalThink(0.5)
end

function modifier_windrunner_gale_force_custom_aura:OnIntervalThink()
	if not IsServer() then return end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 150, 0.5, true)
	if not self:GetCaster():HasModifier("modifier_windrunner_4") then return end
	local damage = self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_windrunner_4_str_damage[self:GetCaster():GetTalentLevel("modifier_windrunner_4")]
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage / 2, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

modifier_windrunner_gale_force_custom_debuff = class({})
function modifier_windrunner_gale_force_custom_debuff:IsHidden() return true end
function modifier_windrunner_gale_force_custom_debuff:IsPurgable() return false end
function modifier_windrunner_gale_force_custom_debuff:IsPurgeException() return false end

function modifier_windrunner_gale_force_custom_debuff:OnCreated(params)
	if not IsServer() then return end
	self.direction = Vector(params.x, params.y, 0)
	self:StartIntervalThink(FrameTime())
end

function modifier_windrunner_gale_force_custom_debuff:OnDestroy()
	if not IsServer() then return end
	if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():IsCurrentlyVerticalMotionControlled() then
		if not self:GetParent():HasModifier("modifier_slark_pounce_arc") and not self:GetParent():HasModifier("modifier_slark_pounce_custom") then
			FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
		end
	end
end

function modifier_windrunner_gale_force_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	local wind_strength = self:GetAbility():GetSpecialValueFor("wind_strength")
	if self.direction == nil then return end

	if self:GetParent():IsDebuffImmune() then return end

	if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():IsCurrentlyVerticalMotionControlled() then
		if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():HasModifier("modifier_slark_pounce_arc") and not self:GetParent():HasModifier("modifier_slark_pounce_custom") then
			local point = self:GetParent():GetAbsOrigin() + self.direction * (wind_strength * FrameTime())
			point = GetGroundPosition(point, self:GetParent())
			if GridNav:CanFindPath( self:GetParent():GetAbsOrigin(), point ) then
				self:GetParent():SetAbsOrigin(point)
			else
				FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
			end
		end
	end
end