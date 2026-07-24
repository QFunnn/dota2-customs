--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_moonlight_debuff", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_moonlight", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_moonlight_debuff_stack", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_moonlight", LUA_MODIFIER_MOTION_NONE)

lone_druid_moonlight = class({})

function lone_druid_moonlight:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_mirana/mirana_starfall_attack.vpcf", context )
    PrecacheResource( "particle", "particles/witch_blade_debuff_52.vpcf", context )
end

lone_druid_moonlight.modifier_lone_druid_18_duration = {2,4,6}
lone_druid_moonlight.modifier_lone_druid_18_damage = 25

function lone_druid_moonlight:GetCooldown(level)
	local bonus = 1
	if self:GetCaster():HasModifier("modifier_lone_druid_true_form_custom") and self:GetCaster():HasModifier("modifier_lone_druid_19") then
		bonus = 2
	end
    return self.BaseClass.GetCooldown( self, level ) / bonus
end

function lone_druid_moonlight:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then return end

	self:StartMoonLight(target)

	local radius = self:GetSpecialValueFor("radius")
	local count = self:GetSpecialValueFor("count")
	local count_current = 0


	local nearby_enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	for _, enemy in pairs(nearby_enemies) do
		if enemy ~= target then
			if count_current < count then
				self:StartMoonLight(enemy)
				count_current = count_current + 1
			else
				break
			end
		end
	end
end

function lone_druid_moonlight:StartMoonLight(target)
	if not IsServer() then return end

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_mirana/mirana_starfall_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)

	Timers:CreateTimer(0.2,function()
		ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = self:GetSpecialValueFor("damage"), ability = self, damage_type = DAMAGE_TYPE_MAGICAL })
		target:EmitSound("Ability.StarfallImpact")
		if self:GetCaster():HasModifier("modifier_lone_druid_18") then
			target:AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_moonlight_debuff_stack", {duration = self.modifier_lone_druid_18_duration[self:GetCaster():GetTalentLevel("modifier_lone_druid_18")]})
			target:AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_moonlight_debuff", {duration = self.modifier_lone_druid_18_duration[self:GetCaster():GetTalentLevel("modifier_lone_druid_18")]})
		end
	end)
end

modifier_lone_druid_moonlight_debuff = class({})

function modifier_lone_druid_moonlight_debuff:OnCreated()
	if not IsServer() then return end
	self.damage_tick = 0
	self:StartIntervalThink(FrameTime())
end

function modifier_lone_druid_moonlight_debuff:OnIntervalThink()
	if not IsServer() then return end
	self.damage_tick = self.damage_tick + FrameTime()

	local modifiers = self:GetParent():FindAllModifiersByName("modifier_lone_druid_moonlight_debuff_stack")
	self:SetStackCount(#modifiers)

	if self.damage_tick >= 1 then
		self.damage_tick = 0
		local damage = self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_lone_druid_18_damage
		damage = damage * self:GetStackCount()
		ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL })
	end
end

function modifier_lone_druid_moonlight_debuff:GetEffectName() return "particles/witch_blade_debuff_52.vpcf" end

function modifier_lone_druid_moonlight_debuff:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end

modifier_lone_druid_moonlight_debuff_stack = class({})
function modifier_lone_druid_moonlight_debuff_stack:IsHidden() return true end
function modifier_lone_druid_moonlight_debuff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end