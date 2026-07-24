--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_naga_siren_1_haste", "modifiers/talents/npc_dota_hero_naga_siren/modifier_naga_siren_1", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_1_debuff", "modifiers/talents/npc_dota_hero_naga_siren/modifier_naga_siren_1", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_1_cooldown", "modifiers/talents/npc_dota_hero_naga_siren/modifier_naga_siren_1", LUA_MODIFIER_MOTION_NONE )

modifier_naga_siren_1=class({})

function modifier_naga_siren_1:IsHidden() return true end
function modifier_naga_siren_1:IsPurgable() return false end
function modifier_naga_siren_1:IsPurgeException() return false end
function modifier_naga_siren_1:RemoveOnDeath() return false end

function modifier_naga_siren_1:OnCreated()
    self.bonus = {1,1.5,2}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_naga_siren_1:OnRefresh()
    self.bonus = {1,1.5,2}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_naga_siren_1:DeclareFunctions()
    local decFuns =
    {
        --MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
    return decFuns
end

function modifier_naga_siren_1:GetModifierPreAttack_BonusDamage()
    return (self:GetParent():GetMaxHealth() + self:GetParent():GetMaxMana()) / 100 * self.bonus[self:GetStackCount()]
end

function modifier_naga_siren_1:OnAttack(params)
    if params.attacker ~= self:GetParent() then return end
    if self:GetParent():HasModifier("modifier_naga_siren_1_cooldown") then return end
    local cooldown = {7,5,3}
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_naga_siren_1_cooldown", {duration = cooldown[self:GetStackCount()]})
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_naga_siren_1_haste", {duration = 2})
    self:GetParent():AttackNoEarlierThan(0, 100)
end

modifier_naga_siren_1_cooldown = class({})
function modifier_naga_siren_1_cooldown:IsDebuff() return true end
function modifier_naga_siren_1_cooldown:IsPurgable() return false end
function modifier_naga_siren_1_cooldown:IsPurgeException() return false end
function modifier_naga_siren_1_cooldown:RemoveOnDeath() return false end
function modifier_naga_siren_1_cooldown:GetTexture() return "naga_siren_1" end

modifier_naga_siren_1_haste = class({})
function modifier_naga_siren_1_haste:IsHidden() return true end
function modifier_naga_siren_1_haste:IsPurgable() return false end

function modifier_naga_siren_1_haste:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK
    }
end

function modifier_naga_siren_1_haste:GetModifierAttackSpeedBonus_Constant()
    if IsClient() then return 0 end
    return 1000
end

function modifier_naga_siren_1_haste:OnAttack(params)
    if params.attacker ~= self:GetParent() then return end
    params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_naga_siren_1_debuff", {duration = 1 * ( 1 - params.target:GetStatusResistance()) })
    self:Destroy()
end

modifier_naga_siren_1_debuff = class({})

function modifier_naga_siren_1_debuff:GetTexture() return "naga_siren_1" end

function modifier_naga_siren_1_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_naga_siren_1_debuff:GetModifierMoveSpeedBonus_Percentage()
    return -100
end