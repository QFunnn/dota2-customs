--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_riki_backstab_custom", "heroes/npc_dota_hero_riki_custom/riki_backstab_custom", LUA_MODIFIER_MOTION_NONE)

riki_backstab_custom = class({})
riki_backstab_custom.modifier_riki_13 = {0.1,0.2,0.3}

function riki_backstab_custom:GetIntrinsicModifierName()
    return "modifier_riki_backstab_custom"
end

function riki_backstab_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_riki_13") then
        return "riki_13"
    end
    return "riki_backstab_custom"
end

modifier_riki_backstab_custom = class({})
function modifier_riki_backstab_custom:IsHidden() return true end
function modifier_riki_backstab_custom:IsPurgable() return false end
function modifier_riki_backstab_custom:IsPurgeException() return false end
function modifier_riki_backstab_custom:RemoveOnDeath() return false end
function modifier_riki_backstab_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_riki_backstab_custom:GetModifierPreAttack_BonusDamage(params)
    if not IsServer() then return end
    if not params.target then return end
    if self:GetParent():IsIllusion() then return end
    if self:GetParent():HasModifier("modifier_riki_4") then return end
    local forwardVector = params.target:GetForwardVector()
	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
	local reverseEnemyVector = (params.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
	local difference = math.abs(forwardAngle - reverseEnemyAngle)
	if (difference <= (110 / 1)) or (difference >= (360 - (110 / 1))) or (difference <= (70)) or (difference >= (360 - (70))) then
        self:GetCaster():AddActivityModifier("backstab")
        return self:GetAbility():GetBonusDamage()
    else
        self:GetCaster():ClearActivityModifiers()
    end
end

function modifier_riki_backstab_custom:GetBonusDamage()
    local damage_multiplier = self:GetAbility():GetSpecialValueFor("damage_multiplier")
    if self:GetCaster():HasModifier("modifier_riki_13") then
        damage_multiplier = damage_multiplier + self:GetAbility().modifier_riki_13[self:GetCaster():GetTalentLevel("modifier_riki_13")]
    end
    return self:GetCaster():GetAgility() * damage_multiplier
end

function modifier_riki_backstab_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self:GetParent():HasModifier("modifier_riki_4") then return end
    if not params.target then return end
    local forwardVector = params.target:GetForwardVector()
	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
	local reverseEnemyVector = (params.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
	local difference = math.abs(forwardAngle - reverseEnemyAngle)
	if (difference <= (110 / 1)) or (difference >= (360 - (110 / 1))) or (difference <= (70)) or (difference >= (360 - (70))) then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_backstab.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
        ParticleManager:SetParticleControlEnt(particle, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
        params.target:EmitSound("Hero_Riki.Backstab")
    end
end