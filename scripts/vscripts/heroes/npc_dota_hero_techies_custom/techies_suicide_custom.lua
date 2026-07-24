--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_suicide_custom", "heroes/npc_dota_hero_techies_custom/techies_suicide_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_techies_suicide_custom_magic_immune", "heroes/npc_dota_hero_techies_custom/techies_suicide_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_suicide_custom_magic_immune_cooldown", "heroes/npc_dota_hero_techies_custom/techies_suicide_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

techies_suicide_custom = class({})

techies_suicide_custom.modifier_techies_1 = {-5,-10,-15}
techies_suicide_custom.modifier_techies_3 = {6,9,12}
techies_suicide_custom.modifier_techies_6 = 2
techies_suicide_custom.modifier_techies_6_cooldown = 8
techies_suicide_custom.modifier_techies_7_cast_point = 90
techies_suicide_custom.modifier_techies_7_stun = 0.6

function techies_suicide_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_suicide.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_blast_off.vpcf", context)
end

function techies_suicide_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_techies_7") then
        return 0 
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end


function techies_suicide_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function techies_suicide_custom:GetCooldown( level )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_techies_1") then
		bonus = self.modifier_techies_1[self:GetCaster():GetTalentLevel("modifier_techies_1")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function techies_suicide_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_techies_7") then
        return self.BaseClass.GetCastPoint( self ) - (self.modifier_techies_7_cast_point / 100 * self.BaseClass.GetCastPoint( self ))
    end
	return self.BaseClass.GetCastPoint( self )
end

function techies_suicide_custom:OnAbilityPhaseStart()
    if IsServer() then
        if self:GetCaster():HasModifier("modifier_techies_6") and not self:GetCaster():HasModifier("modifier_techies_suicide_custom_magic_immune_cooldown") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_techies_suicide_custom_magic_immune", {duration = self.modifier_techies_6})
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_techies_suicide_custom_magic_immune_cooldown", {duration = self.modifier_techies_6_cooldown})
        end
    end
    return true
end

function techies_suicide_custom:OnSpellStart()
    if not IsServer() then return end
    local vLocation = self:GetCursorPosition()
    local direction = self:GetCursorPosition() - self:GetCaster():GetOrigin()
    direction.z = 0
    local length = direction:Length2D()
    direction = direction:Normalized()
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_techies_suicide_custom", {} )
    local arc = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_generic_arc_lua",
    { 
        dir_x = direction.x,
        dir_y = direction.y,
        duration = 0.75,
        distance = length,
        height = 200,
        fix_end = false,
        isStun = false,
        isForward = true,
        activity = ACT_DOTA_OVERRIDE_ABILITY_2,
    })
    self:GetCaster():EmitSound("Hero_Techies.BlastOff.Cast")
    arc:SetEndCallback( function( interrupted )
        local modifier_techies_suicide_custom = self:GetCaster():FindModifierByName("modifier_techies_suicide_custom")
        if modifier_techies_suicide_custom then
            modifier_techies_suicide_custom.interrupt = interrupted
            modifier_techies_suicide_custom:Destroy()
        end
        self:GetCaster():FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_2)
    end)
end

modifier_techies_suicide_custom = class({})
function modifier_techies_suicide_custom:IsHidden() return true end
function modifier_techies_suicide_custom:IsPurgable() return false end
function modifier_techies_suicide_custom:IsPurgeException() return false end
function modifier_techies_suicide_custom:RemoveOnDeath() return false end

function modifier_techies_suicide_custom:OnCreated( kv )
    if not IsServer() then return end
    local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControlEnt( nFXIndex, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
    self:AddParticle( nFXIndex, false, false, -1, false, false )
end

function modifier_techies_suicide_custom:OnDestroy()
    if not IsServer() then return end
    if self.interrupt then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_techies_3") then
        self.damage = self.damage + (self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_techies_3[self:GetCaster():GetTalentLevel("modifier_techies_3")])
    end
    self.duration = self:GetAbility():GetSpecialValueFor("stun_duration")
    if self:GetCaster():HasModifier("modifier_techies_7") then
        self.duration = self.duration + self:GetAbility().modifier_techies_7_stun
    end
    self.hp_cost = self:GetCaster():GetHealth() / 100 * self:GetAbility():GetSpecialValueFor("hp_cost")
    local shard_stun_duration = self:GetAbility():GetSpecialValueFor("shard_stun_duration")
    self:GetCaster():EmitSound("Hero_Techies.Suicide")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_blast_off.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    GridNav:DestroyTreesAroundPoint(self:GetCaster():GetAbsOrigin(), self.radius, true)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
    for i, unit in ipairs(units) do
        ApplyDamage({ victim = unit, attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL })
        unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self.duration * (1 - unit:GetStatusResistance())})
    end
    ApplyDamage({victim = self:GetCaster(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.hp_cost, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
end

function modifier_techies_suicide_custom:CheckState()
    return
    {
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_techies_suicide_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
    }
end

function modifier_techies_suicide_custom:GetModifierIgnoreCastAngle()
    return 1
end

modifier_techies_suicide_custom_magic_immune = class({})
function modifier_techies_suicide_custom_magic_immune:IsPurgable() return false end
function modifier_techies_suicide_custom_magic_immune:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end
function modifier_techies_suicide_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end
function modifier_techies_suicide_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_techies_suicide_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end
function modifier_techies_suicide_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_techies_suicide_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_techies_suicide_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_techies_suicide_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
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

modifier_techies_suicide_custom_magic_immune_cooldown = class({})
function modifier_techies_suicide_custom_magic_immune_cooldown:IsPurgeException() return false end
function modifier_techies_suicide_custom_magic_immune_cooldown:RemoveOnDeath() return false end
function modifier_techies_suicide_custom_magic_immune_cooldown:IsDebuff() return true end
function modifier_techies_suicide_custom_magic_immune_cooldown:IsPurgable() return false end