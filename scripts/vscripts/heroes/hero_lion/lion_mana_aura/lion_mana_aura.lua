--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


lion_mana_aura = class({})
LinkLuaModifier("modifier_lion_mana_aura", "heroes/hero_lion/lion_mana_aura/lion_mana_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aura_slow", "heroes/hero_lion/lion_mana_aura/lion_mana_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aura_slow_effect", "heroes/hero_lion/lion_mana_aura/lion_mana_aura", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
function lion_mana_aura:GetIntrinsicModifierName()
	return "modifier_lion_mana_aura"
end

modifier_lion_mana_aura = class({})

--------------------------------------------------------------------------------
function modifier_lion_mana_aura:IsHidden()
	return true
end

function modifier_lion_mana_aura:IsPurgable()
	return false
end

function modifier_lion_mana_aura:OnCreated(kv)
	self.caster = self:GetCaster()
	self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
	self.mana_loss = self:GetAbility():GetSpecialValueFor("mana_loss")
	self.aura_mana_loss_interval = self:GetAbility():GetSpecialValueFor("aura_mana_loss_interval")
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	if not self:GetCaster():HasModifier("modifier_aura_slow") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_aura_slow", {})
	end
	self:StartIntervalThink(self.aura_mana_loss_interval)
end

function modifier_lion_mana_aura:OnRefresh(kv)
	self.caster = self:GetCaster()
	self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
	self.mana_loss = self:GetAbility():GetSpecialValueFor("mana_loss")
	self.aura_mana_loss_interval = self:GetAbility():GetSpecialValueFor("aura_mana_loss_interval")
	self.slow = self:GetAbility():GetSpecialValueFor("slow")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_lion_2")
	if abil ~= nil and abil:GetLevel() > 0 then
		self.mana_loss = self.mana_loss + 6
	end
end

function modifier_lion_mana_aura:OnIntervalThink()
	self:OnRefresh()
	if not IsServer() then
		return
	end
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster(),
		self.aura_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if #enemies > 0 then
		for _, unit in pairs(enemies) do
			if unit:GetMana() >= self.mana_loss then
				local abil = self:GetCaster():FindAbilityByName("special_bonus_lion_3")
				if abil ~= nil and abil:GetLevel() > 0 then
					local damageTable = {
						victim = unit,
						attacker = self:GetCaster(),
						damage = self.mana_loss / 10,
						damage_type = DAMAGE_TYPE_MAGICAL,
						ability = self:GetAbility(), --Optional.
					}
					ApplyDamage(damageTable)
				end

				unit:Script_ReduceMana(self.mana_loss / 10, nil)
				if self.caster:GetMana() < self.caster:GetMaxMana() then
					self.caster:SetMana(self.caster:GetMana() + (self.mana_loss / 10) * #enemies)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_aura_slow = class({})

function modifier_aura_slow:IsDebuff()
	return false
end
function modifier_aura_slow:AllowIllusionDuplicate()
	return true
end
function modifier_aura_slow:IsHidden()
	return true
end
function modifier_aura_slow:IsPurgable()
	return false
end

function modifier_aura_slow:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("aura_radius")
	end
end

function modifier_aura_slow:GetAuraEntityReject(target)
	return false
end

function modifier_aura_slow:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_aura_slow:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_aura_slow:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_aura_slow:GetModifierAura()
	return "modifier_aura_slow_effect"
end

function modifier_aura_slow:IsAura()
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
modifier_aura_slow_effect = class({})

function modifier_aura_slow_effect:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end
end

function modifier_aura_slow_effect:IsHidden()
	return false
end
function modifier_aura_slow_effect:IsPurgable()
	return false
end
function modifier_aura_slow_effect:IsDebuff()
	return true
end

function modifier_aura_slow_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_aura_slow_effect:GetModifierMoveSpeedBonus_Percentage()
	local abil = self:GetCaster():FindAbilityByName("special_bonus_lion_5")
	if abil ~= nil and abil:GetLevel() > 0 then
		return (self:GetAbility():GetSpecialValueFor("slow") + 10) * -1
	end
	return self:GetAbility():GetSpecialValueFor("slow") * -1
end