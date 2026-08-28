--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_guild_event = class({})

function modifier_guild_event:IsHidden()
	return false
end

function modifier_guild_event:IsPurgable()
	return false
end

function modifier_guild_event:IsPurgeException()
	return false
end

function modifier_guild_event:RemoveOnDeath()
	return false
end