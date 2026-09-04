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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_067_root
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1000
local CAST_POINT = 0.45
local TRAP_COUNT = 4
local TRAP_LENGTH = 720
local TRAP_WIDTH = 110
local TRAP_RANDOM_RADIUS = 1500
local ARM_DELAY = 0.5
local TRAP_ACTIVE_DURATION = 4
local ROOT_DURATION = 2
local ICE_SLOW_DURATION = 6
local ICE_STACK = 10
local DAMAGE_RATE = 15
local DETECT_INTERVAL = 0.1
local DEBUG_RING_RADIUS = 80
local DEBUG_RING_DURATION = 6
local TELEGRAPH_PARTICLE = "particles/unit/broodmother_scepter_sticky_snare_telegraph.vpcf"
local ROOT_PARTICLE = "particles/unit/monster/broodmother_scepter_sticky_snare_root.vpcf"
local BROODMOTHER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_broodmother.vsndevts"
local CAST_SOUND = "Hero_Broodmother.SpawnSpiderlingsCast"
local TRIGGER_SOUND = "Hero_Broodmother.SpawnSpiderlings"
--- 精英技能67 - 霜网孵巢：在目标脚下横向铺设线性蛛网，成型后捕获踏入敌人
____exports.elite_067 = __TS__Class()
local elite_067 = ____exports.elite_067
elite_067.name = "elite_067"
__TS__ClassExtends(elite_067, MonsterAbility_CS)
function elite_067.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.trapLines = {}
end
function elite_067.prototype.Precache(self, context)
	PrecacheResource("particle", TELEGRAPH_PARTICLE, context)
	PrecacheResource("particle", ROOT_PARTICLE, context)
	PrecacheResource("soundfile", BROODMOTHER_SOUND_EVENTS, context)
end
function elite_067.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 1,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			self:LockTrapLine()
		end,
		OnStart = function()
			self:CreateSnareTrap()
		end,
		OnInterrupt = function()
			self.trapLines = {}
		end,
	}
end
function elite_067.prototype.LockTrapLine(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindRandomEnemy()
	local targetOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 8)
		targetOrigin = GetGroundPosition(target:GetAbsOrigin(), target)
	end
	self.trapLines = {}
	do
		local i = 0
		while i < TRAP_COUNT do
			local center =
				self:GetGroundPoint(targetOrigin:__add(RandomVector(RandomFloat(0, TRAP_RANDOM_RADIUS))), caster)
			local direction = RotateVector2D(nil, Vector(1, 0, 0), RandomFloat(0, 360)):Normalized()
			local start = self:GetGroundPoint(center:__add(direction:__mul(TRAP_LENGTH * 0.5)), caster)
			local ____end = self:GetGroundPoint(center:__sub(direction:__mul(TRAP_LENGTH * 0.5)), caster)
			self:WarningEffect(start, ____end, CAST_POINT, { type = 2 })
			local ____self_trapLines_0 = self.trapLines
			____self_trapLines_0[#____self_trapLines_0 + 1] = { start = start, ["end"] = ____end }
			i = i + 1
		end
	end
end
function elite_067.prototype.CreateSnareTrap(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if #self.trapLines <= 0 then
		self:LockTrapLine()
	end
	local lines = self.trapLines
	self.trapLines = {}
	if #lines <= 0 then
		return
	end
	EmitSoundOn(CAST_SOUND, caster)
	for ____, line in ipairs(lines) do
		CreateModifierThinker(caster, self, "modifier_elite_067_snare_trap", {
			duration = ARM_DELAY + TRAP_ACTIVE_DURATION,
			start_x = line.start.x,
			start_y = line.start.y,
			start_z = line.start.z,
			end_x = line["end"].x,
			end_y = line["end"].y,
			end_z = line["end"].z,
		}, line.start, caster:GetTeamNumber(), false)
	end
end
function elite_067.prototype.FindRandomEnemy(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local enemies = __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, CAST_RANGE, 2, 1 + 18, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
	if #enemies <= 0 then
		return nil
	end
	return enemies[RandomInt(0, #enemies - 1) + 1]
end
function elite_067.prototype.GetGroundPoint(self, pos, caster)
	local groundZ = GetGroundHeight(pos, caster)
	return Vector(pos.x, pos.y, groundZ or pos.z)
end
elite_067 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_067)
____exports.elite_067 = elite_067
local modifier_elite_067_snare_trap = __TS__Class()
modifier_elite_067_snare_trap.name = "modifier_elite_067_snare_trap"
__TS__ClassExtends(modifier_elite_067_snare_trap, MonsterModifier_CS)
function modifier_elite_067_snare_trap.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.startPos = Vector(0, 0, 0)
	self.endPos = Vector(0, 0, 0)
	self.elapsed = 0
	self.caughtUnits = {}
end
function modifier_elite_067_snare_trap.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.startPos = Vector(params.start_x or 0, params.start_y or 0, params.start_z or 0)
	self.endPos = Vector(params.end_x or 0, params.end_y or 0, params.end_z or 0)
	self.elapsed = 0
	self.caughtUnits = {}
	self.particleId = ParticleManager:CreateParticle(TELEGRAPH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particleId, 0, self.startPos)
	ParticleManager:SetParticleControl(self.particleId, 1, self.endPos)
	ParticleManager:SetParticleControl(self.particleId, 2, Vector(TRAP_WIDTH, ARM_DELAY, TRAP_ACTIVE_DURATION))
	self:StartIntervalThink(DETECT_INTERVAL)
end
function modifier_elite_067_snare_trap.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + DETECT_INTERVAL
	if self.elapsed < ARM_DELAY then
		return
	end
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		self.startPos,
		self.endPos,
		nil,
		TRAP_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue28
			end
			local entIndex = enemy:entindex()
			if self.caughtUnits[entIndex] then
				goto __continue28
			end
			self.caughtUnits[entIndex] = true
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				ability,
				DebuffStatusType.ICE_SLOW,
				{ stack = ICE_STACK, duration = ICE_SLOW_DURATION }
			)
			modifier_elite_067_root:applys(enemy, caster, ability, { duration = ROOT_DURATION })
		end
		::__continue28::
	end
end
function modifier_elite_067_snare_trap.prototype.OnDestroy(self)
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
function modifier_elite_067_snare_trap.prototype.IsHidden(self)
	return true
end
function modifier_elite_067_snare_trap.prototype.IsPurgable(self)
	return false
end
modifier_elite_067_snare_trap =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_067_snare_trap") }, modifier_elite_067_snare_trap)
modifier_elite_067_root = __TS__Class()
modifier_elite_067_root.name = "modifier_elite_067_root"
__TS__ClassExtends(modifier_elite_067_root, MonsterModifier_CS)
function modifier_elite_067_root.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	EmitSoundOn(TRIGGER_SOUND, parent)
	local pfx = ParticleManager:CreateParticle(ROOT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_elite_067_root.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true }
end
function modifier_elite_067_root.prototype.IsHidden(self)
	return false
end
function modifier_elite_067_root.prototype.IsDebuff(self)
	return true
end
function modifier_elite_067_root.prototype.IsPurgable(self)
	return true
end
function modifier_elite_067_root.GetLocalizationCN(self)
	return { name = "霜网束缚", description = "被霜网缠住，无法移动，并受到强烈寒冷影响。" }
end
modifier_elite_067_root =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_067_root") }, modifier_elite_067_root)
return ____exports