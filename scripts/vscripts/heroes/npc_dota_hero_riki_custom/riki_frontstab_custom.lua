--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_riki_frontstab_custom", "heroes/npc_dota_hero_riki_custom/riki_frontstab_custom", LUA_MODIFIER_MOTION_NONE)

riki_frontstab_custom = class({})

function riki_frontstab_custom:GetIntrinsicModifierName()
    return "modifier_riki_frontstab_custom"
end

modifier_riki_frontstab_custom = class({})
function modifier_riki_frontstab_custom:IsHidden() return true end
function modifier_riki_frontstab_custom:IsPurgable() return false end
function modifier_riki_frontstab_custom:IsPurgeException() return false end
function modifier_riki_frontstab_custom:RemoveOnDeath() return false end
function modifier_riki_frontstab_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_riki_frontstab_custom:GetModifierPreAttack_BonusDamage(params)
    if not IsServer() then return end
    if not params.target then return end
    if self:GetParent():IsIllusion() then return end
    local forwardVector = params.target:GetForwardVector()
	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
	local reverseEnemyVector = (params.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
	local difference = math.abs(forwardAngle - reverseEnemyAngle)
	if (difference >= 120) and (difference <= 260) then
        return self:GetCaster():GetStrength() * self:GetAbility():GetSpecialValueFor("damage_multiplier")
    end
end

function modifier_riki_frontstab_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not params.target then return end
    local forwardVector = params.target:GetForwardVector()
	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
	local reverseEnemyVector = (params.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
	local difference = math.abs(forwardAngle - reverseEnemyAngle)
	if (difference >= 120) and (difference <= 260) then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_backstab.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
        ParticleManager:SetParticleControlEnt(particle, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
        params.target:EmitSound("Hero_Riki.Backstab")
    end
end