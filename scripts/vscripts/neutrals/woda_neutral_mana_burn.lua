--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_mana_burn = class({})

function woda_neutral_mana_burn:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		if target:IsMagicImmune() then self:GetCaster():RemoveModifierByName("modifier_neutral_cast") return end
		target:EmitSound("n_creep_SatyrSoulstealer.ManaBurn")

		local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )

		local mana_reduce = self:GetSpecialValueFor("mana_reduce")

		local mana = target:GetMana() / 100 * mana_reduce

		target:SpendMana(mana, self)

		ApplyDamage({victim = target, attacker = self:GetCaster(), damage = mana, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end