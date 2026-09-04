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
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayFindIndex = ____lualib.__TS__ArrayFindIndex
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____tiny_ab2 = require("abilities.monster.boss_tiny.tiny_ab2")
local TREE_POS_KEY = ____tiny_ab2.TREE_POS_KEY
--- 移动到树木前的固定时间（秒），作为施法前摇
local MOVE_TO_TREE_DURATION = 1
--- 树木剩余持续时间需大于此值才可被选为拔树目标
local MIN_TREE_REMAINING = 2
--- 前摇期间暂存目标树木，供 OnStart 使用
local TINY_AB3_TARGET_TREE_KEY = "__tiny_ab3_target_tree__"
--- 投掷树木直线投射物特效：cp0 起点、cp1 终点
local TINY_TREE_LINEAR_PROJECTILE = "particles/cb/tiny_tree_linear_proj.vpcf"
--- 路径上落石特效：cp0 原点、cp1.x 范围
local ROCK_DROP_PARTICLE = "particles/cb/rock_drop.vpcf"
--- 投掷树木最大距离
local TINY_TREE_THROW_RANGE = 2000
--- 投掷树木碰撞半径（CreateProjectile 的 projectile_range）
local TINY_TREE_THROW_RADIUS = 380
--- 投掷树木伤害系数
local TINY_TREE_THROW_DAMAGE_RATE = 22
--- 路径落石：每多少秒在投射物位置附近播放一次特效
local ROCK_DROP_INTERVAL = 0.2
--- 路径落石：播放特效后延迟多少秒造成范围伤害
local ROCK_DROP_DAMAGE_DELAY = 0.5
--- 路径落石：伤害半径
local ROCK_DROP_DAMAGE_RADIUS = 200
--- 路径落石：落点相对投射物位置的随机偏移范围（半径）
local ROCK_DROP_SPAWN_RANDOM_RANGE = 300
--- 路径落石粒子保留时长（秒）
local ROCK_DROP_PFX_LIFETIME = 1.5
--- 路径落石伤害系数
local ROCK_DROP_DAMAGE_RATE = 12
--- 持树期间普攻：击退（与眩晕分开施加，眩晕固定 1s）
local HOLDING_TREE_KNOCKBACK_DURATION = 0.15
local HOLDING_TREE_KNOCKBACK_DISTANCE = 280
local HOLDING_TREE_KNOCKBACK_HEIGHT = 72
--- 持树期间普攻命中：眩晕时长（秒）
local HOLDING_TREE_ATTACK_STUN = 1
--- 小小 Boss 技能3：
-- - 无树时：移动到地面最近一棵树并拔起，获得「拿着树木」modifier；
-- - 有树时：释放当前 tiny_ab5 的投掷树木逻辑。
____exports.tiny_ab3 = __TS__Class()
local tiny_ab3 = ____exports.tiny_ab3
tiny_ab3.name = "tiny_ab3"
__TS__ClassExtends(tiny_ab3, MonsterAbility_CS)
function tiny_ab3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self._forward = Vector(0, 1, 0)
end
function tiny_ab3.prototype.GetCooldown(self, level)
	return 5
end
function tiny_ab3.prototype.Precache(self, context)
	PrecacheResource("particle", TINY_TREE_LINEAR_PROJECTILE, context)
	PrecacheResource("particle", ROCK_DROP_PARTICLE, context)
end
function tiny_ab3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = MOVE_TO_TREE_DURATION,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		canCast = function()
			local caster = self:GetCaster()
			local holding = ____exports.modifier_tiny_holding_tree:find_on(caster)
			if holding then
				return UF_SUCCESS
			end
			local ____temp_0
			if #self:GetValidTreesForGrab() > 0 then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local holding = ____exports.modifier_tiny_holding_tree:find_on(caster)
			if holding then
				local target = self:GetMinDistanceUnit(TINY_TREE_THROW_RANGE)
				self._caster:LockTargetForSpeed(target, MOVE_TO_TREE_DURATION, 2)
				local origin = self._caster:GetAbsOrigin():__add(Vector(0, 0, 96))
				local forward = self._caster:GetForwardVector()
				local endPos = origin:__add(forward:__mul(TINY_TREE_THROW_RANGE))
				self:WarningEffect(origin, endPos, MOVE_TO_TREE_DURATION, {
					endWidth = TINY_TREE_THROW_RADIUS,
					startWidth = TINY_TREE_THROW_RADIUS,
					getDirection = function()
						self._forward = self._caster:GetForwardVector()
						return self._caster:GetForwardVector()
					end,
				})
				return
			end
			local validTrees = self:GetValidTreesForGrab()
			if #validTrees == 0 then
				return
			end
			local origin = caster:GetAbsOrigin()
			local nearest = __TS__ArrayReduce(validTrees, function(____, a, b)
				local ____temp_1
				if GetDistance(nil, origin, a.pos) < GetDistance(nil, origin, b.pos) then
					____temp_1 = a
				else
					____temp_1 = b
				end
				return ____temp_1
			end)
			caster[TINY_AB3_TARGET_TREE_KEY] = nearest
			caster:StartGesture(ACT_DOTA_RUN)
			caster:Mover(nearest.pos, MOVE_TO_TREE_DURATION, function(____, position)
				caster:SetForwardVector(GetDirection(nil, nearest.pos, position))
				if GetDistance(nil, position, nearest.pos) < 100 then
					caster:RemoveGesture(ACT_DOTA_RUN)
					return true
				end
				return false
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local holding = ____exports.modifier_tiny_holding_tree:find_on(caster)
			if holding then
				holding:Destroy()
				local origin = caster:GetAbsOrigin():__add(Vector(0, 0, 96))
				local forward = self._forward
				local endPos = origin:__add(forward:__mul(TINY_TREE_THROW_RANGE))
				local abilityRef = self
				local rockDropLastTime = 0
				caster:EmitSound("Ability.Avalanche")
				CreateProjectile(nil, {
					projectile_type = "linear",
					caster = caster,
					target = endPos,
					effect_name = TINY_TREE_LINEAR_PROJECTILE,
					projectile_distance = TINY_TREE_THROW_RANGE,
					projectile_speed = 1500,
					projectile_range = TINY_TREE_THROW_RADIUS,
					projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
					projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
					ability = self,
					on_hit = function(____, target, _location, _extraData)
						if not IsValidAlive(nil, caster) then
							return
						end
						if target and IsValidAlive(nil, target) then
							caster:MonsterDamage({
								victim = target,
								damage_rate = TINY_TREE_THROW_DAMAGE_RATE,
								ability = abilityRef,
							})
							EmitSoundOnLocationWithCaster(target:GetAbsOrigin(), "Hero_Tiny_Tree.Impact", caster)
						end
						return false
					end,
					on_think = function(____, location)
						local now = GameRules:GetGameTime()
						if now - rockDropLastTime < ROCK_DROP_INTERVAL then
							return
						end
						rockDropLastTime = now
						local aheadPos = location:__add(forward:__mul(300))
						local offset = RandomVector(ROCK_DROP_SPAWN_RANDOM_RANGE)
						local spawnPos = aheadPos:__add(offset)
						local pfx = ParticleManager:CreateParticle(ROCK_DROP_PARTICLE, PATTACH_WORLDORIGIN, nil)
						ParticleManager:SetParticleControl(pfx, 0, spawnPos)
						ParticleManager:SetParticleControl(pfx, 1, Vector(ROCK_DROP_DAMAGE_RADIUS, 0, 0))
						Timers:CreateTimer(ROCK_DROP_PFX_LIFETIME, function()
							ParticleManager:DestroyParticle(pfx, false)
							ParticleManager:ReleaseParticleIndex(pfx)
							return nil
						end)
						EmitSoundOnLocationWithCaster(spawnPos, "Hero_Tiny_Tree.Throw", caster)
						Timers:CreateTimer(ROCK_DROP_DAMAGE_DELAY, function()
							if not IsValidAlive(nil, caster) then
								return nil
							end
							if not IsValid(nil, abilityRef) or abilityRef:IsNull() then
								return nil
							end
							EmitSoundOnLocationWithCaster(spawnPos, "Ability.TossImpact", caster)
							local enemies = FindUnitsInRadius(
								caster:GetTeamNumber(),
								spawnPos,
								nil,
								ROCK_DROP_DAMAGE_RADIUS,
								DOTA_UNIT_TARGET_TEAM_ENEMY,
								DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
								DOTA_UNIT_TARGET_FLAG_NONE,
								FIND_ANY_ORDER,
								false
							)
							for ____, enemy in ipairs(enemies) do
								if IsValidAlive(nil, enemy) then
									caster:MonsterDamage({
										victim = enemy,
										damage_rate = ROCK_DROP_DAMAGE_RATE,
										ability = abilityRef,
									})
								end
							end
							return nil
						end)
						return false
					end,
				})
				return
			end
			caster:RemoveGesture(ACT_DOTA_RUN)
			local target = caster[TINY_AB3_TARGET_TREE_KEY]
			__TS__Delete(caster, TINY_AB3_TARGET_TREE_KEY)
			if not target then
				return
			end
			caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
			self:RemoveTreeEntry(target)
			____exports.modifier_tiny_holding_tree:applys(caster, caster, self, {})
			caster:EmitSound("Hero_Tiny.Tree.Grab")
		end,
	}
end
function tiny_ab3.prototype.GetValidTreesForGrab(self)
	local caster = self:GetCaster()
	local list = caster[TREE_POS_KEY] or {}
	local now = GameRules:GetGameTime()
	return __TS__ArrayFilter(list, function(____, e)
		return e.endTime > now + MIN_TREE_REMAINING
	end)
end
function tiny_ab3.prototype.RemoveTreeEntry(self, entry)
	local caster = self:GetCaster()
	entry.removed = true
	if entry.unit and IsValid(nil, entry.unit) and not entry.unit:IsNull() then
		entry.unit:AddNoDraw()
		MyGameUnit:DestroyUnit(entry.unit)
		entry.unit = nil
	end
	ParticleManager:DestroyParticle(entry.pfx, false)
	ParticleManager:ReleaseParticleIndex(entry.pfx)
	local list = caster[TREE_POS_KEY]
	if list then
		local idx = __TS__ArrayFindIndex(list, function(____, e)
			return e.pfx == entry.pfx
		end)
		if idx >= 0 then
			__TS__ArraySplice(list, idx, 1)
		end
	end
end
tiny_ab3 = __TS__DecorateLegacy({ registerAbility(nil) }, tiny_ab3)
____exports.tiny_ab3 = tiny_ab3
--- 小小拿着树木的 modifier，拔树后施加；动态创建树木模型挂接在单位身上
local TINY_CLUB_MODEL = "models/items/tiny/burning_stone_giant_club/burning_stone_giant_club.vmdl"
____exports.modifier_tiny_holding_tree = __TS__Class()
local modifier_tiny_holding_tree = ____exports.modifier_tiny_holding_tree
modifier_tiny_holding_tree.name = "modifier_tiny_holding_tree"
__TS__ClassExtends(modifier_tiny_holding_tree, MonsterModifier_CS)
function modifier_tiny_holding_tree.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._treeEntity = nil
end
function modifier_tiny_holding_tree.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_tiny_holding_tree.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or not event.is_base_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) then
		return
	end
	local ability = self:GetAbility()
	local from = parent:GetAbsOrigin()
	local to = target:GetAbsOrigin()
	local v = to - from
	local len = v:Length2D() or 1
	local dir = Vector(v.x / len, v.y / len, 0)
	target:KnockBack(parent, ability, {
		duration = HOLDING_TREE_KNOCKBACK_DURATION,
		distance = HOLDING_TREE_KNOCKBACK_DISTANCE,
		height = HOLDING_TREE_KNOCKBACK_HEIGHT,
		direction = dir,
		heightType = "parabola",
		destroyTreesType = "onDestroy",
		removeOnDeath = true,
	})
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.STUN, { duration = HOLDING_TREE_ATTACK_STUN })
end
function modifier_tiny_holding_tree.prototype.IsHidden(self)
	return false
end
function modifier_tiny_holding_tree.prototype.IsPurgable(self)
	return false
end
function modifier_tiny_holding_tree.prototype.IsDebuff(self)
	return false
end
function modifier_tiny_holding_tree.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_tiny_holding_tree.prototype.GetActivityTranslationModifiers(self)
	return "tree"
end
function modifier_tiny_holding_tree.prototype.GetAttributeBonus(self)
	return { bonus_attack_range = 60, all_attack_damage_percent = 100 }
end
function modifier_tiny_holding_tree.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local treeEntity =
		SpawnEntityFromTableSynchronous("prop_dynamic", { model = TINY_CLUB_MODEL, defaultanim = "ACT_DOTA_IDLE" })
	if not treeEntity or not IsValid(nil, treeEntity) then
		return
	end
	self._treeEntity = treeEntity
	treeEntity:SetParent(parent, "")
	treeEntity:FollowEntity(parent, true)
end
function modifier_tiny_holding_tree.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._treeEntity ~= nil and IsValid(nil, self._treeEntity) then
		self._treeEntity:RemoveSelf()
		self._treeEntity = nil
	end
end
modifier_tiny_holding_tree =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_tiny_holding_tree") }, modifier_tiny_holding_tree)
____exports.modifier_tiny_holding_tree = modifier_tiny_holding_tree
return ____exports