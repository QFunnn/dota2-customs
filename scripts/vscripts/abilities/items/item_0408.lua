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
local EXPLODE_PARTICLE = "particles/lina/huskar_inner_fire2.vpcf"
local CUSTOM_TAG = "item_0408_ash_codex"
____exports.item_0408 = __TS__Class()
local item_0408 = ____exports.item_0408
item_0408.name = "item_0408"
__TS__ClassExtends(item_0408, BaseItem_CS)
function item_0408.prototype.Precache(self, context)
	PrecacheResource("particle", EXPLODE_PARTICLE, context)
end
function item_0408.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0408_ash_codex.name
end
item_0408 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0408)
____exports.item_0408 = item_0408
____exports.modifier_item_0408_ash_codex = __TS__Class()
local modifier_item_0408_ash_codex = ____exports.modifier_item_0408_ash_codex
modifier_item_0408_ash_codex.name = "modifier_item_0408_ash_codex"
__TS__ClassExtends(modifier_item_0408_ash_codex, BaseModifier_CS)
function modifier_item_0408_ash_codex.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0408_ash_codex.prototype.IsHidden(self)
	return true
end
function modifier_item_0408_ash_codex.prototype.IsPurgable(self)
	return false
end
function modifier_item_0408_ash_codex.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if not self:IsValidTriggerDamage(event) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.victim
	if not self:IsValidEnemy(parent, target) then
		return
	end
	if not target:HasModifier("modifier_generic_burning") then
		return
	end
	self:StartAbilityCooldown(ability)
	self:Detonate(parent, ability, target:GetAbsOrigin())
end
function modifier_item_0408_ash_codex.prototype.IsValidTriggerDamage(self, event)
	if (event.final_damage or 0) <= 0 then
		return false
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return false
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.DOT) then
		return false
	end
	local ____opt_3 = event.source
	if (____opt_3 and ____opt_3.custom_tag) == CUSTOM_TAG then
		return false
	end
	return true
end
function modifier_item_0408_ash_codex.prototype.Detonate(self, parent, ability, centerPos)
	local radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local manaPct = math.max(0, ability:GetSpecialValueFor("ability_value_explode_mana_pct"))
	if radius <= 0 then
		return
	end
	local damage = self:GetMaxMana(parent) * (manaPct / 100)
	if damage <= 0 then
		return
	end
	self:PlayEffectsAt(parent, centerPos, radius)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		centerPos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not self:IsValidEnemy(parent, enemy) then
				goto __continue23
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					damage_tags = DamageTag.NO_PROC,
					custom_tag = CUSTOM_TAG,
					source_name = self:GetName(),
				},
			})
		end
		::__continue23::
	end
end
function modifier_item_0408_ash_codex.prototype.GetMaxMana(self, parent)
	return math.max(0, MyGameAttribute:GetAttribute(parent, "total_mana") or 0)
end
function modifier_item_0408_ash_codex.prototype.IsValidEnemy(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_item_0408_ash_codex.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	local ____ability_6 = ability
	local ____ability_StartCooldown_7 = ability.StartCooldown
	local ____temp_5
	if cooldown > 0 then
		____temp_5 = cooldown
	else
		____temp_5 = 0.5
	end
	____ability_StartCooldown_7(____ability_6, ____temp_5)
end
function modifier_item_0408_ash_codex.prototype.PlayEffectsAt(self, parent, pos, radius)
	local particle = MyGameHeroParticleManager:CreateParticle(EXPLODE_PARTICLE, PATTACH_CUSTOMORIGIN, parent, parent)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, pos)
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOnLocationWithCaster(pos, "Hero_Huskar.Burning_Spear.Cast", parent)
end
modifier_item_0408_ash_codex = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0408_ash_codex)
____exports.modifier_item_0408_ash_codex = modifier_item_0408_ash_codex
return ____exports