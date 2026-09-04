--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_065_phantasm_spawn_protection, modifier_elite_065_phantasm_charge_hidden
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SUMMON_NAME = "monster_11070"
local SUMMON_TAG = "elite_065_chaos_clone"
local CAST_RANGE = 1200
local CAST_POINT = 0.6
local CAST_DURATION = 0.8
local SUMMON_DISTANCE = 180
local MAX_SUMMONS = 3
local APPEAR_DELAY = 0.45
local CHARGE_SEARCH_RANGE = 1200
local CHARGE_DISTANCE = 900
local CHARGE_PROJECTILE_SPEED = 1800
local CHARGE_WARNING_WIDTH = 300
local PHANTASM_PARTICLE = "particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf"
local CHARGE_PROJECTILE_PARTICLE = "particles/dd/projectile_linear_multi.vpcf"
local PHANTASM_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_chaos_knight.vsndevts"
local PHANTASM_SOUND = "Hero_ChaosKnight.Phantasm"
--- 精英技能65 - 混沌幻象：召唤三个继承自身配置的混沌分身
____exports.elite_065 = __TS__Class()
local elite_065 = ____exports.elite_065
elite_065.name = "elite_065"
__TS__ClassExtends(elite_065, MonsterAbility_CS)
function elite_065.prototype.Precache(self, context)
	PrecacheResource("particle", PHANTASM_PARTICLE, context)
	PrecacheResource("particle", CHARGE_PROJECTILE_PARTICLE, context)
	PrecacheResource("soundfile", PHANTASM_SOUND_EVENTS, context)
end
function elite_065.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnPhaseStart = function()
			return self:PreparePhantasmCharge()
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound(PHANTASM_SOUND)
			local forward = caster:GetForwardVector():Normalized()
			local origin = caster:GetAbsOrigin()
			self:PlayPhantasmParticle(origin, caster)
			local directions = self:GetSummonDirections(forward)
			local summons = {}
			local pendingSummons = #directions
			local function tryStartCharge()
				if pendingSummons > 0 then
					return
				end
				self:StartPhantasmCharge(caster, summons, forward)
			end
			for ____, direction in ipairs(directions) do
				local rawPos = origin:__add(direction:__mul(SUMMON_DISTANCE))
				local groundZ = GetGroundHeight(rawPos, caster) or rawPos.z
				local spawnPos = Vector(rawPos.x, rawPos.y, groundZ)
				MyGameUnit:CreateSummonedUnitAsync({
					unitName = SUMMON_NAME,
					summoner = caster,
					summonTag = SUMMON_TAG,
					maxSummons = MAX_SUMMONS,
					position = spawnPos,
					findClearSpace = true,
					onSpawn = function(____, unit)
						pendingSummons = pendingSummons - 1
						if unit and IsValidAlive(nil, unit) then
							unit:SetForwardVector(forward)
							modifier_elite_065_phantasm_spawn_protection:applys(
								unit,
								caster,
								self,
								{ duration = APPEAR_DELAY + 1 }
							)
							summons[#summons + 1] = unit
						end
						tryStartCharge(nil)
					end,
				})
			end
		end,
	}
end
function elite_065.prototype.GetSummonDirections(self, forward)
	return __TS__ArrayMap({ -45, 0, 45 }, function(____, angle)
		return RotateVector2D(nil, forward, angle):Normalized()
	end)
end
function elite_065.prototype.PreparePhantasmCharge(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CHARGE_SEARCH_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 8)
	end
	caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-100)), 0.2)
	local origin = caster:GetAbsOrigin()
	local ____end = GetGroundPosition(origin:__add(caster:GetForwardVector():__mul(CHARGE_DISTANCE + 100)), caster)
	self:WarningEffect(origin, ____end, CAST_POINT, {
		startWidth = CHARGE_WARNING_WIDTH,
		endWidth = CHARGE_WARNING_WIDTH,
		getDirection = function()
			return caster:GetForwardVector()
		end,
	})
end
function elite_065.prototype.PlayPhantasmParticle(self, origin, owner)
	local pfx = ParticleManager:CreateParticle(PHANTASM_PARTICLE, PATTACH_WORLDORIGIN, owner)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, origin)
	Timers:CreateTimer(0.5, function()
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_065.prototype.StartPhantasmCharge(self, caster, summons, direction)
	if not IsValidAlive(nil, caster) then
		return
	end
	local start = caster:GetAbsOrigin()
	local ____end = GetGroundPosition(start:__add(direction:__mul(CHARGE_DISTANCE)), caster)
	local distance = GetDistance(nil, start, ____end)
	local travelTime = math.max(0.2, distance / CHARGE_PROJECTILE_SPEED)
	local units = __TS__ArrayFilter({
		caster,
		unpack(summons),
	}, function(____, unit)
		return IsValidAlive(nil, unit)
	end)
	local forward = direction
	for ____, unit in ipairs(units) do
		modifier_elite_065_phantasm_charge_hidden:applys(unit, caster, self, { duration = travelTime + 0.05 })
	end
	self:FireChargeProjectile(caster, start, ____end, distance)
	self:Timer(travelTime, function()
		self:RevealPhantasmUnits(units, ____end, forward)
	end)
end
function elite_065.prototype.FireChargeProjectile(self, caster, start, ____end, distance)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = CHARGE_PROJECTILE_PARTICLE,
		projectile_type = "linear",
		start_point = start:__add(Vector(0, 0, 96)),
		target = ____end:__add(Vector(0, 0, 96)),
		projectile_speed = CHARGE_PROJECTILE_SPEED,
		projectile_distance = distance,
		projectile_range = 300,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, target)
			if IsValidAlive(nil, target) then
				if not IsValidAlive(nil, caster) then
					return true
				end
				caster:MonsterDamage({ victim = target, damage_rate = 25, ability = self })
				AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.STUN, { duration = 0.3 })
				return false
			end
			return true
		end,
	})
end
function elite_065.prototype.RevealPhantasmUnits(self, units, ____end, forward)
	local firstUnit = units[1]
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, firstUnit) then
		____IsValidAlive_result_0 = firstUnit:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = ____end
	end
	local origin = ____IsValidAlive_result_0
	local ____table_CanRevealAt_result_1
	if self:CanRevealAt(origin, ____end) then
		____table_CanRevealAt_result_1 = ____end
	else
		____table_CanRevealAt_result_1 = origin
	end
	local targetPoint = ____table_CanRevealAt_result_1
	do
		local index = 0
		while index < #units do
			do
				local currentIndex = index
				local unit = units[currentIndex + 1]
				if not IsValidAlive(nil, unit) then
					goto __continue32
				end
				local offset = self:GetRevealOffset(currentIndex, #units, forward)
				local revealPoint = GetGroundPosition(targetPoint:__add(offset), unit)
				unit:SetAbsOrigin(revealPoint)
				unit:SetForwardVector(forward)
				FindClearSpaceForUnit(unit, revealPoint, true)
				modifier_elite_065_phantasm_charge_hidden:remove(unit)
				unit:RemoveNoDrawWithWearables()
			end
			::__continue32::
			index = index + 1
		end
	end
end
function elite_065.prototype.GetRevealOffset(self, index, total, forward)
	if index == 0 then
		return Vector(0, 0, 0)
	end
	local side = Vector(-forward.y, forward.x, 0):Normalized()
	local angle = (index - 1) / math.max(1, total - 1) * math.pi * 2
	local radius = 120
	return side:__mul(math.cos(angle) * radius):__add(forward:__mul(math.sin(angle) * radius))
end
function elite_065.prototype.CanRevealAt(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, origin) then
		return false
	end
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
elite_065 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_065)
____exports.elite_065 = elite_065
modifier_elite_065_phantasm_spawn_protection = __TS__Class()
modifier_elite_065_phantasm_spawn_protection.name = "modifier_elite_065_phantasm_spawn_protection"
__TS__ClassExtends(modifier_elite_065_phantasm_spawn_protection, BaseModifier)
function modifier_elite_065_phantasm_spawn_protection.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
function modifier_elite_065_phantasm_spawn_protection.prototype.GetEffectName(self)
	return "particles/econ/items/dazzle/dazzle_ti9/dazzle_shadow_wave_ti9_impact_damage.vpcf"
end
modifier_elite_065_phantasm_spawn_protection = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_065_phantasm_spawn_protection") },
	modifier_elite_065_phantasm_spawn_protection
)
modifier_elite_065_phantasm_charge_hidden = __TS__Class()
modifier_elite_065_phantasm_charge_hidden.name = "modifier_elite_065_phantasm_charge_hidden"
__TS__ClassExtends(modifier_elite_065_phantasm_charge_hidden, MonsterModifier_CS)
function modifier_elite_065_phantasm_charge_hidden.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():AddNoDrawWithWearables()
end
function modifier_elite_065_phantasm_charge_hidden.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveNoDrawWithWearables()
end
function modifier_elite_065_phantasm_charge_hidden.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_elite_065_phantasm_charge_hidden.prototype.IsHidden(self)
	return true
end
function modifier_elite_065_phantasm_charge_hidden.prototype.IsPurgable(self)
	return false
end
modifier_elite_065_phantasm_charge_hidden = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_065_phantasm_charge_hidden") },
	modifier_elite_065_phantasm_charge_hidden
)
return ____exports