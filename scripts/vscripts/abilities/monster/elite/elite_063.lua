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
local __TS__ArrayFindIndex = ____lualib.__TS__ArrayFindIndex
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
____exports.LICH_SPIRE_KEY = "__elite_063_lich_spires__"
____exports.LICH_SPIRE_BOUNCE_DISTANCE = 650
local CAST_RANGE = 1200
local CAST_POINT = 0.1
local SPIRE_DURATION = 15
local SPIRE_AURA_RADIUS = 420
local SPIRE_SLOW_STACK = 3
local SPIRE_SLOW_DURATION = 0.45
local SPIRE_MODEL = "models/heroes/lich/ice_spire.vmdl"
local SPAWN_PARTICLE = "particles/units/heroes/hero_lich/lich_ice_spire.vpcf"
local SPIRE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_lich.vsndevts"
local SPIRE_SPAWN_SOUND = "Ability.FrostNova"
local nextSpireId = 1
--- 精英技能63 - 冰晶尖柱：在敌人附近召唤冰柱，冰柱持续提供寒冷减速并作为连环霜冻弹射目标
____exports.elite_063 = __TS__Class()
local elite_063 = ____exports.elite_063
elite_063.name = "elite_063"
__TS__ClassExtends(elite_063, MonsterAbility_CS)
function elite_063.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.targetPos = nil
end
function elite_063.prototype.Precache(self, context)
	PrecacheResource("model", SPIRE_MODEL, context)
	PrecacheResource("particle", SPAWN_PARTICLE, context)
	PrecacheResource("soundfile", SPIRE_SOUND_EVENTS, context)
end
function elite_063.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, target) then
				return
			end
			self.targetPos = target:GetAbsOrigin()
			caster:LockTargetForSpeed(target, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) or not self.targetPos then
				return
			end
			local center = self.targetPos
			self.targetPos = nil
			for ____, pos in ipairs(self:GetTriangleSpirePositions(center, caster)) do
				local ____CreateModifierThinker_1 = CreateModifierThinker
				local ____nextSpireId_0 = nextSpireId
				nextSpireId = ____nextSpireId_0 + 1
				____CreateModifierThinker_1(
					caster,
					self,
					"modifier_elite_063_spire",
					{ duration = SPIRE_DURATION, spire_id = ____nextSpireId_0 },
					pos,
					caster:GetTeamNumber(),
					false
				)
			end
		end,
	}
end
function elite_063.prototype.GetTriangleSpirePositions(self, center, caster)
	local radius = ____exports.LICH_SPIRE_BOUNCE_DISTANCE / math.sqrt(3)
	local positions = {}
	do
		local i = 0
		while i < 3 do
			local angle = math.rad(90 + i * 120)
			local x = center.x + math.cos(angle) * radius
			local y = center.y + math.sin(angle) * radius
			local rawPos = Vector(x, y, center.z)
			positions[#positions + 1] = GetGroundPosition(rawPos, caster)
			i = i + 1
		end
	end
	return positions
end
elite_063 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_063)
____exports.elite_063 = elite_063
____exports.modifier_elite_063_spire = __TS__Class()
local modifier_elite_063_spire = ____exports.modifier_elite_063_spire
modifier_elite_063_spire.name = "modifier_elite_063_spire"
__TS__ClassExtends(modifier_elite_063_spire, MonsterModifier_CS)
function modifier_elite_063_spire.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.spireId = 0
end
function modifier_elite_063_spire.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local ____params_spire_id_3 = params.spire_id
	if ____params_spire_id_3 == nil then
		local ____nextSpireId_2 = nextSpireId
		nextSpireId = ____nextSpireId_2 + 1
		____params_spire_id_3 = ____nextSpireId_2
	end
	self.spireId = ____params_spire_id_3
	self.owner = caster
	parent:SetOriginalModel(SPIRE_MODEL)
	parent:SetModelScale(1)
	self:Timer(FrameTime(), function()
		if not IsValidAlive(nil, parent) then
			return
		end
		parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
	end)
	local pfx = ParticleManager:CreateParticle(SPAWN_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(pfx, false, false, -1, false, false)
	EmitSoundOn(SPIRE_SPAWN_SOUND, parent)
	self:RegisterSpire(parent, caster)
	self:StartIntervalThink(0.25)
end
function modifier_elite_063_spire.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not ability or not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		SPIRE_AURA_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				ability,
				DebuffStatusType.ICE_SLOW,
				{ stack = SPIRE_SLOW_STACK, duration = SPIRE_SLOW_DURATION }
			)
		end
		::__continue21::
	end
end
function modifier_elite_063_spire.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:UnregisterSpire()
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_063_spire.prototype.IsHidden(self)
	return true
end
function modifier_elite_063_spire.prototype.IsPurgable(self)
	return false
end
function modifier_elite_063_spire.prototype.RegisterSpire(self, parent, caster)
	local list = self:GetSpireList(caster)
	list[#list + 1] = {
		id = self.spireId,
		thinker = parent,
		pos = parent:GetAbsOrigin(),
		endTime = GameRules:GetGameTime() + self:GetDuration(),
	}
end
function modifier_elite_063_spire.prototype.UnregisterSpire(self)
	local caster = self.owner
	if not caster or not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	local list = self:GetSpireList(caster)
	local index = __TS__ArrayFindIndex(list, function(____, entry)
		return entry.id == self.spireId
	end)
	if index >= 0 then
		__TS__ArraySplice(list, index, 1)
	end
end
function modifier_elite_063_spire.prototype.GetSpireList(self, caster)
	if not caster[____exports.LICH_SPIRE_KEY] then
		caster[____exports.LICH_SPIRE_KEY] = {}
	end
	return caster[____exports.LICH_SPIRE_KEY]
end
modifier_elite_063_spire =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_063_spire") }, modifier_elite_063_spire)
____exports.modifier_elite_063_spire = modifier_elite_063_spire
return ____exports