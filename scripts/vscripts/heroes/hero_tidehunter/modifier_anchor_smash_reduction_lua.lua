--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_anchor_smash_reduction_lua = class({})
function modifier_anchor_smash_reduction_lua:IsHidden()
	return false
end
function modifier_anchor_smash_reduction_lua:IsDebuff()
	return true
end
function modifier_anchor_smash_reduction_lua:IsPurgable()
	return true
end
function modifier_anchor_smash_reduction_lua:IsPurgeException()
	return true
end
function modifier_anchor_smash_reduction_lua:OnCreated()
	self.damage_reduction = self:GetAbilitySpecialValueFor("damage_reduction")
	if IsServer() then
	end
end
function modifier_anchor_smash_reduction_lua:OnRefresh()
	self.damage_reduction = self:GetAbilitySpecialValueFor("damage_reduction")
	if IsServer() then
	end
end
function modifier_anchor_smash_reduction_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_anchor_smash_reduction_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.damage_reduction
end
function modifier_anchor_smash_reduction_lua:OnDeath(params)
	local hCaster = self:GetCaster()
	local hUnit = params.unit
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	if IsServer() then
		if IsValid(hCaster) and IsValid(hParent) and IsValid(hUnit) and hCaster == hAttacker and hParent == hUnit and hParent:IsRealHero() then
			local tBuff = hCaster:FindModifierByName("modifier_tidehunter_kraken_shell")
			if IsValid(tBuff) then
				tBuff:IncrementStackCount()
			end
		end
	end
end