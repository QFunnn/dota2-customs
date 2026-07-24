--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_antimage_18=class({})

function modifier_antimage_18:IsHidden() return true end
function modifier_antimage_18:IsPurgable() return false end
function modifier_antimage_18:IsPurgeException() return false end
function modifier_antimage_18:RemoveOnDeath() return false end

function modifier_antimage_18:OnCreated()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self.reduce = 0
	self.reduce_bonus = {-5,-10,-15}
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_antimage_18:OnRefresh()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_antimage_18:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():GetMana() == self:GetParent():GetMaxMana() then
		self.reduce = self.reduce_bonus[self:GetStackCount()]
	else
		self.reduce = 0
	end
end

function modifier_antimage_18:DeclareFunctions()
	return
	{	
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_antimage_18:GetModifierIncomingDamage_Percentage(params)
	if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK  then
		return self.reduce
	end
end


function modifier_antimage_18:GetModifierAttackSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end