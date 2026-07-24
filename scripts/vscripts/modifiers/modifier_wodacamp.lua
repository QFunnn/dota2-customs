--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wodacamp=class({})

function modifier_wodacamp:IsPurgable() return false
end

function modifier_wodacamp:IsHidden() return true 
end

function modifier_wodacamp:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_PROVIDES_VISION] = true
	}
end

function modifier_wodacamp:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
    }
    return decFuncs
end

function modifier_wodacamp:GetModifierProvidesFOWVision()
  return 1
end