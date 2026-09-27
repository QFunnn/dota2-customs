--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_armor", "abilities/creeps_neutral/neutral_ogre_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_armor_buff", "abilities/creeps_neutral/neutral_ogre_armor", LUA_MODIFIER_MOTION_NONE)

neutral_ogre_armor = class({})

function neutral_ogre_armor:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/ogre_magi_frost_armor.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_frost_lich.vpcf", context)
end

function neutral_ogre_armor:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_ogre_armor"
end

modifier_ogre_armor = class(mod_hidden)
function modifier_ogre_armor:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.armor = self.ability:GetSpecialValueFor("armor")
	self.ability.magic = self.ability:GetSpecialValueFor("magic")
end

function modifier_ogre_armor:StartCast(target)
	if not IsServer() then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.3,
			anim = ACT_DOTA_CAST_ABILITY_1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_ogre_armor:EndCast()
	if not IsServer() then
		return
	end

	self.parent:EmitSound("n_creep_OgreMagi.FrostArmor")

	for _, target in
		pairs(
			self.parent:FindFriends(
				400,
				nil,
				FIND_CLOSEST,
				DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			)
		)
	do
		if not target:HasModifier("modifier_ogre_armor_buff") then
			target:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_ogre_armor_buff",
				{ duration = self.ability.duration }
			)
			break
		end
	end
end

modifier_ogre_armor_buff = class(mod_visible)
function modifier_ogre_armor_buff:IsPurgable()
	return true
end
function modifier_ogre_armor_buff:GetEffectName()
	return "particles/neutral_fx/ogre_magi_frost_armor.vpcf"
end
function modifier_ogre_armor_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_ogre_armor_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end
function modifier_ogre_armor_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end
function modifier_ogre_armor_buff:OnCreated()
	self.ability = self:GetAbility()

	self.armor = self.ability.armor
	self.magic = self.ability.magic
end

function modifier_ogre_armor_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_ogre_armor_buff:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_ogre_armor_buff:GetModifierMagicalResistanceBonus()
	return self.magic
end