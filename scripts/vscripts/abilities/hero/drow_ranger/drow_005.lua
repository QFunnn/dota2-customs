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
local ____Sync = require("modules.Sync")
local SyncGameEvent = ____Sync.SyncGameEvent
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 大箭弹道（项目现役 linear 粒子：elite_161 狙击穿刺箭同款）
local DROW_005_PROJECTILE_PARTICLE = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf"
--- 爆炸粒子（项目现役：寒星射击同款冰新星）
local DROW_005_EXPLOSION_PARTICLE = "particles/hero/dr/maiden_crystal_nova_cowlofice.vpcf"
local DROW_005_FIRE_SOUND = "Hero_Mirana.ArrowCast"
local DROW_005_EXPLOSION_SOUND = "Hero_Mirana.ArrowImpact"
--- 大箭判定宽度
local DROW_005_PROJECTILE_WIDTH = 120
--- 撤步技能名：施放它打断蓄力并退还蓝耗与冷却
local DROW_005_INTERRUPT_ABILITY_NAME = "drow_004"
--- 蓄力读条通道 id（channel_bar 前端组件按 id 管理）
local DROW_005_CHANNEL_BAR_ID = "drow_005_charge"
local DROW_005_CHANNEL_BAR_LABEL = "永夜蓄力"
--- 蓄力动画倍速兜底：动画倍速在开播瞬间被引擎锁定（不支持中途变速）
local DROW_005_CHARGE_ANIMATION_RATE = 0.25
--- DOTA_ATTACK 完整拉弓动画的原生时长（秒）：倍速=原生时长/实际蓄力时长，使整段动画恰好铺满蓄力（0.25 倍速铺满 3 秒反推）
local DROW_005_CHARGE_ANIMATION_NATIVE_LENGTH = 0.75
--- 符印「疾弦」：每满 100 敏捷对本技能伤害的增伤百分比（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=10/15/25，>0 即同时启用蓄力缩短）
local DROW_005_GEM_SWIFT_KEY = "drow_005_swift_agi_amp_pct"
--- 符印「冻原」：主箭命中敌人后冰冻地面每秒伤害占主箭基础伤害的百分比（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=25/40/70，>0 即启用）
local DROW_005_GEM_FROST_FIELD_KEY = "drow_005_frost_field_damage_pct"
--- 冻原地面半径
local DROW_005_FROST_FIELD_RADIUS = 600
--- 冻原持续秒数（每秒一跳，共 6 跳）
local DROW_005_FROST_FIELD_DURATION = 6
--- 冻原地面雪场氛围（凛冬之阵 drow_010 现役同款姿势）
local DROW_005_FROST_FIELD_PARTICLE =
	"particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_snow_arcana1.vpcf"
--- 疾弦蓄力缩短：每具有该值攻击速度缩短一档
local DROW_005_SWIFT_ATTACK_SPEED_STEP = 100
--- 疾弦每档缩短秒数
local DROW_005_SWIFT_REDUCTION_PER_STEP = 0.4
--- 疾弦蓄力缩短上限（秒），500 攻速触顶
local DROW_005_SWIFT_MAX_REDUCTION = 2
--- 符印「霜羽」：冰箭伤害占主箭伤害的百分比（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=50/60/70，>0 即启用）
local DROW_005_GEM_FEATHER_KEY = "drow_005_feather_damage_pct"
--- 霜羽每支冰箭所需全属性（力+敏+智三维总和），施放时快照
local DROW_005_FEATHER_ATTR_PER_ARROW = 400
--- 霜羽冰箭数量上限（2400 全属性触顶）
local DROW_005_FEATHER_MAX_ARROWS = 6
--- 霜羽浮空冰箭悬浮高度
local DROW_005_FEATHER_HOVER_HEIGHT = 150
--- 霜羽浮空冰箭横向间距（垂直于施法方向左右交错排开）
local DROW_005_FEATHER_HOVER_SPACING = 80
--- 霜羽冰箭发射错峰间隔（秒），微错峰成箭幕层次
local DROW_005_FEATHER_FIRE_INTERVAL = 0.05
--- 霜羽冰箭判定宽度（linear 兜底分支用，窄于主箭）
local DROW_005_FEATHER_PROJECTILE_WIDTH = 90
--- 霜羽追击冰箭弹道：drow 霜冻箭攻击弹道（tracking 系适配已验证；悬浮/linear 兜底仍用主箭 hoodwink 粒子）
local DROW_005_FEATHER_TRACKING_PARTICLE = "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
--- 霜羽追击冰箭弹速
local DROW_005_FEATHER_TRACKING_SPEED = 1400
--- 蓄力聚力特效（项目现役：boss_chaos 冰霜蓄能同款，环绕周身的凝冰聚能）
local DROW_005_CHARGE_EFFECT = "particles/dd/ice_buff.vpcf"
--- 卓尔游侠技能 005 - 永夜之矢
-- 主动（R 槽）：蓄力后向指定方向（施法时快照）射出一箭，蓄力期间 ROOTED 锁移动；
-- 施放撤步可打断蓄力并退还蓝耗与冷却。箭矢在命中的第一个敌人处爆炸，
-- 对范围内敌人造成总敏捷百分比的物理伤害；飞满未命中则在终点爆炸。
____exports.drow_005 = __TS__Class()
local drow_005 = ____exports.drow_005
drow_005.name = "drow_005"
__TS__ClassExtends(drow_005, BaseHeroAbility)
function drow_005.prototype.Precache(self, context)
	PrecacheResource("particle", DROW_005_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", DROW_005_EXPLOSION_PARTICLE, context)
	PrecacheResource("particle", DROW_005_CHARGE_EFFECT, context)
	PrecacheResource("particle", DROW_005_FEATHER_TRACKING_PARTICLE, context)
	PrecacheResource("particle", DROW_005_FROST_FIELD_PARTICLE, context)
end
function drow_005.prototype.GetAbilityConfig(self)
	return { castPoint = 0.1, castAnimation = "", behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function drow_005.prototype.GetChargeTime(self)
	return self:GetSpecialValue("drow_005", "charge_time")
end
function drow_005.prototype.GetSwiftAgiAmpPct(self)
	local caster = self:GetCaster()
	local ____tonumber_4 = tonumber
	local ____opt_0 = caster and caster.GetCustomValue
	return ____tonumber_4(____opt_0 and ____opt_0(caster, DROW_005_GEM_SWIFT_KEY) or 0)
end
function drow_005.prototype.GetFrostFieldDamagePct(self)
	local caster = self:GetCaster()
	local ____tonumber_9 = tonumber
	local ____opt_5 = caster and caster.GetCustomValue
	return ____tonumber_9(____opt_5 and ____opt_5(caster, DROW_005_GEM_FROST_FIELD_KEY) or 0)
end
function drow_005.prototype.GetEffectiveChargeTime(self)
	local base = self:GetChargeTime()
	if self:GetSwiftAgiAmpPct() <= 0 then
		return base
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return base
	end
	local attackSpeed = MyGameAttribute:GetAttribute(caster, "total_attack_speed") or 0
	local reduction = math.min(
		DROW_005_SWIFT_MAX_REDUCTION,
		math.floor(attackSpeed / DROW_005_SWIFT_ATTACK_SPEED_STEP) * DROW_005_SWIFT_REDUCTION_PER_STEP
	)
	return math.max(base - reduction, 0.5)
end
function drow_005.prototype.GetAgilityDamagePct(self)
	return self:GetSpecialValue("drow_005", "agility_damage_pct")
end
function drow_005.prototype.GetExplosionRadius(self)
	return self:GetSpecialValue("drow_005", "explosion_radius")
end
function drow_005.prototype.GetFeatherDamagePct(self)
	local caster = self:GetCaster()
	local ____tonumber_14 = tonumber
	local ____opt_10 = caster and caster.GetCustomValue
	return ____tonumber_14(____opt_10 and ____opt_10(caster, DROW_005_GEM_FEATHER_KEY) or 0)
end
function drow_005.prototype.GetFeatherArrowCount(self)
	if self:GetFeatherDamagePct() <= 0 then
		return 0
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return 0
	end
	local strength = MyGameAttribute:GetAttribute(caster, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(caster, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(caster, "total_intelligence") or 0
	local totalAttributes = math.max(0, strength + agility + intelligence)
	return math.min(DROW_005_FEATHER_MAX_ARROWS, math.floor(totalAttributes / DROW_005_FEATHER_ATTR_PER_ARROW))
end
function drow_005.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local cursor = self:GetCursorPosition()
	local rawDirection = GetDirection(nil, cursor, origin)
	local direction = Vector(rawDirection.x, rawDirection.y, 0):Normalized()
	local ____opt_15 = ____exports.modifier_drow_005_nightfall_charge:find_on(caster)
	if ____opt_15 ~= nil then
		____opt_15:Destroy()
	end
	____exports.modifier_drow_005_nightfall_charge:applys(caster, caster, self, {
		duration = self:GetEffectiveChargeTime(),
		dir_x = direction.x,
		dir_y = direction.y,
		feather_count = self:GetFeatherArrowCount(),
	})
end
function drow_005.prototype.FireNightfallArrow(self, caster, direction, feathers)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, caster) then
		self:ReleaseFeatherVisuals(feathers)
		return
	end
	local projectileDistance = self:GetSpecialValue("drow_005", "projectile_distance")
	local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 100))
	caster:EmitSound(DROW_005_FIRE_SOUND)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = DROW_005_PROJECTILE_PARTICLE,
		direction = direction,
		start_point = startPoint,
		projectile_type = "linear",
		projectile_speed = self:GetSpecialValue("drow_005", "projectile_speed"),
		projectile_distance = projectileDistance,
		projectile_range = DROW_005_PROJECTILE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget, location)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				self:ExplodeAt(caster, hitTarget:GetAbsOrigin())
				self:LaunchFeatherVolley(caster, feathers, hitTarget, direction)
				self:TrySpawnFrostField(caster, hitTarget:GetAbsOrigin())
				return true
			end
			local fallbackPoint = startPoint:__add(direction:__mul(projectileDistance))
			self:ExplodeAt(caster, location or fallbackPoint)
			self:LaunchFeatherVolley(caster, feathers, nil, direction)
			return true
		end,
	})
end
function drow_005.prototype.ReleaseFeatherVisuals(self, feathers)
	if not feathers then
		return
	end
	for ____, fx in ipairs(feathers.effects) do
		ParticleManager:DestroyParticle(fx, false)
		ParticleManager:ReleaseParticleIndex(fx)
	end
	feathers.effects = {}
end
function drow_005.prototype.LaunchFeatherVolley(self, caster, feathers, target, direction)
	if not feathers then
		return
	end
	self:ReleaseFeatherVisuals(feathers)
	if not IsValidAlive(nil, caster) then
		return
	end
	local featherPct = self:GetFeatherDamagePct()
	if featherPct <= 0 then
		return
	end
	local agility = MyGameAttribute:GetAttribute(caster, "total_agility") or 0
	local damage = agility * self:GetAgilityDamagePct() / 100 * (featherPct / 100)
	if damage <= 0 then
		return
	end
	local targetIndex = target and target:GetEntityIndex()
	do
		local i = 0
		while i < #feathers.positions do
			local spawnPoint = feathers.positions[i + 1]
			Timers:CreateTimer(DROW_005_FEATHER_FIRE_INTERVAL * i, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				if target and IsValidAlive(nil, target) and target:GetEntityIndex() == targetIndex then
					self:FireFeatherTracking(caster, spawnPoint, target, damage)
				else
					self:FireFeatherLinear(caster, spawnPoint, direction, damage)
				end
				return nil
			end)
			i = i + 1
		end
	end
end
function drow_005.prototype.FireFeatherTracking(self, caster, spawnPoint, target, damage)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = DROW_005_FEATHER_TRACKING_PARTICLE,
		projectile_type = "tracking",
		target = target,
		projectile_speed = DROW_005_FEATHER_TRACKING_SPEED,
		start_point = spawnPoint,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return true
			end
			if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
				return true
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = damage,
				damage_type = 2,
				ability = self,
			})
			return true
		end,
	})
end
function drow_005.prototype.FireFeatherLinear(self, caster, spawnPoint, direction, damage)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = DROW_005_PROJECTILE_PARTICLE,
		direction = direction,
		start_point = spawnPoint,
		projectile_type = "linear",
		projectile_speed = self:GetSpecialValue("drow_005", "projectile_speed"),
		projectile_distance = self:GetSpecialValue("drow_005", "projectile_distance"),
		projectile_range = DROW_005_FEATHER_PROJECTILE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return true
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = damage,
				damage_type = 2,
				ability = self,
			})
			return false
		end,
	})
end
function drow_005.prototype.TrySpawnFrostField(self, caster, center)
	local fieldPct = self:GetFrostFieldDamagePct()
	if fieldPct <= 0 then
		return
	end
	local agility = MyGameAttribute:GetAttribute(caster, "total_agility") or 0
	local tickDamage = agility * self:GetAgilityDamagePct() / 100 * (fieldPct / 100)
	if tickDamage <= 0 then
		return
	end
	local fieldFx = ParticleManager:CreateParticle(DROW_005_FROST_FIELD_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(fieldFx, false)
	ParticleManager:SetParticleControl(fieldFx, 0, center)
	do
		local i = 1
		while i <= DROW_005_FROST_FIELD_DURATION do
			Timers:CreateTimer(i, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				local enemies = self:FindMonsterEnemies(center, DROW_005_FROST_FIELD_RADIUS) or {}
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue53
						end
						Damage:ApplyDamage({
							attacker = caster,
							victim = enemy,
							damage = tickDamage,
							damage_type = 2,
							ability = self,
						})
					end
					::__continue53::
				end
				return nil
			end)
			i = i + 1
		end
	end
	Timers:CreateTimer(DROW_005_FROST_FIELD_DURATION, function()
		ParticleManager:DestroyParticle(fieldFx, false)
		ParticleManager:ReleaseParticleIndex(fieldFx)
		return nil
	end)
end
function drow_005.prototype.ExplodeAt(self, caster, point)
	local radius = self:GetExplosionRadius()
	local explosionFx =
		MyGameHeroParticleManager:CreateParticle(DROW_005_EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil, caster)
	MyGameHeroParticleManager:SetParticleControl(explosionFx, 0, point)
	MyGameHeroParticleManager:SetParticleControl(explosionFx, 1, Vector(radius, 2, radius * 3))
	MyGameHeroParticleManager:ReleaseParticleIndex(explosionFx)
	EmitSoundOnLocationWithCaster(point, DROW_005_EXPLOSION_SOUND, caster)
	local agility = MyGameAttribute:GetAttribute(caster, "total_agility") or 0
	local damage = agility * self:GetAgilityDamagePct() / 100
	local swiftAmpPct = self:GetSwiftAgiAmpPct()
	if swiftAmpPct > 0 then
		local agiSteps = math.floor(math.max(0, agility) / 100)
		damage = damage * (1 + agiSteps * swiftAmpPct / 100)
	end
	if damage <= 0 then
		return
	end
	local enemies = self:FindMonsterEnemies(point, radius) or {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue60
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = self,
			})
		end
		::__continue60::
	end
end
drow_005 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_005)
____exports.drow_005 = drow_005
--- 永夜之矢蓄力：ROOTED 锁移动，撤步打断（退蓝退 CD），自然到期发射
____exports.modifier_drow_005_nightfall_charge = __TS__Class()
local modifier_drow_005_nightfall_charge = ____exports.modifier_drow_005_nightfall_charge
modifier_drow_005_nightfall_charge.name = "modifier_drow_005_nightfall_charge"
__TS__ClassExtends(modifier_drow_005_nightfall_charge, BaseHeroModifier)
function modifier_drow_005_nightfall_charge.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.dirX = 0
	self.dirY = 0
	self.interrupted = false
	self.featherCount = 0
	self.featherEffects = {}
	self.featherPositions = {}
end
function modifier_drow_005_nightfall_charge.GetLocalizationCN(self)
	return {
		name = "永夜蓄力",
		description = "正在蓄力永夜之矢，无法移动。施放撤步可打断蓄力。",
	}
end
function modifier_drow_005_nightfall_charge.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_drow_005_nightfall_charge.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_drow_005_nightfall_charge.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_ATTACK
end
function modifier_drow_005_nightfall_charge.prototype.GetOverrideAnimationRate(self)
	local duration = self:GetDuration()
	local ____temp_19
	if duration > 0 then
		____temp_19 = DROW_005_CHARGE_ANIMATION_NATIVE_LENGTH / duration
	else
		____temp_19 = DROW_005_CHARGE_ANIMATION_RATE
	end
	return ____temp_19
end
function modifier_drow_005_nightfall_charge.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_drow_005_nightfall_charge.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_005_nightfall_charge.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.dirX = params.dir_x or 0
	self.dirY = params.dir_y or 0
	self.featherCount = math.max(0, math.floor(params.feather_count or 0))
	self.interrupted = false
	self:SendChargeBar("play")
	local parent = self:GetParent()
	if IsValidAlive(nil, parent) then
		self.chargeEffect = ParticleManager:CreateParticle(DROW_005_CHARGE_EFFECT, PATTACH_ABSORIGIN_FOLLOW, parent)
		ParticleManager:SetParticleControlEnt(
			self.chargeEffect,
			0,
			parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
		self:SpawnFeatherVisuals(parent)
	end
end
function modifier_drow_005_nightfall_charge.prototype.SpawnFeatherVisuals(self, parent)
	if self.featherCount <= 0 then
		return
	end
	local direction = Vector(self.dirX, self.dirY, 0)
	if direction:Length2D() <= 0 then
		return
	end
	local forward = direction:Normalized()
	do
		local i = 0
		while i < self.featherCount do
			local pos = self:GetFeatherHoverPosition(parent, forward, i)
			local fx = ParticleManager:CreateParticle(DROW_005_PROJECTILE_PARTICLE, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControlTransformForward(fx, 0, pos, forward)
			local ____self_featherEffects_20 = self.featherEffects
			____self_featherEffects_20[#____self_featherEffects_20 + 1] = fx
			local ____self_featherPositions_21 = self.featherPositions
			____self_featherPositions_21[#____self_featherPositions_21 + 1] = pos
			i = i + 1
		end
	end
end
function modifier_drow_005_nightfall_charge.prototype.GetFeatherHoverPosition(self, parent, forward, index)
	local perpendicular = Vector(-forward.y, forward.x, 0)
	local side = index % 2 == 0 and 1 or -1
	local rank = math.floor(index / 2) + 1
	local origin = parent:GetAbsOrigin()
	return origin
		+ perpendicular * (side * rank * DROW_005_FEATHER_HOVER_SPACING)
		- forward * 60
		+ Vector(0, 0, DROW_005_FEATHER_HOVER_HEIGHT)
end
function modifier_drow_005_nightfall_charge.prototype.ClearFeatherVisuals(self)
	for ____, fx in ipairs(self.featherEffects) do
		ParticleManager:DestroyParticle(fx, false)
		ParticleManager:ReleaseParticleIndex(fx)
	end
	self.featherEffects = {}
end
function modifier_drow_005_nightfall_charge.prototype.SendChargeBar(self, action)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local player = PlayerResource:GetPlayer(parent:GetPlayerOwnerID())
	if not player then
		return
	end
	if action == "play" then
		local ability = self:GetAbility()
		if not ability or not IsValid(nil, ability) then
			return
		end
		SyncGameEvent:Send_ServerToPlayer(player, "s2c_custom_channel_bar_play", {
			action = "play",
			channel_id = DROW_005_CHANNEL_BAR_ID,
			channel_time = self:GetDuration(),
			start_time = GameRules:GetGameTime(),
			is_slow_channel = true,
			context_entity_index = ability:entindex(),
			icon_type = "ability",
			show_icon = "drow_005",
			label = DROW_005_CHANNEL_BAR_LABEL,
		})
	else
		SyncGameEvent:Send_ServerToPlayer(
			player,
			"s2c_custom_channel_bar_play",
			{ action = "stop", channel_id = DROW_005_CHANNEL_BAR_ID, channel_time = 0, interrupted = self.interrupted }
		)
	end
end
function modifier_drow_005_nightfall_charge.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	if castAbility:GetAbilityName() ~= DROW_005_INTERRUPT_ABILITY_NAME then
		return
	end
	local ability = self:GetAbility()
	if ability and IsValid(nil, ability) then
		parent:GiveMana(ability:GetManaCost(-1))
		ability:EndCooldown()
	end
	self.interrupted = true
	self:Destroy()
end
function modifier_drow_005_nightfall_charge.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:SendChargeBar("stop")
	if self.chargeEffect ~= nil then
		ParticleManager:DestroyParticle(self.chargeEffect, false)
		ParticleManager:ReleaseParticleIndex(self.chargeEffect)
		self.chargeEffect = nil
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local direction = Vector(self.dirX, self.dirY, 0)
	if
		self.interrupted
		or not IsValidAlive(nil, parent)
		or not ability
		or not IsValid(nil, ability)
		or direction:Length2D() <= 0
	then
		self:ClearFeatherVisuals()
		return
	end
	local feathers = { positions = self.featherPositions, effects = self.featherEffects }
	self.featherEffects = {}
	self.featherPositions = {}
	ability:FireNightfallArrow(parent, direction:Normalized(), feathers)
end
function modifier_drow_005_nightfall_charge.prototype.GetTexture(self)
	return "drow_05"
end
modifier_drow_005_nightfall_charge = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_005_nightfall_charge)
____exports.modifier_drow_005_nightfall_charge = modifier_drow_005_nightfall_charge
return ____exports