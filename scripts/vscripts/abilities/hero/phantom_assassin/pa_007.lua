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
--- 施法瞬间特效
local PA_007_BLUR_START_PFX =
	"particles/econ/items/phantom_assassin/pa_crimson_witness_2021/pa_crimson_witness_blur_start.vpcf"
--- Buff 持续期间挂在单位上的环境特效（由 modifier GetEffectName 驱动）
local PA_007_BLUR_AMBIENT_PFX = "particles/pa_crimson_witness_blur_ambient.vpcf"
local PA_007_CAST_SOUND = "Hero_PhantomAssassin.Blur"
local PA_007_BREAK_SOUND = "Hero_PhantomAssassin.Blur.Break"
--- 模糊追击：aoe_dmg 以目标为圆心，在水平面半径 757 的圆上取 cp0，正面指向目标
local PA_007_FOLLOWUP_AOE_PFX = "particles/aa/aoe_dmg.vpcf"
local PA_007_FOLLOWUP_AOE_RING_RADIUS = 150
--- 模糊持续期间：每次普攻「命中结算」后，经该固定延迟再结算追加伤害与一次次级普攻
local PA_007_BLUR_FOLLOWUP_DELAY = 0.35
--- 幻影刺客技能 007 - 魅影模糊
-- 主动：获得模糊状态，移速按 KV 提升；闪避率在 MissCheck 回流中按 KV 倍数乘算 。
-- 持续期间：普攻命中敌人后，短延迟内追加一次基于敏捷的固定物理伤害，并再触发一次次级攻击（走项目攻击管线）。
____exports.pa_007 = __TS__Class()
local pa_007 = ____exports.pa_007
pa_007.name = "pa_007"
__TS__ClassExtends(pa_007, BaseHeroAbility)
function pa_007.prototype.Precache(self, context)
	PrecacheResource("particle", PA_007_BLUR_START_PFX, context)
	PrecacheResource("particle", PA_007_BLUR_AMBIENT_PFX, context)
	PrecacheResource("particle", PA_007_FOLLOWUP_AOE_PFX, context)
end
function pa_007.prototype.GetAbilityConfig(self)
	return { castPoint = 0, castAnimation = ACT_DOTA_CAST_ABILITY_3, behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function pa_007.prototype.GetBonusMovespeedPct(self)
	return math.max(0, self:GetSpecialValue("pa_007", "bonus_movespeed_pct"))
end
function pa_007.prototype.GetBlurDuration(self)
	return math.max(0.03, self:GetSpecialValue("pa_007", "duration"))
end
function pa_007.prototype.GetEvasionMultiplier(self)
	return math.max(0, self:GetSpecialValue("pa_007", "evasion_multiplier"))
end
function pa_007.prototype.GetAgilityFixedDamagePct(self)
	return math.max(0, self:GetSpecialValue("pa_007", "agility_fixed_damage_pct"))
end
function pa_007.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValid(nil, caster) or not caster:IsAlive() then
		return
	end
	caster:EmitSound(PA_007_CAST_SOUND)
	local startPfx =
		MyGameHeroParticleManager:CreateParticle(PA_007_BLUR_START_PFX, PATTACH_ABSORIGIN_FOLLOW, caster, caster)
	MyGameHeroParticleManager:SetParticleControlEnt(
		startPfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(startPfx)
	caster:AddNewModifier(caster, self, ____exports.modifier_pa_007_blur.name, { duration = self:GetBlurDuration() })
	caster:AddNewModifier(caster, self, "modifier_cs_damage_reduction", { duration = 0.5, damage_reduction_pct = 100 })
end
function pa_007.prototype.PlayFollowupAoeDmgPfxOnTarget(self, target)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, target) then
		return
	end
	local center = target:GetAbsOrigin()
	local theta = RandomFloat(0, 2 * math.pi)
	local r = PA_007_FOLLOWUP_AOE_RING_RADIUS
	local pFlat = center:__add(Vector(r * math.cos(theta), r * math.sin(theta), 0))
	local pOnRing = GetGroundPosition(pFlat, target)
	local faceTarget = GetDirection(nil, center, pOnRing)
	local caster = self:GetCaster()
	local pfx = MyGameHeroParticleManager:CreateParticle(PA_007_FOLLOWUP_AOE_PFX, PATTACH_WORLDORIGIN, nil, caster)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, pOnRing)
	MyGameHeroParticleManager:SetParticleControlTransformForward(pfx, 0, pOnRing, faceTarget)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
pa_007 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_007)
____exports.pa_007 = pa_007
____exports.modifier_pa_007_blur = __TS__Class()
local modifier_pa_007_blur = ____exports.modifier_pa_007_blur
modifier_pa_007_blur.name = "modifier_pa_007_blur"
__TS__ClassExtends(modifier_pa_007_blur, BaseHeroModifier)
function modifier_pa_007_blur.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.timer = 0
end
function modifier_pa_007_blur.GetLocalizationCN(self)
	return {
		name = "魅影模糊",
		description = "幻影刺客获得模糊状态，普攻命中敌人后追加一次攻击",
	}
end
function modifier_pa_007_blur.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_pa_007_blur.prototype.GetModifierInvisibilityLevel(self)
	return 1
end
function modifier_pa_007_blur.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_EVASION_QUERY, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_pa_007_blur.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	if GameRules:GetGameTime() < self.timer then
		return
	end
	local entIndex = target:GetEntityIndex()
	self:Timer(PA_007_BLUR_FOLLOWUP_DELAY, function()
		if not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
			return
		end
		if not IsValidAlive(nil, target) or target:GetEntityIndex() ~= entIndex then
			return
		end
		ability:PlayFollowupAoeDmgPfxOnTarget(target)
		local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
		local pct = ability:GetAgilityFixedDamagePct()
		local fixedDamage = agility * (pct / 100)
		if fixedDamage > 0 then
			Damage:ApplyDamage({
				attacker = parent,
				victim = target,
				damage = fixedDamage,
				damage_type = 1,
				ability = ability,
			})
		end
		self.timer = GameRules:GetGameTime() + 0.05
		MyGameAttack:PerformAttack(parent, target, { use_projectile = false, use_effect = true })
	end)
end
function modifier_pa_007_blur.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = true, isPurgeException = false }
end
function modifier_pa_007_blur.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		bonus_movespeed_pct = ability:GetBonusMovespeedPct(),
		damage_reduction_pct = 35,
	}
end
function modifier_pa_007_blur.prototype.OnDamageEvasionQuery_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local mult = ability:GetEvasionMultiplier()
	if mult <= 0 or mult == 1 then
		return
	end
	local ____event_evasion_chance_0, ____mul_1 = event.evasion_chance, "mul"
	if ____event_evasion_chance_0[____mul_1] == nil then
		____event_evasion_chance_0[____mul_1] = {}
	end
	local ____event_evasion_chance_mul_2 = event.evasion_chance.mul
	____event_evasion_chance_mul_2[#____event_evasion_chance_mul_2 + 1] =
		{ value = mult, source = "pa_007:闪避倍率" }
end
function modifier_pa_007_blur.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self._pfx = MyGameHeroParticleManager:CreateParticle(
		PA_007_BLUR_AMBIENT_PFX,
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		self._pfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
end
function modifier_pa_007_blur.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and parent:IsAlive() then
		parent:EmitSound(PA_007_BREAK_SOUND)
	end
	if self._pfx then
		MyGameHeroParticleManager:DestroyParticle(self._pfx, false)
		MyGameHeroParticleManager:ReleaseParticleIndex(self._pfx)
		self._pfx = nil
	end
end
function modifier_pa_007_blur.prototype.GetTexture(self)
	return "phantom_assassin_blur"
end
modifier_pa_007_blur = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_007_blur)
____exports.modifier_pa_007_blur = modifier_pa_007_blur
return ____exports