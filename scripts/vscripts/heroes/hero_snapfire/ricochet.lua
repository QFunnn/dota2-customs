--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_snapfire_ricochet", "heroes/hero_snapfire/ricochet.lua", LUA_MODIFIER_MOTION_NONE )

if ability_snapfire_ricochet == nil then
	ability_snapfire_ricochet = class({})
end

function ability_snapfire_ricochet:GetIntrinsicModifierName()
	return "modifier_ability_snapfire_ricochet"
end

modifier_ability_snapfire_ricochet = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        }
    end,
})

function modifier_ability_snapfire_ricochet:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.Targets = ability:GetSpecialValueFor("targets")
		self.DamagePct = ability:GetSpecialValueFor("damage")
	end
end

function modifier_ability_snapfire_ricochet:AttackModifier(event)
	local attacker = event.attacker
	local parent = self:GetParent()
	local target = event.target
	
	if target and parent == attacker and not event.no_attack_cooldown then
		local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(), 
			target:GetAbsOrigin(),
			nil, 
			parent:Script_GetAttackRange() + 100, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 
			FIND_CLOSEST,
			false
		)
		
		local target_number = 0
		
		for _, enemy in ipairs(enemies) do
			if enemy ~= target then
				self.ricochet_target = true
				
				self:GetParent():PerformAttack(enemy, true, true, true, true, true, false, false)
				
				self.ricochet_target = false
				
				target_number = target_number + 1
				
				if target_number >= self.Targets then
					break
				end
			end
		end
	end
end

function modifier_ability_snapfire_ricochet:GetModifierDamageOutgoing_Percentage(event)
	if not IsServer() then return end
	
	if self.ricochet_target == true then
		return self.DamagePct-100
	else
		return 0
	end
end