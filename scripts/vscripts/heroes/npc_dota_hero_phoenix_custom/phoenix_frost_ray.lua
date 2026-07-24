--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_frost_ray", "heroes/npc_dota_hero_phoenix_custom/phoenix_frost_ray", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

phoenix_frost_ray = class({})

function phoenix_frost_ray:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/phoenix_custom/phoenix_sunray_creo_forge.vpcf", context )
end

function phoenix_frost_ray:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("length_distance")
    end
end

function phoenix_frost_ray:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    self:GetCaster():SetForwardVector(direction)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phoenix_frost_ray", {duration = 0.5})
end

modifier_phoenix_frost_ray = class({})
function modifier_phoenix_frost_ray:IsHidden() return true end
function modifier_phoenix_frost_ray:IsPurgable() return false end
function modifier_phoenix_frost_ray:IsPurgeException() return false end
function modifier_phoenix_frost_ray:OnCreated()
    if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.duration = self:GetAbility():GetSpecialValueFor("duration")
    self.knockback_distance = self:GetAbility():GetSpecialValueFor("knockback_distance")
    self.length_distance = self:GetAbility():GetSpecialValueFor("length_distance") + self:GetCaster():GetCastRangeBonus()
    self.width = self:GetAbility():GetSpecialValueFor("width")
    local endcapPos = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * self.length_distance
    endcapPos = GetGroundPosition( endcapPos, nil )
    endcapPos.z = endcapPos.z + 92

    local pfx = ParticleManager:CreateParticle( "particles/phoenix_custom/phoenix_sunray_creo_forge.vpcf", PATTACH_CUSTOMORIGIN, nil )
    local attach_point = self:GetCaster():ScriptLookupAttachment( "attach_head" )
    ParticleManager:SetParticleControl( pfx, 0, self:GetCaster():GetAttachmentOrigin( attach_point ) )
    ParticleManager:SetParticleControl( pfx, 1, endcapPos )
    self:AddParticle(pfx, false, false, -1, false, false)
    
    local phoenix_ice_debuff = self:GetCaster():FindAbilityByName("phoenix_ice_debuff")
    local damage = self:GetCaster():GetMaxMana() / 100 * self.damage
    local units = FindUnitsInLine(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * 32, endcapPos, nil, self.width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE)
    for _,unit in pairs(units) do
        ApplyDamage({ victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
        unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_silence", {duration = self.duration * (1 - unit:GetStatusResistance())})
        if phoenix_ice_debuff then
            phoenix_ice_debuff:AddStack(unit, 3)
        end
    end

    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_knockback_lua", { duration = 0.25, distance = self.knockback_distance, height = 0, direction_x = -self:GetCaster():GetForwardVector().x, direction_y = -self:GetCaster():GetForwardVector().y})

    StartSoundEvent("Hero_Phoenix.SunRay.Beam", self:GetCaster() )
	StartSoundEvent("Hero_Phoenix.SunRay.Cast", self:GetCaster())
end

function modifier_phoenix_frost_ray:OnDestroy()
    if not IsServer() then return end
    StopSoundEvent("Hero_Phoenix.SunRay.Beam", self:GetCaster() )
    StopSoundEvent("Hero_Phoenix.SunRay.Cast", self:GetCaster())
end