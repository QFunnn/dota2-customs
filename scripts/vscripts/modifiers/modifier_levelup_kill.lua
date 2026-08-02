--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_levelup_kill = class({})
function modifier_levelup_kill:IsHidden()
	return true
end
function modifier_levelup_kill:IsPurgeException()
	return false
end
function modifier_levelup_kill:IsPurgable()
	return false
end
function modifier_levelup_kill:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local entindex = parent:entindex()
	parent:RemoveHealthBar()
	if parent:IsAlive() then
		BaseGameMode:OnEntityKilled({ entindex_killed = entindex, entindex_attacker = entindex })
		parent:ForceKill(false)
	end
end