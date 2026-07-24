--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_warlord_fervor_custom", "heroes/hero_troll/troll_warlord_fervor", LUA_MODIFIER_MOTION_NONE)

troll_warlord_fervor_custom = class({})

function troll_warlord_fervor_custom:GetIntrinsicModifierName()
	return "modifier_troll_warlord_fervor_custom"
end

modifier_troll_warlord_fervor_custom = class({})

function modifier_troll_warlord_fervor_custom:IsPurgable() return false end
function modifier_troll_warlord_fervor_custom:RemoveOnDeath() return false end
function modifier_troll_warlord_fervor_custom:IsHidden() return false end

function modifier_troll_warlord_fervor_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_troll_warlord_fervor_custom:OnCreated()
	if not IsServer() then return end
	self.current_target = nil
end

function modifier_troll_warlord_fervor_custom:AttackLandedModifier( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end
	if params.no_attack_cooldown then return end
	if self:GetParent():PassivesDisabled() then return end

    if self.current_target ~= nil and self.current_target ~= params.target then
        self:SetStackCount(self:GetStackCount() / 2)
    end

    local max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")

    if self.current_target == params.target then
    	if self:GetStackCount() < max_stacks then
        	self:SetStackCount(self:GetStackCount() + 1)
        end
    end

    if self:GetCaster():HasShard() then
        local chance = self:GetAbility():GetSpecialValueFor("base_chance") + (self:GetStackCount() * self:GetAbility():GetSpecialValueFor("extra_attack_chance_per_stack"))
        local nearby_enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetParent():Script_GetAttackRange() + self:GetAbility():GetSpecialValueFor("range_buffer"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	    if #nearby_enemies > 0 then
            self:GetParent():PerformAttack(nearby_enemies[RandomInt(1, #nearby_enemies)], true, true, true, false, false, false, true)
        end
    end

    self.current_target = params.target
end

function modifier_troll_warlord_fervor_custom:GetModifierAttackSpeedBonus_Constant()
	if self:GetParent():PassivesDisabled() then return end
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("attack_speed")
end