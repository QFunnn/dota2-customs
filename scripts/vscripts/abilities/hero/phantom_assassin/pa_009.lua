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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 刀阵旋风：默认主特效（与 KV `damage_radius` 一致，用于施法范围指示）
local PA_009_FAN_PFX = "particles/hero/phantom_assassin_shard_fan_of_knives.vpcf"
--- 符印「无极斩」多段形态：主特效替换为该粒子
local PA_009_FAN_PFX_WUJI = "particles/dd/cast_fan_of_knives_125/cast_fan_of_knives.vpcf"
local PA_009_CAST_SOUND = "Hero_PhantomAssassin.FanOfKnives.Cast"
--- 受击音效：资源 `sounds/weapons/hero/phantom_assassin/stifling_dagger_target.vsnd`，与窒息之刃命中一致，使用引擎 Sound Event 名
local PA_009_VICTIM_HIT_SOUND = "Hero_PhantomAssassin.Dagger.Target"
local PA_009_DAMAGE_START_RADIUS = 300
local PA_009_DAMAGE_EXPAND_DURATION = 0.15
local PA_009_DAMAGE_EXPAND_INTERVAL = 0.05
--- 符印「无极斩」：形态开关
local PA_009_WUJI_SLASH_KEY = "pa_009_wuji_slash"
local PA_009_WUJI_HIT_COUNT_KEY = "pa_009_wuji_slash_hit_count"
--- 符印「瞬身斩」
local PA_009_EVASION_SLASH_KEY = "pa_009_evasion_slash"
local PA_009_EVASION_SLASH_CD_KEY = "pa_009_evasion_slash_cooldown_sec"
local PA_009_EVASION_SLASH_CHANCE_PCT_KEY = "pa_009_evasion_slash_chance_pct"
--- 符印「切割」
local PA_009_CUT_KEY = "pa_009_cut"
local PA_009_CUT_MAX_HP_PCT_KEY = "pa_009_cut_max_health_damage_pct"
local PA_009_CUT_CAP_ATTACK_MULT_KEY = "pa_009_cut_bonus_damage_cap_attack_mult"
--- 无极斩：同一目标多段伤害的间隔（秒）
local PA_009_WUJI_HIT_INTERVAL = 0.12
--- 符印「致伤刀阵」：命中目标时同时施加易伤与流血的概率%（hero_data；Ⅰ/Ⅱ/Ⅲ=20/30/40）
local PA_009_GEM_HIT_VULN_CHANCE_KEY = "pa_009_hit_vulnerable_chance_pct"
--- 符印「致伤刀阵」：命中施加的易伤持续时间（秒）
local PA_009_GEM_VULN_DURATION = 6
--- 符印「魅影刀阵」被动：每 1% 闪避提升刀阵旋风伤害的百分比（hero_data；Ⅰ/Ⅱ/Ⅲ=0.5/0.75/1）
local PA_009_GEM_DAMAGE_PER_EVASION_KEY = "pa_009_damage_pct_per_evasion"
--- 幻影刺客技能 009 - 刀阵旋风
-- 粒子：CP0 为原点，CP1 的 X 为作用范围；无极斩时主特效改用 `PA_009_FAN_PFX_WUJI`。
--
-- 符印：
-- - 无极斩：多段命中；「每段降低 35%」由符印 `tag_gem_damage:-35` 走标签 DAMAGE 乘区，不再用 h * - 切割：附加量按最大生命比例与攻击封顶算出后，作为**独立一段纯粹伤害**与物理 * - 切割：附加量按最大生命比例与攻击封顶算出后，**合并进同一次物理伤害**（不再单独二次 ApplyDamage）；无无极斩时每目标一次，有无极斩时每段各算一次并入该段。
--
-- - 瞬身斩：见 `modifier_pa_009_gem_evasion_slash`（`ON_TAKE_ATTACK_MISS`，需在 ak_gems 挂载 modifier）。
-- - 魅影刀阵：充能上限/充能恢复/固定蓝耗三词条走符印 gem_value；被动按属性 `evasion_pct` 放大主伤，见 `ResolveEvasionDamageMultiplier`。
____exports.pa_009 = __TS__Class()
local pa_009 = ____exports.pa_009
pa_009.name = "pa_009"
__TS__ClassExtends(pa_009, BaseHeroAbility)
function pa_009.prototype.Precache(self, context)
	PrecacheResource("particle", PA_009_FAN_PFX, context)
	PrecacheResource("particle", PA_009_FAN_PFX_WUJI, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context)
end
function pa_009.prototype.GetAOERadius(self)
	return math.max(0, self:GetSpecialValue("pa_009", "damage_radius"))
end
function pa_009.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.08,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		animationPlaybackRate = 1.7,
	}
end
function pa_009.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:EmitSound(PA_009_CAST_SOUND)
	self:RunBladeFanSequence({ playCastSound = false })
end
function pa_009.prototype.TriggerBladeFanFromEvasionGem(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound(PA_009_CAST_SOUND)
	self:RunBladeFanSequence({ playCastSound = false })
end
function pa_009.prototype.RunBladeFanSequence(self, _opts)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	Timers:CreateTimer(0.05, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local maxRadius = math.max(0, self:GetSpecialValue("pa_009", "damage_radius"))
		local startRadius = math.min(PA_009_DAMAGE_START_RADIUS, maxRadius)
		local multPct = math.max(0, self:GetSpecialValue("pa_009", "attack_damage_multiplier_pct"))
		local wuji = self:ResolveWujiConfig(caster)
		local fanPfx = wuji ~= nil and PA_009_FAN_PFX_WUJI or PA_009_FAN_PFX
		if MyGameDestructibleManager ~= nil then
			MyGameDestructibleManager:BreakCircleForHero(caster, origin, maxRadius, self)
		end
		local pfx = MyGameHeroParticleManager:CreateParticle(fanPfx, PATTACH_WORLDORIGIN, caster, caster)
		MyGameHeroParticleManager:SetParticleControl(pfx, 0, origin + Vector(0, 0, 10))
		if fanPfx == PA_009_FAN_PFX_WUJI then
			MyGameHeroParticleManager:SetParticleControl(pfx, 1, Vector(1, 1, 1))
		else
			MyGameHeroParticleManager:SetParticleControl(pfx, 1, Vector(maxRadius * 0.8, 0, 0))
		end
		MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
		local baseDamagePerTarget = self:GetAllAttackDamage(caster)
			* multPct
			/ 100
			* self:ResolveEvasionDamageMultiplier(caster)
		ExpandCircularSearch(nil, {
			origin = origin,
			startRadius = startRadius,
			endRadius = maxRadius,
			duration = PA_009_DAMAGE_EXPAND_DURATION,
			interval = PA_009_DAMAGE_EXPAND_INTERVAL,
			teamNumber = caster:GetTeamNumber(),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
			hitOnce = true,
			onHit = function(____, units)
				for ____, enemy in ipairs(units) do
					self:ApplyBladeFanEntryToEnemy(caster, enemy, origin, baseDamagePerTarget, wuji)
				end
			end,
			cancelCondition = function()
				return not IsValidAlive(nil, caster)
			end,
		})
	end)
end
function pa_009.prototype.ResolveWujiConfig(self, caster)
	local ____tonumber_4 = tonumber
	local ____this_3
	____this_3 = caster
	local ____opt_2 = ____this_3.GetCustomValue
	if ____tonumber_4(____opt_2 and ____opt_2(____this_3, PA_009_WUJI_SLASH_KEY) or 0) <= 0 then
		return nil
	end
	local ____tonumber_7 = tonumber
	local ____this_6
	____this_6 = caster
	local ____opt_5 = ____this_6.GetCustomValue
	local hitCount = ____tonumber_7(____opt_5 and ____opt_5(____this_6, PA_009_WUJI_HIT_COUNT_KEY) or 0)
	if not __TS__NumberIsFinite(__TS__Number(hitCount)) or hitCount < 1 then
		return nil
	end
	return { hitCount = math.floor(hitCount) }
end
function pa_009.prototype.ResolveEvasionDamageMultiplier(self, caster)
	local ____tonumber_10 = tonumber
	local ____this_9
	____this_9 = caster
	local ____opt_8 = ____this_9.GetCustomValue
	local perEvasionPct = ____tonumber_10(____opt_8 and ____opt_8(____this_9, PA_009_GEM_DAMAGE_PER_EVASION_KEY) or 0)
	if not __TS__NumberIsFinite(__TS__Number(perEvasionPct)) or perEvasionPct <= 0 then
		return 1
	end
	local evasionPct = math.min(100, math.max(0, MyGameAttribute:GetAttribute(caster, "evasion_pct") or 0))
	return 1 + evasionPct * perEvasionPct / 100
end
function pa_009.prototype.ResolveCutConfig(self, caster)
	local ____tonumber_13 = tonumber
	local ____this_12
	____this_12 = caster
	local ____opt_11 = ____this_12.GetCustomValue
	if ____tonumber_13(____opt_11 and ____opt_11(____this_12, PA_009_CUT_KEY) or 0) <= 0 then
		return nil
	end
	local ____tonumber_16 = tonumber
	local ____this_15
	____this_15 = caster
	local ____opt_14 = ____this_15.GetCustomValue
	local maxHealthDamagePct = ____tonumber_16(____opt_14 and ____opt_14(____this_15, PA_009_CUT_MAX_HP_PCT_KEY) or 0)
	local ____tonumber_19 = tonumber
	local ____this_18
	____this_18 = caster
	local ____opt_17 = ____this_18.GetCustomValue
	local capAttackMult = ____tonumber_19(____opt_17 and ____opt_17(____this_18, PA_009_CUT_CAP_ATTACK_MULT_KEY) or 0)
	if not __TS__NumberIsFinite(__TS__Number(maxHealthDamagePct)) or maxHealthDamagePct < 0 then
		return nil
	end
	if not __TS__NumberIsFinite(__TS__Number(capAttackMult)) or capAttackMult < 0 then
		return nil
	end
	return { maxHealthDamagePct = maxHealthDamagePct, capAttackMult = capAttackMult }
end
function pa_009.prototype.ApplyBladeFanEntryToEnemy(self, caster, enemy, origin, baseDamagePerTarget, wuji)
	local cutCfg = self:ResolveCutConfig(caster)
	if wuji then
		local hits = math.max(1, wuji.hitCount)
		local dmgEach = baseDamagePerTarget
		do
			local i = 0
			while i < hits do
				local hitIndex = i
				local delay = hitIndex * PA_009_WUJI_HIT_INTERVAL
				Timers:CreateTimer(delay, function()
					if not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
						return
					end
					local applyKbStun = hitIndex == 0
					local cutExtra = self:ComputeCutBonusDamage(caster, enemy, cutCfg)
					self:ApplyPrimaryPhysicalHit(caster, enemy, dmgEach + cutExtra, origin, applyKbStun)
				end)
				i = i + 1
			end
		end
		return
	end
	local cutExtra = self:ComputeCutBonusDamage(caster, enemy, cutCfg)
	self:ApplyPrimaryPhysicalHit(caster, enemy, baseDamagePerTarget + cutExtra, origin, true)
end
function pa_009.prototype.ApplyPrimaryPhysicalHit(self, caster, enemy, damage, origin, applyKnockAndStun)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
		return
	end
	local result = Damage:ApplyDamage({
		attacker = caster,
		victim = enemy,
		damage = damage * 0.8,
		damage_type = 1,
		ability = self,
		extra_data = {
			source_name = self:GetAbilityName(),
			bonus_spell_lifesteal_pct = math.max(0, self:GetSpecialValue("pa_009", "heal_from_damage_pct")),
		},
	})
	local finalDamage = math.max(0, result.final_damage)
	if finalDamage > 0 and IsValid(nil, enemy) then
		EmitSoundOn(PA_009_VICTIM_HIT_SOUND, enemy)
		self:TryApplyWoundingBladeDebuffs(caster, enemy, finalDamage)
	end
	if applyKnockAndStun then
		if not IsValidAlive(nil, enemy) then
			return
		end
		enemy:KnockBack(caster, self, {
			duration = 0.06,
			distance = 30,
			height = 0,
			stun = false,
			origin_pos = origin,
		})
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 1 })
	end
end
function pa_009.prototype.ComputeCutBonusDamage(self, caster, enemy, cutCfg)
	if not cutCfg then
		return 0
	end
	if not IsValidAlive(nil, enemy) then
		return 0
	end
	local Hp = enemy:GetHealth()
	local rawBonus = Hp * cutCfg.maxHealthDamagePct / 100
	local atk = self:GetAllAttackDamage(caster)
	local cap = atk * cutCfg.capAttackMult
	return math.min(math.max(0, rawBonus), math.max(0, cap))
end
function pa_009.prototype.TryApplyWoundingBladeDebuffs(self, caster, enemy, finalDamage)
	if not IsServer() or not IsValidAlive(nil, enemy) then
		return
	end
	local ____tonumber_22 = tonumber
	local ____this_21
	____this_21 = caster
	local ____opt_20 = ____this_21.GetCustomValue
	local chance = ____tonumber_22(____opt_20 and ____opt_20(____this_21, PA_009_GEM_HIT_VULN_CHANCE_KEY) or 0)
	if not __TS__NumberIsFinite(__TS__Number(chance)) or chance <= 0 then
		return
	end
	if not RollPercentage(math.min(100, chance)) then
		return
	end
	AddDeBuffStatus(
		nil,
		enemy,
		caster,
		self,
		DebuffStatusType.VULNERABLE,
		{ stack = 1, duration = PA_009_GEM_VULN_DURATION }
	)
	AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.BLEED, { source_final_damage = finalDamage })
end
pa_009 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_009)
____exports.pa_009 = pa_009
--- 符印「瞬身斩」：`ak_gems.csv` item_G207 需在 modifiers 列挂载本 modifier。
-- 监听 `ON_TAKE_ATTACK_MISS`（与 item_0257 等一致：普攻结算为未命中即触发），受符印冷却约束。
____exports.modifier_pa_009_gem_evasion_slash = __TS__Class()
local modifier_pa_009_gem_evasion_slash = ____exports.modifier_pa_009_gem_evasion_slash
modifier_pa_009_gem_evasion_slash.name = "modifier_pa_009_gem_evasion_slash"
__TS__ClassExtends(modifier_pa_009_gem_evasion_slash, BaseHeroModifier)
function modifier_pa_009_gem_evasion_slash.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self._lastProcGameTime = -1000000000
end
function modifier_pa_009_gem_evasion_slash.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_MISS }
end
function modifier_pa_009_gem_evasion_slash.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_009_gem_evasion_slash.prototype.OnTakeAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	if event.is_miss ~= true then
		return
	end
	local ____tonumber_25 = tonumber
	local ____opt_23 = parent.GetCustomValue
	if ____tonumber_25(____opt_23 and ____opt_23(parent, PA_009_EVASION_SLASH_KEY) or 0) <= 0 then
		return
	end
	local ____opt_26 = parent.GetCustomValue
	local cdRaw = ____opt_26 and ____opt_26(parent, PA_009_EVASION_SLASH_CD_KEY) or 0
	local cdSec = tonumber(cdRaw)
	if not __TS__NumberIsFinite(__TS__Number(cdSec)) or cdSec < 0 then
		return
	end
	local now = GameRules:GetGameTime()
	if now - self._lastProcGameTime < cdSec then
		return
	end
	local ____opt_28 = parent.GetCustomValue
	local chanceRaw = ____opt_28 and ____opt_28(parent, PA_009_EVASION_SLASH_CHANCE_PCT_KEY) or 0
	local chancePct = tonumber(chanceRaw)
	if not __TS__NumberIsFinite(__TS__Number(chancePct)) or chancePct <= 0 then
		return
	end
	if not RollPercentage(math.min(100, chancePct)) then
		return
	end
	local ab = parent:FindAbilityByName("pa_009")
	if not ab or not IsValid(nil, ab) or ab:IsNull() then
		return
	end
	if ab:GetLevel() <= 0 then
		return
	end
	self._lastProcGameTime = now
	ab:TriggerBladeFanFromEvasionGem()
end
modifier_pa_009_gem_evasion_slash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_009_gem_evasion_slash)
____exports.modifier_pa_009_gem_evasion_slash = modifier_pa_009_gem_evasion_slash
return ____exports