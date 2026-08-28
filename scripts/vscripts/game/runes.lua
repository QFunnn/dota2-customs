--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


Runes = Runes or {}

function Runes:Init()
	local game_mode_entity = GameRules:GetGameModeEntity()
	game_mode_entity:SetRuneEnabled(DOTA_RUNE_ARCANE, true)
end