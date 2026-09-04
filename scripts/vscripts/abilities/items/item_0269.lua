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
____exports.item_0269 = __TS__Class()
local item_0269 = ____exports.item_0269
item_0269.name = "item_0269"
__TS__ClassExtends(item_0269, BaseItem_CS)
function item_0269.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:RemoveModifierByName(____exports.modifier_item_0269_empowered_attack.name)
	caster:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0269_empowered_attack.name,
		{ duration = self:GetSpecialValue("item_0269", "ability_duration") }
	)
	self:PlayEffects1(caster)
end
function item_0269.prototype.PlayEffects1(self, caster)
	caster:EmitSound("Hero_Tusk.WalrusPunch.Cast")
	Timers:CreateTimer(2, function()
		local ____ = IsValid(nil, caster) and caster:StopSound("Hero_Tusk.WalrusPunch.Cast")
	end)
end
function item_0269.prototype.PlayEffects2(self, target, ability_radius)
	target:EmitSound("Hero_Techies.RemoteMine.Detonate")
	local particle_cast = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_remote_cart_explode.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControl(particle_cast, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle_cast, 1, Vector(ability_radius, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle_cast)
end
item_0269 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0269)
____exports.item_0269 = item_0269
____exports.modifier_item_0269_empowered_attack = __TS__Class()
local modifier_item_0269_empowered_attack = ____exports.modifier_item_0269_empowered_attack
modifier_item_0269_empowered_attack.name = "modifier_item_0269_empowered_attack"
__TS__ClassExtends(modifier_item_0269_empowered_attack, BaseModifier_CS)
function modifier_item_0269_empowered_attack.GetLocalizationCN(self)
	return { name = "延时爆燃", description = "下一次攻击附加额外魔法伤害与击退。" }
end
function modifier_item_0269_empowered_attack.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0269_empowered_attack.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_radius = 150
	local ability_bonus_damage = ability:GetSpecialValue("item_0269", "ability_bonus_damage")
	local ability_knockback_duration = 0.25
	local ability_knockback_distance = ability:GetSpecialValue("item_0269", "ability_knockback_distance")
	local origin = target:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue15
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = ability_bonus_damage,
				damage_type = 2,
				ability = ability,
			})
			local direction = enemy:GetAbsOrigin() - origin
			if direction:Length2D() < 1 then
				direction = enemy:GetAbsOrigin() - parent:GetAbsOrigin()
			end
			enemy:KnockBack(parent, ability, {
				duration = ability_knockback_duration,
				distance = ability_knockback_distance,
				direction = direction:Normalized(),
				height = 50,
				stun = false,
				block = true,
			})
		end
		::__continue15::
	end
	ability:PlayEffects2(target, ability_radius)
	self:Destroy()
end
function modifier_item_0269_empowered_attack.prototype.IsPurgable(self)
	return false
end
modifier_item_0269_empowered_attack =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0269_empowered_attack)
____exports.modifier_item_0269_empowered_attack = modifier_item_0269_empowered_attack
return ____exports