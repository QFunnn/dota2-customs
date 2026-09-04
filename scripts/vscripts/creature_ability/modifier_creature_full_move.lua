--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 01883f2 
  ~ auto-generated — do not edit
]]


modifier_creature_full_move = class({})

function modifier_creature_full_move:GetTexture()
	return "item_gem"
end

function modifier_creature_full_move:IsHidden()
	return true
end

function modifier_creature_full_move:IsPurgable()
	return false
end

function modifier_creature_full_move:CheckState()
	return {
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
	}
end