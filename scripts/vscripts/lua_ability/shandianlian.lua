--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--闪电链
function ShanDian(caster, old, new, ability, radius, count, count_const, _group)
	if count > count_const then
		return nil
	end

	if IsValidEntity(old) and IsValidEntity(new) and IsValidEntity(caster) and caster:IsNull() == false then
		if old:IsAlive() and new:IsAlive() and caster:IsAlive() then
			local p = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf",
				PATTACH_CUSTOMORIGIN,
				old
			)
			ParticleManager:SetParticleControlEnt(p, 0, old, 5, "attach_hitloc", old:GetOrigin(), true)
			ParticleManager:SetParticleControlEnt(p, 1, new, 5, "attach_hitloc", new:GetOrigin(), true)

			ability:ApplyDataDrivenModifier(caster, new, "modifier_jn_D3_10_effect", nil)

			table.insert(_group, new)

			GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("ShanDian"), function()
				local teams = DOTA_UNIT_TARGET_TEAM_ENEMY
				local types = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
				local flags = DOTA_UNIT_TARGET_FLAG_NONE
				if
					IsValidEntity(new) == false
					or IsValidEntity(caster) == false
					or new:IsNull() == true
					or caster:IsNull() == true
				then
					return
				end
				local group = FindUnitsInRadius(
					caster:GetTeamNumber(),
					new:GetOrigin(),
					nil,
					radius,
					teams,
					types,
					flags,
					FIND_CLOSEST,
					true
				)
				local unit = nil
				local alive = true
				repeat
					if #group <= 0 then
						break
					end

					unit = table.remove(group, 1)

					if IsValidEntity(unit) then
						if unit:IsAlive() then
							alive = true
						else
							alive = false
						end
					else
						alive = false
					end

					for k, v in pairs(_group) do
						if unit == v then
							alive = false
							break
						end
					end

					if not caster:CanEntityBeSeenByMyTeam(unit) then
						alive = false
					end

				until alive
				ShanDian(caster, new, unit, ability, radius, count + 1, count_const, _group)

				return nil
			end, 0.2)
		end
	end
end

function jn_D3_00(keys)
	local caster = keys.caster
	local target = keys.target

	keys.ability.AttackCount = (keys.ability.AttackCount or 0) + 1

	if keys.ability.AttackCount >= keys.AttackCount then
		keys.ability.AttackCount = 0
		ShanDian(caster, caster, target, keys.ability, keys.Radius, 1, keys.Count, {})
	end
end