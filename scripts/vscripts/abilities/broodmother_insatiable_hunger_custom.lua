--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_broodmother_insatiable_hunger_custom", "abilities/broodmother_insatiable_hunger_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_broodmother_insatiable_hunger_custom_cooldown", "abilities/broodmother_insatiable_hunger_custom", LUA_MODIFIER_MOTION_NONE)

broodmother_insatiable_hunger_custom = class({})

function broodmother_insatiable_hunger_custom:GetIntrinsicModifierName()
	return "modifier_broodmother_insatiable_hunger_custom"
end

function broodmother_insatiable_hunger_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Broodmother.InsatiableHunger")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_broodmother_insatiable_hunger", {duration = self:GetSpecialValueFor("duration")})
end

modifier_broodmother_insatiable_hunger_custom = class({})
function modifier_broodmother_insatiable_hunger_custom:IsHidden() return true end
function modifier_broodmother_insatiable_hunger_custom:IsPurgable() return false end
function modifier_broodmother_insatiable_hunger_custom:IsPurgeException() return false end
function modifier_broodmother_insatiable_hunger_custom:RemoveOnDeath() return false end

function modifier_broodmother_insatiable_hunger_custom:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.damage_pct = self.ability:GetSpecialValueFor("damage_pct")
end

function modifier_broodmother_insatiable_hunger_custom:OnRefresh()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.damage_pct = self.ability:GetSpecialValueFor("damage_pct")
end

function modifier_broodmother_insatiable_hunger_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_broodmother_insatiable_hunger_custom:GetModifierPreAttack_BonusDamage(params)
	if not IsServer() then return end
	if not self.parent:HasModifier("modifier_broodmother_insatiable_hunger") then return end
	if self.parent:PassivesDisabled() then return end
	if params.target == nil then return end
    if self.parent:HasModifier("modifier_broodmother_insatiable_hunger_custom_cooldown") then return end
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_broodmother_insatiable_hunger_custom_cooldown", {duration = 0.15})
	local roshan_phys_immune_resist = 1
    local roshan_phys_immune = params.target:FindAbilityByName("roshan_phys_immune")
    if roshan_phys_immune then
        roshan_phys_immune_resist = 1 - (roshan_phys_immune:GetSpecialValueFor("phys_immune") / 100)
    end
	local leech = params.target:GetMaxHealth() / 100 * self.damage_pct
	local bonus = leech * roshan_phys_immune_resist
	if _G.Players and _G.Players.QueueAttackBonus then
		_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "broodmother_insatiable_hunger_custom", DAMAGE_TYPE_PHYSICAL)
	end
	return bonus
end

modifier_broodmother_insatiable_hunger_custom_cooldown = class({})
function modifier_broodmother_insatiable_hunger_custom_cooldown:IsHidden() return true end
function modifier_broodmother_insatiable_hunger_custom_cooldown:IsPurgeException() return false end
function modifier_broodmother_insatiable_hunger_custom_cooldown:IsPurgable() return false end