--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_gold_bonus = class({})

function modifier_gold_bonus:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_gold_bonus:IsPurgable()
	return false
end
function modifier_gold_bonus:RemoveOnDeath()
	return false
end

if IsClient() then
	return
end

function modifier_gold_bonus:OnCreated(kv)
	self.parent_id = self:GetParent():GetPlayerOwnerID()

	self.gold = kv.gold
	self:SetStackCount(self.gold)

	self.total_time = 300
	self.gold_per_operation = 20

	local tick_duration = self.total_time / kv.gold * self.gold_per_operation
	self:StartIntervalThink(tick_duration)
end

function modifier_gold_bonus:OnIntervalThink()
	if GameRules:State_Get() < DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		return
	end

	self.gold = self.gold - self.gold_per_operation
	self:SetStackCount(self.gold)

	PlayerResource:ModifyGold(self.parent_id, self.gold_per_operation, true, DOTA_ModifyGold_GameTick)

	if self.gold <= 0 then
		self:Destroy()
	end
end