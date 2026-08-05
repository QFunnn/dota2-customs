--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kisame_samehada_hunger", "heroes/akatsuki/kisame", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kisame_magic_resist_debuff", "heroes/akatsuki/kisame", LUA_MODIFIER_MOTION_NONE)

kisame_samehada_hunger = class({})

function kisame_samehada_hunger:GetIntrinsicModifierName()
	return "modifier_kisame_samehada_hunger"
end

---------------------------------------------------------------------------

modifier_kisame_samehada_hunger = class({})

function modifier_kisame_samehada_hunger:IsHidden()
	return true
end
function modifier_kisame_samehada_hunger:IsPurgable()
	return false
end
function modifier_kisame_samehada_hunger:IsPermanent()
	return true
end

function modifier_kisame_samehada_hunger:OnCreated()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
	self:StartIntervalThink(1.0)
end

function modifier_kisame_samehada_hunger:OnRefresh()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
end

function modifier_kisame_samehada_hunger:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
		self:_RefreshValues()
	end
end

function modifier_kisame_samehada_hunger:_RefreshValues()
	local ab = self:GetAbility()
	self._burn_pct = ab:GetSpecialValueFor("mana_burn_pct_base") / 100
	self._debuff_dur = ab:GetSpecialValueFor("debuff_duration")
end

function modifier_kisame_samehada_hunger:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_kisame_samehada_hunger:OnAttackLanded(data)
	if not IsServer() then
		return
	end
	if data.attacker ~= self:GetParent() then
		return
	end
	local target = data.target
	if not target or target:IsNull() or not target:IsAlive() then
		return
	end

	local caster = self:GetParent()
	local burn_amount = caster:GetAverageTrueAttackDamage(caster) * self._burn_pct
	local actual_burn = math.min(target:GetMana(), burn_amount)
	if actual_burn <= 0 then
		return
	end

	target:Script_ReduceMana(actual_burn, nil)

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = actual_burn,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})

	target:AddNewModifier(
		caster,
		self:GetAbility(),
		"modifier_kisame_magic_resist_debuff",
		{ duration = self._debuff_dur }
	)
end

---------------------------------------------------------------------------

modifier_kisame_magic_resist_debuff = class({})

function modifier_kisame_magic_resist_debuff:IsHidden()
	return false
end
function modifier_kisame_magic_resist_debuff:IsDebuff()
	return true
end
function modifier_kisame_magic_resist_debuff:IsPurgable()
	return true
end

function modifier_kisame_magic_resist_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end

function modifier_kisame_magic_resist_debuff:GetModifierMagicalResistanceBonus()
	return -self:GetAbility():GetSpecialValueFor("magic_resist_reduction")
end