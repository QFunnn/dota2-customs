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

function modifier_anchor_smash_lua:AllowIllusionDuplicate()
	return false
end

function modifier_anchor_smash_lua:OnCreated()
	-- self.ability = self:GetAbility()

	-- self.parent = self:GetParent()

	self.bonus_damage = self:GetAbility():GetSpecialValueFor("attack_damage")
	self.talent_chance = self:GetAbility():GetSpecialValueFor("attack_active_chance")

	if IsServer() then
		self.units = {}
		self.LastTime = GameRules:GetGameTime()
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_anchor_smash_lua:OnRefresh()
	-- self:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("attack_damage")
	self.talent_chance = self:GetAbility():GetSpecialValueFor("attack_active_chance")
end

function modifier_anchor_smash_lua:OnIntervalThink()
	local hParent = self:GetParent()
	local attack_done = false
	for i = #self.units, 1, -1 do
		local unit = self.units[i]
		if IsValid(unit) and unit:IsAlive() then
			if not attack_done then
				hParent.anchor_attack = true
				hParent:Attack(unit, ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NO_EXTENDATTACK + ATTACK_STATE_SKIPCOUNTING)
				attack_done = true
				hParent.anchor_attack = false
				table.remove(self.units, i)
			end
		else
			table.remove(self.units, i)
		end
	end
end

function modifier_anchor_smash_lua:OnAttackLanded(params)
	local hParent = self:GetParent()
	if IsServer() then
		if not IsValid(self:GetAbility()) then return end
		if hParent ~= params.attacker or params.no_attack_cooldown then
			return
		end

		if GameRules:GetGameTime() < self.LastTime + 0.8 then
			return
		end

		local chance = self:GetAbility():GetSpecialValueFor("attack_active_chance")
		if not hParent:AttackFilter(params.record, ATTACK_STATE_NOT_PROCESSPROCS, ATTACK_STATE_NO_EXTENDATTACK) then
			if RollPercentage(chance) then
				self.LastTime = GameRules:GetGameTime()
				self:GetAbility():OnSpellStart()
				-- self.talent_active = false
			end
		end
	end
end

function modifier_anchor_smash_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end
function modifier_anchor_smash_lua:GetModifierPreAttack_BonusDamage()
	if self:GetParent().anchor_attack then return self.bonus_damage end
end