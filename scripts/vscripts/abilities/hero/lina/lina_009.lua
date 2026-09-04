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
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local LINA_009_PROJECTILE_PARTICLE =
	"particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast.vpcf"
--- 施法：`sounds/weapons/hero/skeleton_king/hellfire_blast.vsnd` → SoundEvent
local LINA_009_SOUND_CAST = "Hero_SkeletonKing.Hellfire_Blast"
--- 命中：`sounds/weapons/hero/skeleton_king/mortal_strike_target.vsnd` → SoundEvent
local LINA_009_SOUND_HIT = "Hero_SkeletonKing.Cursed.Target"
local LINA_009_AOE_BURST_ENABLED_KEY = "lina_009_aoe_burst"
local LINA_009_AOE_BURST_RADIUS_KEY = "lina_009_aoe_burst_radius"
local LINA_009_AOE_BURST_DAMAGE_PCT_KEY = "lina_009_aoe_burst_damage_pct"
local LINA_009_MINI_GAME_ROOM_ID = "M019"
local LINA_009_PAUSE_MODIFIER = "modifier_pause_actions"
--- 追踪投射物 ExtraData 对「嵌套表」回传不稳定，命中回调里 `hit_history` 子表可能丢失，导致去重失效。
-- 因此命中记录必须打成 ExtraData 顶层键：`__ak_lina009_hit_<EntityIndex>` = 1。
local LINA_009_HIT_EXTRA_PREFIX = "__ak_lina009_hit_"
--- 丽娜技能 009：爆裂火球（周期随机索敌 + 弹射）
____exports.lina_009 = __TS__Class()
local lina_009 = ____exports.lina_009
lina_009.name = "lina_009"
__TS__ClassExtends(lina_009, BaseHeroAbility)
function lina_009.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_009_PROJECTILE_PARTICLE, context)
end
function lina_009.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function lina_009.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_lina_009_fireball_passive.name
end
function lina_009.prototype.GetProjectileLaunchOrigin(self, source)
	local attach = source:ScriptLookupAttachment("attach_hitloc")
	if attach > 0 then
		return source:GetAttachmentOrigin(attach)
	end
	return source:GetAbsOrigin()
end
function lina_009.prototype.ShouldProjectileChainAllowRepeatHits(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return false
	end
	if not IsValid(nil, caster) then
		return false
	end
	local ____tonumber_2 = tonumber
	local ____opt_0 = caster.GetCustomValue
	return ____tonumber_2(____opt_0 and ____opt_0(caster, "lina_009_chain_allow_repeat_hits") or 0) > 0
end
function lina_009.prototype.HitHistoryToFlatExtra(self, hitHistory)
	local out = {}
	for ____, key in ipairs(__TS__ObjectKeys(hitHistory)) do
		if hitHistory[key] == 1 then
			out[LINA_009_HIT_EXTRA_PREFIX .. key] = 1
		end
	end
	return out
end
function lina_009.prototype.HitHistoryFromProjectileExtra(self, extra)
	local t = {}
	for key in pairs(extra) do
		if __TS__StringStartsWith(key, LINA_009_HIT_EXTRA_PREFIX) then
			local idx = tonumber(__TS__StringSubstring(key, #LINA_009_HIT_EXTRA_PREFIX))
			if idx > 0 then
				t[idx] = 1
			end
		end
	end
	local legacy = extra.hit_history
	if legacy and type(legacy) == "table" then
		for idx in pairs(legacy) do
			if legacy[idx] == 1 then
				local n = tonumber(idx)
				if n > 0 then
					t[n] = 1
				end
			end
		end
	end
	return t
end
function lina_009.prototype.TriggerRandomFireball(self)
	if not IsServer() then
		return false
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return false
	end
	if caster:HasModifier(LINA_009_PAUSE_MODIFIER) then
		return false
	end
	if self:IsCasterInMiniGameRoom(caster) then
		return false
	end
	local searchRadius = self:GetSpecialValue("lina_009", "search_radius")
	local enemies = self:FindMonsterEnemies(caster:GetAbsOrigin(), searchRadius) or {}
	local targets = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue29
			end
			targets[#targets + 1] = enemy
		end
		::__continue29::
	end
	if #targets <= 0 then
		return false
	end
	local target = targets[RandomInt(0, #targets - 1) + 1]
	EmitSoundOn(LINA_009_SOUND_CAST, caster)
	local projectileSpeed = self:GetSpecialValue("lina_009", "projectile_speed")
	local bounceCount = self:GetSpecialValue("lina_009", "bounce_count")
	self:LaunchFireball(self:GetProjectileLaunchOrigin(caster), target, projectileSpeed, bounceCount, {}, false)
	return true
end
function lina_009.prototype.IsCasterInMiniGameRoom(self, caster)
	local playerId = caster:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return false
	end
	local ____opt_3 = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(playerId)
	return (____opt_3 and ____opt_3:GetRoomId()) == LINA_009_MINI_GAME_ROOM_ID
end
function lina_009.prototype.LaunchFireball(
	self,
	startPoint,
	target,
	projectileSpeed,
	bounceRemaining,
	hitHistoryBeforeThisSegment,
	isBounce
)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		projectile_type = "tracking",
		effect_name = LINA_009_PROJECTILE_PARTICLE,
		projectile_speed = projectileSpeed,
		start_point = startPoint,
		target = target,
		extra_data = __TS__ObjectAssign(
			{ bounce_remaining = bounceRemaining },
			self:HitHistoryToFlatExtra(hitHistoryBeforeThisSegment)
		),
		on_hit = function(____, hitTarget, location, extraData)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			local allowRepeat = self:ShouldProjectileChainAllowRepeatHits()
			local priorHistory = self:HitHistoryFromProjectileExtra(extraData or {})
			local hitIndex = hitTarget:GetEntityIndex()
			if not allowRepeat and priorHistory[hitIndex] == 1 then
				return true
			end
			local hitHistory = __TS__ObjectAssign({}, priorHistory, { [hitIndex] = 1 })
			local hitOrigin = hitTarget:GetAbsOrigin():__add(Vector(0, 0, 0))
			EmitSoundOn(LINA_009_SOUND_HIT, hitTarget)
			local casterHero = caster
			local intDamagePct = self:GetSpecialValue("lina_009", "int_damage_pct")
			local burnDuration = self:GetSpecialValue("lina_009", "burn_duration")
			local intellect = casterHero:GetIntellect(false)
			local damage = intellect * intDamagePct / 100
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = damage,
				damage_type = 2,
				ability = self,
				extra_data = { source_name = self:GetAbilityName() },
			})
			MyGameAttack:PerformAttack(
				caster,
				hitTarget,
				{ use_projectile = false, use_effect = true, is_sub_attack = isBounce, disable_celled = true }
			)
			self:ApplyAoeBurstDamage(hitTarget, damage)
			AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.BURN, { duration = burnDuration })
			local ____tonumber_10 = tonumber
			local ____temp_9 = extraData and extraData.bounce_remaining
			if ____temp_9 == nil then
				____temp_9 = 0
			end
			local remaining = math.max(0, ____tonumber_10(____temp_9) - 1)
			if remaining <= 0 then
				return true
			end
			local next = self:FindNextBounceTarget(hitOrigin, hitIndex, hitHistory, allowRepeat)
			if not next then
				return true
			end
			self:LaunchFireball(hitOrigin:__add(Vector(0, 0, 96)), next, projectileSpeed, remaining, hitHistory, true)
			return true
		end,
	})
end
function lina_009.prototype.FindNextBounceTarget(self, fromLocation, excludeIndex, hitHistory, allowRepeatHits)
	local caster = self:GetCaster()
	local bounceRadius = self:GetSpecialValue("lina_009", "bounce_radius")
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		fromLocation,
		nil,
		bounceRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, u in ipairs(enemies) do
		do
			if not IsValidAlive(nil, u) then
				goto __continue44
			end
			if u:GetEntityIndex() == excludeIndex then
				goto __continue44
			end
			if not allowRepeatHits and hitHistory[u:GetEntityIndex()] == 1 then
				goto __continue44
			end
			local ____opt_11 = u.GetUnitType
			local ut = ____opt_11 and ____opt_11(u)
			if ut == UnitType.BUILDING or ut == UnitType.DESTRUCTIBLE then
				goto __continue44
			end
			return u
		end
		::__continue44::
	end
	return nil
end
function lina_009.prototype.ApplyAoeBurstDamage(self, primaryTarget, baseDamage)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____tonumber_15 = tonumber
	local ____opt_13 = caster.GetCustomValue
	if ____tonumber_15(____opt_13 and ____opt_13(caster, LINA_009_AOE_BURST_ENABLED_KEY) or 0) <= 0 then
		return
	end
	local ____tonumber_18 = tonumber
	local ____opt_16 = caster.GetCustomValue
	local radius = ____tonumber_18(____opt_16 and ____opt_16(caster, LINA_009_AOE_BURST_RADIUS_KEY) or 0)
	local ____tonumber_21 = tonumber
	local ____opt_19 = caster.GetCustomValue
	local damagePct = ____tonumber_21(____opt_19 and ____opt_19(caster, LINA_009_AOE_BURST_DAMAGE_PCT_KEY) or 0)
	if radius <= 0 or damagePct <= 0 then
		return
	end
	if not IsValidAlive(nil, primaryTarget) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		primaryTarget:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local burstDamage = baseDamage * damagePct / 100
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue55
			end
			if enemy == primaryTarget then
				goto __continue55
			end
			local ____opt_22 = enemy.GetUnitType
			local unitType = ____opt_22 and ____opt_22(enemy)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				goto __continue55
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = burstDamage,
				damage_type = 2,
				ability = self,
				extra_data = { source_name = self:GetAbilityName() },
			})
		end
		::__continue55::
	end
end
lina_009 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_009)
____exports.lina_009 = lina_009
____exports.modifier_lina_009_fireball_passive = __TS__Class()
local modifier_lina_009_fireball_passive = ____exports.modifier_lina_009_fireball_passive
modifier_lina_009_fireball_passive.name = "modifier_lina_009_fireball_passive"
__TS__ClassExtends(modifier_lina_009_fireball_passive, BaseHeroModifier)
function modifier_lina_009_fireball_passive.prototype.IsHidden(self)
	return true
end
function modifier_lina_009_fireball_passive.prototype.IsPurgable(self)
	return false
end
function modifier_lina_009_fireball_passive.prototype.IsPermanent(self)
	return true
end
function modifier_lina_009_fireball_passive.prototype.RemoveOnDeath(self)
	return false
end
function modifier_lina_009_fireball_passive.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartFireballInterval()
end
function modifier_lina_009_fireball_passive.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartFireballInterval()
end
function modifier_lina_009_fireball_passive.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		self:Destroy()
		return
	end
	if not parent:IsAlive() then
		self:StartIntervalThink(____exports.modifier_lina_009_fireball_passive.NO_TARGET_RETRY_INTERVAL)
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() or ability:GetLevel() <= 0 then
		self:Destroy()
		return
	end
	if not ability:TriggerRandomFireball() then
		self:StartIntervalThink(____exports.modifier_lina_009_fireball_passive.NO_TARGET_RETRY_INTERVAL)
		return
	end
	self:StartFireballInterval()
end
function modifier_lina_009_fireball_passive.prototype.StartFireballInterval(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local cooldown = math.max(0.1, ability:GetCooldown(math.max(0, ability:GetLevel() - 1)))
	ability:StartCooldown(cooldown)
	self:StartIntervalThink(cooldown)
end
modifier_lina_009_fireball_passive.NO_TARGET_RETRY_INTERVAL = 0.5
modifier_lina_009_fireball_passive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_009_fireball_passive)
____exports.modifier_lina_009_fireball_passive = modifier_lina_009_fireball_passive
return ____exports