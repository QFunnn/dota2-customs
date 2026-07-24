--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_naga_siren_song_of_the_siren_custom", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_song_of_the_siren_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_song_of_the_siren_custom_debuff", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_song_of_the_siren_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_song_of_the_siren_custom_buff", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_song_of_the_siren_custom", LUA_MODIFIER_MOTION_NONE )

naga_siren_song_of_the_siren_custom = class({})

naga_siren_song_of_the_siren_custom.modifier_naga_siren_12 = {3,6}
naga_siren_song_of_the_siren_custom.modifier_naga_siren_21 = -80

function naga_siren_song_of_the_siren_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor( "duration" )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_naga_siren_song_of_the_siren_custom", { duration = duration } )
    local naga_siren_song_of_the_siren_cancel_custom = self:GetCaster():FindAbilityByName("naga_siren_song_of_the_siren_cancel_custom")
    if naga_siren_song_of_the_siren_cancel_custom then
        naga_siren_song_of_the_siren_cancel_custom:SetLevel(1)
        naga_siren_song_of_the_siren_cancel_custom:StartCooldown(1)
    end
end

modifier_naga_siren_song_of_the_siren_custom = class({})
function modifier_naga_siren_song_of_the_siren_custom:IsPurgable() return false end

function modifier_naga_siren_song_of_the_siren_custom:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_siren/naga_siren_siren_song_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( particle )

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_siren/naga_siren_song_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )

	EmitSoundOn( "Hero_NagaSiren.SongOfTheSiren", self:GetCaster() )

    self:GetCaster():SwapAbilities("naga_siren_song_of_the_siren_custom", "naga_siren_song_of_the_siren_cancel_custom", false, true)

    self:StartIntervalThink(0.1)
end

function modifier_naga_siren_song_of_the_siren_custom:OnDestroy()
	if not IsServer() then return end
    StopSoundOn( "Hero_NagaSiren.SongOfTheSiren", self:GetCaster() )
	EmitSoundOn( "Hero_NagaSiren.SongOfTheSiren.Cancel", self:GetCaster() )
    self:GetCaster():SwapAbilities("naga_siren_song_of_the_siren_cancel_custom", "naga_siren_song_of_the_siren_custom", false, true)
end

function modifier_naga_siren_song_of_the_siren_custom:OnIntervalThink()
    if not IsServer() then return end
    local friendly_heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0, false)
    for _, hero in pairs(friendly_heroes) do
        local heal_pct = self:GetAbility():GetSpecialValueFor("heal_pct")
        if self:GetParent():HasModifier("modifier_naga_siren_12") then
            local mana = (hero:GetMaxMana() / 100 * self:GetAbility().modifier_naga_siren_12[self:GetCaster():GetTalentLevel("modifier_naga_siren_12")]) * 0.1
            hero:GiveMana(mana)
            heal_pct = heal_pct + self:GetAbility().modifier_naga_siren_12[self:GetCaster():GetTalentLevel("modifier_naga_siren_12")]
        end
        local health = (hero:GetMaxHealth() / 100 * heal_pct) * 0.1
        hero:Heal(health, self:GetAbility())
    end
end

function modifier_naga_siren_song_of_the_siren_custom:IsAura()
	return true
end

function modifier_naga_siren_song_of_the_siren_custom:GetModifierAura()
    if self:GetCaster():HasModifier("modifier_naga_siren_21") then
        return "modifier_naga_siren_song_of_the_siren_custom_buff"
    end
	return "modifier_naga_siren_song_of_the_siren_custom_debuff"
end

function modifier_naga_siren_song_of_the_siren_custom:GetAuraEntityReject(target)
    if not self:GetCaster():HasModifier("modifier_naga_siren_21") then return false end
    local modifier_illusion = target:FindModifierByName("modifier_illusion")
    if modifier_illusion then
        if modifier_illusion:GetCaster() == self:GetCaster() then
            return false
        end
    end
    if self:GetCaster() == target then
        return false
    end
	return true
end

function modifier_naga_siren_song_of_the_siren_custom:GetAuraRadius()
	return self.radius
end

function modifier_naga_siren_song_of_the_siren_custom:GetAuraDuration()
	return 0.4
end

function modifier_naga_siren_song_of_the_siren_custom:GetAuraSearchTeam()
    if self:GetCaster():HasModifier("modifier_naga_siren_21") then
        return DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_naga_siren_song_of_the_siren_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_naga_siren_song_of_the_siren_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_naga_siren_song_of_the_siren_custom_debuff = class({})
function modifier_naga_siren_song_of_the_siren_custom_debuff:IsPurgable() return false end

function modifier_naga_siren_song_of_the_siren_custom_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:OnCreated( kv )
	self.rate = self:GetAbility():GetSpecialValueFor( "animation_rate" )
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:GetOverrideAnimationRate()
	return self.rate
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:CheckState()
	return
    {
		[MODIFIER_STATE_NIGHTMARED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_song_debuff.vpcf"
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_siren_song.vpcf"
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

naga_siren_song_of_the_siren_cancel_custom = class({})

function naga_siren_song_of_the_siren_cancel_custom:OnSpellStart()
    if not IsServer() then return end
    local modifier_naga_siren_song_of_the_siren_custom = self:GetCaster():FindModifierByName("modifier_naga_siren_song_of_the_siren_custom")
    if modifier_naga_siren_song_of_the_siren_custom then
        modifier_naga_siren_song_of_the_siren_custom:Destroy()
    end
end

modifier_naga_siren_song_of_the_siren_custom_buff = class({})

function modifier_naga_siren_song_of_the_siren_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_naga_siren_song_of_the_siren_custom_buff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_song_debuff.vpcf"
end

function modifier_naga_siren_song_of_the_siren_custom_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_naga_siren_song_of_the_siren_custom_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_siren_song.vpcf"
end

function modifier_naga_siren_song_of_the_siren_custom_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_naga_siren_song_of_the_siren_custom_buff:GetModifierIncomingDamage_Percentage()
    return self:GetAbility().modifier_naga_siren_21
end