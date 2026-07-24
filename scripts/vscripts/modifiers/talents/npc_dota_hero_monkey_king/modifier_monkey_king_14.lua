--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_14=class({})

function modifier_monkey_king_14:IsHidden() return true end
function modifier_monkey_king_14:IsPurgable() return false end
function modifier_monkey_king_14:IsPurgeException() return false end
function modifier_monkey_king_14:RemoveOnDeath() return false end

function modifier_monkey_king_14:OnCreated()
	if not IsServer() then return end
    self.critProc = false
	self:SetStackCount(1)
end

function modifier_monkey_king_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_monkey_king_14:OnCreated()
    if not IsServer() then return end
    self.critProc = false
end

function modifier_monkey_king_14:DeclareFunctions()
    return  
    {
        MODIFIER_EVENT_ON_ATTACK_RECORD,
    }
end

function modifier_monkey_king_14:OnAttackRecord(params)
    if not IsServer() then return end
	if params.attacker == self:GetParent() then
		if params.target:IsOther() then return end
		self.critProc = true
		self.chance = 80
        if RollPercentage(100 - self.chance) then
        	self.critProc = false
        end
	end
end

function modifier_monkey_king_14:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker == self:GetParent() then
        if self:GetParent():IsIllusion() then return end
        if self.critProc then
        	local damage = 70
            ApplyDamage({victim = params.target, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
            params.target:EmitSound("DOTA_Item.MKB.melee")
            params.target:EmitSound("DOTA_Item.MKB.Minibash")
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, damage, nil)
        end
    end
end

function modifier_monkey_king_14:CheckState()
	local state = {}
	if self.critProc then
		state = {[MODIFIER_STATE_CANNOT_MISS] = true}
	end
	return state
end