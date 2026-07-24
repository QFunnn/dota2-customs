--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_darkness_custom", "abilities/night_stalker_darkness_custom", LUA_MODIFIER_MOTION_NONE)

night_stalker_darkness_custom = class({})

function night_stalker_darkness_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_darkness", {duration = self:GetSpecialValueFor("duration")})
end

function night_stalker_darkness_custom:GetManaCost(level)
	if self:GetCaster():HasScepter() then 
        if IsClient() then return 15 end
		return 0
	end
	return self.BaseClass.GetManaCost(self,level)
end

function night_stalker_darkness_custom:GetCooldown(iLevel)
	if self:GetCaster():HasScepter() then
		return 0
	end
	return self.BaseClass.GetCooldown(self, iLevel) 
end

function night_stalker_darkness_custom:GetBehavior()
  	if self:GetCaster():HasScepter() then
    	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
   	end
 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end

function night_stalker_darkness_custom:OnToggle() 
	if not IsServer() then return end
	
	local modifier_night_stalker_darkness = self:GetCaster():FindModifierByName("modifier_night_stalker_darkness")

	if not self:GetToggleState() then
		if modifier_night_stalker_darkness then
			modifier_night_stalker_darkness:Destroy()
		end
	else
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_darkness", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_darkness_custom", {})
	end

	self:EndCooldown()
	self:StartCooldown(1) 
end

modifier_night_stalker_darkness_custom = class({})

function modifier_night_stalker_darkness_custom:IsHidden() return true end
function modifier_night_stalker_darkness_custom:IsPurgable() return false end
function modifier_night_stalker_darkness_custom:IsPurgeException() return false end

function modifier_night_stalker_darkness_custom:OnCreated()
	if not IsServer() then return end
    self.caster = self:GetCaster()
	self:StartIntervalThink(0.5)
end

function modifier_night_stalker_darkness_custom:OnIntervalThink()
	if not IsServer() then return end
    self.caster:SpendMana(15*0.5, self:GetAbility())
    if self.caster:GetMana() <= 14 then
        self.caster:RemoveModifierByName("modifier_night_stalker_darkness")
        return
    end
	if not self.caster:HasModifier("modifier_night_stalker_darkness") then
		self:Destroy()
        return
	end
    if not self.caster:HasScepter() then
        self.caster:RemoveModifierByName("modifier_night_stalker_darkness")
        return
    end
end