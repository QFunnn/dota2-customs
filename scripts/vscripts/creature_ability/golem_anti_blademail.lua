--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_golem_anti_blademail", "creature_ability/golem_anti_blademail.lua", LUA_MODIFIER_MOTION_NONE )

golem_anti_blademail = class({})

function golem_anti_blademail:GetIntrinsicModifierName()
	return "modifier_golem_anti_blademail"
end

modifier_golem_anti_blademail = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function(self)
        return
        {
            MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        }
    end,
    
    OnCreated               = function(self, table)
		local ability = self:GetAbility()
		if ability then
        	self.BlockPct = ability:GetSpecialValueFor("damage_reduction")
		end
    end,

    GetModifierTotal_ConstantBlock         = function(self, event)
        if bit:_and(event.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
			return (event.damage * 0.01) * (self.BlockPct or 0)
		end
		return 0
    end,
})