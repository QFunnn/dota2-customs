--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tidehunter_14=class({})

function modifier_tidehunter_14:IsHidden() return true end
function modifier_tidehunter_14:IsPurgable() return false end
function modifier_tidehunter_14:IsPurgeException() return false end
function modifier_tidehunter_14:RemoveOnDeath() return false end

function modifier_tidehunter_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_tidehunter_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tidehunter_14:DeclareFunctions()
	return {
		 
	}
end

function modifier_tidehunter_14:OnAttackLanded(params)
	if params.attacker ~= self:GetParent() then return end
	if params.no_attack_cooldown then return end
	if params.no_cooldown_attack then return end
	if RollPercentage(28) then
		local tidehunter_anchor_smash_custom = self:GetParent():FindAbilityByName("tidehunter_anchor_smash_custom")
		if tidehunter_anchor_smash_custom and tidehunter_anchor_smash_custom:GetLevel() > 0 then
			tidehunter_anchor_smash_custom:OnSpellStart()
		end
	end
end