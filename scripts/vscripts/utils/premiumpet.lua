--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Spawn( entityKeyValues )
	Timers:CreateTimer(function()
		PetPremiumThink()
		return 0.4
	end)
end

function PetPremiumThink()
	if thisEntity:IsNull() then return end
	local owner = thisEntity:GetOwner()
	local owner_pos = owner:GetAbsOrigin()
	local pet_pos = thisEntity:GetAbsOrigin()
	local distance = ( owner_pos - pet_pos ):Length2D()
	local owner_dir = owner:GetForwardVector()
	local dir = owner_dir * RandomInt( 110, 140 )


	if owner:IsAlive() then
		thisEntity:RemoveNoDraw()

		if distance > 900 then
			local a = RandomInt( 60, 120 )
			if RandomInt( 1, 2 ) == 1 then
				a = a * -1
			end
			local r = RotatePosition( Vector( 0, 0, 0 ), QAngle( 0, a, 0 ), dir )
			thisEntity:SetAbsOrigin( owner_pos + r )
			thisEntity:SetForwardVector( owner_dir )
			FindClearSpaceForUnit( thisEntity, owner_pos + r, true )
		elseif distance > 150 then
			local right = RotatePosition( Vector( 0, 0, 0 ), QAngle( 0, RandomInt( 70, 110 ) * -1, 0 ), dir ) + owner_pos
			local left = RotatePosition( Vector( 0, 0, 0 ), QAngle( 0, RandomInt( 70, 110 ), 0 ), dir ) + owner_pos
			if ( pet_pos - right ):Length2D() > ( pet_pos - left ):Length2D() then
				thisEntity:MoveToPosition( left )
			else
				thisEntity:MoveToPosition( right )
			end
		elseif distance < 90 then
			thisEntity:MoveToPosition( owner_pos + ( pet_pos - owner_pos ):Normalized() * RandomInt( 110, 140 ) )
		end
		
		if owner:IsInvisible() then
			thisEntity:AddNewModifier(thisEntity, thisEntity, "modifier_invisible", {})
		else
			thisEntity:RemoveModifierByName("modifier_invisible")
		end
	else
		thisEntity:AddNoDraw()
	end
end