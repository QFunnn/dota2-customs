--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_muerta_gunslinger_custom", "heroes/npc_dota_hero_muerta_custom/muerta_gunslinger_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_gunslinger_custom_slow", "heroes/npc_dota_hero_muerta_custom/muerta_gunslinger_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

muerta_gunslinger_custom = class({})

function muerta_gunslinger_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf", context )
end

muerta_gunslinger_custom.modifier_muerta_8 = {3,6,9}
muerta_gunslinger_custom.modifier_muerta_10 = {-15,-30}
muerta_gunslinger_custom.modifier_muerta_10_as = {15,30}
muerta_gunslinger_custom.modifier_muerta_10_duration = 0.5
muerta_gunslinger_custom.modifier_muerta_12 = 5

function muerta_gunslinger_custom:GetIntrinsicModifierName()
	return "modifier_muerta_gunslinger_custom"
end

modifier_muerta_gunslinger_custom = class({})

function modifier_muerta_gunslinger_custom:IsHidden() return true end
function modifier_muerta_gunslinger_custom:IsPurgable() return false end

function modifier_muerta_gunslinger_custom:OnCreated()
	if not IsServer() then return end
	self.double_shot_chance = self:GetAbility():GetSpecialValueFor("double_shot_chance")
	self.target_search_bonus_range = self:GetAbility():GetSpecialValueFor("target_search_bonus_range")
	self.double_attack = false
end

function modifier_muerta_gunslinger_custom:OnRefresh()
	if not IsServer() then return end
	self.double_shot_chance = self:GetAbility():GetSpecialValueFor("double_shot_chance")
	self.target_search_bonus_range = self:GetAbility():GetSpecialValueFor("target_search_bonus_range")
end

function modifier_muerta_gunslinger_custom:DeclareFunctions()
	return 
	{
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		 
	}
end

function modifier_muerta_gunslinger_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if not params.no_attack_cooldown then return end
	if self:GetCaster():HasModifier("modifier_muerta_10") then
		params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_gunslinger_custom_slow", {duration = self:GetAbility().modifier_muerta_10_duration})
	end
	if self:GetCaster():HasModifier("modifier_muerta_12") then
        local target = params.target
        if target:HasModifier("modifier_generic_knockback_lua") then return end
        if target:HasModifier("modifier_generic_arc_lua") then return end
        if target:IsCurrentlyVerticalMotionControlled() then return end
        if target:IsCurrentlyHorizontalMotionControlled() then return end
        local direction = (params.target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
        if params.target:IsRangedAttacker() then
			direction = (self:GetCaster():GetAbsOrigin() - params.target:GetAbsOrigin()):Normalized()
		end
		local direction = (params.target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
        params.target:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_generic_knockback_lua", { duration = 0.1, distance = self:GetAbility().modifier_muerta_12, height = 10, direction_x = direction.x, direction_y = direction.y})
	end
end

function modifier_muerta_gunslinger_custom:OnAttackStart(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if params.no_attack_cooldown then return end

	self.double_attack = false

	local bonus_chance = 0

	if self:GetCaster():HasModifier("modifier_muerta_8") then
		bonus_chance = self:GetAbility().modifier_muerta_8[self:GetCaster():GetTalentLevel("modifier_muerta_8")]
	end

	if RollPercentage(self.double_shot_chance + bonus_chance) then
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(particle)
		self.double_attack = true
	end
end

function modifier_muerta_gunslinger_custom:OnAttack(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if params.no_attack_cooldown then return end
	if not self.double_attack then return end

	local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange() + self:GetAbility():GetSpecialValueFor("target_search_bonus_range"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false)
	local creeps = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange() + self:GetAbility():GetSpecialValueFor("target_search_bonus_range"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false)

	for i = #heroes, 1, -1 do
        if heroes[i] ~= nil and (heroes[i] == params.target) then
            table.remove(heroes, i)
        end
    end

    for i = #creeps, 1, -1 do
        if creeps[i] ~= nil and (creeps[i] == params.target or creeps[i]:GetUnitName() == "npc_dota_bounty_hunter_gold_bag" or creeps[i]:GetUnitName() == "npc_dota_spirit_breaker_light") then
            table.remove(creeps, i)
        end
    end

	local heroes_has = false
	local creep_has = false

	if #heroes > 0 then
		heroes_has = true
	end

	if #creeps > 0 then
		creep_has = true
	end

	if heroes_has then
		self:AttackTarget(heroes[1])
	elseif creep_has then
		self:AttackTarget(creeps[1])
	else
		self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_3)
		self:AttackTarget(params.target)
	end

	self.double_attack = false
end

function modifier_muerta_gunslinger_custom:AttackTarget(target)
	if not IsServer() then return end
	self:GetCaster():PerformAttack(target, true, true, true, false, true, false, false)
end

modifier_muerta_gunslinger_custom_slow = class({})

function modifier_muerta_gunslinger_custom_slow:GetTexture() return "muearta_10" end

function modifier_muerta_gunslinger_custom_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
	}
end

function modifier_muerta_gunslinger_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility().modifier_muerta_10[self:GetCaster():GetTalentLevel("modifier_muerta_10")]
end

function modifier_muerta_gunslinger_custom_slow:GetModifierAttackSpeedPercentage()
	return self:GetAbility().modifier_muerta_10[self:GetCaster():GetTalentLevel("modifier_muerta_10")]
end