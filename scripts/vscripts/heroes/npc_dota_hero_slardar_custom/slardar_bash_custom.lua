--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slardar_bash_custom", "heroes/npc_dota_hero_slardar_custom/slardar_bash_custom", LUA_MODIFIER_MOTION_NONE )

slardar_bash_custom = class({})

slardar_bash_custom.modifier_slardar_8 = {150,450}
slardar_bash_custom.modifier_slardar_14 = -1
slardar_bash_custom.modifier_slardar_20 = {70,140,210}

function slardar_bash_custom:GetIntrinsicModifierName()
	return "modifier_slardar_bash_custom"
end

modifier_slardar_bash_custom = class({})

function modifier_slardar_bash_custom:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_slardar_bash_custom:IsPurgable()
	return false
end

function modifier_slardar_bash_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_slardar_bash_custom:GetModifierProcAttack_BonusDamage_Physical(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.attacker:IsIllusion() then return end
	if params.attacker:PassivesDisabled() then return end
	if params.target:IsWard() then return end
	if self:GetParent():HasModifier("modifier_item_diffusal_basher") then return end
 
	self:IncrementStackCount()

	local damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	local duration = self:GetAbility():GetSpecialValueFor("duration") 
	local attack_count = self:GetAbility():GetSpecialValueFor("attack_count")

	if self:GetCaster():HasModifier("modifier_slardar_20") then
		damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_slardar_20[self:GetCaster():GetTalentLevel("modifier_slardar_20")])
	end

	if self:GetCaster():HasModifier("modifier_slardar_14") then
		attack_count = attack_count + self:GetAbility().modifier_slardar_14
	end

	if self:GetStackCount() > attack_count then
		self:SetStackCount(0)
		params.target :EmitSound("Hero_Slardar.Bash")
		params.target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_bashed", { duration = duration * (1 - params.target:GetStatusResistance()) })
		if self:GetCaster():HasModifier("modifier_slardar_8") then
			local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), params.target:GetOrigin(), nil, self:GetAbility().modifier_slardar_8[self:GetCaster():GetTalentLevel("modifier_slardar_8")], DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false )
			for _,enemy in pairs(enemies) do
				if enemy ~= params.target then
                    local mult = 1
                    if not enemy:IsHero() then
                        mult = 2
                    end
					ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage * mult, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = nil })
					enemy:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_bashed", { duration = duration * (1 - enemy:GetStatusResistance()) })
				end
			end
		end
    	return damage
	end
end