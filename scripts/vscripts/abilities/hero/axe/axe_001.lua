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
--- 主目标附近搜索额外打击中心：水平半径
local AXE_001_TRIPLE_SEARCH_RADIUS = 600
--- 自定义值 > 0 时启用：额外打击中心数量（例：2 表示额外打击 2 个目标）
local AXE_001_TRIPLE_EXTRA_CENTER_COUNT_KEY = "axe_001_triple_blow_extra_center_count"
--- 自定义值：施法后强化普攻次数
local AXE_001_DOUBLE_EMPOWERED_ATTACK_COUNT_KEY = "axe_001_double_empowered_attack_count"
--- 自定义值：眩晕减少百分比（例如 60 表示减少 60%）
local AXE_001_DOUBLE_STUN_REDUCTION_PCT_KEY = "axe_001_double_stun_reduction_pct"
--- 符印：每损失 1% 生命值，奋力一击伤害额外提高的百分比。
local AXE_001_DAMAGE_PCT_PER_MISSING_HEALTH_PCT_KEY = "axe_001_damage_pct_per_missing_health_pct"
--- 主挥击与（若有）额外挥击的统一延迟（秒）
local AXE_001_STRIKE_DELAY = 0.3
--- 击退：时长（秒）
local AXE_001_KNOCKBACK_DURATION = 0.5
--- 击退：水平距离
local AXE_001_KNOCKBACK_DISTANCE = 75
--- 击退：抛物线峰值高度
local AXE_001_KNOCKBACK_HEIGHT = 250
--- 斧王技能 001
____exports.axe_001 = __TS__Class()
local axe_001 = ____exports.axe_001
axe_001.name = "axe_001"
__TS__ClassExtends(axe_001, BaseHeroAbility)
function axe_001.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/hero/axe/axe_001.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf", context)
	PrecacheResource("particle", "particles/hero/axe/axe_call.vpcf", context)
	PrecacheResource("particle", "particles/hero/axe/axe_001_2.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_culling_blade_sprint.vpcf",
		context
	)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context)
end
function axe_001.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET
			+ DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT
			+ DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		animationPlaybackRate = 1,
	}
end
function axe_001.prototype.OnSpellStart(self)
	self._caster:EmitSound("Hero_Axe.Berserkers_Call")
	____exports.modifier_axe_001_buff:applys(
		self._caster,
		self._caster,
		self,
		{ duration = self:GetSpecialValue("axe_001", "buff_duration") }
	)
	self._caster:EmitSound("Hero_Axe.Battle_Hunger")
end
axe_001 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_001)
____exports.axe_001 = axe_001
____exports.modifier_axe_001_buff = __TS__Class()
local modifier_axe_001_buff = ____exports.modifier_axe_001_buff
modifier_axe_001_buff.name = "modifier_axe_001_buff"
__TS__ClassExtends(modifier_axe_001_buff, BaseHeroModifier)
function modifier_axe_001_buff.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.pendingStrikeCount = 0
	self.isMultiStrike = false
end
function modifier_axe_001_buff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_axe_001_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.pendingStrikeCount = 0
	local ____this_1
	____this_1 = self._caster
	local ____opt_0 = ____this_1.GetCustomValue
	local empoweredAttackCountRaw = ____opt_0 and ____opt_0(____this_1, AXE_001_DOUBLE_EMPOWERED_ATTACK_COUNT_KEY) or 1
	local empoweredAttackCount = math.max(1, math.floor(tonumber(empoweredAttackCountRaw) or 1))
	self.isMultiStrike = empoweredAttackCount > 1
	self:SetStackCount(empoweredAttackCount)
end
function modifier_axe_001_buff.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START }
end
function modifier_axe_001_buff.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	if self:GetStackCount() <= 0 then
		return
	end
	self:SetStackCount(math.max(0, self:GetStackCount() - 1))
	self:RefreshDurationAfterMultiStrike()
	self.pendingStrikeCount = self.pendingStrikeCount + 1
	self._caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	local target = event.target
	local ____this_3
	____this_3 = self._caster
	local ____opt_2 = ____this_3.GetCustomValue
	local extraCenterCountRaw = ____opt_2 and ____opt_2(____this_3, AXE_001_TRIPLE_EXTRA_CENTER_COUNT_KEY) or 0
	local extraCenterCount = tonumber(extraCenterCountRaw) or 0
	local hasTripleBlow = extraCenterCount > 0
	local ____this_5
	____this_5 = self._caster
	local ____opt_4 = ____this_5.GetCustomValue
	local stunReductionPctRaw = ____opt_4 and ____opt_4(____this_5, AXE_001_DOUBLE_STUN_REDUCTION_PCT_KEY) or 0
	local stunReductionPct = math.max(0, math.min(100, tonumber(stunReductionPctRaw) or 0))
	local stunMultiplier = 1 - stunReductionPct / 100
	local extraStrikeUnits = {}
	if hasTripleBlow then
		local targetOrigin = target:GetAbsOrigin()
		local inRange = self:FindMonsterEnemies(targetOrigin, AXE_001_TRIPLE_SEARCH_RADIUS)
		self:Timer(0.3, function()
			for ____, u in ipairs(inRange) do
				do
					if #extraStrikeUnits >= extraCenterCount then
						break
					end
					if not IsValid(nil, u) or u == target then
						goto __continue16
					end
					extraStrikeUnits[#extraStrikeUnits + 1] = u
					self:PlaySecondaryStrikeFxAndDamage(u:GetAbsOrigin())
				end
				::__continue16::
			end
		end)
	end
	self:Timer(AXE_001_STRIKE_DELAY, function()
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, self._caster) then
			return
		end
		if not IsValid(nil, target) then
			return
		end
		self:PlayDamageEffects(target:GetAbsOrigin(), stunMultiplier)
		self:Timer(AXE_001_STRIKE_DELAY * 0.7, function()
			if not IsValidAlive(nil, parent) or not IsValidAlive(nil, self._caster) then
				return
			end
			for ____, u in ipairs(extraStrikeUnits) do
				do
					if not IsValidAlive(nil, u) then
						goto __continue25
					end
					self:PlayDamageEffects(u:GetAbsOrigin(), stunMultiplier)
				end
				::__continue25::
			end
			self.pendingStrikeCount = math.max(0, self.pendingStrikeCount - 1)
			if self.pendingStrikeCount <= 0 and self:GetStackCount() <= 0 then
				self:Destroy()
			end
		end)
	end)
	self._caster:EmitSound("Hero_Axe.BerserkersCall.Item.Shoutmask")
end
function modifier_axe_001_buff.prototype.RefreshDurationAfterMultiStrike(self)
	if not self.isMultiStrike then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local duration = self:GetSpecialValue("axe_001", "buff_duration")
	if duration <= 0 then
		return
	end
	self:SetDuration(duration, true)
end
function modifier_axe_001_buff.prototype.PlaySecondaryStrikeFxAndDamage(self, pos)
	local effect = MyGameHeroParticleManager:CreateParticle(
		"particles/hero/axe/axe_001_2.vpcf",
		PATTACH_POINT,
		self._parent,
		self._caster
	)
	local dir = GetDirection(nil, pos, self._caster:GetAbsOrigin())
	local fxOrigin = pos - dir * 175
	MyGameHeroParticleManager:SetParticleControl(effect, 0, fxOrigin)
	MyGameHeroParticleManager:SetParticleControlTransformForward(effect, 0, fxOrigin, dir)
	MyGameHeroParticleManager:ReleaseParticleIndex(effect)
end
function modifier_axe_001_buff.prototype.PlayDamageEffects(self, pos, stunMultiplier)
	if stunMultiplier == nil then
		stunMultiplier = 1
	end
	print("造成伤害")
	self._caster:EmitSound("Hero_Sven.SignetLayer")
	local aoe = self:GetSpecialValue("axe_001", "aoe")
	local stunDuration = self:GetSpecialValue("axe_001", "stun_duration") * stunMultiplier
	local effect = MyGameHeroParticleManager:CreateParticle(
		"particles/hero/axe/axe_call.vpcf",
		PATTACH_POINT,
		self._parent,
		self._caster
	)
	MyGameHeroParticleManager:SetParticleControl(effect, 0, pos)
	MyGameHeroParticleManager:SetParticleControlTransformForward(effect, 0, pos, self._caster:GetForwardVector())
	MyGameHeroParticleManager:SetParticleControl(effect, 2, Vector(aoe, aoe, aoe))
	MyGameHeroParticleManager:ReleaseParticleIndex(effect)
	local ____this_7
	____this_7 = self._caster
	local ____opt_6 = ____this_7.GetCustomValue
	local extraMaxHealthPctRaw = ____opt_6 and ____opt_6(____this_7, "axe_001_extra_max_health_dmg_pct") or 0
	local extraMaxHealthPct = tonumber(extraMaxHealthPctRaw) or 0
	local maxHealth = MyGameAttribute:GetAttribute(self._caster, "total_health") or 0
	local mainDamage = maxHealth * self:GetSpecialValue("axe_001", "attack_damage_multiplier") / 100
	local extraDamage = maxHealth * extraMaxHealthPct / 100
	local currentHealth = math.max(0, self._caster:GetHealth())
	local currentMaxHealth = math.max(1, self._caster:GetMaxHealth())
	local missingHealthPct = math.max(0, math.min(100, (currentMaxHealth - currentHealth) / currentMaxHealth * 100))
	local ____tonumber_10 = tonumber
	local ____this_9
	____this_9 = self._caster
	local ____opt_8 = ____this_9.GetCustomValue
	local bonusDamagePctPerMissingHealthPct = ____tonumber_10(
		____opt_8 and ____opt_8(____this_9, AXE_001_DAMAGE_PCT_PER_MISSING_HEALTH_PCT_KEY) or 0
	) or 0
	local damageBonusMultiplier = 1 + missingHealthPct * bonusDamagePctPerMissingHealthPct / 100
	local finalDamage = (mainDamage + extraDamage) * damageBonusMultiplier
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(self._caster, pos, aoe, self:GetAbility())
	end
	local enemies = self:FindMonsterEnemies(pos, aoe)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue35
			end
			enemy:KnockBack(self:GetCaster(), self:GetAbility(), {
				duration = AXE_001_KNOCKBACK_DURATION,
				stun = true,
				destroyTreesType = "onDestroy",
				heightType = "parabola",
				particleName = "",
				distance = AXE_001_KNOCKBACK_DISTANCE,
				height = AXE_001_KNOCKBACK_HEIGHT,
				stunDuration = stunDuration,
				removeOnDeath = true,
				origin_pos = pos,
			})
			Damage:ApplyDamage({
				attacker = self._caster,
				damage = finalDamage,
				damage_type = 1,
				victim = enemy,
				ability = self:GetAbility(),
				damage_flag = ApplyDamageFlag.NO_FLAG,
			})
		end
		::__continue35::
	end
end
function modifier_axe_001_buff.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_001_buff.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = self:GetSpecialValue("axe_001", "buff_movespeed_pct") }
end
function modifier_axe_001_buff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_axe_001_buff.prototype.GetActivityTranslationModifiers(self)
	return "chase"
end
function modifier_axe_001_buff.prototype.SetOverheadEffectOffset(self, offset)
	return true
end
function modifier_axe_001_buff.prototype.GetEffectName(self)
	return "particles/econ/items/axe/axe_cinder/axe_cinder_battle_hunger.vpcf"
end
function modifier_axe_001_buff.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
modifier_axe_001_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_001_buff)
____exports.modifier_axe_001_buff = modifier_axe_001_buff
return ____exports