--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_reroll_neutral_book = class({})
function item_reroll_neutral_book:OnChargeCountChanged(iCharges) end

function item_reroll_neutral_book:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	if caster and IsRealHero(caster) then
		local PlayerID = caster:GetPlayerID()
		if NeutralItems:GiveNeutral(PlayerID, 5, 1, nil, NeutralItems:GetGettedItemsByTier(PlayerID, 5), nil, true) then
			self:SpendCharge(0)
		else
			local player = PlayerResource:GetPlayer(PlayerID)
			if player then
				CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="NEUTRALS_CraftAlready"})
			end

			return
		end
	end
end