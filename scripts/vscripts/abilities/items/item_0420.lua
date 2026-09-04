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
local GetTotalAttackDamage = ____item_0409_shared.GetTotalAttackDamage
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local particleName = "particles/item/item_0420/item_420_faceless_deafening_blast_ti6.vpcf"
local particleName2 = "particles/item/item_0420/item_420_void_spirit_astral_step_impact.vpcf"
local particleName3 = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
____exports.item_0420 = __TS__Class()
local item_0420 = ____exports.item_0420
item_0420.name = "item_0420"
__TS__ClassExtends(item_0420, BaseItem_CS)
function item_0420.prototype.Precache(self, context)
	PrecacheResource("particle", particleName, context)
	PrecacheResource("particle", particleName2, context)
	PrecacheResource("particle", particleName3, context)
end
function item_0420.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function item_0420.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0420_blood_moon_hunt.name
end
function item_0420.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGesture(ACT_DOTA_ATTACK)
	local ability_attack_damage_pct = math.max(0, self:GetSpecialValueFor("ability_attack_damage_pct"))
	local ability_wave_distance = math.max(0, self:GetSpecialValueFor("ability_wave_distance"))
	local ability_wave_width = math.max(0, self:GetSpecialValueFor("ability_wave_width"))
	local ability_projectile_speed = math.max(1, self:GetSpecialValueFor("ability_projectile_speed"))
	local ability_knockback_distance = math.max(0, self:GetSpecialValueFor("ability_knockback_distance"))
	local ability_knockback_duration = math.max(0, self:GetSpecialValueFor("ability_knockback_duration"))
	local ability_damage = GetTotalAttackDamage(nil, caster) * (ability_attack_damage_pct / 100)
	if ability_damage <= 0 or ability_wave_distance <= 0 or ability_wave_width <= 0 then
		return
	end
	local direction = self:GetWaveDirection(caster, self:GetCursorPosition())
	self:PlayEffects1(
		caster,
		direction,
		ability_wave_distance,
		ability_wave_width,
		ability_projectile_speed,
		ability_damage,
		ability_knockback_distance,
		ability_knockback_duration
	)
end
function item_0420.prototype.GetWaveDirection(self, caster, cursorPosition)
	local origin = caster:GetAbsOrigin()
	local direction = Vector(cursorPosition.x - origin.x, cursorPosition.y - origin.y, 0)
	if direction:Length2D() <= 1 then
		return caster:GetForwardVector()
	end
	return direction:Normalized()
end
function item_0420.prototype.PlayEffects1(
	self,
	caster,
	direction,
	ability_wave_distance,
	ability_wave_width,
	ability_projectile_speed,
	ability_damage,
	ability_knockback_distance,
	ability_knockback_duration
)
	local hitTargets = {}
	local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 120)):__add(direction:__mul(100))
	EmitSoundOn("Hero_Invoker.DeafeningBlast", caster)
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = particleName,
		projectile_type = "linear",
		start_point = startPoint,
		direction = direction,
		projectile_speed = ability_projectile_speed,
		projectile_distance = ability_wave_distance,
		projectile_range = ability_wave_width,
		projectile_end_range = ability_wave_width,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not IsServer() then
				return false
			end
			if not IsValidEnemyUnit(nil, caster, hitTarget) then
				return false
			end
			local targetIndex = hitTarget:entindex()
			if hitTargets[targetIndex] then
				return false
			end
			hitTargets[targetIndex] = true
			self:ApplyBloodMoonDamage(
				caster,
				hitTarget,
				direction,
				ability_damage,
				ability_knockback_distance,
				ability_knockback_duration
			)
			return false
		end,
	})
end
function item_0420.prototype.ApplyBloodMoonDamage(
	self,
	caster,
	target,
	direction,
	ability_damage,
	ability_knockback_distance,
	ability_knockback_duration
)
	local damageResult = Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = ability_damage,
		damage_type = 1,
		ability = self,
		extra_data = {
			custom_tag = "item_0420_blood_moon_wave",
			source_name = self:GetAbilityName(),
		},
	})
	local ability_source_final_damage = math.max(0, damageResult.final_damage or 0)
	if ability_source_final_damage > 0 then
		AddDeBuffStatus(
			nil,
			target,
			caster,
			self,
			DebuffStatusType.BLEED,
			{ source_final_damage = ability_source_final_damage, effect_name = particleName3 }
		)
	end
	if ability_knockback_distance > 0 and ability_knockback_duration > 0 then
		target:KnockBack(
			caster,
			self,
			{ distance = ability_knockback_distance, duration = ability_knockback_duration, direction = direction }
		)
	end
	local ability_bloodmoon_duration = math.max(0, self:GetSpecialValueFor("ability_bloodmoon_duration"))
	if ability_bloodmoon_duration > 0 then
		target:AddNewModifier(
			caster,
			self,
			____exports.modifier_item_0420_blood_moon.name,
			{ duration = ability_bloodmoon_duration }
		)
	end
	self:PlayEffects2(caster, target)
end
function item_0420.prototype.PlayEffects2(self, caster, target)
	local particle_hit =
		MyGameHeroParticleManager:CreateParticle(particleName2, PATTACH_ABSORIGIN_FOLLOW, target, caster)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle_hit,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle_hit)
	EmitSoundOn("Hero_Invoker.DeafeningBlast.Target", target)
end
item_0420 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0420)
____exports.item_0420 = item_0420
--- 【血月】印记（敌方可见 debuff·纯标记）：期间佩戴者的攻击会为目标施加易伤。
____exports.modifier_item_0420_blood_moon = __TS__Class()
local modifier_item_0420_blood_moon = ____exports.modifier_item_0420_blood_moon
modifier_item_0420_blood_moon.name = "modifier_item_0420_blood_moon"
__TS__ClassExtends(modifier_item_0420_blood_moon, BaseModifier_CS)
function modifier_item_0420_blood_moon.GetLocalizationCN(self)
	return { name = "血月", description = "身负血月印记：印记持有者的攻击会施加易伤。" }
end
function modifier_item_0420_blood_moon.prototype.IsHidden(self)
	return false
end
function modifier_item_0420_blood_moon.prototype.IsDebuff(self)
	return true
end
function modifier_item_0420_blood_moon.prototype.IsPurgable(self)
	return true
end
function modifier_item_0420_blood_moon.prototype.GetTexture(self)
	return "item_icon_new_14"
end
modifier_item_0420_blood_moon = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0420_blood_moon)
____exports.modifier_item_0420_blood_moon = modifier_item_0420_blood_moon
--- 固有被动「血月狩猎」：佩戴者攻击命中身负【血月】的目标时，为其施加 1 层易伤（团队共享封顶，照 item_0620）。
____exports.modifier_item_0420_blood_moon_hunt = __TS__Class()
local modifier_item_0420_blood_moon_hunt = ____exports.modifier_item_0420_blood_moon_hunt
modifier_item_0420_blood_moon_hunt.name = "modifier_item_0420_blood_moon_hunt"
__TS__ClassExtends(modifier_item_0420_blood_moon_hunt, BaseModifier_CS)
function modifier_item_0420_blood_moon_hunt.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0420_blood_moon_hunt.prototype.IsHidden(self)
	return true
end
function modifier_item_0420_blood_moon_hunt.prototype.IsPurgable(self)
	return false
end
function modifier_item_0420_blood_moon_hunt.prototype.GetMutexKey(self)
	return "xue_yue_mutex"
end
function modifier_item_0420_blood_moon_hunt.prototype.GetMutexPriority(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0420" and 200 or 100
end
function modifier_item_0420_blood_moon_hunt.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, target) then
		return
	end
	if not target:HasModifier(____exports.modifier_item_0420_blood_moon.name) then
		return
	end
	local ability_vulnerable_duration = math.max(0, ability:GetSpecialValueFor("ability_vulnerable_duration"))
	if ability_vulnerable_duration <= 0 then
		return
	end
	local rolled = ability:GetSpecialValueFor("ability_value_vulnerable_chance_pct")
	local ____math_min_4 = math.min
	local ____math_max_3 = math.max
	local ____temp_2
	if rolled > 0 then
		____temp_2 = rolled
	else
		____temp_2 = ability:GetSpecialValueFor("ability_vulnerable_chance_pct")
	end
	local chance = ____math_min_4(100, ____math_max_3(0, ____temp_2))
	if chance <= 0 or not RollPercentage(chance) then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.VULNERABLE,
		{ stack = 1, duration = ability_vulnerable_duration }
	)
end
modifier_item_0420_blood_moon_hunt = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0420_blood_moon_hunt)
____exports.modifier_item_0420_blood_moon_hunt = modifier_item_0420_blood_moon_hunt
return ____exports