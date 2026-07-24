--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


dark_seer_wall_of_replica_nb2017 = class({})
LinkLuaModifier( "modifier_dark_seer_wall_of_replica_nb2017", "heroes/hero_dark_seer/modifier_dark_seer_wall_of_replica_nb2017", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function dark_seer_wall_of_replica_nb2017:GetCooldown(level)
   return self.BaseClass.GetCooldown(self, level)
end



function dark_seer_wall_of_replica_nb2017:OnSpellStart()	
	local vWallDirection = self:GetCursorPosition() - self:GetCaster():GetOrigin()
	vWallDirection = vWallDirection:Normalized();
    
	local kv =
	{
		duration = self:GetSpecialValueFor( "duration" ),
		dir_x = vWallDirection.x,
		dir_y = vWallDirection.y,
		dir_z = vWallDirection.z
	}

	CreateModifierThinker( self:GetCaster(), self, "modifier_dark_seer_wall_of_replica_nb2017", kv, self:GetCursorPosition(), self:GetCaster():GetTeamNumber(), false )
end

--------------------------------------------------------------------------------