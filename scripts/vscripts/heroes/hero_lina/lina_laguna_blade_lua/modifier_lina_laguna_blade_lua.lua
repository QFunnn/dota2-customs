--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_lina_laguna_blade_lua = class({})

function modifier_lina_laguna_blade_lua:IsHidden()
	return true
end

function modifier_lina_laguna_blade_lua:IsPurgable()
	return false
end

function modifier_lina_laguna_blade_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_lina_laguna_blade_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	self.type = DAMAGE_TYPE_MAGICAL
end

function modifier_lina_laguna_blade_lua:OnRefresh(kv) end

function modifier_lina_laguna_blade_lua:OnRemoved() end

function modifier_lina_laguna_blade_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self:GetParent():IsInvulnerable() then
		return
	end
	if self:GetParent():IsMagicImmune() and (not self:GetCaster():HasScepter()) then
		return
	end
	if self:GetParent():TriggerSpellAbsorb(self:GetAbility()) then
		return
	end
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self.type,
		ability = self:GetAbility(),
	}
	ApplyDamage(damageTable)
end