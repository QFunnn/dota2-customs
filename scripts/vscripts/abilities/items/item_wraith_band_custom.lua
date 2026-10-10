--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_wraith_band_custom", "abilities/items/item_wraith_band_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_wraith_band_custom_speed",
	"abilities/items/item_wraith_band_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_wraith_band_custom = class({})

function item_wraith_band_custom:GetIntrinsicModifierName()
	return "modifier_item_wraith_band_custom"
end

function item_wraith_band_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items/wb_bif.vpcf", context)
end

function item_wraith_band_custom:Spawn()
	self.duration = self:GetSpecialValueFor("duration")
	self.agi = self:GetSpecialValueFor("agi")
	self.str = self:GetSpecialValueFor("str")
	self.int = self:GetSpecialValueFor("int")
	self.speed = self:GetSpecialValueFor("speed")
	self.armor = self:GetSpecialValueFor("armor")
	self.speed_buf = self:GetSpecialValueFor("speed_buf")
	self.max_stack = self:GetSpecialValueFor("max_stack")
end

function item_wraith_band_custom:OnSpellStart()
	local caster = self:GetCaster()

	if test then
		for team, hero in pairs(players) do
			if hero ~= caster then
				return
			end
		end
	end

	caster:EmitSound("DOTA_Item.Butterfly")
	caster:AddNewModifier(caster, self, "modifier_item_wraith_band_custom_speed", { duration = self.duration })
end

modifier_item_wraith_band_custom = class(mod_hidden)
function modifier_item_wraith_band_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_wraith_band_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.agi = self.ability.agi
	self.str = self.ability.str
	self.int = self.ability.int
	self.speed = self.ability.speed
	self.armor = self.ability.armor

	if not IsServer() then
		return
	end
	if not self.parent:IsRealHero() or self.parent:IsTempestDouble() then
		return
	end
	start_quest:CheckQuest({ quest_name = "Quest_1", id = self.parent:GetId(), item = self.ability:GetName() })
end

function modifier_item_wraith_band_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_item_wraith_band_custom:GetModifierBonusStats_Strength()
	return self.str
end

function modifier_item_wraith_band_custom:GetModifierBonusStats_Agility()
	return self.agi
end

function modifier_item_wraith_band_custom:GetModifierBonusStats_Intellect()
	return self.int
end

function modifier_item_wraith_band_custom:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_item_wraith_band_custom:GetModifierPhysicalArmorBonus()
	return self.armor
end

modifier_item_wraith_band_custom_speed = class(mod_visible)
function modifier_item_wraith_band_custom_speed:IsPurgable()
	return true
end
function modifier_item_wraith_band_custom_speed:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.speed_buf
	self.max_stack = self.ability.max_stack
	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/items/wb_bif.vpcf", self)

	for _, mod in pairs(self.parent:FindAllModifiers()) do
		if mod:GetName() == "modifier_item_wraith_band_custom" and self:GetStackCount() < self.max_stack then
			self:IncrementStackCount()
		end
	end
end

function modifier_item_wraith_band_custom_speed:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_item_wraith_band_custom_speed:GetModifierAttackSpeedBonus_Constant()
	return self.speed * self:GetStackCount()
end