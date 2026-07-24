--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tempest_double_illusion = class({})
function modifier_tempest_double_illusion:IsHidden() return false end
function modifier_tempest_double_illusion:IsPurgable() return false end

function modifier_tempest_double_illusion:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA 
end

function modifier_tempest_double_illusion:GetEffectName()
	return "particles/units/heroes/hero_arc_warden/arc_warden_tempest_buff.vpcf"
end

function modifier_tempest_double_illusion:GetStatusEffect()
	return "particles/status_fx/status_effect_arc_warden_tempest.vpcf"
end

function modifier_tempest_double_illusion:GetModifierSuperIllusion()
	return true
end

function modifier_tempest_double_illusion:GetIsIllusion()
	return true
end

function modifier_tempest_double_illusion:GetModifierIllusionLabel()
	return true
end

function modifier_tempest_double_illusion:OnCreated()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end
	self.bounty = ability:GetSpecialValueFor("bounty")
	self.parent = self:GetParent()
	self.caster = caster
	self.ability = ability
end

function modifier_tempest_double_illusion:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,
		MODIFIER_PROPERTY_SUPER_ILLUSION,
		MODIFIER_PROPERTY_ILLUSION_LABEL,
		MODIFIER_PROPERTY_IS_ILLUSION
	}
end

function modifier_tempest_double_illusion:GetUnitLifetimeFraction( params )
	return ( ( self:GetDieTime() - GameRules:GetGameTime() ) / self:GetDuration() )
end

function modifier_tempest_double_illusion:TakeDamageScriptModifier( params )
	if not IsServer() then return end
	if not params.attacker or params.attacker:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end
	if params.unit ~= self.parent then return end
	if params.damage >= self.parent:GetHealth() then -- seems like we are dead!       
	    if params.attacker and params.attacker.GetPlayerOwnerID and params.attacker:GetPlayerOwnerID() then
			local hKillerHero =   PlayerResource:GetSelectedHeroEntity(params.attacker:GetPlayerOwnerID())
			if hKillerHero and hKillerHero.IsRealHero and hKillerHero:IsRealHero() then
				if hKillerHero:GetTeamNumber()~=self.parent:GetTeamNumber() then
				  --hKillerHero:ModifyGold(self.bounty, false, 12)
				  --SendOverheadEventMessage(hKillerHero, OVERHEAD_ALERT_GOLD, hKillerHero, self.bounty, nil)
				  --hKillerHero:AddExperience(self.bounty, 1, false, true)
				end
			end
	    end
		self:Destroy()
	end
end

function modifier_tempest_double_illusion:OnDestroy()
	if not IsServer() then return end
	if not self.parent or self.parent:IsNull() then return end
	self.parent:RemoveModifierByName("modifier_life_stealer_infest")
	self.parent:RemoveModifierByName("modifier_life_stealer_infest_enemy_hero")
	self.parent:RemoveModifierByName("modifier_life_stealer_infest_effect")
	self.parent:RemoveModifierByName("modifier_life_stealer_infest_creep")
   if self.parent:HasModifier("modifier_life_stealer_infest_effect") then
       local modifier = self.parent:FindModifierByName("modifier_life_stealer_infest_effect")
       local hInfester =  modifier:GetCaster()
       hInfester:RemoveModifierByName("modifier_life_stealer_infest")

       print(hInfester:GetUnitName())

       local ability = hInfester:FindAbilityByName("life_stealer_consume")
       if ability then
       		print("Я должен выходить бро")
       		ability:OnSpellStart()
       end
   end
   self.parent:RemoveModifierByName("modifier_pudge_rot")
   self.parent:RemoveModifierByName("modifier_leshrac_pulse_nova")
   self.parent:RemoveModifierByName("modifier_bloodseeker_blood_mist_custom")
   self.parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1.1)
   self.parent:AddNewModifier(self.caster, self.ability, "modifier_tempest_double_dying", {duration=1})
end