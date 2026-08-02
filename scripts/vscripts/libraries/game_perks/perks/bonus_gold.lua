--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

bonus_gold = class(base_game_perk)

function bonus_gold:__OnCreated()
	if IsClient() then
		self:StartIntervalThink(self.interval)
		return
	end

	if self.parent:IsTempestDouble() then
		return
	end
	if self.parent:IsClone() then
		return
	end

	BONUS_GOLD_PLAYERS[self.player_id] = {
		gold = self.gold,
		gold_per_operation = math.floor(self.gold / (self.time_for_full_gold / self.interval)),
	}

	self:StartIntervalThink(self.interval)
end

function bonus_gold:OnIntervalThink()
	if IsClient() then
		-- Hide stack count for other players, so they can't find out supp level
		if GetLocalPlayerID() ~= self.player_id then
			self:SetStackCount(0)
		end
		return
	end

	local gold = BONUS_GOLD_PLAYERS[self.player_id].gold

	if gold <= 0 then
		self:StartIntervalThink(-1)
	end
	self:SetStackCount(gold)
end

function bonus_gold:DeclareFunctions()
	if IsClient() then
		return { MODIFIER_PROPERTY_TOOLTIP }
	end
end
function bonus_gold:OnTooltip()
	return self.minutes_tooltip
end