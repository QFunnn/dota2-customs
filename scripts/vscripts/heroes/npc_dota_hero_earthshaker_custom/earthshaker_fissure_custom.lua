--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_earthshaker_fissure_custom_thinker", "heroes/npc_dota_hero_earthshaker_custom/earthshaker_fissure_custom", LUA_MODIFIER_MOTION_NONE )

earthshaker_fissure_custom = class({})

earthshaker_fissure_custom.modifier_earthshaker_8 = {-1,-2,-3}
earthshaker_fissure_custom.modifier_earthshaker_9 = {150,300}
earthshaker_fissure_custom.modifier_earthshaker_15 = {40,80,120}

function earthshaker_fissure_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf", context )
end

function earthshaker_fissure_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_earthshaker_8") then
		bonus = self.modifier_earthshaker_8[self:GetCaster():GetTalentLevel("modifier_earthshaker_8")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function earthshaker_fissure_custom:GetCastRange(location, target)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_earthshaker_9") then
		bonus = self.modifier_earthshaker_9[self:GetCaster():GetTalentLevel("modifier_earthshaker_9")]
	end
    return self.BaseClass.GetCastRange(self, location, target) + bonus
end

function earthshaker_fissure_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_earthshaker_12") then
        return self.BaseClass.GetCastPoint( self ) / 2
    end
    return self.BaseClass.GetCastPoint( self )
end

function earthshaker_fissure_custom:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("fissure_damage")
	local distance = self:GetCastRange( point, caster ) + self:GetCaster():GetCastRangeBonus()
	local duration = self:GetSpecialValueFor("fissure_duration")
	local radius = self:GetSpecialValueFor("fissure_radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	if self:GetCaster():HasModifier("modifier_earthshaker_15") then
		damage = damage + self.modifier_earthshaker_15[self:GetCaster():GetTalentLevel("modifier_earthshaker_15")]
	end

	local block_width = 24
	local block_delta = 8.25

	local direction = point-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()
	local wall_vector = direction * (distance - 150)

	local block_spacing = (block_delta+2*block_width)
	local blocks = distance/block_spacing
	local block_pos = caster:GetHullRadius() + block_delta + block_width
	local start_pos = caster:GetOrigin() + direction*block_pos

	for i=1, blocks do
		local block_vec = caster:GetOrigin() + direction*block_pos
        local blocker = CreateModifierThinker( caster, self, "modifier_earthshaker_fissure_custom_thinker", { duration = duration }, block_vec, caster:GetTeamNumber(), true )
		blocker:SetHullRadius( block_width )
        block_pos = block_pos + block_spacing
	end

	local end_pos = start_pos + wall_vector
	local units = FindUnitsInLine( caster:GetTeamNumber(), start_pos, end_pos, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES )

	local damageTable = { attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }

	for _,unit in pairs(units) do
		FindClearSpaceForUnit( unit, unit:GetOrigin(), true )
		if unit:GetTeamNumber()~=caster:GetTeamNumber() and not unit:IsMagicImmune() then
			damageTable.victim = unit
			ApplyDamage(damageTable)
			unit:AddNewModifier( caster, self, "modifier_stunned", { duration = stun_duration * (1-unit:GetStatusResistance()) } )
		end
	end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, start_pos )
	ParticleManager:SetParticleControl( effect_cast, 1, end_pos )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOnLocationWithCaster( start_pos, "Hero_EarthShaker.Fissure", self:GetCaster() )
	EmitSoundOnLocationWithCaster( end_pos, "Hero_EarthShaker.Fissure", self:GetCaster() )

	local aftershock = self:GetCaster():FindModifierByName("modifier_earthshaker_aftershock_custom")
	if aftershock then
		aftershock:AfterShockApply(self:GetCaster():GetAbsOrigin())
	end
end

modifier_earthshaker_fissure_custom_thinker = class({})

function modifier_earthshaker_fissure_custom_thinker:IsHidden()
	return true
end

function modifier_earthshaker_fissure_custom_thinker:IsPurgable()
	return false
end

function modifier_earthshaker_fissure_custom_thinker:OnDestroy( kv )
	if not IsServer() then return end
	EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), "Hero_EarthShaker.FissureDestroy", self:GetCaster() )
	UTIL_Remove(self:GetParent())
end

function modifier_earthshaker_fissure_custom_thinker:IsAura()
    return self:GetCaster():HasModifier("modifier_earthshaker_12")
end

function modifier_earthshaker_fissure_custom_thinker:GetModifierAura()
    return "modifier_earthshaker_fissure_shard_pathing"
end

function modifier_earthshaker_fissure_custom_thinker:GetAuraEntityReject(hEntity)
    if hEntity == self:GetCaster() then
        return false
    end
    return true
end

function modifier_earthshaker_fissure_custom_thinker:GetAuraRadius()
    return 250
end

function modifier_earthshaker_fissure_custom_thinker:GetAuraDuration()
    return 0.5
end

function modifier_earthshaker_fissure_custom_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_earthshaker_fissure_custom_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_earthshaker_fissure_custom_thinker:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end















earthshaker_fissure_2_custom = earthshaker_fissure_custom