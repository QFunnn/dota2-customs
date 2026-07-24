--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_legion_commander_duel_creep = class({}) ---@class modifier_legion_commander_duel_creep : CDOTA_Modifier_Lua

function modifier_legion_commander_duel_creep:IsHidden() return true end
function modifier_legion_commander_duel_creep:IsDebuff() return false end
function modifier_legion_commander_duel_creep:IsPurgable() return false end
function modifier_legion_commander_duel_creep:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_legion_commander_duel_creep:RemoveOnDeath() return true end

function modifier_legion_commander_duel_creep:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
end

function modifier_legion_commander_duel_creep:OnDestroy()
	if IsClient() then return end
	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	--print("duel removed with time left: "..self:GetRemainingTime())
	if self:GetRemainingTime() > 0 then -- Creep was killed during duel
		local winner_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, self.caster)
		ParticleManager:ReleaseParticleIndex(winner_pfx)
		EmitSoundOn("Hero_LegionCommander.Duel.Victory", hero)

		self.caster:RemoveModifierByName("modifier_legion_commander_duel")

		local duel_modifier
		if not self.caster:HasModifier("modifier_legion_commander_duel_damage_boost") then
			duel_modifier = self.caster:AddNewModifier(self.caster, self.ability, "modifier_legion_commander_duel_damage_boost", {})
		else
			duel_modifier = self.caster:FindModifierByName("modifier_legion_commander_duel_damage_boost")
		end
		duel_modifier:SetStackCount(duel_modifier:GetStackCount() + self.ability:GetSpecialValueFor("reward_damage") + self.caster:GetTalentValue("special_bonus_unique_legion_commander"))
	end
end