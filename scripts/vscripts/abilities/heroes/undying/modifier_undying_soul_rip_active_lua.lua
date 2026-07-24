--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_soul_rip_active_lua = modifier_undying_soul_rip_active_lua or class({})


function modifier_undying_soul_rip_active_lua:IsPurgable() return false end
function modifier_undying_soul_rip_active_lua:IsHidden() return false end
function modifier_undying_soul_rip_active_lua:GetTexture() return "undying_soul_rip" end
function modifier_undying_soul_rip_active_lua:GetEffectName() return "particles/units/heroes/hero_undying/soul_rip_buff.vpcf" end


function modifier_undying_soul_rip_active_lua:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self:OnRefresh()
end


function modifier_undying_soul_rip_active_lua:OnRefresh()
	self.strength_share_model_scale = self.ability:GetSpecialValueFor("strength_share_model_scale")
	self.strength_share_percent = self.ability:GetSpecialValueFor("strength_share_percent") / 100
	self.strength_bonus = self.caster:GetStrength() * self.strength_share_percent
end


function modifier_undying_soul_rip_active_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, -- GetModifierBonusStats_Strength
		MODIFIER_PROPERTY_MODEL_SCALE, -- GetModifierModelScale
	}
end


function modifier_undying_soul_rip_active_lua:GetModifierBonusStats_Strength() return self.strength_bonus end
function modifier_undying_soul_rip_active_lua:GetModifierModelScale() return self.strength_share_model_scale end