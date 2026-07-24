--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostivus2018_weaver_geminate_attack_custom", "heroes/hero_weaver/frostivus2018_weaver_geminate_attack_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostivus2018_weaver_geminate_attack_custom_dmg", "heroes/hero_weaver/frostivus2018_weaver_geminate_attack_custom", LUA_MODIFIER_MOTION_NONE)

frostivus2018_weaver_geminate_attack_custom = class({})

function frostivus2018_weaver_geminate_attack_custom:GetIntrinsicModifierName()
	return "modifier_frostivus2018_weaver_geminate_attack_custom"
end

modifier_frostivus2018_weaver_geminate_attack_custom = class({})

function modifier_frostivus2018_weaver_geminate_attack_custom:IsHidden() return true end
function modifier_frostivus2018_weaver_geminate_attack_custom:IsPurgable() return false end

function modifier_frostivus2018_weaver_geminate_attack_custom:AttackModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.attacker:IsIllusion() then return end
	if params.target == self:GetParent() then return end
	if not self:GetAbility():IsFullyCastable() then return end
	if self:GetParent():PassivesDisabled() then return end
	if params.no_attack_cooldown then return end

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetParent():Script_GetAttackRange() + self:GetAbility():GetSpecialValueFor("bonus_range"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
	local attacks = 0

	for i, enemy in pairs(enemies) do
		if attacks >= self:GetAbility():GetSpecialValueFor("arrow_count") then break end
		attacks = attacks + 1
		Timers:CreateTimer(0.07 * i, function()
			if enemy and not enemy:IsNull() and enemy:IsAlive() and not enemy:IsAttackImmune() and not enemy:IsInvulnerable() then
				local damage_modifier = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_frostivus2018_weaver_geminate_attack_custom_dmg", {})
				self:GetParent()._dont_stop_attack_flag = true
                self:GetParent():PerformAttack(enemy, true, true, true, false, true, false, false) 
				self:GetParent()._dont_stop_attack_flag = nil
                if enemy:HasModifier("modifier_shukuchi_geminate_attack_mark") then
					self:GetParent()._dont_stop_attack_flag = true
                    self:GetParent():PerformAttack(enemy, true, true, true, false, true, false, false) 
					self:GetParent()._dont_stop_attack_flag = nil
                end
                if damage_modifier then
                    damage_modifier:Destroy()
                end
			end
		end)
	end

	if self:GetCaster():HasTalent("special_bonus_unique_weaver_5") then
		local attacks = 0
		for i, enemy in pairs(enemies) do
			if attacks >= self:GetAbility():GetSpecialValueFor("arrow_count") then break end
			attacks = attacks + 1
			Timers:CreateTimer(0.07 * i, function()
				if enemy and not enemy:IsNull() and enemy:IsAlive() and not enemy:IsAttackImmune() and not enemy:IsInvulnerable() then
                    local damage_modifier = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_frostivus2018_weaver_geminate_attack_custom_dmg", {})
					self:GetParent()._dont_stop_attack_flag = true
					self:GetParent():PerformAttack(enemy, true, true, true, false, true, false, false) 
					self:GetParent()._dont_stop_attack_flag = nil
					if enemy:HasModifier("modifier_shukuchi_geminate_attack_mark") then
						self:GetParent()._dont_stop_attack_flag = true
						self:GetParent():PerformAttack(enemy, true, true, true, false, true, false, false) 
						self:GetParent()._dont_stop_attack_flag = nil
					end
                    if damage_modifier then
                        damage_modifier:Destroy()
                    end
				end
			end)
		end
	end

	self:GetAbility():UseResources(false, false, false, true)
end

modifier_frostivus2018_weaver_geminate_attack_custom_dmg = class({})
function modifier_frostivus2018_weaver_geminate_attack_custom_dmg:IsHidden() return true end
function modifier_frostivus2018_weaver_geminate_attack_custom_dmg:IsPurgable() return false end
function modifier_frostivus2018_weaver_geminate_attack_custom_dmg:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end
function modifier_frostivus2018_weaver_geminate_attack_custom_dmg:GetModifierPreAttack_BonusDamage(params)
    if IsClient() then return 0 end
    local bonus = self:GetAbility():GetSpecialValueFor("bonus_damage")
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "weaver_geminate_attack", DAMAGE_TYPE_PHYSICAL)
    end
    return bonus
end