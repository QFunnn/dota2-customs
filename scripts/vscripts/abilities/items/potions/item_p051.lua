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
local ____item_potion_base = require("abilities.items.potions.item_potion_base")
local BasePotionModifier_CS = ____item_potion_base.BasePotionModifier_CS
local function RemovePoisonModifiers(self, caster)
	if not caster.FindAllModifiers then
		return
	end
	local modifiers = caster:FindAllModifiers()
	for ____, modifier in ipairs(modifiers) do
		do
			if modifier:GetName() ~= "modifier_generic_poison" then
				goto __continue4
			end
			modifier:Destroy()
		end
		::__continue4::
	end
end
--- 大自然秘药：移除自身中毒，并在一段时间内免疫新的中毒施加。
____exports.item_P051 = __TS__Class()
local item_P051 = ____exports.item_P051
item_P051.name = "item_P051"
__TS__ClassExtends(item_P051, BaseItem_CS)
function item_P051.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local ability_duration = self:GetSpecialValueFor("ability_duration")
			local potion_base_health_pct = self:GetSpecialValueFor("potion_base_health_pct")
			RemovePoisonModifiers(nil, caster)
			self:ApplyPotionModifier(
				____exports.modifier_item_P051_nature_gift.name,
				ability_duration,
				{ potion_base_health_pct = potion_base_health_pct }
			)
			self:PlayEffects1(caster)
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_P051.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.GlimmerCape.Activate")
	local particle_cast = ParticleManager:CreateParticle(
		"particles/items3_fx/glimmer_cape_initial_flash.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		particle_cast,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle_cast)
end
item_P051 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P051)
____exports.item_P051 = item_P051
____exports.modifier_item_P051_nature_gift = __TS__Class()
local modifier_item_P051_nature_gift = ____exports.modifier_item_P051_nature_gift
modifier_item_P051_nature_gift.name = "modifier_item_P051_nature_gift"
__TS__ClassExtends(modifier_item_P051_nature_gift, BasePotionModifier_CS)
function modifier_item_P051_nature_gift.prototype.____constructor(self, ...)
	BasePotionModifier_CS.prototype.____constructor(self, ...)
	self.baseHealthPct = 0
end
function modifier_item_P051_nature_gift.GetLocalizationCN(self)
	return { name = "大自然秘药", description = "生命基础值提升，并免疫中毒效果。" }
end
function modifier_item_P051_nature_gift.prototype.OnCreated(self, params)
	BasePotionModifier_CS.prototype.OnCreated(self, params)
	self:SetBaseHealthPct(params and params.potion_base_health_pct)
end
function modifier_item_P051_nature_gift.prototype.OnRefresh(self, params)
	self:SetPotionSequence(params and params.ak_potion_sequence)
	self:SetBaseHealthPct(params and params.potion_base_health_pct)
end
function modifier_item_P051_nature_gift.prototype.GetAttributeBonus(self)
	return { base_health_pct = self.baseHealthPct }
end
function modifier_item_P051_nature_gift.prototype.IsPurgable(self)
	return true
end
function modifier_item_P051_nature_gift.prototype.GetTexture(self)
	return "item_P027"
end
function modifier_item_P051_nature_gift.prototype.GetEffectName(self)
	return "particles/items3_fx/glimmer_cape_initial_flash.vpcf"
end
function modifier_item_P051_nature_gift.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_P051_nature_gift.prototype.SetBaseHealthPct(self, value)
	self.baseHealthPct = math.max(0, tonumber(value) or 0)
end
modifier_item_P051_nature_gift = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P051_nature_gift)
____exports.modifier_item_P051_nature_gift = modifier_item_P051_nature_gift
--- 毒抗药剂：移除当前中毒层数，并在持续时间内降低中毒伤害。
____exports.item_P052 = __TS__Class()
local item_P052 = ____exports.item_P052
item_P052.name = "item_P052"
__TS__ClassExtends(item_P052, BaseItem_CS)
function item_P052.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local ability_duration = self:GetSpecialValueFor("ability_duration")
			local ability_poison_damage_reduce_pct = self:GetSpecialValueFor("ability_poison_damage_reduce_pct")
			RemovePoisonModifiers(nil, caster)
			self:ApplyPotionModifier(
				____exports.modifier_item_P052_antidote.name,
				ability_duration,
				{ ability_poison_damage_reduce_pct = ability_poison_damage_reduce_pct }
			)
			self:PlayEffects1(caster)
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_P052.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.GlimmerCape.Activate")
	local particle_cast = ParticleManager:CreateParticle(
		"particles/items3_fx/glimmer_cape_initial_flash.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		particle_cast,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle_cast)
end
item_P052 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P052)
____exports.item_P052 = item_P052
____exports.modifier_item_P052_antidote = __TS__Class()
local modifier_item_P052_antidote = ____exports.modifier_item_P052_antidote
modifier_item_P052_antidote.name = "modifier_item_P052_antidote"
__TS__ClassExtends(modifier_item_P052_antidote, BasePotionModifier_CS)
function modifier_item_P052_antidote.prototype.____constructor(self, ...)
	BasePotionModifier_CS.prototype.____constructor(self, ...)
	self.poisonDamageReducePct = 0
end
function modifier_item_P052_antidote.GetLocalizationCN(self)
	return { name = "抗毒", description = "受到的中毒伤害大幅减少。" }
end
function modifier_item_P052_antidote.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_P052_antidote.prototype.OnCreated(self, params)
	BasePotionModifier_CS.prototype.OnCreated(self, params)
	self:SetPoisonDamageReducePct(params and params.ability_poison_damage_reduce_pct)
end
function modifier_item_P052_antidote.prototype.OnRefresh(self, params)
	self:SetPotionSequence(params and params.ak_potion_sequence)
	self:SetPoisonDamageReducePct(params and params.ability_poison_damage_reduce_pct)
end
function modifier_item_P052_antidote.prototype.IsPurgable(self)
	return true
end
function modifier_item_P052_antidote.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	local source = event.ctx.spec.source
	if not source or source.debuff_status ~= DebuffStatusType.POISON then
		return
	end
	if self.poisonDamageReducePct <= 0 then
		return
	end
	local ____event_final_12, ____mul_13 = event.final, "mul"
	if ____event_final_12[____mul_13] == nil then
		____event_final_12[____mul_13] = {}
	end
	local ____event_final_mul_14 = event.final.mul
	____event_final_mul_14[#____event_final_mul_14 + 1] =
		{ value = 1 - self.poisonDamageReducePct / 100, source = "item_P052:中毒减伤" }
end
function modifier_item_P052_antidote.prototype.GetTexture(self)
	return "item_icon_p052"
end
function modifier_item_P052_antidote.prototype.SetPoisonDamageReducePct(self, value)
	self.poisonDamageReducePct = math.max(0, math.min(100, tonumber(value) or 0))
end
modifier_item_P052_antidote = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P052_antidote)
____exports.modifier_item_P052_antidote = modifier_item_P052_antidote
return ____exports