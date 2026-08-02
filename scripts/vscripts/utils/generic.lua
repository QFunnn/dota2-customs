--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function DisplayError(player_id, message)
	local player = PlayerResource:GetPlayer(player_id)
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "display_custom_error", { message = message })
	end
end

function GetRandomPathablePositionWithin(vPos, nRadius, nMinRadius)
	if IsServer() then
		local nMaxAttempts = 10
		local nAttempts = 0
		local vTryPos

		if nMinRadius == nil then
			nMinRadius = nRadius
		end

		repeat
			vTryPos = vPos + RandomVector(RandomFloat(nMinRadius, nRadius))

			nAttempts = nAttempts + 1
			if nAttempts >= nMaxAttempts then
				break
			end
		until GridNav:CanFindPath(vPos, vTryPos)

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
	if not value then
		return value
	end
	local val_type = type(value)
	if val_type == "boolean" then
		return value
	end
	if val_type == "number" then
		return value ~= 0
	end
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
		local pos = math.random(1, #shuffled + 1)
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
	if not unit:HasInventory() then
		return
	end

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
	local rot_vector_x = (vector.x * cos_angle) - (vector.y * sin_angle)
	local rot_vector_y = (vector.x * sin_angle) + (vector.y * cos_angle)
	return Vector(rot_vector_x, rot_vector_y, vector.z)
end

function AddNeutralItemToStashWithEffects(player_id, team, item)
	PlayerResource:AddNeutralItemToStash(player_id, team, item)

	local container = item:GetContainer()
	if not container then
		return
	end

	local pos = container:GetAbsOrigin()

	local particle_id =
		ParticleManager:CreateParticle("particles/items2_fx/neutralitem_teleport.vpcf", PATTACH_WORLDORIGIN, nil)
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
	if not delay or delay <= 0 then
		return PingLocationForEveryone(location)
	end

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
	if not IsValidEntity(bear) then
		return
	end
	local owner = bear:GetOwner()
	if not IsValidEntity(owner) then
		return
	end

	if owner:GetClassname() == "dota_player_controller" then
		return owner:GetAssignedHero()
	end

	return owner
end

function FindUnitsInCone(
	teamNumber,
	vDirection,
	vPosition,
	startRadius,
	endRadius,
	flLength,
	hCacheUnit,
	targetTeam,
	targetUnit,
	targetFlags,
	findOrder,
	bCache,
	bIsFullCircle
)
	local unitTable = {}
	local radiusSearch = endRadius + flLength
	if bIsFullCircle then
		radiusSearch = flLength
	end

	local enemies = FindUnitsInRadius(
		teamNumber,
		vPosition,
		hCacheUnit,
		radiusSearch,
		targetTeam,
		targetUnit,
		targetFlags,
		findOrder,
		bCache
	)

	if #enemies > 0 then
		if bIsFullCircle then
			unitTable = enemies
		else
			local vDirectionCone = Vector(vDirection.y, -vDirection.x, 0.0)
			for _, enemy in pairs(enemies) do
				if enemy ~= nil then
					local vToPotentialTarget = enemy:GetOrigin() - vPosition
					local flSideAmount = math.abs(
						vToPotentialTarget.x * vDirectionCone.x
							+ vToPotentialTarget.y * vDirectionCone.y
							+ vToPotentialTarget.z * vDirectionCone.z
					)
					local enemy_distance_from_caster = (
						vToPotentialTarget.x * vDirection.x
						+ vToPotentialTarget.y * vDirection.y
						+ vToPotentialTarget.z * vDirection.z
					)

					local max_increased_radius_from_distance = endRadius - startRadius

					local pct_distance = enemy_distance_from_caster / flLength

					local radius_increase_from_distance = max_increased_radius_from_distance * pct_distance

					if
						(
							(flSideAmount < startRadius + radius_increase_from_distance)
							and (enemy_distance_from_caster > 0.0)
							and (enemy_distance_from_caster < flLength)
						) or (vToPotentialTarget:Length2D() < startRadius)
					then
						table.insert(unitTable, enemy)
					end
				end
			end
		end
	end
	return unitTable
end

function CalculateDirection(ent1, ent2)
	local pos1 = ent1
	local pos2 = ent2
	if ent1.GetAbsOrigin then
		pos1 = ent1:GetAbsOrigin()
	end
	if ent2.GetAbsOrigin then
		pos2 = ent2:GetAbsOrigin()
	end
	local direction = (pos1 - pos2):Normalized()
	return direction
end

function IsBitSet(value, ...)
	local flags = bit.bor(...)
	return bit.band(value, flags) == flags
end

function IsBitOff(value, ...)
	local flags = bit.bor(...)
	return bit.band(value, flags) == 0
end

-- bit.band works only in int32 range
function TestFlag(set, flag)
	return set % (2 * flag) >= flag
end

function GetFountainSpawnPosition(team_id, random_offset)
	local fountain = GameLoop.fountains[team_id]
	if not fountain then
		return
	end

	return fountain.pos:Normalized() * fountain.pos_multiplier
		+ RandomVector(RandomFloat(0, random_offset or 0))
		+ fountain.pos
end

function IsPlayersInParty(player1, player2)
	local party_id1 = tostring(PlayerResource:GetPartyID(player1))
	local party_id2 = tostring(PlayerResource:GetPartyID(player2))

	return party_id1 == party_id2 and party_id1 ~= "0"
end

function IsPlayerConnected(player_id)
	return PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_CONNECTED
end

function IsPlayerBotByConnect(player_id)
	return PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_NOT_YET_CONNECTED
end