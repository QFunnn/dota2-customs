--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pudge_innate_graft_flesh_custom", "heroes/npc_dota_hero_pudge_custom/pudge_innate_graft_flesh_custom", LUA_MODIFIER_MOTION_NONE)

pudge_innate_graft_flesh_custom = class({})

function pudge_innate_graft_flesh_custom:GetIntrinsicModifierName()
	return "modifier_pudge_innate_graft_flesh_custom"
end

modifier_pudge_innate_graft_flesh_custom = class({})
function modifier_pudge_innate_graft_flesh_custom:IsPurgable() return false end
function modifier_pudge_innate_graft_flesh_custom:IsPurgeException() return false end
function modifier_pudge_innate_graft_flesh_custom:RemoveOnDeath() return false end

function modifier_pudge_innate_graft_flesh_custom:OnDeath(params)
	local target = params.unit
	if self:GetCaster():GetTeamNumber() == target:GetTeamNumber() then return end
	if target:IsReincarnating() then return end
	if not self:GetCaster():IsRealHero() then return end
	if not target:IsRealHero() then return end
	if self:GetParent():HasModifier("modifier_wodarelax") then return end
	if ((self:GetCaster():GetAbsOrigin() - target:GetAbsOrigin()):Length2D() <= self:GetAbility():GetSpecialValueFor("flesh_heap_range")) or (params.attacker and params.attacker == self:GetParent()) then
		self:SetStackCount(self:GetStackCount() + 1)
        self:GetCaster():CalculateStatBonus(true)
		local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_fleshheap_count.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end

function modifier_pudge_innate_graft_flesh_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_pudge_innate_graft_flesh_custom:GetModifierBonusStats_Strength()
	if self:GetCaster():HasModifier("modifier_pudge_13") then return end
	if self:GetCaster():HasModifier("modifier_pudge_20") then return end
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("flesh_heap_strength_buff_amount")
end

function modifier_pudge_innate_graft_flesh_custom:GetModifierBonusStats_Agility()
	if not self:GetCaster():HasModifier("modifier_pudge_13") then return end
	if self:GetCaster():HasModifier("modifier_pudge_20") then return end
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("flesh_heap_strength_buff_amount")
end

function modifier_pudge_innate_graft_flesh_custom:GetModifierBonusStats_Intellect()
	if not self:GetCaster():HasModifier("modifier_pudge_20") then return end
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("flesh_heap_strength_buff_amount")
end