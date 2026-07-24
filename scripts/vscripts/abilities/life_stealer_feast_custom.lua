--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_life_stealer_feast_custom", "abilities/life_stealer_feast_custom", LUA_MODIFIER_MOTION_NONE)

life_stealer_feast_custom = class({})

function life_stealer_feast_custom:GetCooldown(iLevel)
    return self.BaseClass.GetCooldown(self, iLevel) / self:GetCaster():GetCooldownReduction()
end

function life_stealer_feast_custom:GetIntrinsicModifierName()
	return "modifier_life_stealer_feast_custom"
end

modifier_life_stealer_feast_custom = class({})
function modifier_life_stealer_feast_custom:IsHidden() return true end
function modifier_life_stealer_feast_custom:IsPurgable() return false end
function modifier_life_stealer_feast_custom:IsPurgeException() return false end
function modifier_life_stealer_feast_custom:RemoveOnDeath() return false end

function modifier_life_stealer_feast_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.hp_leech_percent = self.ability:GetSpecialValueFor("hp_leech_percent")
    self.hp_damage_percent = self.ability:GetSpecialValueFor("hp_damage_percent")
end

function modifier_life_stealer_feast_custom:OnRefresh()
    self.hp_leech_percent = self.ability:GetSpecialValueFor("hp_leech_percent")
    self.hp_damage_percent = self.ability:GetSpecialValueFor("hp_damage_percent") 
end

function modifier_life_stealer_feast_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_life_stealer_feast_custom:GetModifierPreAttack_BonusDamage(params)
	if not IsServer() then return end
	if params.target == nil then return end
    if params.attacker:PassivesDisabled() then return end
    if not self.ability:IsFullyCastable() then return end
    self.ability:UseResources(false, false, false, true)
	local roshan_phys_immune_resist = 1
    local roshan_phys_immune = params.target:FindAbilityByName("roshan_phys_immune")
    if roshan_phys_immune then
        roshan_phys_immune_resist = 1 - (roshan_phys_immune:GetSpecialValueFor("phys_immune") / 100)
    end
	local leech = params.target:GetMaxHealth() / 100 * self.hp_damage_percent
	local bonus = leech * roshan_phys_immune_resist
	if _G.Players and _G.Players.QueueAttackBonus then
		_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "life_stealer_feast_custom", DAMAGE_TYPE_PHYSICAL)
	end
	return bonus
end

function modifier_life_stealer_feast_custom:TakeDamageScriptModifier( params )
	if not IsServer() then return end
	if params.unit == self.parent then return end
	if params.attacker ~= self.parent then return end
	if params.attacker:PassivesDisabled() then return end
	if params.attacker:IsIllusion() then return end
	if params.no_attack_cooldown then return end
	if params.inflictor ~= nil then return end
	local leech = params.unit:GetMaxHealth() / 100 * self.hp_leech_percent
	self.parent:Heal(leech, self.ability)
end