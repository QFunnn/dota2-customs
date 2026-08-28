--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function Filters:FilterModifyExperience(event)
	local hero = event.hero_entindex_const and EntIndexToHScript(event.hero_entindex_const)

	if hero and hero.IsTempestDouble and hero:IsTempestDouble() then
		return false
	end

	local experience = event.experience

	local scaled_experience = experience * GameLoop.current_xp_scale_factor

	event.experience = scaled_experience

	return true
end