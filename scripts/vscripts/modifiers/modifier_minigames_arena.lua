--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_minigames_arena_evasion", "modifiers/modifier_minigames_arena", LUA_MODIFIER_MOTION_NONE)

modifier_minigames_arena = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
})

function modifier_minigames_arena:AttackLandedModifier(event)
    local parent = self:GetParent()
    local target = event.target

    if parent and target == parent and not parent:HasModifier("modifier_minigames_arena_evasion") and not parent:HasModifier("modifier_item_custom_rune_shield") and not parent:HasModifier("modifier_minigames_warrior_refraction") then
        parent:AddNewModifier(parent, nil, "modifier_minigames_arena_evasion", {duration=3})
    end
end

modifier_minigames_arena_evasion = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_AVOID_DAMAGE
        }
    end,

    GetEffectName           = function(self) return "particles/units/heroes/hero_ogre_magi/ogre_magi_fire_shield.vpcf" end,
})

function modifier_minigames_arena_evasion:OnCreated(table)
    self.AttacksToBlock = 2
    self.IgnoreNextHit = true
    self:SetStackCount(self.AttacksToBlock)

    if IsServer() then
        EmitSoundOn("Minigames.ArenaShield.Cast", self:GetParent())
    end
end

function modifier_minigames_arena_evasion:GetModifierAvoidDamage(event)

    if event.inflictor and event.inflictor:GetName() == "item_custom_rune_arcane" then
        return 0
    end

    if self.IgnoreNextHit then
        self.IgnoreNextHit = false
        return 0
    end

    if self.AttacksToBlock > 0 then
        self.AttacksToBlock = self.AttacksToBlock - 1

        self:SetStackCount(self.AttacksToBlock)

        if IsServer() then
            local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_phoenix/phoenix_supernova_hit.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
            ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
            ParticleManager:ReleaseParticleIndex(fx)

            EmitSoundOn("Minigames.ArenaShield.Damage", self:GetParent())
        end

        if self.AttacksToBlock <= 0 then
            self:Destroy()
        end

        return 1
    end

    return 0
end