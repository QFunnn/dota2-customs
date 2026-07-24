--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_banana_custom", "items/item_banana_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_banana_custom_attribute", "items/item_banana_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_banana_custom_visual", "items/item_banana_custom", LUA_MODIFIER_MOTION_NONE)

item_banana_custom = class({})

function item_banana_custom:GetIntrinsicModifierName()
	return "modifier_item_banana_custom_attribute"
end

function item_banana_custom:OnSpellStart()
    local caster = self:GetCaster()
    local point = caster:GetAbsOrigin()
    CreateModifierThinker( caster, self, "modifier_item_banana_custom", {duration = self:GetSpecialValueFor("banana_duration")}, point, caster:GetTeamNumber(), false )
end

modifier_item_banana_custom = class({})

function modifier_item_banana_custom:IsHidden()
    return true
end

function modifier_item_banana_custom:OnCreated( kv )
	if not IsServer() then return end
	self.banana = CreateUnitByName("npc_dota_companion", self:GetParent():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
	self.banana:SetModel("models/props_gameplay/banana_prop_open.vmdl")
	self.banana:SetOriginalModel("models/props_gameplay/banana_prop_open.vmdl")
	self.banana:AddNewModifier(nil, nil, "modifier_invulnerable", {})
	self.banana:AddNewModifier(nil, nil, "modifier_phased", {})
	self.banana:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_banana_custom_visual", {})
	self.banana:StartGesture(ACT_DOTA_IDLE)
	self:StartIntervalThink(FrameTime())
end

function modifier_item_banana_custom:OnIntervalThink( kv )
	if not IsServer() then return end

    local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(),
    self:GetParent():GetAbsOrigin(),
    nil,
    self:GetAbility():GetSpecialValueFor("radius"),
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    FIND_ANY_ORDER,
    false)

    if #enemies > 0 then
	    enemies[1]:AddNewModifier( self:GetCaster(), nil, "modifier_ice_slide", {duration = self:GetAbility():GetSpecialValueFor("duration_debuff")} )
	    if self.banana then
	    	self.banana:Destroy()
	    end
	    self:Destroy()
	end
end

function modifier_item_banana_custom:OnDestroy()
	if not IsServer() then return end
	if self.banana and not self.banana:IsNull() then
		self.banana:Destroy()
	end
end

modifier_item_banana_custom_attribute = class({})

function modifier_item_banana_custom_attribute:IsHidden() return true end
function modifier_item_banana_custom_attribute:IsPurgable() return false end
function modifier_item_banana_custom_attribute:IsPurgeException() return false end
function modifier_item_banana_custom_attribute:IsPurgeException() return false end

function modifier_item_banana_custom_attribute:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
	}
end

function modifier_item_banana_custom_attribute:GetModifierPercentageCasttime()
	return self:GetAbility():GetSpecialValueFor("cast_point_pct")
end


modifier_item_banana_custom_visual = class({})

function modifier_item_banana_custom_visual:IsHidden() return true end

function modifier_item_banana_custom_visual:CheckState()
	return {
		[MODIFIER_STATE_UNSELECTABLE]		= true,
		[MODIFIER_STATE_INVULNERABLE]		= true,
		[MODIFIER_STATE_NO_UNIT_COLLISION]	= true,
		[MODIFIER_STATE_OUT_OF_GAME]	= true,
	}
end