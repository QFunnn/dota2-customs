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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_void_spirit_phase_intro
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_simple_phase_summon = require("abilities.monster.boss.boss_simple_phase_summon")
local boss_simple_phase_summon = ____boss_simple_phase_summon.boss_simple_phase_summon
local SIMPLE_PHASE_SOUND = ____boss_simple_phase_summon.SIMPLE_PHASE_SOUND
local SIMPLE_PHASE_SUMMON_COUNT = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_COUNT
local SIMPLE_PHASE_SUMMON_RADIUS = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_RADIUS
local VOID_PHASE_DURATION = 7
local VOID_PHASE_INTRO_DURATION = 1
local VOID_PHASE_DISSIMILATE_RADIUS = 150
local VOID_PHASE_ASTRAL_STEP_EFFECT = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step.vpcf"
local VOID_PHASE_DISSIMILATE_EFFECT = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf"
local VOID_PHASE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_void_spirit.vsndevts"
local VOID_PHASE_ASTRAL_START_SOUND = "Hero_VoidSpirit.AstralStep.Start"
local VOID_PHASE_ASTRAL_END_SOUND = "Hero_VoidSpirit.AstralStep.End"
local VOID_PHASE_DISSIMILATE_PORTAL_SOUND = "Hero_VoidSpirit.Dissimilate.Portals"
local VOID_PHASE_DISSIMILATE_IN_SOUND = "Hero_VoidSpirit.Dissimilate.TeleportIn"
____exports.boss_void_spirit_phase_summon = __TS__Class()
local boss_void_spirit_phase_summon = ____exports.boss_void_spirit_phase_summon
boss_void_spirit_phase_summon.name = "boss_void_spirit_phase_summon"
__TS__ClassExtends(boss_void_spirit_phase_summon, boss_simple_phase_summon)
function boss_void_spirit_phase_summon.prototype.Precache(self, context)
	boss_simple_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", VOID_PHASE_ASTRAL_STEP_EFFECT, context)
	PrecacheResource("particle", VOID_PHASE_DISSIMILATE_EFFECT, context)
	PrecacheResource("soundfile", VOID_PHASE_SOUND_EVENTS, context)
end
function boss_void_spirit_phase_summon.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return 0
end
function boss_void_spirit_phase_summon.prototype.GetBossPhaseTransitionWindowDuration(self)
	return VOID_PHASE_DURATION
end
function boss_void_spirit_phase_summon.prototype.GetBossPhaseTransitionGesture(self)
	return ACT_DOTA_CAST_ABILITY_4
end
function boss_void_spirit_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	local cfg = boss_simple_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return __TS__ObjectAssign({}, cfg, {
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartVoidSpiritPhaseTransition(caster, self:GetSimplePhaseSummonConfig())
		end,
	})
end
function boss_void_spirit_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return { summonUnitName = "monster_10067", note = "紫老头：沿用已确认的 M006 召唤单位，剧毒刺蛇" }
end
function boss_void_spirit_phase_summon.prototype.StartVoidSpiritPhaseTransition(self, caster, config)
	local start = caster:GetAbsOrigin()
	local center = self:ResolveCenterPoint(caster)
	self:PlayVoidSpiritAstralStepEffect(start, center, caster)
	caster:SetAbsOrigin(center)
	FindClearSpaceForUnit(caster, center, true)
	self:SummonVoidSpiritPhaseMonsters(caster, config, center)
	self:StartSummonEffectLoop(caster, center)
end
function boss_void_spirit_phase_summon.prototype.SummonVoidSpiritPhaseMonsters(self, caster, config, center)
	local roomId = caster:GetRoomId()
	EmitSoundOnLocationWithCaster(center, SIMPLE_PHASE_SOUND, caster)
	do
		local i = 0
		while i < SIMPLE_PHASE_SUMMON_COUNT do
			local currentIndex = i
			local angle = math.pi * 2 * currentIndex / SIMPLE_PHASE_SUMMON_COUNT
			local offset =
				Vector(math.cos(angle) * SIMPLE_PHASE_SUMMON_RADIUS, math.sin(angle) * SIMPLE_PHASE_SUMMON_RADIUS, 0)
			local summonPos = GetGroundPosition(center:__add(offset), caster)
			local currentSummonPos = summonPos
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = config.summonUnitName,
				summonTag = "phase_summon_" .. caster:GetUnitName(),
				maxSummons = SIMPLE_PHASE_SUMMON_COUNT,
				position = currentSummonPos,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if not unit or not IsValidAlive(nil, unit) then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, currentSummonPos, caster:GetAbsOrigin()))
					modifier_boss_void_spirit_phase_intro:applys(
						unit,
						caster,
						self,
						{ duration = VOID_PHASE_INTRO_DURATION, radius = VOID_PHASE_DISSIMILATE_RADIUS }
					)
				end,
			})
			i = i + 1
		end
	end
end
function boss_void_spirit_phase_summon.prototype.PlayVoidSpiritAstralStepEffect(self, start, ____end, caster)
	local effect = ParticleManager:CreateParticle(VOID_PHASE_ASTRAL_STEP_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, start)
	ParticleManager:SetParticleControl(effect, 1, ____end)
	ParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOnLocationWithCaster(start, VOID_PHASE_ASTRAL_START_SOUND, caster)
	EmitSoundOnLocationWithCaster(____end, VOID_PHASE_ASTRAL_END_SOUND, caster)
end
boss_void_spirit_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_void_spirit_phase_summon)
____exports.boss_void_spirit_phase_summon = boss_void_spirit_phase_summon
modifier_boss_void_spirit_phase_intro = __TS__Class()
modifier_boss_void_spirit_phase_intro.name = "modifier_boss_void_spirit_phase_intro"
__TS__ClassExtends(modifier_boss_void_spirit_phase_intro, MonsterModifier_CS)
function modifier_boss_void_spirit_phase_intro.prototype.IsHidden(self)
	return true
end
function modifier_boss_void_spirit_phase_intro.prototype.IsPurgable(self)
	return false
end
function modifier_boss_void_spirit_phase_intro.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:AddNoDraw()
	local radius = params.radius or VOID_PHASE_DISSIMILATE_RADIUS
	self.effect = ParticleManager:CreateParticle(VOID_PHASE_DISSIMILATE_EFFECT, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(self.effect, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.effect, 1, Vector(radius, 0, 1))
	EmitSoundOnLocationWithCaster(parent:GetAbsOrigin(), VOID_PHASE_DISSIMILATE_PORTAL_SOUND, parent)
end
function modifier_boss_void_spirit_phase_intro.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if self.effect ~= nil then
		ParticleManager:DestroyParticle(self.effect, false)
		ParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end
	if IsValidAlive(nil, parent) then
		parent:RemoveNoDraw()
		parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
		EmitSoundOn(VOID_PHASE_DISSIMILATE_IN_SOUND, parent)
	end
end
function modifier_boss_void_spirit_phase_intro.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
modifier_boss_void_spirit_phase_intro = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_void_spirit_phase_intro") },
	modifier_boss_void_spirit_phase_intro
)
return ____exports