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
local AXE_005_RESTORE_SHIELD_PCT_KEY = "axe_005_restore_shield_pct"
local AXE_005_PURE_DAMAGE_CONVERSION_PCT_KEY = "axe_005_pure_damage_conversion_pct"
local AXE_005_ARMOR_DAMAGE_PCT_PER_POINT_KEY = "axe_005_armor_damage_pct_per_point"
local AXE_005_ARMOR_DAMAGE_THRESHOLD = 100
--- 斧王技能 005（嘲讽）
-- 短暂前摇后对附近敌人施加嘲讽 debuff：
-- - 强制攻击施法者
-- 同时给自己施加护甲增益。
____exports.axe_005 = __TS__Class()
local axe_005 = ____exports.axe_005
axe_005.name = "axe_005"
__TS__ClassExtends(axe_005, BaseHeroAbility)
function axe_005.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf", context)
	PrecacheResource("particle", "particles/hero/axe/axe_call.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_silenced.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context)
end
function axe_005.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.2,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		animationPlaybackRate = 1,
	}
end
function axe_005.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	____exports.modifier_axe_005_self_buff:applys(
		caster,
		caster,
		self,
		{ duration = self:GetSpecialValue("axe_005", "self_buff_duration") }
	)
	Timers:CreateTimer(0.1, function()
		caster:EmitSound("Hero_Axe.Berserkers_Call")
		local ownerPfx = MyGameHeroParticleManager:CreateParticle(
			"particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			caster,
			caster
		)
		MyGameHeroParticleManager:SetParticleControlEnt(
			ownerPfx,
			1,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_mouth",
			Vector(0, 0, 0),
			true
		)
		MyGameHeroParticleManager:ReleaseParticleIndex(ownerPfx)
		local castRadius = self:GetSpecialValue("axe_005", "cast_radius")
		local callPfx =
			MyGameHeroParticleManager:CreateParticle("particles/hero/axe/axe_call.vpcf", PATTACH_POINT, caster, caster)
		MyGameHeroParticleManager:SetParticleControl(callPfx, 0, origin)
		MyGameHeroParticleManager:SetParticleControl(callPfx, 2, Vector(castRadius, castRadius, castRadius))
		MyGameHeroParticleManager:ReleaseParticleIndex(callPfx)
		if MyGameDestructibleManager ~= nil then
			MyGameDestructibleManager:BreakCircleForHero(caster, origin, castRadius, self)
		end
		local enemies = self:FindMonsterEnemies(origin, castRadius)
		local pullToDistance = math.max(0, self:GetSpecialValue("axe_005", "pull_to_distance"))
		self:RestoreShield(caster)
		local damagePct = self:GetSpecialValue("axe_005", "self_max_health_damage_pct")
		local ____math_max_4 = math.max
		local ____opt_2 = caster.GetTotalEnergyShield
		local maxShield = ____math_max_4(
			0,
			____opt_2 and ____opt_2(caster) or MyGameAttribute:GetAttribute(caster, "total_energy_shield") or 0
		)
		local baseDamage = (caster:GetMaxHealth() + maxShield) * damagePct * 0.01
		local damage = baseDamage * self:GetArmorDamageMultiplier(caster)
		local pureDamageConversionPct = self:GetPureDamageConversionPct(caster)
		local pullSpeed = 1000
		self:PlayEffects()
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue7
				end
				AddDeBuffStatus(
					nil,
					enemy,
					caster,
					self,
					DebuffStatusType.STUN,
					{ duration = self:GetSpecialValue("axe_005", "debuff_duration") }
				)
				local casterPos = caster:GetAbsOrigin()
				local enemyPos = enemy:GetAbsOrigin()
				local dist = GetDistance(nil, casterPos, enemyPos)
				if dist > pullToDistance then
					local dir = GetDirection(nil, casterPos, enemyPos)
					local target = enemyPos:__add(dir:__mul((dist - pullToDistance) / 2))
					target.z = GetGroundHeight(target, enemy)
					local moveTime = math.max(0.03, (dist - pullToDistance) / pullSpeed)
					enemy:Mover(target, moveTime)
					local currentEnemy = enemy
					Timers:CreateTimer(moveTime, function()
						if not IsValidAlive(nil, caster) or not IsValidAlive(nil, currentEnemy) then
							return
						end
						self:ApplyChallengeRoarDamage(caster, currentEnemy, damage, pureDamageConversionPct)
					end)
				else
					self:ApplyChallengeRoarDamage(caster, enemy, damage, pureDamageConversionPct)
				end
			end
			::__continue7::
		end
	end)
end
function axe_005.prototype.RestoreShield(self, caster)
	local ____tonumber_7 = tonumber
	local ____this_6
	____this_6 = caster
	local ____opt_5 = ____this_6.GetCustomValue
	local restorePct = ____tonumber_7(____opt_5 and ____opt_5(____this_6, AXE_005_RESTORE_SHIELD_PCT_KEY) or 0)
	if restorePct <= 0 then
		return
	end
	local ____math_max_10 = math.max
	local ____this_9
	____this_9 = caster
	local ____opt_8 = ____this_9.GetTotalEnergyShield
	local maxShield = ____math_max_10(
		0,
		____opt_8 and ____opt_8(____this_9) or MyGameAttribute:GetAttribute(caster, "total_energy_shield") or 0
	)
	if maxShield <= 0 then
		return
	end
	local ____this_12
	____this_12 = caster
	local ____opt_11 = ____this_12.AddCurrentEnergyShield
	if ____opt_11 ~= nil then
		____opt_11(____this_12, maxShield * (restorePct / 100), "next_frame_delta")
	end
end
function axe_005.prototype.GetPureDamageConversionPct(self, caster)
	local ____tonumber_15 = tonumber
	local ____this_14
	____this_14 = caster
	local ____opt_13 = ____this_14.GetCustomValue
	local conversionPct =
		____tonumber_15(____opt_13 and ____opt_13(____this_14, AXE_005_PURE_DAMAGE_CONVERSION_PCT_KEY) or 0)
	return math.min(100, math.max(0, conversionPct))
end
function axe_005.prototype.ApplyChallengeRoarDamage(self, caster, target, damage, pureDamageConversionPct)
	local pureDamage = damage * (pureDamageConversionPct / 100)
	local physicalDamage = damage - pureDamage
	if physicalDamage > 0 then
		Damage:ApplyDamage({
			attacker = caster,
			victim = target,
			damage = physicalDamage,
			damage_type = 1,
			ability = self,
		})
	end
	if pureDamage > 0 then
		Damage:ApplyDamage({
			attacker = caster,
			victim = target,
			damage = pureDamage,
			damage_type = 4,
			ability = self,
			extra_data = {
				damage_tags = DamageTag.NO_PROC,
				custom_tag = "axe_005_pure_damage_conversion",
				source_name = "axe_005:纯粹伤害转换",
			},
		})
	end
end
function axe_005.prototype.GetArmorDamageMultiplier(self, caster)
	local ____tonumber_18 = tonumber
	local ____this_17
	____this_17 = caster
	local ____opt_16 = ____this_17.GetCustomValue
	local damagePctPerArmor =
		____tonumber_18(____opt_16 and ____opt_16(____this_17, AXE_005_ARMOR_DAMAGE_PCT_PER_POINT_KEY) or 0)
	if damagePctPerArmor <= 0 then
		return 1
	end
	local totalArmor = math.max(0, MyGameAttribute:GetAttribute(caster, "total_armor") or 0)
	if totalArmor <= AXE_005_ARMOR_DAMAGE_THRESHOLD then
		return 1
	end
	return 1 + totalArmor * damagePctPerArmor / 100
end
function axe_005.prototype.PlayEffects(self)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster(),
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, self:GetCaster():GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, self:GetCaster():GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 2, self:GetCaster():GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	self._caster:EmitSound("Hero_Huskar.Life_Break.Impact")
end
axe_005 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_005)
____exports.axe_005 = axe_005
____exports.modifier_axe_005_self_buff = __TS__Class()
local modifier_axe_005_self_buff = ____exports.modifier_axe_005_self_buff
modifier_axe_005_self_buff.name = "modifier_axe_005_self_buff"
__TS__ClassExtends(modifier_axe_005_self_buff, BaseHeroModifier)
function modifier_axe_005_self_buff.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_005_self_buff.GetLocalizationCN(self)
	return { name = "护甲加成", description = "增加护甲" }
end
function modifier_axe_005_self_buff.prototype.GetAttributeBonus(self)
	local baseArmorPct = self:GetSpecialValue("axe_005", "buff_base_armor_pct")
	local fixedArmor = self:GetSpecialValue("axe_005", "buff_armor")
	return { bonus_armor = fixedArmor, all_armor_pct = baseArmorPct }
end
modifier_axe_005_self_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_005_self_buff)
____exports.modifier_axe_005_self_buff = modifier_axe_005_self_buff
return ____exports