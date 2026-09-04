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
local ____effect_modifiers = require("modifiers.effect_modifiers")
local modifier_wearable_unit_state = ____effect_modifiers.modifier_wearable_unit_state
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local BLOOD_OATH_HEAD_MODEL = "models/items/axe/axe_lava_legion_commander_head/axe_lava_legion_commander_head.vmdl"
local BLOOD_OATH_WEAPON_MODEL =
	"models/items/axe/axe_lava_legion_commander_weapon/axe_lava_legion_commander_weapon.vmdl"
local BLOOD_OATH_HEAD_AMBIENT = "particles/econ/items/axe/lava_legion/lava_legion_head_ambient.vpcf"
local BLOOD_OATH_WEAPON_AMBIENT = "particles/econ/items/axe/lava_legion/lava_legion_weapon_ambient.vpcf"
local BLOOD_OATH_WEARABLE_MODELS = {
	"models/items/axe/axe_lava_legion_commander_armor/axe_lava_legion_commander_armor.vmdl",
	"models/items/axe/axe_lava_legion_commander_belt/axe_lava_legion_commander_belt.vmdl",
	BLOOD_OATH_HEAD_MODEL,
	"models/items/axe/axe_lava_legion_commander_misc/axe_lava_legion_commander_misc.vmdl",
	BLOOD_OATH_WEAPON_MODEL,
}
____exports.axe_008 = __TS__Class()
local axe_008 = ____exports.axe_008
axe_008.name = "axe_008"
__TS__ClassExtends(axe_008, BaseHeroAbility)
function axe_008.prototype.Precache(self, context)
	for ____, model in ipairs(BLOOD_OATH_WEARABLE_MODELS) do
		PrecacheResource("model", model, context)
	end
	PrecacheResource("particle", BLOOD_OATH_HEAD_AMBIENT, context)
	PrecacheResource("particle", BLOOD_OATH_WEAPON_AMBIENT, context)
	PrecacheResource("particle", "particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf", context)
end
function axe_008.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.5,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		animationPlaybackRate = 1,
	}
end
function axe_008.prototype.OnAbilityPhaseStart(self)
	if not IsServer() then
		return true
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return false
	end
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/hero/axe_008.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, Vector(500, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	return true
end
function axe_008.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	____exports.modifier_axe_008_blood_oath:applys(
		caster,
		caster,
		self,
		{ duration = self:GetSpecialValue("axe_008", "buff_duration") }
	)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/econ/items/sven/sven_ti10_helmet/sven_ti10_helmet_gods_strength.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControlTransformForward(
		pfx,
		0,
		caster:GetAbsOrigin(),
		caster:GetForwardVector()
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	caster:EmitSound("Hero_Sven.GodsStrength")
end
axe_008 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_008)
____exports.axe_008 = axe_008
____exports.modifier_axe_008_blood_oath = __TS__Class()
local modifier_axe_008_blood_oath = ____exports.modifier_axe_008_blood_oath
modifier_axe_008_blood_oath.name = "modifier_axe_008_blood_oath"
__TS__ClassExtends(modifier_axe_008_blood_oath, BaseHeroModifier)
function modifier_axe_008_blood_oath.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.extraDamageDealt = 0
	self.bloodOathWearableEntities = {}
	self.bloodOathWearableParticles = {}
end
function modifier_axe_008_blood_oath.GetLocalizationCN(self)
	return {
		name = "血誓",
		description = "攻击速度提高；每次攻击消耗当前生命值并附加物理伤害，期间生命最低保留 1 点。",
	}
end
function modifier_axe_008_blood_oath.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_008_blood_oath.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_axe_008_blood_oath.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.extraDamageDealt = 0
	local parent = self:GetParent()
	if parent and IsValid(nil, parent) then
		parent:AddNoDrawToManagedWearables()
		self:ApplyBloodOathWearables(parent)
	end
	self:PlayStartEffect()
end
function modifier_axe_008_blood_oath.prototype.OnAttackLanded_CS(self, event)
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
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local healthCostPct = math.max(0, self:GetSpecialValue("axe_008", "health_cost_current_pct"))
	local healthCost = math.floor(parent:GetHealth() * healthCostPct / 100)
	local spentHealth = parent:CostHeal(
		healthCost,
		{
			ability = ability,
			attacker = parent,
			reserve_min_health = 1,
			source = { custom_tag = "axe_008_attack_health_cost", source_name = "axe_008_blood_oath" },
		}
	)
	if spentHealth <= 0 then
		return
	end
	local damageMultiplierPct = math.max(0, self:GetSpecialValue("axe_008", "bonus_cost_damage_multiplier_pct"))
	local bonusDamage = spentHealth * damageMultiplierPct / 100
	if bonusDamage <= 0 then
		return
	end
	local result = Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = bonusDamage,
		damage_type = 1,
		ability = ability,
		extra_data = { custom_tag = "axe_008_bonus_attack_damage", source_name = "axe_008_blood_oath" },
	})
	self.extraDamageDealt = self.extraDamageDealt + math.max(0, result.final_damage)
end
function modifier_axe_008_blood_oath.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self:RemoveBloodOathWearables()
	if parent and IsValid(nil, parent) then
		parent:RemoveNoDrawFromManagedWearables()
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local maxHealth = parent:GetMaxHealth()
	local baseHeal = maxHealth * self:GetSpecialValue("axe_008", "restore_max_health_pct") / 100
	local damageHeal = self.extraDamageDealt * self:GetSpecialValue("axe_008", "restore_extra_damage_heal_pct") / 100
	local healCap = maxHealth * self:GetSpecialValue("axe_008", "restore_cap_max_health_pct") / 100
	local healAmount = math.min(healCap, baseHeal + damageHeal)
	if healAmount > 0 then
		parent:CustomHeal(healAmount, {
			ability = self:GetAbility(),
			source = "spell",
		})
	end
	parent:EmitSound("Hero_Axe.Culling_Blade_Success")
end
function modifier_axe_008_blood_oath.prototype.GetAttributeBonus(self)
	return {
		attack_speed_pct = self:GetSpecialValue("axe_008", "buff_attack_speed_pct"),
		min_health = 1,
	}
end
function modifier_axe_008_blood_oath.prototype.PlayStartEffect(self)
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_axe_008_blood_oath.prototype.ApplyBloodOathWearables(self, parent)
	self:RemoveBloodOathWearables()
	for ____, model in ipairs(BLOOD_OATH_WEARABLE_MODELS) do
		do
			local wearable =
				SpawnEntityFromTableSynchronous("npc_dota_creature", { model = model, StatusHealth = 99999 })
			if not wearable or not IsValid(nil, wearable) then
				goto __continue35
			end
			wearable:SetOwner(parent)
			wearable:SetParent(parent, "")
			wearable:FollowEntity(parent, true)
			wearable:SetTeam(parent:GetTeamNumber())
			modifier_wearable_unit_state:applys(wearable, parent, nil, { duration = -1, invisibility_level = 0 })
			self:ApplyBloodOathWearableAmbient(model, wearable)
			local ____self_bloodOathWearableEntities_0 = self.bloodOathWearableEntities
			____self_bloodOathWearableEntities_0[#____self_bloodOathWearableEntities_0 + 1] = wearable:entindex()
		end
		::__continue35::
	end
end
function modifier_axe_008_blood_oath.prototype.RemoveBloodOathWearables(self)
	for ____, pfx in ipairs(self.bloodOathWearableParticles) do
		do
			if pfx == nil then
				goto __continue39
			end
			MyGameHeroParticleManager:DestroyParticle(pfx, false)
			MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
		end
		::__continue39::
	end
	self.bloodOathWearableParticles = {}
	for ____, entityIndex in ipairs(self.bloodOathWearableEntities) do
		local entity = EntIndexToHScript(entityIndex)
		if entity and IsValid(nil, entity) then
			entity:RemoveSelf()
		end
	end
	self.bloodOathWearableEntities = {}
end
function modifier_axe_008_blood_oath.prototype.ApplyBloodOathWearableAmbient(self, model, wearable)
	if model == BLOOD_OATH_HEAD_MODEL then
		local pfx = MyGameHeroParticleManager:CreateParticle(
			BLOOD_OATH_HEAD_AMBIENT,
			PATTACH_ABSORIGIN_FOLLOW,
			wearable,
			self:GetCaster()
		)
		MyGameHeroParticleManager:SetParticleControlEnt(
			pfx,
			1,
			wearable,
			PATTACH_POINT_FOLLOW,
			"attach_visor",
			wearable:GetAbsOrigin(),
			true
		)
		local ____self_bloodOathWearableParticles_1 = self.bloodOathWearableParticles
		____self_bloodOathWearableParticles_1[#____self_bloodOathWearableParticles_1 + 1] = pfx
		return
	end
	if model ~= BLOOD_OATH_WEAPON_MODEL then
		return
	end
	local pfx = MyGameHeroParticleManager:CreateParticle(
		BLOOD_OATH_WEAPON_AMBIENT,
		PATTACH_ABSORIGIN_FOLLOW,
		wearable,
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		wearable,
		PATTACH_POINT_FOLLOW,
		"Thumb_plc1_R",
		wearable:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		1,
		wearable,
		PATTACH_POINT_FOLLOW,
		"attach_weapon",
		wearable:GetAbsOrigin(),
		true
	)
	local ____self_bloodOathWearableParticles_2 = self.bloodOathWearableParticles
	____self_bloodOathWearableParticles_2[#____self_bloodOathWearableParticles_2 + 1] = pfx
end
modifier_axe_008_blood_oath = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_008_blood_oath)
____exports.modifier_axe_008_blood_oath = modifier_axe_008_blood_oath
return ____exports