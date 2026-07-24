--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_1=class({})

function modifier_chaos_knight_1:IsHidden() return true end
function modifier_chaos_knight_1:IsPurgable() return false end
function modifier_chaos_knight_1:IsPurgeException() return false end
function modifier_chaos_knight_1:RemoveOnDeath() return false end

function modifier_chaos_knight_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_chaos_knight_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chaos_knight_1:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    local damage = self:GetParent():GetAverageTrueAttackDamage(nil) / 100 * 8
    ApplyDamage({victim = params.attacker, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION})
end