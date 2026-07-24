--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_flesh_golem_custom_fly", "abilities/undying_flesh_golem_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_infinite_form_mana_drain", "modifiers/modifier_infinite_form_mana_drain", LUA_MODIFIER_MOTION_NONE)

undying_flesh_golem_custom = class({})

function undying_flesh_golem_custom:OnToggle() 
	if not IsServer() then return end
	
	local modifier_undying_flesh_golem = self:GetCaster():FindModifierByName("modifier_undying_flesh_golem")

	if not self:GetToggleState() then
		if modifier_undying_flesh_golem then
			modifier_undying_flesh_golem:Destroy()
		end
	else
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_flesh_golem", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_flesh_golem_custom_fly", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_infinite_form_mana_drain", {}) -- [MF-16] общий дрейн 3%/сек
	end

	self:EndCooldown()
	self:StartCooldown(1) 
end

function undying_flesh_golem_custom:GetCooldown(iLevel)
	if self:GetCaster():HasScepter() then
		return 0
	end
	return self.BaseClass.GetCooldown(self, iLevel) 
end

function undying_flesh_golem_custom:GetBehavior()
  	if self:GetCaster():HasScepter() then
    	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
   	end
 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end

function undying_flesh_golem_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_flesh_golem", {duration = self:GetSpecialValueFor("duration")})
end

modifier_undying_flesh_golem_custom_fly = class({})

function modifier_undying_flesh_golem_custom_fly:IsHidden() return true end
function modifier_undying_flesh_golem_custom_fly:IsPurgable() return false end
function modifier_undying_flesh_golem_custom_fly:IsPurgeException() return false end

function modifier_undying_flesh_golem_custom_fly:OnCreated()
	if not IsServer() then return end
    self.caster = self:GetCaster()
	self:StartIntervalThink(0.5)
end

function modifier_undying_flesh_golem_custom_fly:OnIntervalThink()
	if not IsServer() then return end
	if not self.caster:HasModifier("modifier_undying_flesh_golem") and not self.bHiddenByRoll then
		self:Destroy()
        return
	end
    if not self.caster:HasScepter() then
        self.caster:RemoveModifierByName("modifier_undying_flesh_golem")
        return
    end

    local bHasRoll = self.caster:HasModifier("modifier_pangolier_gyroshell") or self.caster:HasModifier("modifier_pangolier_rollup")
    if bHasRoll and not self.bHiddenByRoll then
        self.bHiddenByRoll = true
        self.caster:RemoveModifierByName("modifier_undying_flesh_golem")
    elseif not bHasRoll and self.bHiddenByRoll then
        self.bHiddenByRoll = false
        local hAbility = self:GetAbility()
        if hAbility then
            self.caster:AddNewModifier(self.caster, hAbility, "modifier_undying_flesh_golem", {})
        end
    end
end

function modifier_undying_flesh_golem_custom_fly:CheckState()
	if not self.caster:HasScepter() then return end
	return 
	{
		[MODIFIER_STATE_FLYING] = true,
		-- [A61] без NO_UNIT_COLLISION летающий блокирует наземного врага (коллизия на земле) → застакивание/ловушка в дуэли
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end