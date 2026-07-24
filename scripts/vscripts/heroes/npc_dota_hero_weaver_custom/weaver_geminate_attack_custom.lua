--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_weaver_geminate_attack_custom", "heroes/npc_dota_hero_weaver_custom/weaver_geminate_attack_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_geminate_attack_custom_debuff", "heroes/npc_dota_hero_weaver_custom/weaver_geminate_attack_custom", LUA_MODIFIER_MOTION_NONE)

weaver_geminate_attack_custom = class({})

weaver_geminate_attack_custom.modifier_weaver_1 = {15,30,45}
weaver_geminate_attack_custom.modifier_weaver_2_radius = 300
weaver_geminate_attack_custom.modifier_weaver_2_armor = -3
weaver_geminate_attack_custom.modifier_weaver_2_duration = 7

function weaver_geminate_attack_custom:GetIntrinsicModifierName()
	return "modifier_weaver_geminate_attack_custom"
end

function weaver_geminate_attack_custom:OnUpgrade()
    if not IsServer() then return end
    if self and self:GetLevel() == 1 then
        self:ToggleAutoCast()
    end
end

function weaver_geminate_attack_custom:GetCooldown(iLevel)
    return self.BaseClass.GetCooldown( self, iLevel )
end

modifier_weaver_geminate_attack_custom = class({})
function modifier_weaver_geminate_attack_custom:IsHidden() return true end
function modifier_weaver_geminate_attack_custom:IsPurgable() return false end
function modifier_weaver_geminate_attack_custom:IsPurgeException() return false end
function modifier_weaver_geminate_attack_custom:RemoveOnDeath() return false end
function modifier_weaver_geminate_attack_custom:OnCreated()
    if not IsServer() then return end
    self.double_attack = {}
end

function modifier_weaver_geminate_attack_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
    }
end

function modifier_weaver_geminate_attack_custom:GetModifierProcAttack_BonusDamage_Physical(params)
    if self.double_attack[params.record] ~= nil then
        if self:GetCaster():HasModifier("modifier_weaver_2") then
            params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_weaver_geminate_attack_custom_debuff", {duration = self:GetAbility().modifier_weaver_2_duration})
        end
        local damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
        if self:GetCaster():HasModifier("modifier_weaver_1") then
            damage = damage + self:GetAbility().modifier_weaver_1[self:GetCaster():GetTalentLevel("modifier_weaver_1")]
        end
        return damage
    end
end

function modifier_weaver_geminate_attack_custom:OnAttack(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if params.no_attack_cooldown then
        self.double_attack[params.record] = true
        return 
    end
    if not self:GetAbility():GetAutoCastState() then return end
    if self:GetParent():PassivesDisabled() then return end
    local delay = self:GetAbility():GetSpecialValueFor("delay")
    if self:GetAbility():IsFullyCastable() then
        self:GetAbility():UseResources(false, false, false, true)
        Timers:CreateTimer(delay, function()
            if params.target and not params.target:IsNull() and params.target:IsAlive() and not params.target:IsAttackImmune() and not params.target:IsInvulnerable() then
                self:GetParent():PerformAttack(params.target, true, true, true, false, true, false, false) 
                if self:GetCaster():HasModifier("modifier_weaver_7") then
                    Timers:CreateTimer(delay, function()
                        self:GetParent():PerformAttack(params.target, true, true, true, false, true, false, false)
                    end)
                end
            end
        end)
        if self:GetCaster():HasModifier("modifier_weaver_2") then
            local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), params.target:GetAbsOrigin(), nil, self:GetAbility().modifier_weaver_2_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            for _, unit in pairs(units) do
                if unit ~= params.target then
                    Timers:CreateTimer(delay, function()
                        if unit and not unit:IsNull() and unit:IsAlive() and not unit:IsAttackImmune() and not unit:IsInvulnerable() then
                            self:GetParent():PerformAttack(unit, true, true, true, false, true, false, false)
                            Timers:CreateTimer(delay, function()
                                self:GetParent():PerformAttack(unit, true, true, true, false, true, false, false)
                            end)
                        end
                    end)
                end
            end
        end
    end
end

function modifier_weaver_geminate_attack_custom:FastAttack(enemy)
    if not IsServer() then return end
    if enemy:IsAlive() and not enemy:IsAttackImmune() and not enemy:IsInvulnerable() then
        self:GetParent():PerformAttack(enemy, true, true, true, false, true, false, false)
        if self:GetCaster():HasModifier("modifier_weaver_7") then
            self:GetParent():PerformAttack(enemy, true, true, true, false, true, false, false)
        end
    end
end

modifier_weaver_geminate_attack_custom_debuff = class({})
function modifier_weaver_geminate_attack_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end
function modifier_weaver_geminate_attack_custom_debuff:GetModifierPhysicalArmorBonus()
    return self:GetAbility().modifier_weaver_2_armor
end