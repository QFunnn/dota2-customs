--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_anchor_smash_lua = class({})

function modifier_anchor_smash_lua:IsHidden() return true end
function modifier_anchor_smash_lua:IsPurgable() return false end

if not IsServer() then return end

function modifier_anchor_smash_lua:OnCreated()
	self.ability = self:GetAbility()

	self.parent = self:GetParent()

	self.bonus_damage = self.ability:GetSpecialValueFor("attack_damage")
	self.talent_chance = self.ability:GetSpecialValueFor("attack_chance")
end

function modifier_anchor_smash_lua:OnRefresh()
	self:OnCreated()
end

function modifier_anchor_smash_lua:GetModifierProcAttack_Feedback(keys)
	if not self.ability or self.ability:IsNull() then return end
	
	if keys.no_attack_cooldown then return end

	if RollPseudoRandomPercentage(self.talent_chance, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, self.parent) then
		self.ability:OnSpellStart("talent")
	end
end

function modifier_anchor_smash_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_anchor_smash_lua:GetModifierPreAttack_BonusDamage(params)
	if self.parent.anchor_attack or self.parent.anchor_attack_talent then
		if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
			_G.Players:QueueAttackBonus(params.attacker, params.target, self.bonus_damage, "tidehunter_anchor_smash", DAMAGE_TYPE_PHYSICAL)
		end
		return self.bonus_damage
	end
end