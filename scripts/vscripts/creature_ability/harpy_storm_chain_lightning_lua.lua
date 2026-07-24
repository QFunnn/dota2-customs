--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


harpy_storm_chain_lightning_lua = class({})

function harpy_storm_chain_lightning_lua:OnSpellStart()
	if IsServer() then
		self:GetCaster():EmitSound("Item.Maelstrom.Chain_Lightning")

		self.targets_hit = {}

		self:Zap(self:GetCaster(), self:GetCursorTarget(), self:GetSpecialValueFor("initial_damage"))
	end
end

function harpy_storm_chain_lightning_lua:Zap(source, target, damage)
	table.insert(self.targets_hit, target)

	local bounce_pfx = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, source)
	ParticleManager:SetParticleControlEnt(bounce_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(bounce_pfx, 1, source, PATTACH_POINT_FOLLOW, "attach_hitloc", source:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(bounce_pfx, 2, Vector(1, 1, 1))
	ParticleManager:ReleaseParticleIndex(bounce_pfx)

	target:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")

	if (not target:IsMagicImmune()) then
		ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
	end

	local nearby_enemies = FindUnitsInRadius(self:GetCaster():GetTeam(), source:GetAbsOrigin(), nil, self:GetSpecialValueFor("bounce_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
	for _, enemy in pairs(nearby_enemies) do
		local valid_target = true
		for _, hit_enemy in pairs(self.targets_hit) do
			if enemy == hit_enemy then
				valid_target = false
			end
		end
		if valid_target then
			self:Zap(target, enemy, damage)
			return
		end
	end
end