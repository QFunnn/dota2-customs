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
local PA_006_PROC_SOUND = "Hero_PhantomAssassin.Spatter"
--- 弱点打击触发后：与 pa_007 魅影模糊追击相同的固定延迟再结算追加物伤与符印追加普攻
local PA_006_PROC_FOLLOWUP_DELAY = 0.35
--- 与 pa_007 一致：aoe_dmg 以目标为圆心在水平面圆环上取 cp0，正面指向目标
local PA_006_FOLLOWUP_AOE_PFX = "particles/aa/aoe_dmg.vpcf"
local PA_006_FOLLOWUP_AOE_RING_RADIUS = 150
--- 符印「分影斩」：在 KV 的 magic_hits_per_proc 基础上额外需要的魔法伤害次数（hero_data）
local PA_006_GEM_FENYINZHAN_MAGIC_HITS_ADD_KEY = "pa_006_gem_fenyinzhan_magic_hits_add"
--- 符印「分影斩」：触发弱点打击时追加一次次级普攻（>0 生效）
local PA_006_GEM_FENYINZHAN_EXTRA_ATTACK_KEY = "pa_006_gem_fenyinzhan_extra_attack"
local PA_006_GEM_FENYINZHAN_ATTACK_DAMAGE_MAGIC_PCT_KEY = "pa_006_gem_fenyinzhan_attack_damage_magic_pct"
--- 幻影刺客技能 006 - 勒紧（被动，建议置于 W 槽）
-- 每造成若干次对敌方的魔法伤害，在该次伤害结算后经固定短延迟再追加一段物理伤害：总敏捷 × 配置百分比；
-- 表现与 pa_007 追击一致（环形 aoe_dmg 特效 + 同秒延迟）。
____exports.pa_006 = __TS__Class()
local pa_006 = ____exports.pa_006
pa_006.name = "pa_006"
__TS__ClassExtends(pa_006, BaseHeroAbility)
function pa_006.prototype.Precache(self, context)
	PrecacheResource("particle", PA_006_FOLLOWUP_AOE_PFX, context)
end
function pa_006.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pa_006.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_006_garrote.name
end
function pa_006.prototype.GetMagicHitsPerProc(self)
	local base = math.max(1, math.floor(self:GetSpecialValue("pa_006", "magic_hits_per_proc")))
	local caster = self:GetCaster()
	local ____math_max_4 = math.max
	local ____math_floor_3 = math.floor
	local ____tonumber_2 = tonumber
	local ____opt_0 = caster.GetCustomValue
	local add = ____math_max_4(
		0,
		____math_floor_3(____tonumber_2(____opt_0 and ____opt_0(caster, PA_006_GEM_FENYINZHAN_MAGIC_HITS_ADD_KEY) or 0))
	)
	return base + add
end
function pa_006.prototype.GetAgilityDamagePct(self)
	return math.max(0, self:GetSpecialValue("pa_006", "agility_damage_pct"))
end
function pa_006.prototype.GetFenyinzhanAttackDamageMagicPct(self, caster)
	local ____math_max_8 = math.max
	local ____tonumber_7 = tonumber
	local ____this_6
	____this_6 = caster
	local ____opt_5 = ____this_6.GetCustomValue
	return ____math_max_8(
		0,
		____tonumber_7(____opt_5 and ____opt_5(____this_6, PA_006_GEM_FENYINZHAN_ATTACK_DAMAGE_MAGIC_PCT_KEY) or 0) or 0
	)
end
function pa_006.prototype.PlayFollowupAoeDmgPfxOnTarget(self, target)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, target) then
		return
	end
	local center = target:GetAbsOrigin()
	local theta = RandomFloat(0, 2 * math.pi)
	local r = PA_006_FOLLOWUP_AOE_RING_RADIUS
	local pFlat = center:__add(Vector(r * math.cos(theta), r * math.sin(theta), 0))
	local pOnRing = GetGroundPosition(pFlat, target)
	local faceTarget = GetDirection(nil, center, pOnRing)
	local caster = self:GetCaster()
	local pfx = MyGameHeroParticleManager:CreateParticle(PA_006_FOLLOWUP_AOE_PFX, PATTACH_WORLDORIGIN, nil, caster)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, pOnRing)
	MyGameHeroParticleManager:SetParticleControlTransformForward(pfx, 0, pOnRing, faceTarget)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
pa_006 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_006)
____exports.pa_006 = pa_006
____exports.modifier_pa_006_garrote = __TS__Class()
local modifier_pa_006_garrote = ____exports.modifier_pa_006_garrote
modifier_pa_006_garrote.name = "modifier_pa_006_garrote"
__TS__ClassExtends(modifier_pa_006_garrote, BaseHeroModifier)
function modifier_pa_006_garrote.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.magicHitCounter = 0
end
function modifier_pa_006_garrote.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_pa_006_garrote.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_006_garrote.prototype.IsPermanent(self)
	return true
end
function modifier_pa_006_garrote.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	if event.attacker ~= parent then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if not IsValidAlive(nil, event.victim) then
		return
	end
	if event.victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if event.damage_type ~= 2 then
		return
	end
	self.magicHitCounter = self.magicHitCounter + 1
	local need = ability:GetMagicHitsPerProc()
	if self.magicHitCounter < need then
		return
	end
	self.magicHitCounter = 0
	local victim = event.victim
	local entIndex = victim:GetEntityIndex()
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local bonus = agility * (ability:GetAgilityDamagePct() / 100)
	if bonus <= 0 then
		return
	end
	local ____tonumber_11 = tonumber
	local ____opt_9 = parent.GetCustomValue
	if ____tonumber_11(____opt_9 and ____opt_9(parent, PA_006_GEM_FENYINZHAN_EXTRA_ATTACK_KEY) or 0) > 0 then
		self:Timer(PA_006_PROC_FOLLOWUP_DELAY, function()
			if not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
				return
			end
			if not IsValidAlive(nil, victim) or victim:GetEntityIndex() ~= entIndex then
				return
			end
			ability:PlayFollowupAoeDmgPfxOnTarget(victim)
			victim:EmitSound(PA_006_PROC_SOUND)
			Damage:ApplyDamage({
				attacker = parent,
				victim = victim,
				damage = bonus,
				damage_type = 1,
				ability = ability,
			})
			local attackDamageMagicPct = ability:GetFenyinzhanAttackDamageMagicPct(parent)
			local attackDamageMagicBonus = ability:GetAllAttackDamage(parent) * attackDamageMagicPct / 100
			if attackDamageMagicBonus > 0 then
				Damage:ApplyDamage({
					attacker = parent,
					victim = victim,
					damage = attackDamageMagicBonus,
					damage_type = 2,
					ability = ability,
				})
			end
			MyGameAttack:PerformAttack(
				parent,
				victim,
				{ use_projectile = false, is_sub_attack = false, use_effect = true }
			)
		end)
	end
	self:GetAbility():StartCooldown(ability:GetCooldown(math.max(0, ability:GetLevel() - 1)))
end
function modifier_pa_006_garrote.prototype.GetTexture(self)
	return "phantom_assassin_coup_de_grace"
end
modifier_pa_006_garrote = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_006_garrote)
____exports.modifier_pa_006_garrote = modifier_pa_006_garrote
return ____exports