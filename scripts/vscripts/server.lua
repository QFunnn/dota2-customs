--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local Jump = {}

function Jump.Activate()
	-- 只提供下载界面，不启动大厅控制器或对局逻辑。
	GameRules:EnableCustomGameSetupAutoLaunch(false)
	GameRules:SetCustomGameSetupTimeout(-1)
	GameRules:SetCustomGameSetupAutoLaunchDelay(999999)
	if GameRules.SetCustomGameSetupRemainingTime then
		GameRules:SetCustomGameSetupRemainingTime(999999)
	end
	GameRules:SetHeroSelectionTime(99999)
	GameRules:SetStrategyTime(0)
	GameRules:SetShowcaseTime(0)
	GameRules:SetPreGameTime(0)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)
	if GameRules.LockCustomGameSetupTeamAssignment then
		GameRules:LockCustomGameSetupTeamAssignment(true)
	end
	print("[HallJump] waiting for client Workshop preparation")
end

return Jump