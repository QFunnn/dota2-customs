--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_muerta_gunslinger_custom", "abilities/muerta_gunslinger_custom", LUA_MODIFIER_MOTION_NONE)

muerta_gunslinger_custom = class({})

function muerta_gunslinger_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf", context )
end

function muerta_gunslinger_custom:GetIntrinsicModifierName()
	return "modifier_muerta_gunslinger_custom"
end

modifier_muerta_gunslinger_custom = class({})
function modifier_muerta_gunslinger_custom:IsHidden() return true end
function modifier_muerta_gunslinger_custom:IsPurgable() return false end
function modifier_muerta_gunslinger_custom:AllowIllusionDuplicate() return false end

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

function modifier_muerta_gunslinger_custom:AttackStartModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if params.no_attack_cooldown then return end
	self.double_attack = false
	local bonus_chance = 0
	if RollPercentage(self.double_shot_chance + bonus_chance) then
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(particle)
		self.double_attack = true
	end
end

function modifier_muerta_gunslinger_custom:AttackModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if params.no_attack_cooldown then return end
	if not self.double_attack then return end
    if self:GetParent():IsIllusion() then return end
	local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange() + self:GetAbility():GetSpecialValueFor("target_search_bonus_range"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false)
	local creeps = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange() + self:GetAbility():GetSpecialValueFor("target_search_bonus_range"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false)

	for i = #heroes, 1, -1 do
        if heroes[i] ~= nil and (heroes[i] == params.target) then
            table.remove(heroes, i)
        end
    end

    for i = #creeps, 1, -1 do
        if creeps[i] ~= nil and (creeps[i] == params.target) then
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
		self:AttackTarget(params.target)
	end

	self.double_attack = false
end

function modifier_muerta_gunslinger_custom:AttackTarget(target)
	if not IsServer() then return end
	self:GetCaster():PerformAttack(target, true, true, true, false, true, false, false)
end