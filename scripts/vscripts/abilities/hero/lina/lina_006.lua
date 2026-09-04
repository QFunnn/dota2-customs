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
local modifier_lina_006_channel
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local MODIFIER_LINA_006_FLAME_ANCHOR = "modifier_lina_006_flame_anchor"
--- 烈焰炙烤光束：CP0/CP9 施法者头部，CP1 锚点 Thinker（modifier 父单位）
local LINA_006_SUNRAY_PARTICLE = "particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf"
--- Phoenix Sun Ray音效（soundevents 事件名，与日光束特效一致）
local LINA_006_SUNRAY_SOUND_CAST = "Hero_Phoenix.SunRay.Cast"
local LINA_006_SUNRAY_SOUND_LOOP = "Hero_Phoenix.SunRay.Loop"
local LINA_006_SUNRAY_SOUND_BEAM = "Hero_Phoenix.SunRay.Beam"
local LINA_006_SUNRAY_SOUND_STOP = "Hero_Phoenix.SunRay.Stop"
local LINA_006_SUNRAY_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts"
--- 符印「涅槃」：`ak_gems.csv` hero_data，持续喷射期间减伤（数值由 `lina_006_gem_nirvana_damage_reduction_pct` 配置）
local LINA_006_GEM_NIRVANA_KEY = "lina_006_gem_nirvana"
local LINA_006_GEM_NIRVANA_REDUCTION_PCT_KEY = "lina_006_gem_nirvana_damage_reduction_pct"
--- 符印「涅槃」周身特效：CP0/1 施法者原点，CP3.x=50
local LINA_006_GEM_NIRVANA_PARTICLE = "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf"
--- 与 `LockTargetForSpeed` 默认第二参数一致（内部再 ×30 为每帧角速度基准）
local LINA_006_AIM_EVENT = "c2s_lina_006_channel_aim"
local LINA_006_CMD_ROTATION_SPEED = 8
--- 线段半宽（与 lina_001 灼地检索同量级；未单独进 KV）
local LINA_006_BEAM_WIDTH = 125
--- 伤害与递增判定节拍（秒）；每秒期望伤害 = 各 tick 之和
local LINA_006_TICK_INTERVAL = 0.2
if IsServer() then
	CustomGameEventManager:RegisterListener(LINA_006_AIM_EVENT, function(_userId, event)
		local playerId = event.PlayerID
		if playerId == nil then
			return
		end
		local ____opt_0 = PlayerResource:GetPlayer(playerId)
		local hero = ____opt_0 and ____opt_0:GetAssignedHero()
		if not IsValidAlive(nil, hero) then
			return
		end
		local modifier = modifier_lina_006_channel:find_on(hero)
		if not modifier then
			return
		end
		local x = tonumber(event.x)
		local y = tonumber(event.y)
		local z = tonumber(event.z or 0)
		if x == nil or y == nil or z == nil then
			return
		end
		modifier:UpdateFacingWorldPos(Vector(x, y, z))
	end)
end
--- 丽娜技能 006 - 烈焰炙烤（点地非引导）
-- 施法时生成 Thinker，持续期间 Thinker 位于「施法者朝向前方 beam_spawn_distance」并每帧贴合；伤害与光束均为「施法者 → 锚点」线段，随玩家指令转身同步旋转。
-- 递增：以 modifier 已存在时间 `GetElapsedTime()` 为自变量，对每秒智力伤害与每秒耗蓝做相同线性放大（见 KV channel_ramp_pct_per_second；耗蓝见 channel_mana_cost_per_second）。
____exports.lina_006 = __TS__Class()
local lina_006 = ____exports.lina_006
lina_006.name = "lina_006"
__TS__ClassExtends(lina_006, BaseHeroAbility)
function lina_006.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_006_SUNRAY_PARTICLE, context)
	PrecacheResource("particle", LINA_006_GEM_NIRVANA_PARTICLE, context)
	PrecacheResource("soundfile", LINA_006_SUNRAY_SOUND_EVENTS, context)
end
function lina_006.prototype.GetAbilityConfig(self)
	return { castPoint = 0.2, behavior = DOTA_ABILITY_BEHAVIOR_POINT, manaCost = 0 }
end
function lina_006.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local spawnDist = self:GetSpecialValue("lina_006", "beam_spawn_distance")
	local fwd = caster:GetForwardVector()
	local flat = origin:__add(fwd:__mul(spawnDist))
	local skPos = GetGroundPosition(flat, caster)
	local anchorDuration = self:GetSpecialValue("lina_006", "channel_duration")
	caster:EmitSound(LINA_006_SUNRAY_SOUND_CAST)
	CreateModifierThinker(
		caster,
		self,
		"modifier_lina_006_flame_anchor",
		{ duration = anchorDuration },
		skPos,
		caster:GetTeamNumber(),
		false
	)
	caster:AddNewModifier(
		caster,
		self,
		"modifier_lina_006_channel",
		{ duration = anchorDuration, rotation_speed = LINA_006_CMD_ROTATION_SPEED }
	)
end
lina_006 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_006)
____exports.lina_006 = lina_006
--- 炙烤持续期间：缠绕 + 禁原生转向，由 ON_ORDER 更新「欲朝向的世界坐标」，每帧按 LockTargetForSpeed 同款步进转向。
modifier_lina_006_channel = __TS__Class()
modifier_lina_006_channel.name = "modifier_lina_006_channel"
__TS__ClassExtends(modifier_lina_006_channel, BaseHeroModifier)
function modifier_lina_006_channel.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self._rotationSpeedScaled = LINA_006_CMD_ROTATION_SPEED * 30
	self._gemNirvanaDamageReductionPct = 0
end
function modifier_lina_006_channel.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_006_channel.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_lina_006_channel.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING, MODIFIER_EVENT_ON_ORDER, MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_lina_006_channel.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_GENERIC_CHANNEL_1
end
function modifier_lina_006_channel.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_lina_006_channel.prototype.GetAttributeBonus(self)
	if self._gemNirvanaDamageReductionPct <= 0 then
		return {}
	end
	return { damage_reduction_pct = self._gemNirvanaDamageReductionPct }
end
function modifier_lina_006_channel.prototype.OnCreated(self, params)
	local hero = self:GetParent()
	local ____IsValidAlive_result_5 = IsValidAlive(nil, hero)
	if ____IsValidAlive_result_5 then
		local ____tonumber_4 = tonumber
		local ____opt_2 = hero.GetCustomValue
		____IsValidAlive_result_5 = ____tonumber_4(____opt_2 and ____opt_2(hero, LINA_006_GEM_NIRVANA_KEY) or 0) > 0
	end
	local hasNirvanaGem = ____IsValidAlive_result_5
	if hasNirvanaGem then
		local ____opt_6 = hero.GetCustomValue
		local pctRaw = ____opt_6 and ____opt_6(hero, LINA_006_GEM_NIRVANA_REDUCTION_PCT_KEY) or 0
		if pctRaw ~= nil then
			local pct = tonumber(pctRaw)
			if pct > 0 then
				self._gemNirvanaDamageReductionPct = pct
				self:RefreshAttributes()
			end
		end
	end
	if not IsServer() then
		return
	end
	if hasNirvanaGem then
		self:PlayNirvanaGemBuffParticle(hero)
	end
	if (params and params.rotation_speed) ~= nil and params.rotation_speed > 0 then
		self._rotationSpeedScaled = params.rotation_speed * 30
	end
	if (params and params.duration) ~= nil then
		self:SetDuration(math.max(0.1, params.duration), true)
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_lina_006_channel.prototype.PlayNirvanaGemBuffParticle(self, caster)
	local pid = ParticleManager:CreateParticle(LINA_006_GEM_NIRVANA_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(pid, 0, caster, PATTACH_ABSORIGIN_FOLLOW, nil, caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(pid, 1, caster, PATTACH_ABSORIGIN_FOLLOW, nil, caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(pid, 3, Vector(50, 0, 0))
	ParticleManager:SetParticleShouldCheckFoW(pid, false)
	self:AddParticle(pid, false, false, -1, false, false)
end
function modifier_lina_006_channel.prototype.OnOrder(self, event)
	if not IsServer() then
		return
	end
	if event.unit ~= self:GetParent() then
		return
	end
	local pos = self:resolveFacingPointFromOrder(event)
	if pos then
		self:UpdateFacingWorldPos(pos)
	end
end
function modifier_lina_006_channel.prototype.UpdateFacingWorldPos(self, pos)
	self._facingWorldPos = pos
end
function modifier_lina_006_channel.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local hero = self:GetParent()
	if not IsValidAlive(nil, hero) then
		self:Destroy()
		return
	end
	if not self._facingWorldPos then
		return
	end
	self:stepRotateTowardPoint(hero, self._facingWorldPos)
end
function modifier_lina_006_channel.prototype.stepRotateTowardPoint(self, unit, worldTarget)
	local frameInterval = FrameTime()
	if not IsValidAlive(nil, unit) then
		return
	end
	local origin = unit:GetOrigin()
	local dis = worldTarget:__sub(origin):Length2D()
	local directionToTarget = worldTarget:__sub(origin):Normalized()
	local cur = unit:GetForwardVector()
	local dx = cur.x
	local dy = cur.y
	local tx = directionToTarget.x
	local ty = directionToTarget.y
	local cross = dx * ty - dy * tx
	local dot = dx * tx + dy * ty
	local deltaDeg = math.atan2(cross, dot) * 180 / math.pi
	local distanceFactor = math.max(0.5, math.min(2, 2 - dis / 1500))
	local maxAngleDegPerFrame = self._rotationSpeedScaled * frameInterval * distanceFactor
	local stepDeg = math.max(-maxAngleDegPerFrame, math.min(maxAngleDegPerFrame, deltaDeg))
	local newForwardVector = RotateVector2D(nil, cur, stepDeg)
	unit:SetForwardVector(Vector(newForwardVector.x, newForwardVector.y, 0))
end
function modifier_lina_006_channel.prototype.resolveFacingPointFromOrder(self, event)
	local ev = event
	local orderType = event.order_type
	--- 原生 ON_ORDER 对单位目标几乎总是走 entindex_target，hScript target 常为 nil；必须先解析单位再考虑 new_pos，否则会“跳过”右键/A 人
	local targetUnit = self:resolveOrderTargetUnit(ev)
	if targetUnit and self:orderTypeShouldFaceTargetUnit(orderType) then
		return targetUnit:GetAbsOrigin()
	end
	if ev.new_pos then
		return ev.new_pos
	end
	return nil
end
function modifier_lina_006_channel.prototype.resolveOrderTargetUnit(self, ev)
	local idx = ev.entindex_target
	if idx ~= nil and idx > 0 then
		local ent = EntIndexToHScript(idx)
		if IsValid(nil, ent) and not ent:IsNull() and ent:IsBaseNPC() then
			return ent
		end
	end
	local t = ev.target
	if t and IsValid(nil, t) and not t:IsNull() and t:IsBaseNPC() then
		return t
	end
	return nil
end
function modifier_lina_006_channel.prototype.orderTypeShouldFaceTargetUnit(self, orderType)
	return orderType == DOTA_UNIT_ORDER_ATTACK_TARGET
		or orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET
		or orderType == DOTA_UNIT_ORDER_CAST_TARGET
		or orderType == DOTA_UNIT_ORDER_CAST_TARGET_TREE
		or orderType == DOTA_UNIT_ORDER_ATTACK_MOVE
end
modifier_lina_006_channel =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_lina_006_channel") }, modifier_lina_006_channel)
local modifier_lina_006_flame_anchor = __TS__Class()
modifier_lina_006_flame_anchor.name = "modifier_lina_006_flame_anchor"
__TS__ClassExtends(modifier_lina_006_flame_anchor, BaseHeroModifier)
function modifier_lina_006_flame_anchor.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self._damageAcc = 0
end
function modifier_lina_006_flame_anchor.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_006_flame_anchor.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		self:Destroy()
		return
	end
	if (params and params.duration) ~= nil then
		self:SetDuration(math.max(0.1, params.duration), true)
	end
	self._damageAcc = 0
	self:StartIntervalThink(FrameTime())
	self:PlaySunrayParticle()
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		caster:EmitSound(LINA_006_SUNRAY_SOUND_LOOP)
		caster:EmitSound(LINA_006_SUNRAY_SOUND_BEAM)
	end
end
function modifier_lina_006_flame_anchor.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if caster and IsValid(nil, caster) and not caster:IsNull() then
		caster:StopSound(LINA_006_SUNRAY_SOUND_LOOP)
		caster:EmitSound(LINA_006_SUNRAY_SOUND_STOP)
	end
end
function modifier_lina_006_flame_anchor.prototype.PlaySunrayParticle(self)
	local caster = self:GetCaster()
	local anchor = self:GetParent()
	if not IsValidAlive(nil, caster) or not IsValid(nil, anchor) then
		return
	end
	local pfx = ParticleManager:CreateParticle(LINA_006_SUNRAY_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_head",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		9,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_head",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(pfx, 1, anchor, PATTACH_ABSORIGIN_FOLLOW, nil, anchor:GetAbsOrigin(), true)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_lina_006_flame_anchor.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not IsValidAlive(nil, caster) or not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local spawnDist = ability:GetSpecialValue("lina_006", "beam_spawn_distance")
	local fwd = caster:GetForwardVector()
	local anchorFlat = caster:GetAbsOrigin():__add(fwd:__mul(spawnDist))
	local anchorPos = GetGroundPosition(anchorFlat, caster) + Vector(0, 0, 50)
	parent:SetAbsOrigin(anchorPos)
	local dt = FrameTime()
	self._damageAcc = self._damageAcc + dt
	while self._damageAcc >= LINA_006_TICK_INTERVAL do
		self._damageAcc = self._damageAcc - LINA_006_TICK_INTERVAL
		self:ApplyBeamDamageTick(caster, ability, parent)
	end
end
function modifier_lina_006_flame_anchor.prototype.InterruptBeamForMana(self, ability, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:RemoveModifierByName("modifier_lina_006_channel")
	caster:Stop()
	local lv = math.max(ability:GetLevel() - 1, 0)
	local cd = ability:GetCooldown(lv)
	if cd > 0 then
		ability:StartCooldown(cd)
	end
	self:Destroy()
end
function modifier_lina_006_flame_anchor.prototype.ApplyBeamDamageTick(self, caster, ability, anchor)
	if not IsValidAlive(nil, caster) then
		return
	end
	local lineStart = caster:GetAbsOrigin()
	if not IsValidAlive(nil, anchor) then
		return
	end
	local lineEnd = anchor:GetAbsOrigin()
	local intPct = ability:GetSpecialValue("lina_006", "int_damage_pct")
	local rampPctPerSec = ability:GetSpecialValue("lina_006", "channel_ramp_pct_per_second")
	--- 每秒耗蓝是成本配置，读取原始 KV，不参与宝石标签加成
	local manaPerSec = ability:GetSpecialValueRaw("lina_006", "channel_mana_cost_per_second")
	local hero = caster
	if not IsValidAlive(nil, hero) then
		return
	end
	local intellect = hero:GetIntellect(false)
	local elapsed = self:GetElapsedTime()
	local rampMult = 1 + rampPctPerSec / 100 * elapsed
	if manaPerSec > 0 then
		local manaCost = manaPerSec * LINA_006_TICK_INTERVAL * rampMult
		if caster:GetMana() < manaCost then
			self:InterruptBeamForMana(ability, caster)
			return
		end
		caster:SpendMana(manaCost, ability)
	end
	local damage = intellect * (intPct / 100) * rampMult * LINA_006_TICK_INTERVAL
	if damage <= 0 then
		return
	end
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakLineForHero(caster, lineStart, lineEnd, LINA_006_BEAM_WIDTH, ability)
	end
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		lineStart,
		lineEnd,
		nil,
		LINA_006_BEAM_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue73
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = { source_name = ability:GetAbilityName() },
			})
		end
		::__continue73::
	end
end
modifier_lina_006_flame_anchor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_006_flame_anchor)
return ____exports