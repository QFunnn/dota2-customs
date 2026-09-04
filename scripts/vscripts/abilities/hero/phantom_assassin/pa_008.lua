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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local PA_008_DAMAGE_PARTICLE = "particles/phantom_assassin_phantom_strike_start.vpcf"
local PA_008_PROC_SOUND = "Hero_PhantomAssassin.Dagger.Target"
--- 吸血池转化：等价于每秒流失当前池量的 25%，按 0.25s 步长切片结算
local PA_008_POOL_TICK_INTERVAL = 0.25
local PA_008_POOL_DRAIN_PER_SEC = 0.25
--- 符印蓄血池容量上限：按最大生命百分比计算（默认 100）
local PA_008_OVERHEAL_POOL_CAP_MAX_HP_PCT_KEY = "pa_008_overheal_pool_cap_max_hp_pct"
local PA_008_OVERHEAL_POOL_CAP_MAX_HP_PCT_DEFAULT = 100
--- 单 tick 治疗下限 = 最大生命 × 该比例。
-- - 每 tick 转化量不低于该下限（避免中段出现 8、9 这种小数字）
-- - 剩余池量不足一次下限时，把最后这点尾巴整包 dump
local PA_008_POOL_MIN_HEAL_PCT_OF_MAX_HP = 0.05
--- 幻影刺客技能 008 - 兵势（被动）
--
-- - 受到主动治疗/吸血时，获得等量兵势（以实际生效治疗量为准，不区分来源）。
-- - 下一次普通攻击命中时消耗全部兵势，追加等量（×倍率）物理伤害。
-- - 符印「蓄血兵势」：`ak_gems.csv` item_G205，挂载
--   `modifier_pa_008_gem_overheal_pool` 独立维护吸血溢出池。
____exports.pa_008 = __TS__Class()
local pa_008 = ____exports.pa_008
pa_008.name = "pa_008"
__TS__ClassExtends(pa_008, BaseHeroAbility)
function pa_008.prototype.Precache(self, context)
	PrecacheResource("particle", PA_008_DAMAGE_PARTICLE, context)
end
function pa_008.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pa_008.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_008_bing_shi.name
end
function pa_008.prototype.GetDamageMultiplierPct(self)
	return math.max(0, self:GetSpecialValue("pa_008", "damage_multiplier_pct"))
end
pa_008 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_008)
____exports.pa_008 = pa_008
____exports.modifier_pa_008_bing_shi = __TS__Class()
local modifier_pa_008_bing_shi = ____exports.modifier_pa_008_bing_shi
modifier_pa_008_bing_shi.name = "modifier_pa_008_bing_shi"
__TS__ClassExtends(modifier_pa_008_bing_shi, BaseHeroModifier)
function modifier_pa_008_bing_shi.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.bingShi = 0
end
function modifier_pa_008_bing_shi.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HEAL_RECEIVED, BusinessEvents.ON_ATTACK }
end
function modifier_pa_008_bing_shi.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_008_bing_shi.GetLocalizationCN(self)
	return {
		name = "兵势",
		description = "下一次普通攻击命中时消耗全部兵势，追加等量物理伤害。",
	}
end
function modifier_pa_008_bing_shi.prototype.IsHidden(self)
	if self:GetStackCount() > 0 then
		return false
	end
	return true
end
function modifier_pa_008_bing_shi.prototype.OnHealReceived_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	if event.source == "item" then
		return
	end
	if (event.actual_amount or 0) <= 0 then
		return
	end
	self.bingShi = self.bingShi + event.actual_amount
	local maxHealth = parent:GetMaxHealth()
	if self.bingShi > maxHealth then
		self.bingShi = maxHealth
	end
	self:SetStackCount(self.bingShi)
end
function modifier_pa_008_bing_shi.prototype.OnAttack_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	if not event.target or not IsValidAlive(nil, event.target) or event.target:IsBuilding() then
		return
	end
	if event.target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local total = self.bingShi
	if total <= 0 then
		return
	end
	local mult = ability:GetDamageMultiplierPct() / 100
	local bonus = total * mult
	if bonus <= 0 then
		return
	end
	self.bingShi = 0
	self:SetStackCount(self.bingShi)
	event.target:EmitSound(PA_008_PROC_SOUND)
	Damage:ApplyDamage({
		attacker = parent,
		victim = event.target,
		damage = bonus,
		damage_type = 1,
		ability = ability,
	})
	local pfx =
		MyGameHeroParticleManager:CreateParticle(PA_008_DAMAGE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, event.target, parent)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		event.target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		event.target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	ability:StartCooldown(ability:GetCooldown(math.max(0, ability:GetLevel() - 1)))
end
modifier_pa_008_bing_shi = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_008_bing_shi)
____exports.modifier_pa_008_bing_shi = modifier_pa_008_bing_shi
--- 符印「蓄血兵势」：`ak_gems.csv` item_G205 挂载，持有英雄独享。
--
-- - 仅统计「吸血」来源（attack_lifesteal / spell_lifesteal）的溢出治疗。
-- - 池容量上限默认为英雄最大生命值，可通过词条按最大生命百分比配置。
-- - 每 0.25s 按每秒 25% 的速率把池量转化为治疗；单次计划转化 <
--   最大生命 5% 时一次性清空以避免尾数。
____exports.modifier_pa_008_gem_overheal_pool = __TS__Class()
local modifier_pa_008_gem_overheal_pool = ____exports.modifier_pa_008_gem_overheal_pool
modifier_pa_008_gem_overheal_pool.name = "modifier_pa_008_gem_overheal_pool"
__TS__ClassExtends(modifier_pa_008_gem_overheal_pool, BaseHeroModifier)
function modifier_pa_008_gem_overheal_pool.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.pool = 0
	self._ability_008_is_valid = false
end
function modifier_pa_008_gem_overheal_pool.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HEAL_RECEIVED }
end
function modifier_pa_008_gem_overheal_pool.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:StartIntervalThink(PA_008_POOL_TICK_INTERVAL)
end
function modifier_pa_008_gem_overheal_pool.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_008_gem_overheal_pool.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_pa_008_gem_overheal_pool.prototype.RemoveOnDeath(self)
	return false
end
function modifier_pa_008_gem_overheal_pool.prototype.GetTexture(self)
	return "spectre_dispersion"
end
function modifier_pa_008_gem_overheal_pool.GetLocalizationCN(self)
	return { name = "蓄血", description = "吸血溢出暂存于池中，持续转化为治疗。" }
end
function modifier_pa_008_gem_overheal_pool.prototype.OnHealReceived_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	local src = event.source
	if src ~= "attack_lifesteal" and src ~= "spell_lifesteal" then
		return
	end
	local overheal = event.overheal or 0
	if overheal <= 0 then
		return
	end
	self.pool = self.pool + overheal
	local maxHealth = parent:GetMaxHealth()
	local ____math_max_3 = math.max
	local ____tonumber_2 = tonumber
	local ____opt_0 = parent.GetCustomValue
	local capPct = ____math_max_3(
		0,
		____tonumber_2(
			____opt_0 and ____opt_0(parent, PA_008_OVERHEAL_POOL_CAP_MAX_HP_PCT_KEY)
				or PA_008_OVERHEAL_POOL_CAP_MAX_HP_PCT_DEFAULT
		) or PA_008_OVERHEAL_POOL_CAP_MAX_HP_PCT_DEFAULT
	)
	local maxPool = maxHealth * (capPct / 100)
	if self.pool > maxPool then
		self.pool = maxPool
	end
	self:SyncStackDisplay()
end
function modifier_pa_008_gem_overheal_pool.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self.pool <= 0 then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	if not self._ability_008_is_valid then
		local ability = parent and parent:FindAbilityByName("pa_008")
		if not ability then
			return
		end
		self._ability_008 = ability
		self._ability_008_is_valid = true
	else
		local cached = self._ability_008
		if not cached or not IsValid(nil, cached) or cached:IsNull() then
			local ability = parent and parent:FindAbilityByName("pa_008")
			if not ability then
				self._ability_008_is_valid = false
				self._ability_008 = nil
				return
			end
			self._ability_008 = ability
		end
	end
	local maxHp = parent:GetMaxHealth()
	local minHeal = maxHp * PA_008_POOL_MIN_HEAL_PCT_OF_MAX_HP
	local healFromPool
	if self.pool < minHeal then
		healFromPool = self.pool
		self.pool = 0
	else
		local fractionalTake = self.pool * PA_008_POOL_DRAIN_PER_SEC * PA_008_POOL_TICK_INTERVAL
		healFromPool = math.max(fractionalTake, minHeal)
		healFromPool = math.min(healFromPool, self.pool)
		self.pool = self.pool - healFromPool
		if self.pool < 0 then
			self.pool = 0
		end
	end
	if healFromPool > 0 then
		parent:CustomHeal(healFromPool, { ability = self._ability_008, source = "other" })
	end
	self:SyncStackDisplay()
end
function modifier_pa_008_gem_overheal_pool.prototype.SyncStackDisplay(self)
	local stacks = math.floor(self.pool)
	if self.pool > 0 and stacks < 1 then
		stacks = 1
	end
	self:SetStackCount(stacks)
end
modifier_pa_008_gem_overheal_pool = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_008_gem_overheal_pool)
____exports.modifier_pa_008_gem_overheal_pool = modifier_pa_008_gem_overheal_pool
return ____exports