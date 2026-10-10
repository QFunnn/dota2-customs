--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


modifier_patrol_reward_1_gold = class(mod_visible)
function modifier_patrol_reward_1_gold:GetTexture()
	return "item_hand_of_midas"
end
function modifier_patrol_reward_1_gold:RemoveOnDeath()
	return false
end
function modifier_patrol_reward_1_gold:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.gold = self.parent:GetTalentValue("modifier_patrol_reward_gold", "gold") / 100
	self.max_gold = self.parent:GetTalentValue("modifier_patrol_reward_gold", "max_gold")
	EmitSoundOnEntityForPlayer("DOTA_Item.Hand_Of_Midas", self.parent, self.parent:GetPlayerOwnerID())
	self:OnRefresh()
end

function modifier_patrol_reward_1_gold:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self.max_gold)
end