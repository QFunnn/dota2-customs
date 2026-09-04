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
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
--- 小小 Boss 成长阶段在单位自定义键值中的 key，其他技能通过 GetCustomValue 读取
____exports.TINY_BOSS_GROWTH_STAGE_KEY = "tiny_boss_growth_stage"
--- 50% 血量以下时进化到 4 形态
local STAGE_HP_THRESHOLD = 60
--- 小小 4 个体型阶段模型（无大招 / 大招 1/2/3 级）
local TINY_MODELS = {
	"models/items/tiny/scarlet_quarry/scarlet_quarry01.vmdl",
	"models/items/tiny/scarlet_quarry/scarlet_quarry_02.vmdl",
	"models/items/tiny/scarlet_quarry/scarlet_quarry_03.vmdl",
	"models/items/tiny/scarlet_quarry/scarlet_quarry_04.vmdl",
}
--- 小小持握的树模型（预载入用）
local TINY_CLUB_MODEL = "models/items/tiny/burning_stone_giant_club/burning_stone_giant_club.vmdl"
--- 进化时在单位身上播放的特效
local TINY_TRANSFORM_PARTICLE = "particles/units/heroes/hero_tiny/tiny_transform_2_lvl4.vpcf"
--- 阶段切换时的踩地板特效
local TINY_GROW_STOMP_PARTICLE = "particles/tiny/centaur_warstomp.vpcf"
--- 阶段切换时特效1
local TINY_GROW_STOMP_PARTICLE_1 = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
--- 阶段切换时特效2
local TINY_GROW_STOMP_PARTICLE_2 = "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf"
--- 踩地板搜索和击退半径
local TINY_GROW_STOMP_RADIUS = 1500
--- 阶段切换打击粒子保留时长（秒）
local GROW_STOMP_PFX_1_LIFETIME = 2.2
local GROW_STOMP_PFX_2_LIFETIME = 2.5
--- 转阶段无敌和隐藏血条持续时间
local TINY_PHASE_TRANSITION_DURATION = 3
--- 转阶段窗口内动作重播间隔
local TINY_PHASE_TRANSITION_GESTURE_INTERVAL = 1
--- 转阶段直接召唤的树人单位
local TINY_PHASE_SUMMON_UNIT_NAME = "tiny_boss_treant"
--- 转阶段召唤树人数量
local TINY_PHASE_SUMMON_COUNT = 5
--- 转阶段树人生成半径
local TINY_PHASE_SUMMON_RADIUS = 650
--- 小小转阶段召唤物标签
local TINY_PHASE_SUMMON_TAG = "tiny_phase_treant"
--- 二阶段伤害和减伤加成
local TINY_PHASE_TWO_DAMAGE_BONUS_PCT = 10
--- 二阶段移速百分比加成
local TINY_PHASE_TWO_MOVESPEED_BONUS_PCT = 20
--- 二阶段攻速加成
local TINY_PHASE_TWO_ATTACK_SPEED_BONUS = 20
____exports.tiny_ab1 = __TS__Class()
local tiny_ab1 = ____exports.tiny_ab1
tiny_ab1.name = "tiny_ab1"
__TS__ClassExtends(tiny_ab1, BossPhaseTransitionAbility_CS)
function tiny_ab1.prototype.Precache(self, context)
	for ____, model in ipairs(TINY_MODELS) do
		PrecacheResource("model", model, context)
	end
	PrecacheResource("model", TINY_CLUB_MODEL, context)
	PrecacheResource("particle", TINY_TRANSFORM_PARTICLE, context)
	PrecacheResource("particle", TINY_GROW_STOMP_PARTICLE, context)
end
function tiny_ab1.prototype.GetBossPhaseTransitionHealthThresholdPct(self)
	return STAGE_HP_THRESHOLD
end
function tiny_ab1.prototype.ShouldApplyDefaultBossPhaseTransitionWindow(self)
	return false
end
function tiny_ab1.prototype.ShouldApplyDefaultBossPhaseTwoBuff(self)
	return false
end
function tiny_ab1.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = TINY_PHASE_TRANSITION_DURATION + self:GetBossPhaseTransitionReturnToSpawnDuration(),
		animationPlaybackRate = 0.6,
		castAnimation = ACT_TINY_GROWL,
		canCast = function()
			local caster = self:GetCaster()
			local ____caster_HasModifier_result_0
			if caster:HasModifier("modifier_tiny_ab1_buff") then
				____caster_HasModifier_result_0 = UF_FAIL_CUSTOM
			else
				____caster_HasModifier_result_0 = UF_SUCCESS
			end
			return ____caster_HasModifier_result_0
		end,
		OnStart = function()
			local caster = self:GetCaster()
			____exports.modifier_tiny_ab1_transition_window:applys(
				caster,
				caster,
				self,
				{ duration = TINY_PHASE_TRANSITION_DURATION }
			)
			self:SummonPhaseTreants(caster)
			caster:EmitSound("Tiny.Grow")
			ScreenShake(caster:GetAbsOrigin(), 30, 30, 0.5, 3000, 0, true)
			self:Timer(0.2, function()
				if not IsValid(nil, self) or self:IsNull() then
					return
				end
				if not IsValidAlive(nil, caster) then
					return
				end
				local model = TINY_MODELS[3]
				caster:SetOriginalModel(model)
				caster:SetModel(model)
				local pfx = ParticleManager:CreateParticle(TINY_GROW_STOMP_PARTICLE_1, PATTACH_WORLDORIGIN, caster)
				ParticleManager:SetParticleControl(pfx, 3, caster:GetAbsOrigin() + Vector(0, 0, 125))
				Timers:CreateTimer(GROW_STOMP_PFX_1_LIFETIME, function()
					ParticleManager:DestroyParticle(pfx, false)
					ParticleManager:ReleaseParticleIndex(pfx)
					return nil
				end)
				caster:StartGesture(ACT_TINY_GROWL)
				self:Timer(0.35, function()
					if not IsValid(nil, self) or self:IsNull() then
						return
					end
					if not IsValidAlive(nil, caster) then
						return
					end
					local pfx = ParticleManager:CreateParticle(TINY_GROW_STOMP_PARTICLE_2, PATTACH_WORLDORIGIN, caster)
					ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin() + Vector(0, 0, 125))
					ParticleManager:SetParticleControl(pfx, 1, Vector(1500, 0, 0))
					ParticleManager:SetParticleControl(pfx, 2, Vector(1500, 0, 0))
					Timers:CreateTimer(GROW_STOMP_PFX_2_LIFETIME, function()
						ParticleManager:DestroyParticle(pfx, false)
						ParticleManager:ReleaseParticleIndex(pfx)
						return nil
					end)
					local enemies = FindUnitsInRadius(
						caster:GetTeamNumber(),
						caster:GetAbsOrigin(),
						nil,
						TINY_GROW_STOMP_RADIUS,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						DOTA_UNIT_TARGET_FLAG_NONE,
						FIND_ANY_ORDER,
						false
					)
					for ____, enemy in ipairs(enemies) do
						if IsValidAlive(nil, enemy) then
							caster:MonsterDamage({ victim = enemy, damage_rate = 5, ability = self })
							AddDeBuffStatus(
								nil,
								enemy,
								self:GetCaster(),
								self,
								DebuffStatusType.STUN,
								{ duration = 1.5 }
							)
						end
					end
				end)
			end)
			self:Timer(TINY_PHASE_TRANSITION_DURATION, function()
				if not IsValid(nil, self) or self:IsNull() then
					return
				end
				if not IsValidAlive(nil, caster) then
					return
				end
				____exports.modifier_tiny_ab1_buff:applys(caster, caster, self, {})
			end)
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:StartGestureWithPlaybackRate(ACT_TINY_GROWL, 1)
		end,
	}
end
function tiny_ab1.prototype.SummonPhaseTreants(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local roomId = caster:GetRoomId()
	do
		local i = 0
		while i < TINY_PHASE_SUMMON_COUNT do
			local angle = math.pi * 2 * i / TINY_PHASE_SUMMON_COUNT
			local offset =
				Vector(math.cos(angle) * TINY_PHASE_SUMMON_RADIUS, math.sin(angle) * TINY_PHASE_SUMMON_RADIUS, 0)
			local currentPosition = origin + offset
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = TINY_PHASE_SUMMON_UNIT_NAME,
				summonTag = TINY_PHASE_SUMMON_TAG,
				maxSummons = TINY_PHASE_SUMMON_COUNT,
				position = currentPosition,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if not IsValid(nil, self) or self:IsNull() then
						return
					end
					if not IsValidAlive(nil, caster) then
						return
					end
					if not unit or not IsValid(nil, unit) or unit:IsNull() then
						return
					end
					unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, caster:GetAbsOrigin(), currentPosition))
					unit:AddNewModifier(unit, nil, "modifier_monster_born", { duration = 1.2 })
				end,
			})
			i = i + 1
		end
	end
end
tiny_ab1 = __TS__DecorateLegacy({ registerAbility(nil) }, tiny_ab1)
____exports.tiny_ab1 = tiny_ab1
____exports.modifier_tiny_ab1_transition_window = __TS__Class()
local modifier_tiny_ab1_transition_window = ____exports.modifier_tiny_ab1_transition_window
modifier_tiny_ab1_transition_window.name = "modifier_tiny_ab1_transition_window"
__TS__ClassExtends(modifier_tiny_ab1_transition_window, MonsterModifier_CS)
function modifier_tiny_ab1_transition_window.prototype.IsHidden(self)
	return true
end
function modifier_tiny_ab1_transition_window.prototype.IsPurgable(self)
	return false
end
function modifier_tiny_ab1_transition_window.prototype.IsDebuff(self)
	return false
end
function modifier_tiny_ab1_transition_window.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:HideBossBar()
	self:PlayTransitionGesture()
	self:StartIntervalThink(TINY_PHASE_TRANSITION_GESTURE_INTERVAL)
end
function modifier_tiny_ab1_transition_window.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetParent():FadeGesture(ACT_TINY_GROWL)
	self:RestoreBossBar()
end
function modifier_tiny_ab1_transition_window.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:PlayTransitionGesture()
end
function modifier_tiny_ab1_transition_window.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end
function modifier_tiny_ab1_transition_window.prototype.HideBossBar(self)
	local parent = self:GetParent()
	local key = tostring(parent:entindex())
	local ____opt_1 = MyGameBossBarManager and MyGameBossBarManager.bossBar
	local entry = ____opt_1 and ____opt_1[key]
	if not entry then
		return
	end
	local ____entry_BossID_6 = entry.BossID
	local ____entry_PlayerIDs_5
	if entry.PlayerIDs then
		____entry_PlayerIDs_5 = { __TS__Spread(entry.PlayerIDs) }
	else
		____entry_PlayerIDs_5 = nil
	end
	self.bossBarEntry = { BossID = ____entry_BossID_6, PlayerIDs = ____entry_PlayerIDs_5 }
	MyGameBossBarManager.bossBar[key] = nil
	MyGameBossBarManager:SyncNetTabel()
end
function modifier_tiny_ab1_transition_window.prototype.RestoreBossBar(self)
	if not self.bossBarEntry then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local key = tostring(parent:entindex())
	MyGameBossBarManager.bossBar[key] = self.bossBarEntry
	MyGameBossBarManager:SyncNetTabel()
	self.bossBarEntry = nil
end
function modifier_tiny_ab1_transition_window.prototype.PlayTransitionGesture(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:StartGestureWithPlaybackRate(ACT_TINY_GROWL, 0.8)
end
modifier_tiny_ab1_transition_window = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_tiny_ab1_transition_window") },
	modifier_tiny_ab1_transition_window
)
____exports.modifier_tiny_ab1_transition_window = modifier_tiny_ab1_transition_window
____exports.modifier_tiny_ab1_buff = __TS__Class()
local modifier_tiny_ab1_buff = ____exports.modifier_tiny_ab1_buff
modifier_tiny_ab1_buff.name = "modifier_tiny_ab1_buff"
__TS__ClassExtends(modifier_tiny_ab1_buff, MonsterModifier_CS)
function modifier_tiny_ab1_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():SetCustomValue(____exports.TINY_BOSS_GROWTH_STAGE_KEY, 3)
end
function modifier_tiny_ab1_buff.prototype.IsHidden(self)
	return false
end
function modifier_tiny_ab1_buff.prototype.IsPurgable(self)
	return false
end
function modifier_tiny_ab1_buff.prototype.IsDebuff(self)
	return false
end
function modifier_tiny_ab1_buff.prototype.GetAttributeBonus(self)
	return {
		outgoing_damage_pct = TINY_PHASE_TWO_DAMAGE_BONUS_PCT,
		damage_reduction_pct = TINY_PHASE_TWO_DAMAGE_BONUS_PCT,
		bonus_movespeed_pct = TINY_PHASE_TWO_MOVESPEED_BONUS_PCT,
		attack_speed = TINY_PHASE_TWO_ATTACK_SPEED_BONUS,
	}
end
modifier_tiny_ab1_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_tiny_ab1_buff") }, modifier_tiny_ab1_buff)
____exports.modifier_tiny_ab1_buff = modifier_tiny_ab1_buff
return ____exports