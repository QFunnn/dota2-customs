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
local item_0153_FIREBALL_PARTICLE = "particles/items_fx/phylactery.vpcf"
local item_0153_FIREBALL_HIT_SOUND = "Item.Phylactery.Target"
local item_0153_DEFAULT_FIREBALL_COUNT = 2
local item_0153_DEFAULT_SEARCH_RADIUS = 1000
local item_0153_DEFAULT_PROJECTILE_SPEED = 1200
local item_0153_DEFAULT_INT_DAMAGE_PCT = 100
____exports.item_0153 = __TS__Class()
local item_0153 = ____exports.item_0153
item_0153.name = "item_0153"
__TS__ClassExtends(item_0153, BaseItem_CS)
function item_0153.prototype.Precache(self, context)
	PrecacheResource("particle", item_0153_FIREBALL_PARTICLE, context)
end
function item_0153.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0153.name
end
item_0153 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0153)
____exports.item_0153 = item_0153
____exports.modifier_item_0153 = __TS__Class()
local modifier_item_0153 = ____exports.modifier_item_0153
modifier_item_0153.name = "modifier_item_0153"
__TS__ClassExtends(modifier_item_0153, BaseModifier_CS)
function modifier_item_0153.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0153.prototype.IsHidden(self)
	return true
end
function modifier_item_0153.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local itemAbility = self:GetAbility()
	if not itemAbility then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	local damage = self:GetFireballDamage(parent, itemAbility)
	if damage <= 0 then
		return
	end
	local targets = self:SelectTargets(parent, itemAbility)
	Timers:CreateTimer(0.15, function()
		for ____, target in ipairs(targets) do
			do
				if not IsValidAlive(nil, target) then
					goto __continue16
				end
				self:LaunchFireball(parent, itemAbility, target, damage)
			end
			::__continue16::
		end
	end)
end
function modifier_item_0153.prototype.GetFireballDamage(self, parent, itemAbility)
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local intDamagePct =
		math.max(0, itemAbility:GetSpecialValueFor("ability_int_damage_pct") or item_0153_DEFAULT_INT_DAMAGE_PCT)
	return intelligence * intDamagePct / 100
end
function modifier_item_0153.prototype.SelectTargets(self, parent, itemAbility)
	local searchRadius =
		math.max(0, itemAbility:GetSpecialValueFor("ability_search_radius") or item_0153_DEFAULT_SEARCH_RADIUS)
	local maxFireballs = math.max(
		0,
		math.floor(itemAbility:GetSpecialValueFor("ability_fireball_count") or item_0153_DEFAULT_FIREBALL_COUNT)
	)
	if searchRadius <= 0 or maxFireballs <= 0 then
		return {}
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		searchRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local pool = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue22
			end
			pool[#pool + 1] = enemy
		end
		::__continue22::
	end
	local targets = {}
	while #pool > 0 and #targets < maxFireballs do
		local pickIndex = RandomInt(0, #pool - 1)
		local pick = pool[pickIndex + 1]
		if pick and IsValidAlive(nil, pick) then
			targets[#targets + 1] = pick
		end
		local lastIndex = #pool - 1
		pool[pickIndex + 1] = pool[lastIndex + 1]
		table.remove(pool)
	end
	return targets
end
function modifier_item_0153.prototype.LaunchFireball(self, caster, itemAbility, target, damage)
	local projectileSpeed =
		math.max(1, itemAbility:GetSpecialValueFor("ability_projectile_speed") or item_0153_DEFAULT_PROJECTILE_SPEED)
	caster:EmitSound(item_0153_FIREBALL_HIT_SOUND)
	local distance = caster:GetDistance(target)
	local speed = distance / 0.3
	CreateProjectile(nil, {
		caster = caster,
		ability = itemAbility,
		effect_name = item_0153_FIREBALL_PARTICLE,
		target = target,
		start_point = self:GetProjectileLaunchOrigin(caster),
		projectile_type = "tracking",
		projectile_speed = speed,
		on_hit = function(____, hitTarget)
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, hitTarget) or hitTarget:IsBuilding() then
				return true
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = damage,
				damage_type = 2,
				ability = itemAbility,
			})
			EmitSoundOn(item_0153_FIREBALL_HIT_SOUND, hitTarget)
			return true
		end,
	})
end
function modifier_item_0153.prototype.GetProjectileLaunchOrigin(self, caster)
	local attach = caster:ScriptLookupAttachment("attach_hitloc")
	if attach > 0 then
		return caster:GetAttachmentOrigin(attach)
	end
	return caster:GetAbsOrigin()
end
modifier_item_0153 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0153)
____exports.modifier_item_0153 = modifier_item_0153
return ____exports