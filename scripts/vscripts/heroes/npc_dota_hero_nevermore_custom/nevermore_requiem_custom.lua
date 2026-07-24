--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_requiem_custom_debuff", "heroes/npc_dota_hero_nevermore_custom/nevermore_requiem_custom", LUA_MODIFIER_MOTION_NONE)

nevermore_requiem_custom = class({})

function nevermore_requiem_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_a.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_nevermore.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_nevermore.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_nevermore.vpcf", context)
end

nevermore_requiem_custom.modifier_nevermore_20 = {-20,-40,-60}
nevermore_requiem_custom.modifier_nevermore_12 = {50}

function nevermore_requiem_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_nevermore_20") then
		bonus = self.modifier_nevermore_20[self:GetCaster():GetTalentLevel("modifier_nevermore_20")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function nevermore_requiem_custom:OnAbilityPhaseStart()
	if self:GetCaster():IsInvisible() then
		EmitSoundOnLocationForAllies(self:GetCaster():GetAbsOrigin(), self.sound, self:GetCaster())
	else
		self:GetCaster():EmitSound("Hero_Nevermore.RequiemOfSoulsCast")
	end
	self.wings_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_wings.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_6)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phased", {})
	return true
end

function nevermore_requiem_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_6)
	self:GetCaster():RemoveModifierByName("modifier_phased")
	self:GetCaster():StopSound("Hero_Nevermore.RequiemOfSoulsCast")
	if self.wings_particle then
		ParticleManager:DestroyParticle(self.wings_particle, true)
		ParticleManager:ReleaseParticleIndex(self.wings_particle)
	end
end

function nevermore_requiem_custom:OnSpellStart(death_cast)	
	if not IsServer() then return end

	local souls_per_line = self:GetSpecialValueFor("requiem_soul_conversion")
	local travel_distance = self:GetSpecialValueFor("requiem_radius")

	self:GetCaster():EmitSound("Hero_Nevermore.RequiemOfSouls")

	if self.wings_particle then
		ParticleManager:ReleaseParticleIndex(self.wings_particle)
	end

	local particle_caster_souls_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_a.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_caster_souls_fx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_caster_souls_fx, 1, Vector(lines, 0, 0))
	ParticleManager:SetParticleControl(particle_caster_souls_fx, 2, self:GetCaster():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_caster_souls_fx)

	local particle_caster_ground_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_caster_ground_fx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_caster_ground_fx, 1, Vector(lines, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle_caster_ground_fx)

	local modifier_souls_handler
	local stacks
	local necro_ability
	local max_souls
    local max_soul_release = self:GetSpecialValueFor("max_soul_release")
    if self:GetCaster():GetUnitName() == "npc_dota_hero_rubick" then
        stacks = 20
        max_souls = 20
    else
        if self:GetCaster():HasModifier("modifier_nevermore_necromastery_custom") then
            modifier_souls_handler = self:GetCaster():FindModifierByName("modifier_nevermore_necromastery_custom")
            if modifier_souls_handler then
                if self:GetCaster():HasModifier("modifier_nevermore_12") then
                    stacks = modifier_souls_handler:GetStackCount()
                else
                    stacks = math.min(modifier_souls_handler:GetStackCount(), max_soul_release)
                end
                necro_ability = modifier_souls_handler:GetAbility()
                max_souls = modifier_souls_handler.total_max_souls
            end
        end
        if not modifier_souls_handler then
            return nil
        end
    end

	local line_position = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * travel_distance
	if stacks >= 1 then
		CreateRequiemSoulLine(self:GetCaster(), self, line_position, death_cast)
	end

	local qangle_rotation_rate = 360 / stacks

	for i = 1, stacks - 1 do
		local qangle = QAngle(0, qangle_rotation_rate, 0)
		line_position = RotatePosition(self:GetCaster():GetAbsOrigin() , qangle, line_position)
		CreateRequiemSoulLine(self:GetCaster(), self, line_position, death_cast)
	end

	self:GetCaster():RemoveModifierByName("modifier_phased")
end

function nevermore_requiem_custom:OnProjectileHit_ExtraData(target, location, extra_data)
	if not target then
		return nil
	end

	local modifier_debuff = "modifier_nevermore_requiem_custom_debuff"
	local scepter_line = extra_data.scepter_line
	local death_cast = extra_data.death_cast

	local damage = self:GetSpecialValueFor("damage")
	local slow_duration = self:GetSpecialValueFor("requiem_slow_duration")
	local max_duration = self:GetSpecialValueFor("requiem_slow_duration_max")

	if scepter_line == 0 then
		scepter_line = false
	else
		scepter_line = true
	end

	if scepter_line then
		damage = damage * (self.modifier_nevermore_12[self:GetCaster():GetTalentLevel("modifier_nevermore_12")] * 0.01)
	end

	target:EmitSound("Hero_Nevermore.RequiemOfSouls.Damage")
	
	ApplyDamage({victim = target, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self:GetCaster(), ability = self})
	
	if not death_cast then
		if not target:HasModifier("modifier_nevermore_requiem_fear") then
			target:AddNewModifier(self:GetCaster(), self, "modifier_nevermore_requiem_fear", {duration  = slow_duration * (1 - target:GetStatusResistance())})
			target:AddNewModifier(self:GetCaster(), self, modifier_debuff, {duration = slow_duration * (1 - target:GetStatusResistance())})
		else
			target:FindModifierByName("modifier_nevermore_requiem_fear"):SetDuration(math.min(target:FindModifierByName("modifier_nevermore_requiem_fear"):GetRemainingTime() + slow_duration, max_duration) * (1 - target:GetStatusResistance()), true)
			target:FindModifierByName(modifier_debuff):SetDuration(math.min(target:FindModifierByName(modifier_debuff):GetRemainingTime() + slow_duration, max_duration) * (1 - target:GetStatusResistance()), true)
		end
	end
end


function CreateRequiemSoulLine(caster, ability, line_end_position, death_cast)
	local travel_distance = ability:GetSpecialValueFor("requiem_radius")
	local lines_starting_width = ability:GetSpecialValueFor("requiem_line_width_start")
	local lines_end_width = ability:GetSpecialValueFor("requiem_line_width_end")
	local lines_travel_speed = ability:GetSpecialValueFor("requiem_line_speed")
	local max_distance_time = travel_distance / lines_travel_speed
    local direction = (line_end_position - caster:GetAbsOrigin()):Normalized()
	local velocity = (line_end_position - caster:GetAbsOrigin()):Normalized()  * lines_travel_speed 

	local projectile_info = 
	{
		Ability = ability,	
	   	vSpawnOrigin = caster:GetAbsOrigin() + (line_end_position - caster:GetAbsOrigin()):Normalized()*(105),
	   	fDistance = travel_distance,
	   	fStartRadius = lines_starting_width,
	   	fEndRadius = lines_end_width,
	   	Source = caster,
	   	bHasFrontalCone = false,
	   	bReplaceExisting = false,
	   	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	   	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	   	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	   	bDeleteOnHit = false,
	   	vVelocity = velocity,
	   	bProvidesVision = false,
	   	ExtraData = {scepter_line = false, death_cast = death_cast}
	}

	ProjectileManager:CreateLinearProjectile(projectile_info)

	local particle_lines_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_lines_fx, 0, caster:GetAbsOrigin() + (line_end_position - caster:GetAbsOrigin()):Normalized()*(105))
    ParticleManager:SetParticleControl(particle_lines_fx, 1, velocity)
	ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, max_distance_time, 0))
	ParticleManager:ReleaseParticleIndex(particle_lines_fx)

	if caster:HasModifier("modifier_nevermore_12") and not death_cast then
		Timers:CreateTimer(max_distance_time, function()
            local origin = caster:GetAbsOrigin()
            local new_pos = origin + direction * travel_distance
            local velocity_new = (origin - new_pos):Normalized()  * lines_travel_speed 

			projectile_info = 
			{
				Ability = ability,
			   vSpawnOrigin = new_pos,
			   fDistance = travel_distance,
			   fStartRadius = lines_end_width,
			   fEndRadius = lines_starting_width,
			   Source = caster,
			   bHasFrontalCone = false,
			   bReplaceExisting = false,
			   iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			   iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			   iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			   bDeleteOnHit = false,
			   vVelocity = velocity_new,
			   bProvidesVision = false,
			   ExtraData = {scepter_line = true}
			}
			ProjectileManager:CreateLinearProjectile(projectile_info)
			local particle_lines_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(particle_lines_fx, 0, new_pos)
			ParticleManager:SetParticleControl(particle_lines_fx, 1, velocity_new)
			ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, max_distance_time, 0))
			ParticleManager:ReleaseParticleIndex(particle_lines_fx)
		end)
	end
end

modifier_nevermore_requiem_custom_debuff = class({})

function modifier_nevermore_requiem_custom_debuff:OnCreated()
	self.ms_slow_pct = self:GetAbility():GetSpecialValueFor("requiem_reduction_ms") 
	self.requiem_reduction_mres = self:GetAbility():GetSpecialValueFor("requiem_reduction_mres")
end

function modifier_nevermore_requiem_custom_debuff:IsHidden() return false end
function modifier_nevermore_requiem_custom_debuff:IsPurgable() return true end
function modifier_nevermore_requiem_custom_debuff:IsDebuff() return true end

function modifier_nevermore_requiem_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_nevermore_requiem_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow_pct
end

function modifier_nevermore_requiem_custom_debuff:GetModifierMagicalResistanceBonus()
	return self.ms_slow_pct
end