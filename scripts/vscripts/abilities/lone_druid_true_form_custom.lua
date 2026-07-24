--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_true_form_custom_fly", "abilities/lone_druid_true_form_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_true_form_custom", "abilities/lone_druid_true_form_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_infinite_form_mana_drain", "modifiers/modifier_infinite_form_mana_drain", LUA_MODIFIER_MOTION_NONE)

lone_druid_true_form_custom = class({})

function lone_druid_true_form_custom:OnToggle() 
	if not IsServer() then return end
	local modifier_lone_druid_true_form_custom = self:GetCaster():FindModifierByName("modifier_lone_druid_true_form_custom")
	if not self:GetToggleState() then
		if modifier_lone_druid_true_form_custom then
			modifier_lone_druid_true_form_custom:Destroy()
		end
	else
		self:GetCaster():RemoveModifierByName("modifier_lone_druid_true_form_custom")
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_true_form_custom", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_true_form_custom_fly", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_infinite_form_mana_drain", {}) -- [MF-16] общий дрейн 3%/сек
	end
	self:EndCooldown()
	self:StartCooldown(1) 
end

function lone_druid_true_form_custom:GetCooldown(iLevel)
	if self:GetCaster():HasScepter() then
		return 0
	end
	return self.BaseClass.GetCooldown(self, iLevel) 
end

function lone_druid_true_form_custom:GetBehavior()
  	if self:GetCaster():HasScepter() then
    	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
   	end
 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end

function lone_druid_true_form_custom:OnSpellStart()
	if not IsServer() then return end
	if self:GetCaster():HasScepter() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_true_form_custom", {duration = self:GetSpecialValueFor("duration")})
end

modifier_lone_druid_true_form_custom_fly = class({})

function modifier_lone_druid_true_form_custom_fly:IsHidden() return true end
function modifier_lone_druid_true_form_custom_fly:IsPurgable() return false end
function modifier_lone_druid_true_form_custom_fly:IsPurgeException() return false end

function modifier_lone_druid_true_form_custom_fly:OnCreated()
	if not IsServer() then return end
    self.parent = self:GetParent()
	self:StartIntervalThink(0.5)
end

function modifier_lone_druid_true_form_custom_fly:OnIntervalThink()
	if not IsServer() then return end
	if not self.parent:HasModifier("modifier_lone_druid_true_form_custom") then
		self:Destroy()
	end
    if not self.parent:HasScepter() then
        self.parent:RemoveModifierByName("modifier_lone_druid_true_form_custom")
    end
end

function modifier_lone_druid_true_form_custom_fly:CheckState()
	if not self.parent:HasScepter() then return end
	return 
	{
		[MODIFIER_STATE_FLYING] = true,
		-- [A61] без NO_UNIT_COLLISION летающий блокирует наземного врага (коллизия на земле) → застакивание/ловушка в дуэли
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

modifier_lone_druid_true_form_custom = class({})
function modifier_lone_druid_true_form_custom:IsHidden() return false end
function modifier_lone_druid_true_form_custom:IsPurgable() return false end
function modifier_lone_druid_true_form_custom:GetTexture() return "lone_druid_true_form" end

function modifier_lone_druid_true_form_custom:DeclareFunctions()  
    local decFuncs = 
    {
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return decFuncs 
end

function modifier_lone_druid_true_form_custom:GetModifierMoveSpeedBonus_Constant()
    return self.bonus_movement_speed
end

function modifier_lone_druid_true_form_custom:GetModifierModelChange()
    return "models/heroes/lone_druid/true_form.vmdl"
end

function modifier_lone_druid_true_form_custom:OnCreated()
    self.ability = self:GetAbility()
    self.caster = self:GetCaster()
    self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
    self.bonus_hp = self.ability:GetSpecialValueFor("bonus_hp")
    self.bonus_movement_speed = self.ability:GetSpecialValueFor("bonus_movement_speed")
end

function modifier_lone_druid_true_form_custom:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_lone_druid_true_form_custom:GetModifierHealthBonus()
	return self.bonus_hp
end

function modifier_lone_druid_true_form_custom:OnRefresh()
    self:OnCreated()
end