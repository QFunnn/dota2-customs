--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_shredder/boss_shredder_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_shredder_2"
d(j, h)
function j.prototype.OnSpellStart(self)
	local k = self:GetCursorTarget()
	if not IsValid(k) then
		return
	end
	local l = self:GetCaster()
	local m = self:GetSpecialValueFor("speed")
	local n = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_shredder/shredder_timberchain.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(n, 0, l, PATTACH_POINT_FOLLOW, "attach_attack1", l:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(n, 1, k, PATTACH_POINT_FOLLOW, "attach_hitloc", k:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(n, 2, Vector(m, 0, 0))
	ParticleManager:SetParticleControl(n, 3, Vector(4, 0, 0))
	Bullet:CreateTrackingBullet({
		caster = l,
		target = k,
		spawnOrigin = l:GetAttachmentPosition("attach_attack1"),
		moveSpeed = m,
		ignoreBlock = true,
		OnBulletHit = function(k)
			l:EmitSound("Hero_Shredder.TimberChain.Impact")
			local o = CalcDistance(k, l)
			l:Dash(CalcDirection2D(k, l), o, 0, o / (m * 1.5), function()
				ParticleManager:DestroyParticle(n, false)
				local p = l:FindAbilityByName("boss_shredder_1")
				if IsValid(p) then
					p:CutDownTree(k)
				end
			end)
			local q = l:FindAbilityByName("boss_shredder_3")
			if IsValid(q) and q:IsCooldownReady() then
				l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, q)
			end
		end,
	})
	l:EmitSound("Hero_Shredder.TimberChain.Cast")
end
j = e({ i(nil, {}) }, j)
return f