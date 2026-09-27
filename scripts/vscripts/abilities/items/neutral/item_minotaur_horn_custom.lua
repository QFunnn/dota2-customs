--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_minotaur_horn_custom_active",
	"abilities/items/neutral/item_minotaur_horn_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_minotaur_horn_custom = class({})

function item_minotaur_horn_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items5_fx/minotaur_horn.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_avatar.vpcf", context)
end

function item_minotaur_horn_custom:Spawn()
	self.duration = self:GetSpecialValueFor("duration")
	self.heal = self:GetSpecialValueFor("heal")
	self.magic_resist = self:GetSpecialValueFor("magic_resist")
	self.model_scale = self:GetSpecialValueFor("model_scale")
end

function item_minotaur_horn_custom:OnSpellStart()
	local caster = self:GetCaster()

	caster:EmitSound("DOTA_Item.MinotaurHorn.Cast")
	caster:Purge(false, true, false, false, false)
	local duration = self.duration
	local heal = (caster:GetMaxHealth() - caster:GetHealth()) * self.heal / 100
	caster:GenericHeal(heal, self)

	caster:AddNewModifier(caster, self, "modifier_item_minotaur_horn_custom_active", { duration = duration })
	caster:AddNewModifier(
		caster,
		self,
		"modifier_generic_debuff_immune",
		{ magic_damage = self.magic_resist, duration = duration }
	)
end

modifier_item_minotaur_horn_custom_active = class(mod_visible)
function modifier_item_minotaur_horn_custom_active:GetEffectName()
	return "particles/items5_fx/minotaur_horn.vpcf"
end
function modifier_item_minotaur_horn_custom_active:GetStatusEffectName()
	return "particles/status_fx/status_effect_avatar.vpcf"
end
function modifier_item_minotaur_horn_custom_active:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end
function modifier_item_minotaur_horn_custom_active:OnCreated(table)
	self.ability = self:GetAbility()

	self.model_scale = self.ability.model_scale
end

function modifier_item_minotaur_horn_custom_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_item_minotaur_horn_custom_active:GetModifierModelScale()
	return self.model_scale
end