--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pudge_12 = class({})

function modifier_pudge_12:IsHidden() return true end
function modifier_pudge_12:IsPurgable() return false end
function modifier_pudge_12:IsPurgeException() return false end
function modifier_pudge_12:RemoveOnDeath() return false end

function modifier_pudge_12:OnCreated()
	if not IsServer() then return end
	self.critProc = false
	self.chance = {30,60,90}
	self:SetStackCount(1)
end

function modifier_pudge_12:OnRefresh()
	if not IsServer() then return end
	self.chance = {30,60,90}
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_pudge_12:DeclareFunctions()
	return 
	{
        MODIFIER_EVENT_ON_ATTACK_RECORD
	}
end
function modifier_pudge_12:OnAttackRecord(keys)
	if keys.attacker == self:GetParent() then
		if keys.target:IsOther() then
            return nil
        end
        self.critProc = true
        if RollPercentage(100 - self.chance[self:GetStackCount()]) then
        	self.critProc = false
        end
	end
end

function modifier_pudge_12:CheckState()
	local state = {}
	if self.critProc then
		state = {[MODIFIER_STATE_CANNOT_MISS] = true}
	end
	return state
end