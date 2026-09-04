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
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
--- 穿透箭弹道（项目现役 linear 粒子：normal_038_2 强力击同款，攻击弹道粒子不适配 linear 会竖立滑行）
local DROW_002_PROJECTILE_PARTICLE = "particles/windranger_arcana_spell_powershot.vpcf"
local DROW_002_CAST_SOUND = "Hero_DrowRanger.FrostArrows"
local DROW_002_HIT_SOUND = "Hero_DrowRanger.ProjectileImpact"
--- 穿透箭判定宽度
local DROW_002_PROJECTILE_WIDTH = 100
--- 命中击退（隐藏手感，不写入技能描述）：以弹道起点为源心把命中敌人向外顶开一小段
local DROW_002_KNOCKBACK_DISTANCE = 150
local DROW_002_KNOCKBACK_DURATION = 0.25
local DROW_002_KNOCKBACK_HEIGHT = 30
--- 符印「叠矢」：追加箭触发概率键（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=35/50/75）；追加箭朝最近敌人索敌
local DROW_002_GEM_MULTISHOT_CHANCE_KEY = "drow_002_multishot_chance_pct"
--- 符印「叠矢」：追加支数键（仅Ⅲ档配 2=三重；缺省 1）；多支时逐支分敌（最近/次近），敌人不足则同目标
local DROW_002_GEM_MULTISHOT_EXTRA_COUNT_KEY = "drow_002_multishot_extra_count"
--- 符印「凝眸」：每 1% 面板闪避提升本技能伤害的百分比（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=1/1.5/2，魅影刀阵 G214 同构）
local DROW_002_GEM_GAZE_PER_EVASION_KEY = "drow_002_gaze_dmg_pct_per_evasion"
--- 卓尔游侠技能 002 - 贯霜之矢
-- 主动（充能 2 层 / 每 5 秒回 1 层）：向指定方向射出一支穿透箭矢，
-- 对路径上的敌人造成总敏捷百分比的物理伤害，并施加可叠加的破甲。
____exports.drow_002 = __TS__Class()
local drow_002 = ____exports.drow_002
drow_002.name = "drow_002"
__TS__ClassExtends(drow_002, BaseHeroAbility)
function drow_002.prototype.Precache(self, context)
	PrecacheResource("particle", DROW_002_PROJECTILE_PARTICLE, context)
end
function drow_002.prototype.GetAbilityConfig(self)
	return { castPoint = 0.2, castAnimation = ACT_DOTA_CAST_ABILITY_2, behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function drow_002.prototype.GetAgilityDamagePct(self)
	return self:GetSpecialValue("drow_002", "agility_damage_pct")
end
function drow_002.prototype.GetArmorReductionPct(self)
	return self:GetSpecialValue("drow_002", "armor_reduction_pct")
end
function drow_002.prototype.GetMaxArmorStack(self)
	return self:GetSpecialValue("drow_002", "max_armor_stack")
end
function drow_002.prototype.GetArmorDuration(self)
	return self:GetSpecialValue("drow_002", "armor_duration")
end
function drow_002.prototype.ResolveGazeDamageMultiplier(self, caster)
	local ____tonumber_2 = tonumber
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetCustomValue
	local perEvasionPct = ____tonumber_2(____opt_0 and ____opt_0(____this_1, DROW_002_GEM_GAZE_PER_EVASION_KEY) or 0)
	if not __TS__NumberIsFinite(__TS__Number(perEvasionPct)) or perEvasionPct <= 0 then
		return 1
	end
	local evasionPct = math.min(100, math.max(0, MyGameAttribute:GetAttribute(caster, "evasion_pct") or 0))
	return 1 + evasionPct * perEvasionPct / 100
end
function drow_002.prototype.OnSpellStart(self)
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
	local agilityDamagePct = self:GetAgilityDamagePct()
	local armorDuration = self:GetArmorDuration()
	caster:EmitSound(DROW_002_CAST_SOUND)
	self:FireArrow(caster, direction, agilityDamagePct, armorDuration)
	local ____tonumber_5 = tonumber
	local ____opt_3 = caster.GetCustomValue
	local multishotChance = ____tonumber_5(____opt_3 and ____opt_3(caster, DROW_002_GEM_MULTISHOT_CHANCE_KEY) or 0)
	if multishotChance > 0 and RollPercentage(multishotChance) then
		local ____math_max_10 = math.max
		local ____math_floor_9 = math.floor
		local ____tonumber_8 = tonumber
		local ____opt_6 = caster.GetCustomValue
		local extraCount = ____math_max_10(
			1,
			____math_floor_9(
				____tonumber_8(____opt_6 and ____opt_6(caster, DROW_002_GEM_MULTISHOT_EXTRA_COUNT_KEY) or 0) or 1
			)
		)
		local searchRange = self:GetSpecialValue("drow_002", "projectile_distance")
		local nearbyEnemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			searchRange,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		local validEnemies = {}
		for ____, enemy in ipairs(nearbyEnemies) do
			if IsValidAlive(nil, enemy) then
				validEnemies[#validEnemies + 1] = enemy
			end
		end
		if #validEnemies > 0 then
			do
				local i = 0
				while i < extraCount do
					local extraTarget = validEnemies[math.min(i, #validEnemies - 1) + 1]
					local extraDirRaw = GetDirection(nil, extraTarget:GetAbsOrigin(), caster:GetAbsOrigin())
					self:FireArrow(
						caster,
						Vector(extraDirRaw.x, extraDirRaw.y, 0):Normalized(),
						agilityDamagePct,
						armorDuration
					)
					i = i + 1
				end
			end
		end
	end
end
function drow_002.prototype.FireArrow(self, caster, direction, agilityDamagePct, armorDuration)
	local origin = caster:GetAbsOrigin()
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = DROW_002_PROJECTILE_PARTICLE,
		direction = direction,
		start_point = origin:__add(Vector(0, 0, 100)),
		projectile_type = "linear",
		projectile_speed = self:GetSpecialValue("drow_002", "projectile_speed"),
		projectile_distance = self:GetSpecialValue("drow_002", "projectile_distance"),
		projectile_range = DROW_002_PROJECTILE_WIDTH,
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
			hitTarget:EmitSound(DROW_002_HIT_SOUND)
			local agility = MyGameAttribute:GetAttribute(caster, "total_agility") or 0
			local damage = agility * agilityDamagePct / 100 * self:ResolveGazeDamageMultiplier(caster)
			if damage > 0 then
				Damage:ApplyDamage({
					attacker = caster,
					victim = hitTarget,
					damage = damage,
					damage_type = 1,
					ability = self,
				})
			end
			____exports.modifier_drow_002_armor_break:applys(
				hitTarget,
				caster,
				self,
				{ duration = armorDuration, stack = 1 }
			)
			hitTarget:KnockBack(caster, self, {
				duration = DROW_002_KNOCKBACK_DURATION,
				stun = true,
				heightType = "parabola",
				particleName = "",
				distance = DROW_002_KNOCKBACK_DISTANCE,
				height = DROW_002_KNOCKBACK_HEIGHT,
				removeOnDeath = true,
				origin_pos = origin,
			})
			return false
		end,
	})
end
drow_002 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_002)
____exports.drow_002 = drow_002
--- 贯霜之矢破甲 Debuff：每层按百分比降低目标护甲，刷新时叠层并重置时长
____exports.modifier_drow_002_armor_break = __TS__Class()
local modifier_drow_002_armor_break = ____exports.modifier_drow_002_armor_break
modifier_drow_002_armor_break.name = "modifier_drow_002_armor_break"
__TS__ClassExtends(modifier_drow_002_armor_break, BaseModifier_CS)
function modifier_drow_002_armor_break.GetLocalizationCN(self)
	return { name = "破甲", description = "护甲降低。每层降低10%%，最多叠加5层。" }
end
function modifier_drow_002_armor_break.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetStackCount(math.min(math.max(math.floor(params.stack or 1), 1), self:GetMaxStack()))
end
function modifier_drow_002_armor_break.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local add = math.max(math.floor(params.stack or 1), 1)
	self:SetStackCount(math.min(self:GetStackCount() + add, self:GetMaxStack()))
	self:RefreshAttributes()
end
function modifier_drow_002_armor_break.prototype.GetMaxStack(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return 1
	end
	return math.max(1, math.floor(ability:GetMaxArmorStack()))
end
function modifier_drow_002_armor_break.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true, isPurgeException = false }
end
function modifier_drow_002_armor_break.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return { all_armor_pct = -self:GetStackCount() * ability:GetArmorReductionPct() }
end
function modifier_drow_002_armor_break.prototype.GetTexture(self)
	return "drow_02"
end
modifier_drow_002_armor_break = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_002_armor_break)
____exports.modifier_drow_002_armor_break = modifier_drow_002_armor_break
return ____exports