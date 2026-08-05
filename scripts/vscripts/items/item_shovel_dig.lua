--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


﻿item_shovel_dig = class({})
--------------------------------------------------------------------------------
function item_shovel_dig:OnSpellStart()
		self.caster = self:GetCaster()
		vTargetPosition = self:GetCursorPosition()
		
		local point_dig_zone = Entities:FindByName( nil, "digger"):GetAbsOrigin()
					
		local flDist = (vTargetPosition - point_dig_zone):Length2D()
		if flDist > 6000 then return end
							
		local nFXIndex = ParticleManager:CreateParticle( "particles/econ/events/ti9/shovel_dig.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, vTargetPosition )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 0.0, r, 0.0 ) )
		local sound_cast = "SeasonalConsumable.TI9.Shovel.Dig"
		-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_cast, self:GetCaster() )
		EmitSoundOn(sound_cast, self:GetCaster())
		
		Timers:CreateTimer({
		endTime = 2, 
		callback = function()
		ParticleManager:DestroyParticle(nFXIndex, true)
		ParticleManager:ReleaseParticleIndex(nFXIndex)
		
		if RandomInt(1,100) <= 25 then 
			self.caster:EmitSound("Item.DropGemWorld")
			local newItem = CreateItem( "item_gold_brus", nil, nil )
			local drop = CreateItemOnPositionForLaunch( vTargetPosition, newItem )
			local dropRadius = RandomFloat( 50, 50 )
			UTIL_Remove(self)		
		end
		
		end
		})
end