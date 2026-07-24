--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function DisplayError(player_id, message)
	local player = PlayerResource:GetPlayer(player_id)
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "display_custom_error", { message = message })
	end
end

function GetRandomPathablePositionWithin(vPos, nRadius, nMinRadius )
	if IsServer() then
		local nMaxAttempts = 10
		local nAttempts = 0
		local vTryPos

		if nMinRadius == nil then
			nMinRadius = nRadius
		end

		repeat
			vTryPos = vPos + RandomVector( RandomFloat( nMinRadius, nRadius ) )

			nAttempts = nAttempts + 1
			if nAttempts >= nMaxAttempts then
				break
			end
		until ( GridNav:CanFindPath( vPos, vTryPos ) )

		return vTryPos
	end
end

function GetPlayerIdBySteamId(id)
	for i = 0, 23 do
		if PlayerResource:IsValidPlayerID(i) and tostring(PlayerResource:GetSteamID(i)) == id then
			return i
		end
	end

	return -1
end

function toboolean(value)
	if not value then return value end
	local val_type = type(value)
	if val_type == "boolean" then return value end
	if val_type == "number"	then return value ~= 0 end
	return true
end

-- Copy shallow copy given input
function table.shallowcopy(orig)
	local copy = {}
	for orig_key, orig_value in pairs(orig) do
		copy[orig_key] = orig_value
	end
	return copy
end

function table.shuffle(orig)
	shuffled = {}
	for i, v in ipairs(orig) do
		local pos = math.random(1, #shuffled+1)
		table.insert(shuffled, pos, v)
	end
	return shuffled
end

function BubbleSort(t)
	local i = 0

	-- Basically, if the counter goes up to table length without ordering anything we're good to go
	while i ~= #t do
		for k, v in ipairs(t) do
			if t[k + 1] and t[k] and t[k + 1] and t[k] > t[k + 1] then
--				print(t[k], t[k + 1])
				t[k], t[k + 1] = t[k + 1], t[k]
				i = 0
				break
			else
				i = i + 1
			end
		end
	end

	return t
end

function GetFreeStashSlot(unit)
	if not unit:HasInventory() then return end

	for i = DOTA_STASH_SLOT_1, DOTA_STASH_SLOT_6 do
		if not unit:GetItemInSlot(i) then
			return i
		end
	end
end

function RotateVector2D(vector, angle, is_degree_rad)
	angle = is_degree_rad and angle or math.rad(angle)
	local sin_angle = math.sin(angle)
	local cos_angle = math.cos(angle)
	local rot_vector_x = ( vector.x * cos_angle ) - ( vector.y * sin_angle )
	local rot_vector_y = ( vector.x * sin_angle ) + ( vector.y * cos_angle )
	return Vector(rot_vector_x, rot_vector_y, vector.z)
end


function AddNeutralItemToStashWithEffects(player_id, team, item)
	PlayerResource:AddNeutralItemToStash(player_id, team, item)

	local container = item:GetContainer()
	if not container then return end

	local pos = container:GetAbsOrigin()

	local particle_id = ParticleManager:CreateParticle("particles/items2_fx/neutralitem_teleport.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_id, 0, pos)
	ParticleManager:ReleaseParticleIndex(particle_id)
	StartSoundEventFromPosition("NeutralItem.TeleportToStash", pos)

	container:RemoveSelf()
end

function CountPlayers(include_bots)
	local count = 0

	for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(i) and (not PlayerResource:IsFakeClient(i) or include_bots) then
			count = count + 1
		end
	end

	return count
end


--- Ping certain location for all teams at once
--- With optional delay in seconds (ping will be delayed for all teams)
---@param location Vector
---@param delay number
function PingLocationForEveryoneWithDelay(location, delay)
	if not delay or delay <= 0 then return PingLocationForEveryone(location) end

	Timers:CreateTimer(delay, function()
		PingLocationForEveryone(location)
	end)
end


function PingLocationForEveryone(location)
	for team = DOTA_TEAM_GOODGUYS, DOTA_TEAM_CUSTOM_8 do
		GameRules:ExecuteTeamPing(team, location.x, location.y, nil, 2)
	end
end


function GetBearOwnerHero(bear)
	if not IsValidEntity(bear) then return end
	local owner = bear:GetOwner()
	if not IsValidEntity(owner) then return end

	if owner:GetClassname() == "dota_player_controller" then
		return owner:GetAssignedHero()
	end

	return owner
end