--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_shredder_chakram_slow_lua = class({})

function modifier_shredder_chakram_slow_lua:IsHidden() return false end
function modifier_shredder_chakram_slow_lua:IsDebuff() return true end
function modifier_shredder_chakram_slow_lua:IsStunDebuff() return false end
function modifier_shredder_chakram_slow_lua:IsPurgable() return true end

function modifier_shredder_chakram_slow_lua:OnCreated()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		self.slow = 0
		return
	end

	self.slow = ability:GetSpecialValueFor( "slow" )
	self.step = 5
end

function modifier_shredder_chakram_slow_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_shredder_chakram_slow_lua:GetModifierMoveSpeedBonus_Percentage()
	local parent = self:GetParent()
	if not parent or parent:IsNull() then return 0 end
	
	return -math.floor((100 - parent:GetHealthPercent()) / self.step ) * self.slow
end

function modifier_shredder_chakram_slow_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end