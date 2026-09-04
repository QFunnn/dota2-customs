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
--- 刷盾间隔词条缺失时的兜底基数（与 ability_value_c_interval 基数一致）。
local ITEM_0291_FALLBACK_INTERVAL = 10
--- 影墟棱晶
-- 被动：每隔一段时间生成折光护盾，抵消一次超过当前生命阈值的伤害。
____exports.item_0291 = __TS__Class()
local item_0291 = ____exports.item_0291
item_0291.name = "item_0291"
__TS__ClassExtends(item_0291, BaseItem_CS)
function item_0291.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0291_refraction_guard.name
end
item_0291 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0291)
____exports.item_0291 = item_0291
____exports.modifier_item_0291_refraction_guard = __TS__Class()
local modifier_item_0291_refraction_guard = ____exports.modifier_item_0291_refraction_guard
modifier_item_0291_refraction_guard.name = "modifier_item_0291_refraction_guard"
__TS__ClassExtends(modifier_item_0291_refraction_guard, BaseModifier_CS)
function modifier_item_0291_refraction_guard.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.nextChargeTime = 0
end
function modifier_item_0291_refraction_guard.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0291_refraction_guard.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.nextChargeTime = GameRules:GetGameTime()
	self:SetShieldCharges(0)
	self:StartIntervalThink(0.1)
end
function modifier_item_0291_refraction_guard.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local ability = self:GetItemAbility()
	if not ability then
		self:Destroy()
		return
	end
	if self:HasShield() then
		return
	end
	if GameRules:GetGameTime() < self.nextChargeTime then
		return
	end
	self:GrantShield(ability)
end
function modifier_item_0291_refraction_guard.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetItemAbility()
	if not ability or event.ctx.spec.victim ~= parent or not self:HasShield() then
		return
	end
	local damage = self:GetCurrentPipeDamage(event.final)
	local ability_trigger_health_pct = 8
	if damage < parent:GetHealth() * ability_trigger_health_pct / 100 then
		return
	end
	event.prevent_apply = true
	self:ConsumeShield(ability)
	self:PlayEffects4_Block(parent, damage)
end
function modifier_item_0291_refraction_guard.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyShieldParticle()
end
function modifier_item_0291_refraction_guard.prototype.IsHidden(self)
	return false
end
function modifier_item_0291_refraction_guard.prototype.IsPurgable(self)
	return false
end
function modifier_item_0291_refraction_guard.prototype.IsDebuff(self)
	return false
end
function modifier_item_0291_refraction_guard.prototype.GetItemAbility(self)
	return self:GetAbility()
end
function modifier_item_0291_refraction_guard.prototype.HasShield(self)
	return self:GetStackCount() > 0
end
function modifier_item_0291_refraction_guard.prototype.SetShieldCharges(self, charges)
	self:SetStackCount(math.max(0, math.floor(charges)))
end
function modifier_item_0291_refraction_guard.prototype.GrantShield(self, ability)
	local parent = self:GetParent()
	local ability_block_count = math.max(1, math.floor(ability:GetSpecialValue("item_0291", "ability_block_count")))
	self:SetShieldCharges(ability_block_count)
	self:PlayEffects2_GainShield(parent)
	self:CreateOrRefreshShieldParticle(parent)
end
function modifier_item_0291_refraction_guard.prototype.ConsumeShield(self, ability)
	local parent = self:GetParent()
	self:SetShieldCharges(0)
	self:PlayEffects3_ShieldBreak(parent)
	self:DestroyShieldParticle()
	self:StartRechargeCooldown(ability)
end
function modifier_item_0291_refraction_guard.prototype.StartRechargeCooldown(self, ability)
	local parent = self:GetParent()
	local rolledInterval = ability:GetSpecialValueFor("ability_value_c_interval")
	local ____temp_0
	if rolledInterval > 0 then
		____temp_0 = rolledInterval
	else
		____temp_0 = ITEM_0291_FALLBACK_INTERVAL
	end
	local baseInterval = ____temp_0
	local reduction = 0
	if MyGameAttribute and MyGameAttribute:HasAttributes(parent) then
		reduction = MyGameAttribute:GetAttribute(parent, "cooldown_reduction_pct") or 0
	end
	local interval = math.max(0.5, baseInterval * math.max(0, 1 - reduction / 100))
	self.nextChargeTime = GameRules:GetGameTime() + interval
	ability:StartCooldown(interval)
end
function modifier_item_0291_refraction_guard.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
function modifier_item_0291_refraction_guard.prototype.CreateOrRefreshShieldParticle(self, parent)
	self:DestroyShieldParticle()
	self:PlayEffects1_Shield(parent)
end
function modifier_item_0291_refraction_guard.prototype.DestroyShieldParticle(self)
	if self.shieldParticle == nil then
		return
	end
	MyGameHeroParticleManager:DestroyParticle(self.shieldParticle, false)
	MyGameHeroParticleManager:ReleaseParticleIndex(self.shieldParticle)
	self.shieldParticle = nil
end
function modifier_item_0291_refraction_guard.prototype.PlayEffects1_Shield(self, parent)
	self.shieldParticle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		self.shieldParticle,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
end
function modifier_item_0291_refraction_guard.prototype.PlayEffects2_GainShield(self, parent)
	parent:EmitSound("Hero_TemplarAssassin.Refraction")
end
function modifier_item_0291_refraction_guard.prototype.PlayEffects3_ShieldBreak(self, parent)
	parent:EmitSound("Hero_TemplarAssassin.Refraction.Absorb")
end
function modifier_item_0291_refraction_guard.prototype.PlayEffects4_Block(self, parent, blockedDamage)
	Popups:damageBlock(parent, math.max(1, math.floor(blockedDamage)))
end
modifier_item_0291_refraction_guard =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0291_refraction_guard)
____exports.modifier_item_0291_refraction_guard = modifier_item_0291_refraction_guard
return ____exports