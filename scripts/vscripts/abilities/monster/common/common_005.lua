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
local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
local findHeroesInRadius = ____monster_warning_effects.findHeroesInRadius
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 环绕球数量（thinker 数量）
local COMMON_005_ORB_COUNT = 5
--- 环绕半径（码）
local COMMON_005_ORBIT_RADIUS = 400
--- 环绕特效相对落地点统一抬高（Z，码）
local COMMON_005_ORBIT_Z_OFFSET = 75
--- 伤害环带：与携带者 2D 距离 ∈ [min, max]（码，含端点）。
-- 仅在此环带内造成伤害；与轨道半径 400 无强制关联，可按需改数值。
local COMMON_005_DAMAGE_RANGE = { 350, 450 }
--- 环绕角速度（度/秒），360°/s = 每秒一圈
local COMMON_005_ORBIT_DEG_PER_SEC = 360
--- thinker 位置刷新间隔（秒）
local COMMON_005_VISUAL_INTERVAL = 0.03
--- 伤害结算间隔（秒）
local COMMON_005_DAMAGE_INTERVAL = 0.2
--- 伤害倍率
local COMMON_005_DAMAGE_RATE = 15
--- thinker 上轨道球 modifier 持续时间（秒；施法者死亡后由 orb 自身 interval 清掉）
local COMMON_005_ORB_THINKER_DURATION = 999999
--- 轨道 thinker 检测施法者是否存活间隔（秒）
local COMMON_005_ORB_CASTER_CHECK_INTERVAL = 0.05
local PARTICLE_ORB = "particles/monster/ability_5.vpcf"
--- 每次伤害结算时在目标处播放（CP0 为原点）
local PARTICLE_DAMAGE_HIT = "particles/units/heroes/hero_wisp/wisp_tether_hit.vpcf"
--- 伤害命中粒子自动回收延迟（秒）
local COMMON_005_HIT_PFX_LIFETIME = 3
--- 挂在轨道 thinker 上，OnDestroy / 自毁时释放粒子
local COMMON_005_ORB_PFX_KEY = "__common005_orb_pfx__"
local function Common005GetDamageAttacker(self, caster)
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetRoomId
	local roomId = ____opt_0 and ____opt_0(____this_1)
	if roomId == nil or roomId == nil then
		return caster
	end
	local room = MyGameRoomManager:GetRoom(tostring(roomId))
	return room and room:GetRoomDummy() or caster
end
--- 怪物通用技能5 - 被动：5 个 thinker 沿 400 码轨道公转（特效载体，360°/s，Z +75）；
-- 每秒对 `COMMON_005_DAMAGE_RANGE` 环带内敌人结算伤害；轨道 thinker 定时检测施法者存活，死亡则自毁并清特效。
____exports.common_005 = __TS__Class()
local common_005 = ____exports.common_005
common_005.name = "common_005"
__TS__ClassExtends(common_005, MonsterAbility_CS)
function common_005.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_ORB, context)
end
function common_005.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function common_005.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_005"
end
common_005 = __TS__DecorateLegacy({ registerAbility(nil) }, common_005)
____exports.common_005 = common_005
--- 轨道 thinker：粒子挂在 thinker 上；定时检测施法者存活，死亡则销毁粒子并移除 thinker
local modifier_common_005_orb_thinker = __TS__Class()
modifier_common_005_orb_thinker.name = "modifier_common_005_orb_thinker"
__TS__ClassExtends(modifier_common_005_orb_thinker, MonsterModifier_CS)
function modifier_common_005_orb_thinker.prototype.IsHidden(self)
	return true
end
function modifier_common_005_orb_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local pid = ParticleManager:CreateParticle(PARTICLE_ORB, PATTACH_ABSORIGIN_FOLLOW, thinker)
	ParticleManager:SetParticleShouldCheckFoW(pid, false)
	thinker[COMMON_005_ORB_PFX_KEY] = pid
	self:StartIntervalThink(COMMON_005_ORB_CASTER_CHECK_INTERVAL)
end
function modifier_common_005_orb_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		return
	end
	self:releaseParticleAndRemoveThinker()
end
function modifier_common_005_orb_thinker.prototype.releaseParticleAndRemoveThinker(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local thinker = self:GetParent()
	self:destroyParticleOnThinker(thinker)
	if IsValid(nil, thinker) and not thinker:IsNull() then
		thinker:RemoveSelf()
	end
end
function modifier_common_005_orb_thinker.prototype.destroyParticleOnThinker(self, thinker)
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local pid = thinker[COMMON_005_ORB_PFX_KEY]
	if pid ~= nil then
		ParticleManager:DestroyParticle(pid, false)
		ParticleManager:ReleaseParticleIndex(pid)
		thinker[COMMON_005_ORB_PFX_KEY] = nil
	end
end
function modifier_common_005_orb_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self:destroyParticleOnThinker(thinker)
end
function modifier_common_005_orb_thinker.prototype.IsPurgable(self)
	return false
end
modifier_common_005_orb_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_common_005_orb_thinker") }, modifier_common_005_orb_thinker)
local modifier_common_005 = __TS__Class()
modifier_common_005.name = "modifier_common_005"
__TS__ClassExtends(modifier_common_005, MonsterModifier_CS)
function modifier_common_005.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.orbThinkers = {}
	self.lastDamageGameTime = 0
end
function modifier_common_005.prototype.IsHidden(self)
	return true
end
function modifier_common_005.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	caster:EmitSound("Hero_Leshrac.Pulse_Nova")
	self.lastDamageGameTime = GameRules:GetGameTime()
	local center = caster:GetAbsOrigin()
	local now = GameRules:GetGameTime()
	local theta = now * COMMON_005_ORBIT_DEG_PER_SEC * (math.pi / 180)
	do
		local i = 0
		while i < COMMON_005_ORB_COUNT do
			local phase = theta + i * 2 * math.pi / COMMON_005_ORB_COUNT
			local pos = self:computeOrbWorldPos(caster, center, phase)
			local th = CreateModifierThinker(
				caster,
				ability,
				"modifier_common_005_orb_thinker",
				{ duration = COMMON_005_ORB_THINKER_DURATION },
				pos,
				caster:GetTeamNumber(),
				false
			)
			local ____self_orbThinkers_4 = self.orbThinkers
			____self_orbThinkers_4[#____self_orbThinkers_4 + 1] = th
			i = i + 1
		end
	end
	self:StartIntervalThink(COMMON_005_VISUAL_INTERVAL)
end
function modifier_common_005.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local now = GameRules:GetGameTime()
	self:moveOrbThinkers(caster, now)
	if now - self.lastDamageGameTime >= COMMON_005_DAMAGE_INTERVAL then
		self.lastDamageGameTime = now
		self:applyDamage()
	end
end
function modifier_common_005.prototype.computeOrbWorldPos(self, caster, center, phase)
	local x = center.x + COMMON_005_ORBIT_RADIUS * math.cos(phase)
	local y = center.y + COMMON_005_ORBIT_RADIUS * math.sin(phase)
	local zBase = Vector(x, y, center.z)
	local gz = GetGroundHeight(zBase, caster)
	local ____temp_5
	if gz ~= nil then
		____temp_5 = gz
	else
		____temp_5 = center.z
	end
	local baseZ = ____temp_5
	return Vector(x, y, baseZ + COMMON_005_ORBIT_Z_OFFSET)
end
function modifier_common_005.prototype.moveOrbThinkers(self, caster, now)
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = caster:GetAbsOrigin()
	local theta = now * COMMON_005_ORBIT_DEG_PER_SEC * (math.pi / 180)
	do
		local i = 0
		while i < COMMON_005_ORB_COUNT do
			do
				local th = self.orbThinkers[i + 1]
				if not th or not IsValid(nil, th) or th:IsNull() then
					goto __continue36
				end
				local phase = theta + i * 2 * math.pi / COMMON_005_ORB_COUNT
				local pos = self:computeOrbWorldPos(caster, center, phase)
				if not IsValidAlive(nil, th) then
					goto __continue36
				end
				th:SetAbsOrigin(pos)
			end
			::__continue36::
			i = i + 1
		end
	end
end
function modifier_common_005.prototype.applyDamage(self)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	local origin = caster:GetAbsOrigin()
	local attacker = Common005GetDamageAttacker(nil, caster)
	local dMin, dMax = unpack(COMMON_005_DAMAGE_RANGE)
	local enemies = findHeroesInRadius(nil, caster:GetTeamNumber(), origin, dMax)
	for ____, victim in ipairs(enemies) do
		do
			if not IsValidAlive(nil, victim) then
				goto __continue41
			end
			local d = GetDistance(nil, origin, victim:GetAbsOrigin())
			if d < dMin or d > dMax then
				goto __continue41
			end
			ApplyMonsterDamage(
				nil,
				attacker,
				{ victim = victim, damage_rate = COMMON_005_DAMAGE_RATE, damage_type = 2, ability = ability }
			)
			self:playDamageHitParticle(victim)
		end
		::__continue41::
	end
end
function modifier_common_005.prototype.playDamageHitParticle(self, victim)
	if not IsValidAlive(nil, victim) then
		return
	end
	if not IsServer() or not IsValid(nil, victim) or victim:IsNull() then
		return
	end
	local origin = victim:GetAbsOrigin()
	local pid = ParticleManager:CreateParticle(PARTICLE_DAMAGE_HIT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pid, false)
	ParticleManager:SetParticleControl(pid, 0, origin)
	local pidKeep = pid
	Timers:CreateTimer(COMMON_005_HIT_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(pidKeep, false)
		ParticleManager:ReleaseParticleIndex(pidKeep)
	end)
end
function modifier_common_005.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	for ____, th in ipairs({ unpack(self.orbThinkers) }) do
		if th and IsValid(nil, th) and not th:IsNull() then
			th:RemoveSelf()
		end
	end
	self.orbThinkers = {}
end
function modifier_common_005.prototype.IsPurgable(self)
	return false
end
modifier_common_005 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_common_005") }, modifier_common_005)
return ____exports