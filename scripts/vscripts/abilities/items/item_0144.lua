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
____exports.ITEM_0144_SHADOW_BARRIER_MODIFIER = "modifier_item_0144_shadow_barrier"
____exports.item_0144 = __TS__Class()
local item_0144 = ____exports.item_0144
item_0144.name = "item_0144"
__TS__ClassExtends(item_0144, BaseItem_CS)
function item_0144.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0144.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	self:RemovePoisonModifiers(caster)
	caster:AddNewModifier(caster, self, ____exports.ITEM_0144_SHADOW_BARRIER_MODIFIER, { duration = ability_duration })
	self:PlayEffects1(caster)
end
function item_0144.prototype.RemovePoisonModifiers(self, caster)
	if not caster.FindAllModifiers then
		return
	end
	local modifiers = caster:FindAllModifiers()
	for ____, modifier in ipairs(modifiers) do
		do
			if modifier:GetName() ~= "modifier_generic_poison" then
				goto __continue8
			end
			modifier:Destroy()
		end
		::__continue8::
	end
end
function item_0144.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.GlimmerCape.Activate")
	local particle_cast = MyGameHeroParticleManager:CreateParticle(
		"particles/items3_fx/glimmer_cape_initial_flash.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle_cast,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle_cast)
end
item_0144 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0144)
____exports.item_0144 = item_0144
____exports.modifier_item_0144_shadow_barrier = __TS__Class()
local modifier_item_0144_shadow_barrier = ____exports.modifier_item_0144_shadow_barrier
modifier_item_0144_shadow_barrier.name = "modifier_item_0144_shadow_barrier"
__TS__ClassExtends(modifier_item_0144_shadow_barrier, BaseModifier_CS)
function modifier_item_0144_shadow_barrier.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.potionSequence = 0
end
function modifier_item_0144_shadow_barrier.GetLocalizationCN(self)
	return { name = "暗影屏障", description = "免疫中毒效果。" }
end
function modifier_item_0144_shadow_barrier.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetPotionSequence(params and params.ak_potion_sequence)
end
function modifier_item_0144_shadow_barrier.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:SetPotionSequence(params and params.ak_potion_sequence)
end
function modifier_item_0144_shadow_barrier.prototype.IsPotionModifier(self)
	return self.potionSequence > 0
end
function modifier_item_0144_shadow_barrier.prototype.SetPotionSequence(self, sequence)
	self.potionSequence = math.max(0, math.floor(tonumber(sequence) or 0))
	self.__ak_potion_sequence = self.potionSequence
end
function modifier_item_0144_shadow_barrier.prototype.GetPotionSequence(self)
	return self.potionSequence
end
function modifier_item_0144_shadow_barrier.prototype.IsPurgable(self)
	return true
end
function modifier_item_0144_shadow_barrier.prototype.GetTexture(self)
	return "item_shadow_amulet"
end
function modifier_item_0144_shadow_barrier.prototype.GetEffectName(self)
	return "particles/items3_fx/glimmer_cape_initial_flash.vpcf"
end
function modifier_item_0144_shadow_barrier.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_item_0144_shadow_barrier = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0144_shadow_barrier)
____exports.modifier_item_0144_shadow_barrier = modifier_item_0144_shadow_barrier
return ____exports