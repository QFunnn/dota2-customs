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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
--- 吞噬区域半径
local ZONE_RADIUS = 300
--- 区域存在时长（吸力+掉血的窗口；孵化后区域继续残留到时长结束）
local ZONE_DURATION = 8
--- 区域出现到孵化小鬼的延迟
local HATCH_DELAY = 3
--- 区域向心吸力（每秒；略强于五芒囚阵的 120，区域小逃出快）
local ZONE_PULL = 160
--- 吸力死区（贴中心不再拖，防抖）
local ZONE_PULL_DEADZONE = 40
--- 区域轮询间隔
local ZONE_TICK = 0.03
--- 掉血结算间隔
local ZONE_DMG_INTERVAL = 0.25
--- 每跳伤害系数（damage_rate × 谜团攻击力；≈每秒 0.48 倍攻击的温和压力）
local ZONE_DMG_RATE = 0.12
--- 选点倾向：以随机敌方英雄为锚的随机偏移上限
local BIAS_RANGE = 250
--- 区域中心离谜团的最大距离（超出沿径向钳回）
local MAX_ANCHOR_DIST = 800
--- 无敌人时的兜底选点距离（谜团前方随机环带）
local FALLBACK_DIST = 500
--- 召唤物单位名（绝对零度艾多伦·站桩炮台）
local SUMMON_NAME = "monster_11309_eidolon"
--- 同场召唤物上限（AI 层依此决定是否施放）
local MAX_SUMMONS = 3
--- 每只在场小鬼每次回血占谜团最大生命比例
local HEAL_PCT = 0.01
--- 回血结算间隔（秒）——即"每只小鬼每秒回 1%"
local HEAL_INTERVAL = 1
--- 勾魂虹吸链接束（帕格纳生命汲取；VPK 已验证存在，原版即双端实体绑定用法）
local LINK_PARTICLE = "particles/units/heroes/hero_pugna/pugna_life_drain.vpcf"
--- 虹吸领域开启时 boss 缠身星云（领域态可视标识）
local DOMAIN_AURA_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf"
--- 虹吸领域半径（boss 周身范围伤害+吸力的作用圈）
local DOMAIN_RADIUS = 450
--- 领域向心吸力（每秒，把敌人往 boss 身上拽）
local DOMAIN_PULL = 100
--- 领域吸力死区（贴身不再拉，防止拖进模型）
local DOMAIN_PULL_DEADZONE = 120
--- 领域轮询间隔
local DOMAIN_TICK = 0.03
--- 领域伤害结算间隔
local DOMAIN_DMG_INTERVAL = 0.25
--- 领域每跳伤害系数（≈每秒 0.32 倍攻击的贴身灼烧）
local DOMAIN_DMG_RATE = 0.08
--- 区域氛围粒子（谜团午夜脉冲缩小版；已随 precacheUnits enigma 全局缓存）
local ZONE_PARTICLE = "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf"
--- 孵化破壳爆点粒子（冰女新星；CM 在 precacheUnits 清单，零预缓存成本，绝对零度主题）
local HATCH_PARTICLE = "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf"
____exports.elite_322 = __TS__Class()
local elite_322 = ____exports.elite_322
elite_322.name = "elite_322"
__TS__ClassExtends(elite_322, MonsterAbility_CS)
function elite_322.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_322_link"
end
function elite_322.prototype.Precache(self, context)
	PrecacheResource("particle", ZONE_PARTICLE, context)
	PrecacheResource("particle", HATCH_PARTICLE, context)
end
function elite_322.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function elite_322.prototype.autoCastZone(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:openZone()
	local cd = self:GetCooldown(self:GetLevel() - 1)
	if cd > 0 then
		self:StartCooldown(cd)
	end
end
function elite_322.prototype.getAliveSummons(self)
	local out = {}
	local list = self._summons
	if not list then
		return out
	end
	for ____, u in ipairs(list) do
		if IsValidAlive(nil, u) then
			out[#out + 1] = u
		end
	end
	return out
end
function elite_322.prototype.aliveSummonCount(self)
	return #self:getAliveSummons()
end
function elite_322.prototype.killAllSummons(self)
	local list = self._summons
	if not list then
		return
	end
	self._summons = nil
	for ____, u in ipairs(list) do
		if IsValidAlive(nil, u) then
			u:ForceKill(false)
		end
	end
end
function elite_322.prototype.pickZoneCenter(self, caster)
	local origin = caster:GetAbsOrigin()
	local anchor
	local heroes = self:FindHeroesInRadius(1200)
	local alive = {}
	for ____, h in ipairs(heroes) do
		if IsValidAlive(nil, h) then
			alive[#alive + 1] = h
		end
	end
	if #alive > 0 then
		local picked = alive[RandomInt(0, #alive - 1) + 1]
		local ang = RandomFloat(0, 2 * math.pi)
		local dist = RandomFloat(0, BIAS_RANGE)
		if IsValidAlive(nil, picked) then
			anchor = picked:GetAbsOrigin():__add(Vector(math.cos(ang) * dist, math.sin(ang) * dist, 0))
		end
	else
		local ang = RandomFloat(0, 2 * math.pi)
		anchor = origin:__add(Vector(math.cos(ang) * FALLBACK_DIST, math.sin(ang) * FALLBACK_DIST, 0))
	end
	if anchor == nil then
		anchor = origin
	end
	local rel = anchor:__sub(origin)
	local d = rel:Length2D()
	if d > MAX_ANCHOR_DIST then
		anchor = origin:__add(rel:Normalized():__mul(MAX_ANCHOR_DIST))
	end
	return GetGroundPosition(anchor, nil)
end
function elite_322.prototype.openZone(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = self:pickZoneCenter(caster)
	local pulse = ParticleManager:CreateParticle(ZONE_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pulse, 0, center)
	ParticleManager:SetParticleControl(pulse, 1, Vector(ZONE_RADIUS, 0, 0))
	Timers:CreateTimer(ZONE_DURATION, function()
		ParticleManager:DestroyParticle(pulse, false)
		ParticleManager:ReleaseParticleIndex(pulse)
	end)
	self:WarningRingEffect(center, ZONE_RADIUS, HATCH_DELAY)
	CreateModifierThinker(
		caster,
		self,
		"modifier_elite_322_zone",
		{ duration = ZONE_DURATION, cx = center.x, cy = center.y },
		center,
		caster:GetTeamNumber(),
		false
	)
	caster:EmitSound("Hero_Enigma.Demonic_Conversion")
	self:Timer(HATCH_DELAY, function()
		return self:hatchSummon(center)
	end)
end
function elite_322.prototype.hatchSummon(self, center)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	MyGameUnit:CreateUnitAsync({
		unitName = SUMMON_NAME,
		position = center,
		findClearSpace = false,
		owner = caster,
		entityOwner = caster,
		team = caster:GetTeamNumber(),
		unitType = UnitType.SUMMONED,
		roomId = caster:GetRoomId(),
		onSpawn = function(____, summon)
			if not summon or not IsValidAlive(nil, summon) then
				return
			end
			if not IsValidAlive(nil, caster) then
				MyGameUnit:DestroyUnit(summon)
				return
			end
			summon:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
			summon:StartGesture(ACT_DOTA_SPAWN)
			local target = summon:GetMinDistanceUnit(1200)
			if IsValidAlive(nil, target) then
				summon:SetForwardVector(target:GetAbsOrigin():__sub(center):Normalized())
			end
			local burst = ParticleManager:CreateParticle(HATCH_PARTICLE, PATTACH_WORLDORIGIN, summon)
			ParticleManager:SetParticleControl(burst, 0, center)
			ParticleManager:ReleaseParticleIndex(burst)
			summon:EmitSound("Hero_Enigma.Demonic_Conversion")
			if not self._summons then
				self._summons = {}
			end
			local ____self__summons_0 = self._summons
			____self__summons_0[#____self__summons_0 + 1] = summon
		end,
	})
end
elite_322 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_322)
____exports.elite_322 = elite_322
--- 吞噬区域逻辑（挂在区域中心 thinker 上）：
-- 高频轮询区域内敌方英雄——向心拖拽（五芒囚阵引力同款数学）+ 周期掉血。
-- duration 到期 thinker 自毁，区域自然消散。
local modifier_elite_322_zone = __TS__Class()
modifier_elite_322_zone.name = "modifier_elite_322_zone"
__TS__ClassExtends(modifier_elite_322_zone, BaseModifier)
function modifier_elite_322_zone.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.cx = 0
	self.cy = 0
	self.dmgAcc = 0
end
function modifier_elite_322_zone.prototype.IsHidden(self)
	return true
end
function modifier_elite_322_zone.prototype.IsPurgable(self)
	return false
end
function modifier_elite_322_zone.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.cx = kv.cx or 0
	self.cy = kv.cy or 0
	self:StartIntervalThink(ZONE_TICK)
end
function modifier_elite_322_zone.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if not caster or caster:IsNull() then
		return
	end
	self.dmgAcc = self.dmgAcc + ZONE_TICK
	local doDamage = self.dmgAcc >= ZONE_DMG_INTERVAL
	if doDamage then
		self.dmgAcc = 0
	end
	local center = Vector(self.cx, self.cy, 0)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		ZONE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue47
			end
			local pos = enemy:GetAbsOrigin()
			local dx = pos.x - self.cx
			local dy = pos.y - self.cy
			local dist = math.sqrt(dx * dx + dy * dy)
			if dist > ZONE_PULL_DEADZONE then
				local step = math.min(ZONE_PULL * ZONE_TICK, dist - ZONE_PULL_DEADZONE)
				local scale = (dist - step) / dist
				local pulled = GetGroundPosition(Vector(self.cx + dx * scale, self.cy + dy * scale, pos.z), enemy)
				enemy:SetAbsOrigin(pulled)
			end
			if doDamage and IsValidAlive(nil, caster) then
				caster:MonsterDamage({
					victim = enemy,
					damage_rate = ZONE_DMG_RATE,
					ability = self:GetAbility(),
				})
			end
		end
		::__continue47::
	end
end
modifier_elite_322_zone =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_322_zone") }, modifier_elite_322_zone)
--- 勾魂虹吸（谜团常驻 intrinsic）：
-- - 每只在场小鬼与 boss 之间挂一条虹吸链接束（帕格纳汲取，动态对账增删）
-- - 链接存在 → boss 自动开启【虹吸领域】：周身范围伤害 + 吸往中心 + 每秒回血（1%×链接数）
-- - 链接全断（小鬼死光）→ 领域自动关闭
-- - 谜团死亡时清场全部小鬼（主死仆死）+ 清光链接粒子
local modifier_elite_322_link = __TS__Class()
modifier_elite_322_link.name = "modifier_elite_322_link"
__TS__ClassExtends(modifier_elite_322_link, BaseModifier)
function modifier_elite_322_link.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.links = {}
	self.domainOn = false
	self.dmgAcc = 0
	self.healAcc = 0
end
function modifier_elite_322_link.prototype.IsHidden(self)
	return true
end
function modifier_elite_322_link.prototype.IsPurgable(self)
	return false
end
function modifier_elite_322_link.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(DOMAIN_TICK)
end
function modifier_elite_322_link.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	local horizonActive = parent:HasModifier("modifier_elite_325_field")
	if
		not parent:IsStunned()
		and not horizonActive
		and ability:IsCooldownReady()
		and ability:aliveSummonCount() < MAX_SUMMONS
	then
		local target = parent:GetMinDistanceUnit(1200)
		if IsValidAlive(nil, target) then
			ability:autoCastZone()
		end
	end
	self:reconcileLinks(parent, ability)
	local n = #self.links
	local wantOn = n > 0 and not horizonActive
	if wantOn and not self.domainOn then
		self:openDomain(parent)
	elseif not wantOn and self.domainOn then
		self:closeDomain()
	end
	if not self.domainOn then
		return
	end
	self.healAcc = self.healAcc + DOMAIN_TICK
	if self.healAcc >= HEAL_INTERVAL then
		self.healAcc = 0
		MyGameHeal:ApplyHeal({
			healer = parent,
			target = parent,
			amount = parent:GetMaxHealth() * HEAL_PCT * n,
			ability = ability,
			source = "other",
		})
	end
	self.dmgAcc = self.dmgAcc + DOMAIN_TICK
	local doDamage = self.dmgAcc >= DOMAIN_DMG_INTERVAL
	if doDamage then
		self.dmgAcc = 0
	end
	local center = parent:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		center,
		nil,
		DOMAIN_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue67
			end
			local pos = enemy:GetAbsOrigin()
			local dx = pos.x - center.x
			local dy = pos.y - center.y
			local dist = math.sqrt(dx * dx + dy * dy)
			if dist > DOMAIN_PULL_DEADZONE then
				local step = math.min(DOMAIN_PULL * DOMAIN_TICK, dist - DOMAIN_PULL_DEADZONE)
				local scale = (dist - step) / dist
				local pulled = GetGroundPosition(Vector(center.x + dx * scale, center.y + dy * scale, pos.z), enemy)
				enemy:SetAbsOrigin(pulled)
			end
			if doDamage then
				parent:MonsterDamage({ victim = enemy, damage_rate = DOMAIN_DMG_RATE, ability = ability })
			end
		end
		::__continue67::
	end
end
function modifier_elite_322_link.prototype.reconcileLinks(self, parent, ability)
	if not IsValidAlive(nil, parent) then
		for ____, link in ipairs(self.links) do
			ParticleManager:DestroyParticle(link.pfx, false)
			ParticleManager:ReleaseParticleIndex(link.pfx)
		end
		self.links = {}
		return
	end
	local kept = {}
	for ____, l in ipairs(self.links) do
		if IsValidAlive(nil, l.unit) then
			kept[#kept + 1] = l
		else
			ParticleManager:DestroyParticle(l.pfx, false)
			ParticleManager:ReleaseParticleIndex(l.pfx)
		end
	end
	self.links = kept
	for ____, u in ipairs(ability:getAliveSummons()) do
		do
			local linked = false
			if not IsValidAlive(nil, u) then
				goto __continue80
			end
			for ____, l in ipairs(self.links) do
				if l.unit == u then
					linked = true
					break
				end
			end
			if linked then
				goto __continue80
			end
			local pfx = ParticleManager:CreateParticle(LINK_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
			ParticleManager:SetParticleControlEnt(
				pfx,
				0,
				parent,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				parent:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				pfx,
				1,
				u,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				u:GetAbsOrigin(),
				true
			)
			local ____self_links_1 = self.links
			____self_links_1[#____self_links_1 + 1] = { unit = u, pfx = pfx }
		end
		::__continue80::
	end
end
function modifier_elite_322_link.prototype.openDomain(self, parent)
	self.domainOn = true
	self.auraPfx = ParticleManager:CreateParticle(DOMAIN_AURA_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
end
function modifier_elite_322_link.prototype.closeDomain(self)
	self.domainOn = false
	if self.auraPfx ~= nil then
		ParticleManager:DestroyParticle(self.auraPfx, false)
		ParticleManager:ReleaseParticleIndex(self.auraPfx)
		self.auraPfx = nil
	end
end
function modifier_elite_322_link.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	for ____, l in ipairs(self.links) do
		ParticleManager:DestroyParticle(l.pfx, false)
		ParticleManager:ReleaseParticleIndex(l.pfx)
	end
	self.links = {}
	self:closeDomain()
end
function modifier_elite_322_link.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_DEATH }
end
function modifier_elite_322_link.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.unit ~= parent then
		return
	end
	local ability = self:GetAbility()
	if ability and not ability:IsNull() then
		ability:killAllSummons()
	end
end
modifier_elite_322_link =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_322_link") }, modifier_elite_322_link)
return ____exports