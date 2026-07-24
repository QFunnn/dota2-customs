--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_minigames_circle_debuff = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,
})

function modifier_minigames_circle_debuff:OnCreated()
    if not IsServer() then return end

    self:StartIntervalThink(GAME_ROUNDS_CIRCLE_SETTINGS["MINIGAMES"].INTERVAL)
end

function modifier_minigames_circle_debuff:OnIntervalThink()
    local parent = self:GetParent()
    if parent and not parent:IsNull() and parent:IsAlive() then
        ApplyDamage({
            victim = parent,
            damage = GAME_ROUNDS_CIRCLE_SETTINGS["MINIGAMES"].DAMAGE,
            damage_type = DAMAGE_TYPE_PURE,
            damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
            attacker = parent,
            ability = Bans:GetDebuffImmuneAbility()
        })
    end
end