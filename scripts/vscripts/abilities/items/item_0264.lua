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
--- 追踪弹特效（卓尔游侠 TI9 弓特效）
local ability_item_0264_projectile_effect = "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_marksman.vpcf"
____exports.item_0264 = __TS__Class()
local item_0264 = ____exports.item_0264
item_0264.name = "item_0264"
__TS__ClassExtends(item_0264, BaseItem_CS)
function item_0264.prototype.Precache(self, context)
	PrecacheResource("particle", ability_item_0264_projectile_effect, context)
end
function item_0264.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET }
end
function item_0264.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	local ability_attack_damage_reduce_pct = self:GetSpecialValueFor("ability_attack_damage_reduce_pct")
	local ability_movespeed_slow_pct = self:GetSpecialValueFor("ability_movespeed_slow_pct")
	local ability_projectile_speed_raw = self:GetSpecialValueFor("ability_projectile_speed")
	local ____temp_0
	if ability_projectile_speed_raw > 0 then
		____temp_0 = ability_projectile_speed_raw
	else
		____temp_0 = 1300
	end
	local ability_projectile_speed = ____temp_0
	local launchOrigin = self:GetProjectileLaunchOrigin(caster)
	caster:EmitSound("item_crippling_crossbow.cast")
	CreateProjectile(nil, {
		projectile_type = "tracking",
		caster = caster,
		target = target,
		effect_name = ability_item_0264_projectile_effect,
		projectile_speed = ability_projectile_speed,
		ability = self,
		start_point = launchOrigin,
		on_hit = function(____, hitTarget, _location, _extra)
			if not IsServer() then
				return true
			end
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, hitTarget) or hitTarget:IsBuilding() then
				return true
			end
			if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
				return true
			end
			self:PlayEffects1(hitTarget)
			hitTarget:AddNewModifier(
				caster,
				self,
				____exports.modifier_item_0264_debuff.name,
				{
					duration = ability_duration,
					ability_attack_damage_reduce_pct = ability_attack_damage_reduce_pct,
					ability_movespeed_slow_pct = ability_movespeed_slow_pct,
				}
			)
			return true
		end,
	})
end
function item_0264.prototype.GetProjectileLaunchOrigin(self, caster)
	local attach = caster:ScriptLookupAttachment("attach_attack1")
	if attach > 0 then
		return caster:GetAttachmentOrigin(attach)
	end
	return caster:GetAbsOrigin()
end
function item_0264.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.DiffusalBlade.Activate")
end
item_0264 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0264)
____exports.item_0264 = item_0264
____exports.modifier_item_0264_debuff = __TS__Class()
local modifier_item_0264_debuff = ____exports.modifier_item_0264_debuff
modifier_item_0264_debuff.name = "modifier_item_0264_debuff"
__TS__ClassExtends(modifier_item_0264_debuff, BaseModifier_CS)
function modifier_item_0264_debuff.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_bonus_attack_damage = 0
	self.ability_bonus_movespeed_pct = 0
end
function modifier_item_0264_debuff.prototype.IsHidden(self)
	return false
end
function modifier_item_0264_debuff.prototype.IsDebuff(self)
	return true
end
function modifier_item_0264_debuff.prototype.IsPurgable(self)
	return true
end
function modifier_item_0264_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local attackDamageReducePct = math.max(0, tonumber(params.ability_attack_damage_reduce_pct or 0))
	local slowPct = math.max(0, tonumber(params.ability_movespeed_slow_pct or 0))
	local currentAttackDamage = MyGameAttribute:GetAttribute(parent, "total_attack_damage")
	self.ability_bonus_attack_damage = -currentAttackDamage * (attackDamageReducePct / 100)
	self.ability_bonus_movespeed_pct = -slowPct
	self:RefreshAttributes()
	self:PlayEffects2(parent)
end
function modifier_item_0264_debuff.prototype.GetAttributeBonus(self)
	return {
		bonus_attack_damage = self.ability_bonus_attack_damage,
		bonus_movespeed_pct = self.ability_bonus_movespeed_pct,
	}
end
function modifier_item_0264_debuff.prototype.PlayEffects2(self, target)
	local pfx =
		ParticleManager:CreateParticle("particles/items_fx/diffusal_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(pfx, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetAbsOrigin(), true)
	self:AddParticle(pfx, false, false, -1, false, false)
end
modifier_item_0264_debuff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0264_debuff)
____exports.modifier_item_0264_debuff = modifier_item_0264_debuff
return ____exports