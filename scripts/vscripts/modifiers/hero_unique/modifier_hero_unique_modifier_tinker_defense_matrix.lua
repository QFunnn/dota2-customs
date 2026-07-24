--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_tinker_defense_matrix = class({})
function modifier_hero_unique_modifier_tinker_defense_matrix:IsHidden() return true end
function modifier_hero_unique_modifier_tinker_defense_matrix:IsPurgable() return false end
function modifier_hero_unique_modifier_tinker_defense_matrix:IsPurgeException() return false end
function modifier_hero_unique_modifier_tinker_defense_matrix:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_tinker_defense_matrix:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.dmg = 0
    self.cooldown = false
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_tinker_defense_matrix:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_tinker_defense_matrix:TakeDamageScriptModifier(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if self:GetAbility():GetLevel() <= 0 then return end
    if self.cooldown then return end
    self.dmg = self.dmg + params.damage
    if self.dmg >= 400 then
        self.dmg = 0
        self.cooldown = true
        self:GetParent():Heal(300, self:GetAbility())
        self:GetParent():SetCursorCastTarget(self:GetParent())
        self:GetAbility():OnSpellStart()
        Timers:CreateTimer(7, function()
            self.cooldown = false
        end)
    end
end