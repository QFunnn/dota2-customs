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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0210 = __TS__Class()
local item_0210 = ____exports.item_0210
item_0210.name = "item_0210"
__TS__ClassExtends(item_0210, BaseItem_CS)
function item_0210.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0210"
end
item_0210 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0210)
____exports.item_0210 = item_0210
local modifier_item_0210 = __TS__Class()
modifier_item_0210.name = "modifier_item_0210"
__TS__ClassExtends(modifier_item_0210, BaseModifier_CS)
function modifier_item_0210.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0210.prototype.IsHidden(self)
	return true
end
function modifier_item_0210.prototype.PlayEffects(self, target)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local effect = MyGameHeroParticleManager:CreateParticle(
		"particles/elder_dust_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(effect, 0, target:GetAbsOrigin())
	ScreenShake(target:GetAbsOrigin(), 5, 5, 0.1, 3000, 0, true)
	MyGameHeroParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
end
function modifier_item_0210.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local ability_bonus_max_health_pct = ability:GetSpecialValueFor("ability_value_bonus_max_health_pct")
	local maxHp = MyGameAttribute:GetAttribute(event.attacker, "total_health") or 0
	local bonus = maxHp * (ability_bonus_max_health_pct / 100)
	if bonus <= 0 then
		return
	end
	self:PlayEffects(event.target)
	local units = FindUnitsInRadius(
		event.attacker:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		240,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	self:PlayEffects(target)
	if #units == 0 then
		return
	end
	__TS__ArrayForEach(units, function(____, unit)
		if not unit or not IsValid(nil, unit) or unit:IsBuilding() then
			return
		end
		unit:EmitSound("Item.Lotus.Heal")
		Damage:ApplyDamage({
			victim = unit,
			attacker = event.attacker,
			damage = bonus,
			damage_type = 1,
			ability = ability,
		})
	end)
	local lv = math.max(0, ability:GetLevel() - 1)
	local cd = ability:GetCooldown(lv)
	ability:StartCooldown(cd)
end
modifier_item_0210 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0210)
return ____exports