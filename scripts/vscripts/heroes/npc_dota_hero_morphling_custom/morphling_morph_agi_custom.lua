--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_morphling_morph_agi_custom", "heroes/npc_dota_hero_morphling_custom/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_morphling_morph_agi_custom_interval", "heroes/npc_dota_hero_morphling_custom/morphling_morph_agi_custom", LUA_MODIFIER_MOTION_NONE  )

morphling_morph_agi_custom = class({})

function morphling_morph_agi_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_morph_agi.vpcf", context )
end

function morphling_morph_agi_custom:GetIntrinsicModifierName()
	return "modifier_morphling_morph_agi_custom"
end

function morphling_morph_agi_custom:ProcsMagicStick()
    return false
end

function morphling_morph_agi_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_morphling_8") then
		return DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
	end
	return DOTA_ABILITY_BEHAVIOR_TOGGLE
end

function morphling_morph_agi_custom:OnToggle()
	if not IsServer() then return end
	local ability_two = self:GetCaster():FindAbilityByName("morphling_morph_str_custom")
	local agi_modifier = self:GetCaster():FindModifierByName("modifier_morphling_morph_agi_custom_interval")
	local str_modifier = self:GetCaster():FindModifierByName("modifier_morphling_morph_str_custom_interval")

	if self:GetToggleState() and ability_two:GetToggleState() then
		ability_two:ToggleAbility()
		if str_modifier and not str_modifier:IsNull() then
			str_modifier:Destroy()
		end
	end

	if self:GetToggleState() then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_morphling_morph_agi_custom_interval", {})
	else
		if agi_modifier and not agi_modifier:IsNull() then
			agi_modifier:Destroy()
		end
	end
end

modifier_morphling_morph_agi_custom = class({})

function modifier_morphling_morph_agi_custom:IsPurgable() return false end
function modifier_morphling_morph_agi_custom:IsHidden() return true end

function modifier_morphling_morph_agi_custom:RemoveOnDeath()
	return false
end

function modifier_morphling_morph_agi_custom:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(self:GetCaster():GetBaseAgility()+1)
	self:StartIntervalThink(FrameTime())
end

function modifier_morphling_morph_agi_custom:OnIntervalThink()
	if not IsServer() then return end
	self:SetStackCount(self:GetCaster():GetBaseAgility()+1)
    if self:GetCaster():IsIllusion() then return end
    if not self:GetCaster():IsRealHero() then return end
    local agi = self:GetCaster():GetAgility()
    local str = self:GetCaster():GetStrength()
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "morph_stats_refresh", {agi = agi, str = str})
end

modifier_morphling_morph_agi_custom_interval = class({})

function modifier_morphling_morph_agi_custom_interval:IsPurgable() return false end
function modifier_morphling_morph_agi_custom_interval:IsHidden() return true end

function modifier_morphling_morph_agi_custom_interval:OnCreated()
	if not IsServer() then return end
	self.interval = self:GetAbility():GetSpecialValueFor("morph_cooldown")
	self:StartIntervalThink(self.interval)
end

function modifier_morphling_morph_agi_custom_interval:OnIntervalThink()
	if not IsServer() then return end

	if not self:GetCaster():HasModifier("modifier_morphling_1") then
		if self:GetCaster():GetMana() < (self:GetAbility():GetSpecialValueFor("mana_cost") * self.interval) then
			return
		end
	end

	local str_stacks = self:GetCaster():FindModifierByName("modifier_morphling_morph_str_custom")
	local ag_stacks = self:GetCaster():FindModifierByName("modifier_morphling_morph_agi_custom")

	if math.floor(self:GetCaster():GetBaseStrength()) > 1 then
        local modify_health_check = self:GetParent():GetHealth()
		if not self:GetCaster():HasModifier("modifier_morphling_1") then
			self:GetCaster():SpendMana( (self:GetAbility():GetSpecialValueFor("mana_cost")*self.interval ), self:GetAbility())
		end
		self:GetParent():ModifyStrength(-1)
		self:GetParent():ModifyAgility(1)
        self:GetCaster():CalculateStatBonus(true)
        modify_health_check = modify_health_check - self:GetParent():GetHealth()
        self:GetParent():ModifyHealth(self:GetParent():GetHealth() - (22 - modify_health_check), self, false, DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_HPLOSS)
	end
end

function modifier_morphling_morph_agi_custom_interval:GetEffectName()
	return "particles/units/heroes/hero_morphling/morphling_morph_agi.vpcf"
end