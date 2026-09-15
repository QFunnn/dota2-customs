--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


function CDOTAPlayerController:GetTeamNumber()
	local hero = self:GetAssignedHero()
	if hero then
		return hero:GetTeamNumber()
	end
end