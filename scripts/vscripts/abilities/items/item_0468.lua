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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local FindEnemies = ____item_0409_shared.FindEnemies
local GetStrength = ____item_0409_shared.GetStrength
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_0468 = __TS__Class()
local item_0468 = ____exports.item_0468
item_0468.name = "item_0468"
__TS__ClassExtends(item_0468, BaseItem_CS)
function item_0468.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)
end
function item_0468.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE }
end
function item_0468.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local duration = math.max(0, self:GetSpecialValueFor("ability_storm_duration"))
	if duration <= 0 then
		return
	end
	____exports.modifier_item_0468_thunderstorm:applys(caster, caster, self, { duration = duration })
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", caster)
end
item_0468 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0468)
____exports.item_0468 = item_0468
--- 雷暴 buff：主动释放进入，持续期间自身减伤；期间【每次】普攻引发一次 AOE（300% 力量物理），不限次数。
-- 持续时间到（duration 过期）自然结束。
____exports.modifier_item_0468_thunderstorm = __TS__Class()
local modifier_item_0468_thunderstorm = ____exports.modifier_item_0468_thunderstorm
modifier_item_0468_thunderstorm.name = "modifier_item_0468_thunderstorm"
__TS__ClassExtends(modifier_item_0468_thunderstorm, BaseModifier_CS)
function modifier_item_0468_thunderstorm.GetLocalizationCN(self)
	return { name = "雷暴", description = "普攻引发范围雷击，自身受到的伤害降低。" }
end
function modifier_item_0468_thunderstorm.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0468_thunderstorm.prototype.IsHidden(self)
	return false
end
function modifier_item_0468_thunderstorm.prototype.IsPurgable(self)
	return false
end
function modifier_item_0468_thunderstorm.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_value_damage_reduction_pct"))
	else
		____ability_0 = 0
	end
	local reduction = ____ability_0
	return { damage_reduction_pct = reduction }
end
function modifier_item_0468_thunderstorm.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_strength_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_strength_damage_pct"))
	local damage = GetStrength(nil, parent) * (ability_strength_damage_pct / 100)
	if ability_radius <= 0 or damage <= 0 then
		return
	end
	local enemies = FindEnemies(nil, parent, event.target:GetAbsOrigin(), ability_radius)
	self:PlayEffects1(parent, event.target)
	TriggerDarkDomainLightningFlash(nil, parent, event.target)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidEnemyUnit(nil, parent, enemy) then
				goto __continue18
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = damage,
				damage_type = 1,
				ability = ability,
				extra_data = {
					custom_tag = "item_0468_thunderstorm",
					source_name = ability:GetAbilityName(),
				},
			})
		end
		::__continue18::
	end
end
function modifier_item_0468_thunderstorm.prototype.PlayEffects1(self, parent, center)
	local lightning = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/chain_lightning.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		lightning,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		lightning,
		1,
		center,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		center:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(lightning)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", center)
end
function modifier_item_0468_thunderstorm.prototype.GetEffectName(self)
	return "particles/disruptor_2022_immortal_static_storm_hero_debuff_3.vpcf"
end
modifier_item_0468_thunderstorm = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0468_thunderstorm)
____exports.modifier_item_0468_thunderstorm = modifier_item_0468_thunderstorm
return ____exports