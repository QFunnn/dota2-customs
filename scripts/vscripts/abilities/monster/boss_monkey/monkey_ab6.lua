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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local MONKEY_AB6_HEALTH_THRESHOLD = 0.5
local MONKEY_AB6_HEALTH_CHECK_INTERVAL = 0.5
local MONKEY_AB6_SUMMON_INTERVAL_MIN = 8
local MONKEY_AB6_SUMMON_INTERVAL_MAX = 12
local MONKEY_AB6_SUMMON_COUNT_MIN = 1
local MONKEY_AB6_SUMMON_COUNT_MAX = 2
local MONKEY_AB6_SUMMON_UNIT_NAME = "monster_11027"
local MONKEY_AB6_SUMMON_RADIUS_MIN = 220
local MONKEY_AB6_SUMMON_RADIUS_MAX = 420
local MONKEY_AB6_SUMMON_POSITION_RETRY = 12
local MONKEY_AB6_SUMMON_BORN_DURATION = 0.5
local MONKEY_AB6_SUMMON_EFFECT = "particles/boss/boss_004debuff.vpcf"
local MONKEY_AB6_SUMMON_SOUND = "Hero_SkywrathMage.AncientSeal.Target"
____exports.monkey_ab6 = __TS__Class()
local monkey_ab6 = ____exports.monkey_ab6
monkey_ab6.name = "monkey_ab6"
__TS__ClassExtends(monkey_ab6, MonsterAbility_CS)
function monkey_ab6.prototype.Precache(self, context)
	PrecacheResource("particle", MONKEY_AB6_SUMMON_EFFECT, context)
end
function monkey_ab6.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN, castPoint = 0, castDuration = 0 }
end
function monkey_ab6.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_monkey_ab6_low_health_summon.name
end
monkey_ab6 = __TS__DecorateLegacy({ registerAbility(nil) }, monkey_ab6)
____exports.monkey_ab6 = monkey_ab6
____exports.modifier_monkey_ab6_low_health_summon = __TS__Class()
local modifier_monkey_ab6_low_health_summon = ____exports.modifier_monkey_ab6_low_health_summon
modifier_monkey_ab6_low_health_summon.name = "modifier_monkey_ab6_low_health_summon"
__TS__ClassExtends(modifier_monkey_ab6_low_health_summon, MonsterModifier_CS)
function modifier_monkey_ab6_low_health_summon.prototype.IsHidden(self)
	return true
end
function modifier_monkey_ab6_low_health_summon.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_ab6_low_health_summon.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(MONKEY_AB6_HEALTH_CHECK_INTERVAL)
end
function modifier_monkey_ab6_low_health_summon.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if caster:GetHealth() > caster:GetMaxHealth() * MONKEY_AB6_HEALTH_THRESHOLD then
		self:StartIntervalThink(MONKEY_AB6_HEALTH_CHECK_INTERVAL)
		return
	end
	self:SummonMonkeyChildren(caster)
	self:StartIntervalThink(RandomFloat(MONKEY_AB6_SUMMON_INTERVAL_MIN, MONKEY_AB6_SUMMON_INTERVAL_MAX))
end
function modifier_monkey_ab6_low_health_summon.prototype.SummonMonkeyChildren(self, caster)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local count = RandomInt(MONKEY_AB6_SUMMON_COUNT_MIN, MONKEY_AB6_SUMMON_COUNT_MAX)
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetRoomId
	local roomId = ____opt_0 and ____opt_0(____this_1)
	EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), MONKEY_AB6_SUMMON_SOUND, caster)
	do
		local index = 0
		while index < count do
			local currentSpawnPos = self:FindSummonPosition(caster)
			self:PlaySummonEffect(currentSpawnPos, caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = MONKEY_AB6_SUMMON_UNIT_NAME,
				summonTag = "monkey_ab6_" .. tostring(caster:entindex()),
				position = currentSpawnPos,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				findClearSpace = true,
				destroyWithSummoner = true,
				onSpawn = function(____, unit)
					if not unit or not IsValid(nil, unit) or unit:IsNull() then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					unit:AddNewModifier(
						caster,
						ability,
						"modifier_monster_born",
						{ duration = MONKEY_AB6_SUMMON_BORN_DURATION }
					)
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, caster:GetAbsOrigin(), currentSpawnPos))
				end,
			})
			index = index + 1
		end
	end
end
function modifier_monkey_ab6_low_health_summon.prototype.FindSummonPosition(self, caster)
	local origin = caster:GetAbsOrigin()
	do
		local index = 0
		while index < MONKEY_AB6_SUMMON_POSITION_RETRY do
			local angle = RandomFloat(0, 360)
			local distance = RandomFloat(MONKEY_AB6_SUMMON_RADIUS_MIN, MONKEY_AB6_SUMMON_RADIUS_MAX)
			local candidate = origin:__add(RotateVector2D(nil, Vector(1, 0, 0), angle):__mul(distance))
			local groundPos = GetGroundPosition(candidate, caster)
			if
				GridNav:IsTraversable(groundPos)
				and not GridNav:IsBlocked(groundPos)
				and GridNav:CanFindPath(origin, groundPos)
			then
				return groundPos
			end
			index = index + 1
		end
	end
	return GetGroundPosition(origin:__add(RandomVector(MONKEY_AB6_SUMMON_RADIUS_MIN)), caster)
end
function modifier_monkey_ab6_low_health_summon.prototype.PlaySummonEffect(self, pos, caster)
	local effect = ParticleManager:CreateParticle(MONKEY_AB6_SUMMON_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, pos)
	ParticleManager:SetParticleControl(effect, 1, pos)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
modifier_monkey_ab6_low_health_summon =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_ab6_low_health_summon)
____exports.modifier_monkey_ab6_low_health_summon = modifier_monkey_ab6_low_health_summon
return ____exports