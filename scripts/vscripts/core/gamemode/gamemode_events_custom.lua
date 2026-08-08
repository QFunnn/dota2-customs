--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


function GameMode:RegisterCustomEventListeners()
	GameListener:SubscribeProtected("update_player_settings", function(event)
		self:OnSettingsUpdate(event)
	end)
end

---@class PlayerSettingsUpdateEvent
---@field PlayerID integer
---@field barrageOpacity number
---@field autoViewPvp boolean
---@field autoViewPve boolean
---@field extraCreatureOption ExtraCreatureOption
---@field disableChatWheelMessages boolean
---@field abilitySelectPosition string|nil
---@field abilityReplaceSelectMode string|nil
---@field hidePvpOnRoundStart boolean|nil

---@param event PlayerSettingsUpdateEvent
function GameMode:OnSettingsUpdate(event)
	Settings:Apply(event.PlayerID, event)
end