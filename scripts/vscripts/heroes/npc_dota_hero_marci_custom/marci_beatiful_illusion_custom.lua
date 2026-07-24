--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("marci_beatiful_illusion_custom_handler", "heroes/npc_dota_hero_marci_custom/marci_beatiful_illusion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("marci_beatiful_illusion_custom_handler_explosion", "heroes/npc_dota_hero_marci_custom/marci_beatiful_illusion_custom", LUA_MODIFIER_MOTION_NONE)

marci_beatiful_illusion_custom = class({})

marci_beatiful_illusion_custom.modifier_marci_18 = {35,70}
marci_beatiful_illusion_custom.modifier_marci_17 = {10,15,20}
marci_beatiful_illusion_custom.modifier_marci_17_radius = 400

function marci_beatiful_illusion_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
	PrecacheResource( "particle", "particles/marci_illusion_death_effect.vpcf", context )
end

function marci_beatiful_illusion_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local illusion_count = self:GetSpecialValueFor("illusion_count")
    local damage_out = self:GetSpecialValueFor("damage_out") - 100
    local damage_in = self:GetSpecialValueFor("damage_in") - 100
    if self.marci_illusion and not self.marci_illusion:IsNull() then
        self.marci_illusion:ForceKill(false)
    end
    self:GetCaster():EmitSound("Hero_Terrorblade.ConjureImage")
    if self:GetCaster():HasModifier("modifier_marci_18") then
        damage_in = damage_in - self.modifier_marci_18[self:GetCaster():GetTalentLevel("modifier_marci_18")]
    end
    local illusions = CreateIllusions( self:GetCaster(), self:GetCaster(), { outgoing_damage = damage_out, incoming_damage = damage_in, duration = duration }, illusion_count, 150, false, true )
	for _,illusion in pairs(illusions) do
		self.marci_illusion = illusion
	end
end

function marci_beatiful_illusion_custom:GetIntrinsicModifierName()
    return "marci_beatiful_illusion_custom_handler"
end

marci_beatiful_illusion_custom_handler = class({})
function marci_beatiful_illusion_custom_handler:IsHidden() return true end
function marci_beatiful_illusion_custom_handler:IsPurgable() return false end
function marci_beatiful_illusion_custom_handler:IsPurgeException() return false end
function marci_beatiful_illusion_custom_handler:RemoveOnDeath() return false end
function marci_beatiful_illusion_custom_handler:IsAura() return true end
function marci_beatiful_illusion_custom_handler:GetModifierAura() return "marci_beatiful_illusion_custom_handler_explosion" end
function marci_beatiful_illusion_custom_handler:GetAuraRadius() return -1 end
function marci_beatiful_illusion_custom_handler:GetAuraDuration() return 3 end
function marci_beatiful_illusion_custom_handler:IsAuraActiveOnDeath() return true end
function marci_beatiful_illusion_custom_handler:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function marci_beatiful_illusion_custom_handler:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function marci_beatiful_illusion_custom_handler:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function marci_beatiful_illusion_custom_handler:GetAuraEntityReject(target)
	if target:IsIllusion() then
        local modifier_illusion = target:FindModifierByName("modifier_illusion")
        if modifier_illusion and modifier_illusion:GetCaster() == self:GetCaster() then
            return false
        end
    end
    return true
end

marci_beatiful_illusion_custom_handler_explosion = class({})
function marci_beatiful_illusion_custom_handler_explosion:IsHidden() return false end
function marci_beatiful_illusion_custom_handler_explosion:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_DEATH
    }
end
function marci_beatiful_illusion_custom_handler_explosion:OnDestroy(params)
    if not IsServer() then return end
    if self:GetParent():IsAlive() then return end
    if not self:GetCaster():HasModifier("modifier_marci_17") then return end
    local damage = self:GetCaster():GetMaxMana() / 100 * self:GetAbility().modifier_marci_17[self:GetCaster():GetTalentLevel("modifier_marci_17")]
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility().modifier_marci_17_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    end
    local particle = ParticleManager:CreateParticle("particles/marci_illusion_death_effect.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self:GetAbility().modifier_marci_17_radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end