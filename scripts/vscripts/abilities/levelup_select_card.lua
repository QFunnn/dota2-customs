--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


levelup_select_card = class({})

function levelup_select_card:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_select_card:OnSpellStart()
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		self:EndCooldown()
		return
	end

	local caster = self:GetCaster()
	if card_system:TryReopenHiddenSelector(caster) then
		return
	end

	local wood_cost = player_data:GetAbilityCost(caster:GetPlayerOwnerID(), self:GetAbilityName())
	local current_wood = caster:LevelUpGetWood()
	if current_wood < wood_cost then
		return
	end
	if card_system:GenerateRandomCardList(caster) then
		caster:LevelUpModifyWood(-wood_cost)
		player_data:UpdateAbilityCost(caster:GetPlayerOwnerID(), self:GetAbilityName())
		if tutorial_system then
			tutorial_system:CompleteStep(caster:GetPlayerOwnerID(), "select_card")
		end
	end
end

function levelup_select_card:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return false
	end
	if not card_system then
		return false
	end
	return card_system:OnProjectileHit_ExtraData(self, target, location, extra_data)
end