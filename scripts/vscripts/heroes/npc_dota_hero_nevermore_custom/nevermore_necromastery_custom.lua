--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_necromastery_custom", "heroes/npc_dota_hero_nevermore_custom/nevermore_necromastery_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_necromastery_custom_bonus_souls", "heroes/npc_dota_hero_nevermore_custom/nevermore_necromastery_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_necromastery_custom_9_debuff", "heroes/npc_dota_hero_nevermore_custom/nevermore_necromastery_custom", LUA_MODIFIER_MOTION_NONE)

nevermore_necromastery_custom = class({})	

function nevermore_necromastery_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_souls_hero_effect.vpcf", context )
end

nevermore_necromastery_custom.modifier_nevermore_8_cooldown = {6,3}
nevermore_necromastery_custom.modifier_nevermore_9_crit = 120
nevermore_necromastery_custom.modifier_nevermore_10_souls = {2,4,6}
nevermore_necromastery_custom.modifier_nevermore_11 = {0.5,1,1.5}
nevermore_necromastery_custom.modifier_nevermore_13 = {1,1.5,2}
nevermore_necromastery_custom.modifier_nevermore_14_duration = 3
nevermore_necromastery_custom.modifier_nevermore_18_bonus = 1
nevermore_necromastery_custom.modifier_nevermore_18_int = 30

function nevermore_necromastery_custom:OnOrbFire( params )
	if not IsServer() then return end
	local mod_souls = self:GetCaster():FindModifierByName("modifier_nevermore_necromastery_custom")
	if mod_souls then
		if mod_souls:GetStackCount() > 0 then
			mod_souls:DecrementStackCount()
		end
	end
end

function nevermore_necromastery_custom:GetCastRange(vLocation, hTarget)
	return self:GetCaster():Script_GetAttackRange() + 50
end

function nevermore_necromastery_custom:OnOrbImpact( params )
    if not IsServer() then return end
    if params.target:IsDebuffImmune() then return end
	params.target:AddNewModifier(self:GetCaster(), self, "modifier_nevermore_necromastery_fear", {duration = 0.5})
end

function nevermore_necromastery_custom:GetIntrinsicModifierName()
	return "modifier_nevermore_necromastery_custom"
end

modifier_nevermore_necromastery_custom = class({})

function modifier_nevermore_necromastery_custom:RemoveOnDeath() return false end
function modifier_nevermore_necromastery_custom:IsHidden() return false end
function modifier_nevermore_necromastery_custom:IsPurgable() return false end
function modifier_nevermore_necromastery_custom:IsDebuff() return false end
function modifier_nevermore_necromastery_custom:DestroyOnExpire() return false end

function modifier_nevermore_necromastery_custom:OnCreated()
    self.souls_per_kill = self:GetAbility():GetSpecialValueFor("souls_per_kill")
    self.souls_per_hero_kill = self:GetAbility():GetSpecialValueFor("souls_per_hero_kill")
	if not IsServer() then return end
    self.give_soul = false
    self.cooldown = nil
	self:StartIntervalThink(0.1)
end

function modifier_nevermore_necromastery_custom:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_nevermore_8") then return end
    local cooldown = self:GetAbility().modifier_nevermore_8_cooldown[self:GetCaster():GetTalentLevel("modifier_nevermore_8")]
    local maximum = self:GetMaxSoulsCounter()
    if self:GetStackCount() < maximum then
        if not self.cooldown or self.cooldown <= 0 then
            self.cooldown = cooldown
            self:SetDuration(cooldown, true)
        end
        self.cooldown = self.cooldown - 0.1
    else
        self:SetDuration(-1, true)
        self.cooldown = nil
    end
    if self.cooldown and self.cooldown <= 0 then
        self:AddNewSoul(1)
    end
end

function modifier_nevermore_necromastery_custom:GetHeroEffectName()
	return "particles/units/heroes/hero_nevermore/nevermore_souls_hero_effect.vpcf"
end

function modifier_nevermore_necromastery_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
end

function modifier_nevermore_necromastery_custom:GetModifierPreAttack_BonusDamage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_nevermore_11") then
		bonus = self:GetAbility().modifier_nevermore_11[self:GetCaster():GetTalentLevel("modifier_nevermore_11")]
	end
	return (self:GetAbility():GetSpecialValueFor("necromastery_damage_per_soul") + bonus ) * self:GetStackCount() 
end

function modifier_nevermore_necromastery_custom:OnDeath(params)
	if not IsServer() then return end

	if params.attacker ~= self:GetParent() and params.unit == self:GetParent() and self:GetParent():IsRealHero() then
		-- Здесь будет выпуск душ при смерти

		if not self:GetParent():HasModifier("modifier_wodaduel1") and not self:GetParent():HasModifier("modifier_wodaduel_duo") and not self:GetParent():HasModifier("modifier_wodaduel2") and not self:GetParent():HasModifier("modifier_nevermore_12") then 
			self:SetStackCount(self:GetStackCount() * self:GetAbility():GetSpecialValueFor("necromastery_soul_release"))
		end
		
		if self:GetParent():HasAbility("nevermore_requiem_custom") then
			local nevermore_requiem_custom = self:GetParent():FindAbilityByName("nevermore_requiem_custom")
			if nevermore_requiem_custom then
				if nevermore_requiem_custom:GetLevel() >= 1 then
					nevermore_requiem_custom:OnSpellStart(true)
				end
			end
		end
		return
	end

	if params.attacker ~= self:GetParent() then return end
	if params.unit == self:GetParent() then return end
	if params.unit:IsIllusion() then return end
	if params.unit:IsTempestDouble() then return end
	if params.unit:IsBuilding() then return end
	if params.unit:IsReincarnating() then return end
    local soul = self.souls_per_kill
    if params.unit:IsRealHero() then
        soul = self.souls_per_hero_kill
    end
	self:AddNewSoul(soul)
end

function modifier_nevermore_necromastery_custom:GetModifierIncomingDamage_Percentage()
	if not self:GetCaster():HasModifier("modifier_nevermore_19") then return 0 end
end

function modifier_nevermore_necromastery_custom:GetModifierAttackSpeedBonus_Constant()
	if not self:GetCaster():HasModifier("modifier_nevermore_13") then return 0 end
	return self:GetStackCount() * self:GetAbility().modifier_nevermore_13[self:GetCaster():GetTalentLevel("modifier_nevermore_13")]
end

function modifier_nevermore_necromastery_custom:OnAttack(params)
    if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
    if self:GetParent():HasModifier("modifier_nevermore_9") and not self:GetParent():HasModifier("modifier_nevermore_necromastery_custom_9_debuff") and self:GetStackCount() > 0 then
        self.record_modifier_9 = params.record
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_nevermore_necromastery_custom_9_debuff", {duration = 6})
        self:AddNewSoul(-1, true)
    end
end

function modifier_nevermore_necromastery_custom:GetModifierProjectileName()
	if self:GetParent():HasModifier("modifier_nevermore_9") and not self:GetParent():HasModifier("modifier_nevermore_necromastery_custom_9_debuff") and self:GetStackCount() > 0 then
		return "particles/units/heroes/hero_nevermore/sf_necromastery_attack.vpcf"
	end
	return "particles/units/heroes/hero_nevermore/nevermore_base_attack.vpcf"
end

function modifier_nevermore_necromastery_custom:GetModifierPreAttack_CriticalStrike( params )
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_nevermore_9") and not self:GetParent():HasModifier("modifier_nevermore_necromastery_custom_9_debuff") and self:GetStackCount() > 0 then
    	return self:GetAbility().modifier_nevermore_9_crit
    end
end

function modifier_nevermore_necromastery_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
    if params.record == self.record_modifier_9 then
        self:GetAbility():OnOrbImpact(params)
    end
	if not self:GetParent():HasModifier("modifier_nevermore_14") then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_nevermore_necromastery_custom_bonus_souls", {duration = self:GetAbility().modifier_nevermore_14_duration})
	self:AddNewSoul(1)
end

function modifier_nevermore_necromastery_custom:AddNewSoul(count, ignore_maximum)
	if not IsServer() then return end
	local maximum = self:GetMaxSoulsCounter()
	if (self:GetStackCount() < maximum or ignore_maximum) then
		if (self:GetStackCount() + count > maximum) and not ignore_maximum then
			self:SetStackCount(maximum)
		else
			self:SetStackCount(self:GetStackCount() + count)
		end
	end
end

function modifier_nevermore_necromastery_custom:RemoveSouls()
	if not IsServer() then return end
	local maximum = self:GetMaxSoulsCounter()
	if self:GetStackCount() > maximum then
		self:SetStackCount(maximum)
	end
end

function modifier_nevermore_necromastery_custom:GetMaxSoulsCounter()
    local maximum = self:GetAbility():GetSpecialValueFor("necromastery_max_souls")
	if self:GetCaster():HasModifier("modifier_nevermore_18") then
		maximum = maximum + (( math.min(self:GetCaster():GetIntellect(false), 600) / self:GetAbility().modifier_nevermore_18_int) * self:GetAbility().modifier_nevermore_18_bonus )
	end
	if self:GetCaster():HasModifier("modifier_nevermore_10") then
		maximum = maximum + self:GetAbility().modifier_nevermore_10_souls[self:GetCaster():GetTalentLevel("modifier_nevermore_10")]
	end
	if self:GetCaster():HasModifier("modifier_nevermore_14") then
		maximum = maximum + (#self:GetParent():FindAllModifiersByName("modifier_nevermore_necromastery_custom_bonus_souls"))
	end
    local modifier_nevermore_frenzy_custom = self:GetCaster():FindModifierByName("modifier_nevermore_frenzy_custom")
    if modifier_nevermore_frenzy_custom then
        maximum = maximum + modifier_nevermore_frenzy_custom.souls_steal
    end
    local modifier_nevermore_frenzy_custom_pre_buff = self:GetCaster():FindModifierByName("modifier_nevermore_frenzy_custom_pre_buff")
    if modifier_nevermore_frenzy_custom_pre_buff then
        maximum = maximum + modifier_nevermore_frenzy_custom_pre_buff.souls_counter
    end
    return maximum
end

modifier_nevermore_necromastery_custom_bonus_souls = class({})
function modifier_nevermore_necromastery_custom_bonus_souls:IsHidden() return true end
function modifier_nevermore_necromastery_custom_bonus_souls:IsPurgable() return false end
function modifier_nevermore_necromastery_custom_bonus_souls:RemoveOnDeath() return false end
function modifier_nevermore_necromastery_custom_bonus_souls:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_nevermore_necromastery_custom_bonus_souls:OnDestroy()
	if not IsServer() then return end
	local mod = self:GetCaster():FindModifierByName("modifier_nevermore_necromastery_custom")
	if mod then
		mod:RemoveSouls()
	end
end

modifier_nevermore_necromastery_custom_9_debuff = class({})
function modifier_nevermore_necromastery_custom_9_debuff:IsPurgable() return false end
function modifier_nevermore_necromastery_custom_9_debuff:IsDebuff() return true end
function modifier_nevermore_necromastery_custom_9_debuff:IsPurgeException() return false end
function modifier_nevermore_necromastery_custom_9_debuff:RemoveOnDeath() return false end