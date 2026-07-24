--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_courier_speed_controller = modifier_courier_speed_controller or class({})

function modifier_courier_speed_controller:IsHidden() return true end
function modifier_courier_speed_controller:IsPurgable() return false end
function modifier_courier_speed_controller:RemoveOnDeath() return false end

function modifier_courier_speed_controller:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT, -- GetModifierMoveSpeedBonus_Constant
	}
end

if IsServer() then
	function modifier_courier_speed_controller:OnCreated()
		self:StartIntervalThink(1)
	end

	function modifier_courier_speed_controller:OnIntervalThink()
		local owner_player_id = self:GetParent():GetPlayerOwnerID()
		self:SetStackCount(WebPlayer:GetSubscriptionTier(owner_player_id) > 0 and 1 or 0)
	end
end

function modifier_courier_speed_controller:GetModifierMoveSpeedBonus_Constant() return self:GetStackCount() > 0 and 20000 or 0 end