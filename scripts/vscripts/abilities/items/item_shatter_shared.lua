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
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
____exports.modifier_item_shatter_base = __TS__Class()
local modifier_item_shatter_base = ____exports.modifier_item_shatter_base
modifier_item_shatter_base.name = "modifier_item_shatter_base"
__TS__ClassExtends(modifier_item_shatter_base, BaseModifier_CS)
function modifier_item_shatter_base.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_shatter_base.prototype.IsHidden(self)
	return true
end
function modifier_item_shatter_base.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local ability = self:GetAbility()
	local target = event.target
	if not ability or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_ps_chance = ability:GetSpecialValueFor("ability_ps_chance")
	if not RollPercentage(ability_ps_chance) then
		return
	end
	local ability_ps_damage = ability:GetSpecialValueFor("ability_ps_damage")
	local ability_ps_radius = ability:GetSpecialValueFor("ability_ps_radius") or 200
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	if ability_ps_damage <= 0 or ability_ps_radius <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		ability_ps_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue11
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = ability_ps_damage,
				damage_type = 1,
				ability = ability,
			})
			enemy:AddNewModifier(parent, ability, self:GetDebuffModifierName(), { duration = ability_duration })
		end
		::__continue11::
	end
	self:PlayEffects1(target)
end
function modifier_item_shatter_base.prototype.PlayEffects1(self, target)
	local pfx = ParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
	local pfx2 =
		ParticleManager:CreateParticle("particles/windrunner_tailwind_oneshot_arcana.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx2, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx2)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
end
____exports.modifier_item_shatter_debuff_base = __TS__Class()
local modifier_item_shatter_debuff_base = ____exports.modifier_item_shatter_debuff_base
modifier_item_shatter_debuff_base.name = "modifier_item_shatter_debuff_base"
__TS__ClassExtends(modifier_item_shatter_debuff_base, BaseModifier_CS)
function modifier_item_shatter_debuff_base.prototype.IsDebuff(self)
	return true
end
function modifier_item_shatter_debuff_base.prototype.GetEffectName(self)
	return "particles/items4_fx/nullifier_mute_debuff.vpcf"
end
function modifier_item_shatter_debuff_base.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_armor_reduce = ability:GetSpecialValueFor("ability_armor_reduce")
	return { bonus_armor = -math.abs(ability_armor_reduce) }
end
return ____exports