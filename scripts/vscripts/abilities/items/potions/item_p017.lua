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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ITEM_P017_REVIVE_EFFECT = "particles/item/item_p107owner.vpcf"
--- 复苏药剂：120 秒内若受到致死伤害，则免疫该伤害并恢复 50% 最大生命值，触发后移除。
-- 实现方式：监听死亡拦截事件，触发后额外给予短暂无敌用于兜底。
____exports.item_P017 = __TS__Class()
local item_P017 = ____exports.item_P017
item_P017.name = "item_P017"
__TS__ClassExtends(item_P017, BaseItem_CS)
function item_P017.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_P017_REVIVE_EFFECT, context)
end
function item_P017.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			if caster:HasModifier(____exports.item_P017_modifier.name) then
				return UF_FAIL_CUSTOM
			end
			return UF_SUCCESS
		end,
		castError = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return "#dota_hud_error_invalid_target"
			end
			if caster:HasModifier(____exports.item_P017_modifier.name) then
				return "已存在复苏效果"
			end
			return ""
		end,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:AddNewModifier(
				caster,
				self,
				____exports.item_P017_modifier.name,
				{ duration = self:GetSpecialValueFor("duration") }
			)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
item_P017 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P017)
____exports.item_P017 = item_P017
____exports.item_P017_modifier = __TS__Class()
local item_P017_modifier = ____exports.item_P017_modifier
item_P017_modifier.name = "item_P017_modifier"
__TS__ClassExtends(item_P017_modifier, BaseModifier_CS)
function item_P017_modifier.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.triggered = false
	self.reviveHealthPct = 50
end
function item_P017_modifier.GetLocalizationCN(self)
	return {
		name = "复苏",
		description = "120 秒内如果受到致死伤害，免疫该伤害并恢复 50% 最大生命值，触发后移除。",
	}
end
function item_P017_modifier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.triggered = false
	local ability = self:GetAbility()
	if ability then
		self.reviveHealthPct = math.max(0, ability:GetSpecialValueFor("revive_health_pct"))
	end
	local pfx = ParticleManager:CreateParticle(ITEM_P017_REVIVE_EFFECT, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(pfx, false, false, -1, false, false)
end
function item_P017_modifier.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = DeathRevivePriority.STATUS } }
end
function item_P017_modifier.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() then
		return
	end
	if event.prevented then
		return
	end
	if self.triggered then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.victim ~= parent then
		return
	end
	self.triggered = true
	local maxHp = parent:GetMaxHealth()
	local targetHp = math.max(1, math.floor(maxHp * (self.reviveHealthPct / 100)))
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "revive"
	event.set_health = targetHp
	parent:AddNewModifier(parent, self:GetAbility(), ____exports.item_P017_invulnerable.name, { duration = 2 })
	parent:EmitSound("Hero_Omniknight.GuardianAngel.Cast")
	self:Destroy()
end
function item_P017_modifier.prototype.IsHidden(self)
	return false
end
function item_P017_modifier.prototype.IsPurgable(self)
	return false
end
function item_P017_modifier.prototype.GetTexture(self)
	return "item_icon_m3_30"
end
item_P017_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_P017_modifier)
____exports.item_P017_modifier = item_P017_modifier
____exports.item_P017_invulnerable = __TS__Class()
local item_P017_invulnerable = ____exports.item_P017_invulnerable
item_P017_invulnerable.name = "item_P017_invulnerable"
__TS__ClassExtends(item_P017_invulnerable, BaseModifier_CS)
function item_P017_invulnerable.GetLocalizationCN(self)
	return { name = "复苏守护", description = "短时间内获得完全伤害减免。" }
end
function item_P017_invulnerable.prototype.IsHidden(self)
	return false
end
function item_P017_invulnerable.prototype.IsPurgable(self)
	return false
end
function item_P017_invulnerable.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local pfx = ParticleManager:CreateParticle(ITEM_P017_REVIVE_EFFECT, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(pfx, false, false, -1, false, false)
	local pfx2 = ParticleManager:CreateParticle(
		"particles/items4_fx/combo_breaker_buff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(pfx2, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		pfx2,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(pfx2, false, false, -1, false, false)
	self:GetParent():EmitSound("DOTA_Item.ComboBreaker")
end
function item_P017_invulnerable.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = 100 }
end
function item_P017_invulnerable.prototype.GetTexture(self)
	return "item_icon_m5_25"
end
item_P017_invulnerable = __TS__DecorateLegacy({ registerModifier(nil) }, item_P017_invulnerable)
____exports.item_P017_invulnerable = item_P017_invulnerable
return ____exports