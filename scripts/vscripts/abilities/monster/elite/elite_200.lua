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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 命中特效：虚空之灵星界步斩击
local pfx4 = "particles/void_spirit_astral_step_impact_red.vpcf"
--- 裂地波特效：该粒子不能挂在线性投射物上，需要绑定移动马甲
local WAVE_PARTICLE = "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test_3.vpcf"
--- 裂地波飞行距离
local WAVE_DISTANCE = 1500
--- 裂地波飞行速度
local WAVE_SPEED = 2000
--- 裂地波命中半径
local WAVE_RADIUS = 250
--- 裂地波起点前移距离
local WAVE_START_OFFSET = 100
--- 裂地波马甲持续时间
local WAVE_DURATION = WAVE_DISTANCE / WAVE_SPEED
--- 裂地波伤害倍率
local WAVE_DAMAGE_RATE = 25
--- 命中击退距离
local HIT_KNOCKBACK_DISTANCE = 220
--- 命中击退持续时间
local HIT_KNOCKBACK_DURATION = 0.35
--- 击退结束后额外眩晕时间
local HIT_STUN_EXTRA_DURATION = 0.45
--- 斩击动作到裂地波生成的延迟
local WAVE_RELEASE_DELAY = 0.15
--- 裂地波生成后追加连招的延迟
local FOLLOW_UP_AFTER_WAVE_DELAY = 0.8
--- 等待当前技能控制器结束后再下达连招指令
local FOLLOW_UP_ORDER_DELAY = WAVE_RELEASE_DELAY + FOLLOW_UP_AFTER_WAVE_DELAY + 0.03
--- 裂地斩后的随机追加技能池
local FOLLOW_UP_ABILITY_NAMES = { "elite_144", "elite_145" }
--- 前端显示与怪物施法判定使用的固定施法距离
local CAST_RANGE = 1100
--- 前摇锁敌搜索范围
local TARGET_SEARCH_RANGE = 3500
--- 精英技能 200 - 裂地斩：后撤后向前斩出裂地波，对命中敌人击退眩晕。
local elite_200 = __TS__Class()
elite_200.name = "elite_200"
__TS__ClassExtends(elite_200, MonsterAbility_CS)
function elite_200.prototype.Precache(self, context)
	PrecacheResource("particle", pfx4, context)
	PrecacheResource("particle", WAVE_PARTICLE, context)
end
function elite_200.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.6,
		castDuration = 0.8,
		animationPlaybackRate = 1.1,
		castAnimation = "",
		castRange = CAST_RANGE,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local forward = caster:GetForwardVector()
			local target = caster:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
			caster:SetAnimation("golem_attack2")
			local ____ = target and caster:LockTargetForSpeed(target, 1, 3)
			local backward = caster:GetAbsOrigin():__add(forward:__mul(-150))
			caster:Mover(backward, 0.2)
			self:WarningEffect(backward, caster:GetAbsOrigin():__add(forward:__mul(WAVE_DISTANCE)), 1, {
				getDirection = function()
					return caster:GetForwardVector()
				end,
				startWidth = WAVE_RADIUS * 0.8,
				endWidth = WAVE_RADIUS * 0.8,
				follow = true,
			})
		end,
		OnStart = function()
			return self:SpellStart()
		end,
	}
end
function elite_200.prototype.SpellStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetAnimation("golem_attack")
	self:Timer(WAVE_RELEASE_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:PlayAttack()
		caster:EmitSound("Hero_Invoker.DeafeningBlast")
		local direction = self:GetFlatDirection(caster:GetForwardVector())
		ScreenShake(caster:GetAbsOrigin(), 10, 10, 1, 3000, 0, true)
		local startPos = GetGroundPosition(caster:GetAbsOrigin():__add(direction:__mul(WAVE_START_OFFSET)), caster)
		local thinker = CreateModifierThinker(caster, self, "modifier_elite_200_wave_thinker", {
			duration = WAVE_DURATION + FrameTime() * 2,
			dirX = direction.x,
			dirY = direction.y,
			dirZ = direction.z,
		}, startPos, caster:GetTeamNumber(), false)
		if IsValidAlive(nil, thinker) then
			thinker:SetForwardVector(direction)
		end
	end)
	self:Timer(FOLLOW_UP_ORDER_DELAY, function()
		self:CastRandomFollowUpAbility()
	end)
end
function elite_200.prototype.PlayAttack(self)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle("particles/dd/attack_03.vpcf", PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 4, caster:GetAbsOrigin())
	Timers:CreateTimer(0.2, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_200.prototype.GetFlatDirection(self, direction)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return flatDirection:Normalized()
end
function elite_200.prototype.CastRandomFollowUpAbility(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if caster:IsStunned() or caster:IsSilenced() or caster:IsChanneling() then
		return
	end
	local abilities = {}
	for ____, abilityName in ipairs(FOLLOW_UP_ABILITY_NAMES) do
		do
			local ability = caster:FindAbilityByName(abilityName)
			if not ability or ability:IsPassive() then
				goto __continue20
			end
			abilities[#abilities + 1] = ability
		end
		::__continue20::
	end
	if #abilities <= 0 then
		return
	end
	local ability = abilities[RandomInt(0, #abilities - 1) + 1]
	ability:EndCooldown()
	caster:Stop()
	caster:CastAbilityNoTarget(ability, caster:GetPlayerOwnerID())
end
elite_200 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_200)
local modifier_elite_200_wave_thinker = __TS__Class()
modifier_elite_200_wave_thinker.name = "modifier_elite_200_wave_thinker"
__TS__ClassExtends(modifier_elite_200_wave_thinker, MonsterModifier_CS)
function modifier_elite_200_wave_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.direction = Vector(1, 0, 0)
	self.traveled = 0
	self.hitTargets = __TS__New(Set)
end
function modifier_elite_200_wave_thinker.prototype.IsHidden(self)
	return true
end
function modifier_elite_200_wave_thinker.prototype.IsPurgable(self)
	return false
end
function modifier_elite_200_wave_thinker.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_elite_200_wave_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.direction = Vector(tonumber(params.dirX) or 0, tonumber(params.dirY) or 0, tonumber(params.dirZ) or 0)
	if self.direction:Length2D() <= 0.01 then
		self.direction = parent:GetForwardVector()
	else
		self.direction = Vector(self.direction.x, self.direction.y, 0):Normalized()
	end
	parent:SetForwardVector(self.direction)
	self:CreateWaveParticle(parent)
	self:HitEnemies(parent:GetAbsOrigin())
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_200_wave_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local dt = FrameTime()
	local step = WAVE_SPEED * dt
	local origin = parent:GetAbsOrigin()
	local nextPos = GetGroundPosition(origin:__add(self.direction:__mul(step)), parent)
	parent:SetForwardVector(self.direction)
	parent:SetAbsOrigin(nextPos)
	GridNav:DestroyTreesAroundPoint(nextPos, WAVE_RADIUS, false)
	self.traveled = self.traveled + step
	self:HitEnemies(nextPos)
	if self.traveled >= WAVE_DISTANCE then
		self:Destroy()
	end
end
function modifier_elite_200_wave_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:DestroyWaveParticle()
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_200_wave_thinker.prototype.CreateWaveParticle(self, parent)
	self.particleId = ParticleManager:CreateParticle(WAVE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.particleId, false)
	ParticleManager:SetParticleControlEnt(
		self.particleId,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_origin",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(self.particleId, 0, self.direction)
end
function modifier_elite_200_wave_thinker.prototype.DestroyWaveParticle(self)
	if self.particleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self.particleId, false)
	ParticleManager:ReleaseParticleIndex(self.particleId)
	self.particleId = nil
end
function modifier_elite_200_wave_thinker.prototype.HitEnemies(self, center)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		WAVE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue43
			end
			local enemyIndex = enemy:GetEntityIndex()
			if self.hitTargets:has(enemyIndex) then
				goto __continue43
			end
			self.hitTargets:add(enemyIndex)
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = WAVE_DAMAGE_RATE,
				ability = ability,
				effectName = pfx4,
			})
			enemy:KnockBack(caster, ability, {
				direction = self.direction,
				duration = HIT_KNOCKBACK_DURATION,
				distance = HIT_KNOCKBACK_DISTANCE,
				height = 100,
				stun = true,
				stunDuration = HIT_STUN_EXTRA_DURATION,
				uniform = true,
				destroyTreesRange = 120,
				destroyTreesType = "continues",
			})
		end
		::__continue43::
	end
end
modifier_elite_200_wave_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_200_wave_thinker") }, modifier_elite_200_wave_thinker)
return ____exports