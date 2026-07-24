--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[
	Author: Noya
	Date: 18.01.2015.
	Kills a target, gives Mana to the caster according to the sacrificed target current Health
	Also gives split XP to all heroes in radius
]]
function DarkRitual( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	-- Mana to give	
	local target_health = target:GetHealth()
	local rate = ability:GetLevelSpecialValueFor( "health_conversion" , ability:GetLevel() - 1 ) * 0.01
	local mana_gain = target_health * rate

	caster:GiveMana( mana_gain )

	-- Purple particle with eye
	local particleName = "particles/msg_fx/msg_xp.vpcf"
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_OVERHEAD_FOLLOW, target)

	local digits = 0
    if mana_gain ~= nil then
        digits = #tostring(mana_gain)
    end

	ParticleManager:SetParticleControl(particle, 1, Vector(9, mana_gain, 6))
    ParticleManager:SetParticleControl(particle, 2, Vector(1, digits+1, 0))
    ParticleManager:SetParticleControl(particle, 3, Vector(170, 0, 250))

    -- Kill the target, ForceKill doesn't grant xp
	target:ForceKill(true)

end