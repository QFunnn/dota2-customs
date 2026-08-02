--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

manaburn = class(base_game_perk)

function manaburn:DeclareFunctions()
	return { MODIFIER_PROPERTY_PROCATTACK_FEEDBACK }
end

function manaburn:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if params.target:IsMagicImmune() then
		return
	end
	if params.target:IsDebuffImmune() then
		return
	end
	if self.parent:GetTeamNumber() == params.target:GetTeamNumber() then
		return
	end

	local target_mana = params.target:GetMana()
	local mana_burn = self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)

	if self.parent:IsIllusion() then
		mana_burn = mana_burn * self.illusion_multiplier
	end
	if mana_burn > target_mana then
		mana_burn = target_mana
	end

	params.target:Script_ReduceMana(mana_burn, nil)
	if mana_burn > 0 then
		EmitSoundOnLocationWithCaster(params.target:GetAbsOrigin(), "Hero_Antimage.ManaBreak", params.attacker)
		local particle = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_manaburn.vpcf",
			PATTACH_ROOTBONE_FOLLOW,
			params.target
		)
		ParticleManager:ReleaseParticleIndex(particle)
		local damage = {
			victim = params.target,
			attacker = params.attacker,
			damage = mana_burn,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = nil,
		}
		ApplyDamage(damage)
	end
end