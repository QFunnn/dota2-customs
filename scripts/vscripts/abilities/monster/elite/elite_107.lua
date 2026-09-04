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
local CAST_POINT = 1.4
local CAST_DURATION = 1.6
local AREA_DURATION = 3
local AREA_RADIUS = 800
local HEAL_MAX_HEALTH_PCT_PER_SECOND = 10
local DAMAGE_RATE = 10
local TICK_INTERVAL = 1
local SUMMON_NAME = "monster_13003"
local SUMMON_COUNT = 3
local SUMMON_DISTANCE = 300
local SUMMON_BORN_DURATION = 0.5
local HEALING_WORD_EFFECT = "particles/units/heroes/hero_oracle/oracle_scepter_rain_of_destiny.vpcf"
____exports.elite_107 = __TS__Class()
local elite_107 = ____exports.elite_107
elite_107.name = "elite_107"
__TS__ClassExtends(elite_107, MonsterAbility_CS)
function elite_107.prototype.Precache(self, context)
	PrecacheResource("particle", HEALING_WORD_EFFECT, context)
end
function elite_107.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = AREA_RADIUS,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnStart = function()
			self:GetCaster():EmitSound("Hero_Dazzle.Shadow_Wave")
			self:CreateHealingWordArea()
			self:SummonMonsters()
		end,
	}
end
function elite_107.prototype.CreateHealingWordArea(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	CreateModifierThinker(
		caster,
		self,
		"modifier_elite_107_healing_word_area",
		{ duration = AREA_DURATION },
		origin,
		caster:GetTeamNumber(),
		false
	)
end
function elite_107.prototype.SummonMonsters(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local ____caster_GetRoomId_0
	if caster.GetRoomId then
		____caster_GetRoomId_0 = caster:GetRoomId()
	else
		____caster_GetRoomId_0 = nil
	end
	local roomId = ____caster_GetRoomId_0
	local directions = GetRotateVectors(nil, caster:GetForwardVector(), SUMMON_COUNT, 360 / SUMMON_COUNT)
	for ____, direction in ipairs(directions) do
		local currentDirection = direction
		local rawPos = origin:__add(currentDirection:__mul(SUMMON_DISTANCE))
		local spawnPos = GetGroundPosition(rawPos, caster)
		MyGameUnit:CreateSummonedUnitAsync({
			unitName = SUMMON_NAME,
			position = spawnPos,
			roomId = roomId,
			team = caster:GetTeamNumber(),
			owner = caster,
			summoner = caster,
			findClearSpace = true,
			onSpawn = function(____, unit)
				if not unit or not IsValidAlive(nil, unit) then
					return
				end
				unit:AddNewModifier(unit, nil, "modifier_monster_born", { duration = SUMMON_BORN_DURATION })
				unit:SetForwardVectorWithoutInterrupt(currentDirection)
			end,
		})
	end
end
elite_107 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_107)
____exports.elite_107 = elite_107
local modifier_elite_107_healing_word_area = __TS__Class()
modifier_elite_107_healing_word_area.name = "modifier_elite_107_healing_word_area"
__TS__ClassExtends(modifier_elite_107_healing_word_area, MonsterModifier_CS)
function modifier_elite_107_healing_word_area.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.origin = Vector(0, 0, 0)
end
function modifier_elite_107_healing_word_area.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.origin = self:GetParent():GetAbsOrigin()
	self.particleId = ParticleManager:CreateParticle(HEALING_WORD_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particleId, 0, self.origin)
	ParticleManager:SetParticleControl(self.particleId, 1, Vector(AREA_RADIUS, 0, 0))
	self:StartIntervalThink(TICK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_elite_107_healing_word_area.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	self:HealAllies(caster, ability)
	self:DamageEnemies(caster, ability)
end
function modifier_elite_107_healing_word_area.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if self.particleId ~= nil then
		ParticleManager:DestroyParticle(self.particleId, false)
		ParticleManager:ReleaseParticleIndex(self.particleId)
		self.particleId = nil
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_107_healing_word_area.prototype.IsHidden(self)
	return true
end
function modifier_elite_107_healing_word_area.prototype.IsPurgable(self)
	return false
end
function modifier_elite_107_healing_word_area.prototype.HealAllies(self, caster, ability)
	if not IsValidAlive(nil, caster) then
		return
	end
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		self.origin,
		nil,
		AREA_RADIUS,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, ally in ipairs(allies) do
		do
			if not IsValidAlive(nil, ally) then
				goto __continue27
			end
			if ally == caster then
				goto __continue27
			end
			local healAmount = ally:GetMaxHealth() * (HEAL_MAX_HEALTH_PCT_PER_SECOND / 100)
			ally:CustomHeal(healAmount, { ability = ability, source = "spell" })
		end
		::__continue27::
	end
end
function modifier_elite_107_healing_word_area.prototype.DamageEnemies(self, caster, ability)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		self.origin,
		nil,
		AREA_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue33
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
		end
		::__continue33::
	end
end
modifier_elite_107_healing_word_area = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_107_healing_word_area") },
	modifier_elite_107_healing_word_area
)
return ____exports