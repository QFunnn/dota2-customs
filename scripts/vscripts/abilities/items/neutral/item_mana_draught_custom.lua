--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_mana_draught_custom",
	"abilities/items/neutral/item_mana_draught_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_mana_draught_custom = class({})

function item_mana_draught_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items_fx/mana_draught.vpcf", context)
end

function item_mana_draught_custom:Spawn()
	self.duration = self:GetSpecialValueFor("duration")
	self.mana = self:GetSpecialValueFor("mana")
	self.mana_pct = self:GetSpecialValueFor("mana_pct") / 100
	self.max_regen = self:GetSpecialValueFor("max_regen")
end

function item_mana_draught_custom:OnSpellStart()
	local caster = self:GetCaster()
	caster:EmitSound("Item.Draught_active")
	caster:AddNewModifier(caster, self, "modifier_item_mana_draught_custom", { duration = self.duration })
end

modifier_item_mana_draught_custom = class(mod_visible)
function modifier_item_mana_draught_custom:IsPurgable()
	return true
end
function modifier_item_mana_draught_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.regen = math.min(self.ability.max_regen, self.ability.mana + self.parent:GetMaxMana() * self.ability.mana_pct)

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/items_fx/mana_draught.vpcf", self)
end

function modifier_item_mana_draught_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_mana_draught_custom:GetModifierConstantHealthRegen()
	return self.regen
end

function modifier_item_mana_draught_custom:GetModifierConstantManaRegen()
	return self.regen
end