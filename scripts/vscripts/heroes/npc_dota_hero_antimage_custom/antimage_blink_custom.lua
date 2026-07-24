--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_blink_custom_magic_immune", "heroes/npc_dota_hero_antimage_custom/antimage_blink_custom", LUA_MODIFIER_MOTION_NONE )

antimage_blink_custom = class({})

antimage_blink_custom.modifier_antimage_9 = {100,200}
antimage_blink_custom.modifier_antimage_15 = {10,20}
antimage_blink_custom.modifier_antimage_21_damage = 10
antimage_blink_custom.modifier_antimage_21_radius = 500

function antimage_blink_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_blink_start.vpcf', context )
	PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_blink_end.vpcf', context )
	PrecacheResource( "particle", 'particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_ti_5.vpcf', context )
	PrecacheResource( "particle", 'particles/items_fx/black_king_bar_avatar.vpcf', context )
	PrecacheResource( "particle", 'particles/status_fx/status_effect_avatar.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_antimage.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_antimage.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_antimage.vpcf", context)
end

function antimage_blink_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_antimage_9") then
            bonus = antimage_blink_custom.modifier_antimage_9[self:GetCaster():GetTalentLevel("modifier_antimage_9")]
        end
        return self:GetSpecialValueFor("blink_range") + bonus
    end
end

function antimage_blink_custom:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local blink_range = self:GetSpecialValueFor("blink_range") + self:GetCaster():GetCastRangeBonus()
    if caster:HasModifier("modifier_antimage_9") then
        blink_range = blink_range + antimage_blink_custom.modifier_antimage_9[self:GetCaster():GetTalentLevel("modifier_antimage_9")]
    end

	local direction = (point - origin)

	direction.z = 0

	if direction:Length2D() > blink_range then
		direction = direction:Normalized() * blink_range
	end

	local particle_start = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_start.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( particle_start, 0, origin )
	ParticleManager:SetParticleControlForward( particle_start, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_start )

	EmitSoundOnLocationWithCaster( origin, "Hero_Antimage.Blink_out", self:GetCaster() )

	ProjectileManager:ProjectileDodge(self:GetCaster())

	FindClearSpaceForUnit( caster, origin + direction, true )

	ProjectileManager:ProjectileDodge(self:GetCaster())

	local particle_end = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_end.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( particle_end, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( particle_end, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_end )

	if self:GetCaster():HasModifier("modifier_antimage_15") then
		local heal = self:GetCaster():GetMana() / 100 * self.modifier_antimage_15[self:GetCaster():GetTalentLevel("modifier_antimage_15")]
		self:GetCaster():Heal(heal, self)
	end

	if self:GetCaster():HasModifier("modifier_antimage_20") then
		self:GetCaster():Purge(false, true, false, false, false)
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_antimage_blink_custom_magic_immune", {duration = 0.3})
	end

	if self:GetCaster():HasModifier("modifier_antimage_21") then
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self.modifier_antimage_21_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

		self:GetCaster():EmitSound("Hero_Antimage.ManaVoid")

		local particle = ParticleManager:CreateParticle( "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_ti_5.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster() )
		ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
		ParticleManager:SetParticleControl( particle, 1, Vector( self.modifier_antimage_21_radius, 0, 0 ) )
		ParticleManager:ReleaseParticleIndex( particle )

		for _,enemy in pairs(enemies) do
			enemy:Script_ReduceMana(self:GetCaster():GetMana() / 100 * self.modifier_antimage_21_damage, self)
			ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = self:GetCaster():GetMana() / 100 * self.modifier_antimage_21_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
		end
	end

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Antimage.Blink_in", self:GetCaster() )
end

modifier_antimage_blink_custom_magic_immune = class({})

function modifier_antimage_blink_custom_magic_immune:IsPurgable() return false end


function modifier_antimage_blink_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_antimage_blink_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_antimage_blink_custom_magic_immune:CheckState()
    return {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_antimage_blink_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_antimage_blink_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_antimage_blink_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_antimage_blink_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_antimage_blink_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end