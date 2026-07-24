--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_xpm_gpm = modifier_xpm_gpm or class({})


function modifier_xpm_gpm:IsPurgable() return false end
function modifier_xpm_gpm:RemoveOnDeath() return false end
function modifier_xpm_gpm:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end
function modifier_xpm_gpm:IsHidden() return true end


function modifier_xpm_gpm:OnCreated()
	self.parent = self:GetParent()

	if not IsServer() then return end

	self.base_gpm = 960
	self.base_xpm = 720
	self.interval = 0.5

	local ring_bonuses = TEAMS_LAYOUTS[GetMapName()].ring_bonuses

	self.base_tick_gold = self.base_gpm / 60 * self.interval
	self.base_tick_exp = self.base_xpm / 60 * self.interval

	self.additive_tick_gold = ring_bonuses.gpm / 60 * self.interval
	self.additive_tick_exp = ring_bonuses.xpm / 60 * self.interval

	self:StartIntervalThink(self.interval)
	self:OnIntervalThink()
end


function modifier_xpm_gpm:OnIntervalThink()
	if not self.parent or self.parent:IsNull() then return end
	if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then return end


	local gold = self.base_tick_gold
	local exp = self.base_tick_exp

	if self.parent:HasModifier("modifier_central_ring") then
		gold = gold + self.additive_tick_gold
		exp = exp + self.additive_tick_exp
	end

	if self.parent.gpm_bonus then
		gold = gold + self.parent.gpm_bonus / 60
	end

	-- print("[XPM/GPM] adding", gold, exp, "gold and exp to", self.parent:GetUnitName())

	self.parent:ModifyGold(gold, false, DOTA_ModifyGold_GameTick)
	self.parent:AddExperience(exp, DOTA_ModifyXP_Unspecified, false, true)
end