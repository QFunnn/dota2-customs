--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local self_bomb = __TS__Class()
self_bomb.name = "self_bomb"
__TS__ClassExtends(self_bomb, MonsterAbility_CS)
function self_bomb.prototype.GetIntrinsicModifierName(self)
	return "self_bomb_modifier"
end
self_bomb = __TS__DecorateLegacy({ registerAbility(nil) }, self_bomb)
local self_bomb_modifier = __TS__Class()
self_bomb_modifier.name = "self_bomb_modifier"
__TS__ClassExtends(self_bomb_modifier, MonsterModifier_CS)
function self_bomb_modifier.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_UNIT_DEATH }
end
function self_bomb_modifier.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____event_entindex_killed_0
	if event.entindex_killed then
		____event_entindex_killed_0 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_0 = nil
	end
	local victim = ____event_entindex_killed_0
	if not victim or victim ~= parent then
		return
	end
	local caster = self:GetCaster()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 0.8)
	caster:SetColor(Vector(255, 0, 0), 1.7)
	local pfx = self:PlayEffect()
	local pfx2 = self:PlayEffect2()
	ScreenShake(caster:GetAbsOrigin(), 4, 4, 1.7, 2000, 0, true)
	Timers:CreateTimer(1.6, function()
		if not IsValid(nil, caster) then
			return
		end
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:DestroyParticle(pfx2, false)
		caster:SetColor(Vector(0, 0, 0), 0.1)
		ScreenShake(caster:GetAbsOrigin(), 25, 25, 0.2, 3000, 0, true)
		caster:EmitSound("Hero_PrimalBeast.RockThrow.Impact")
		local pfx1 = ParticleManager:CreateParticle("particles/techies_blast_off2.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(pfx1, 0, self:GetCaster():GetAbsOrigin())
		ParticleManager:SetParticleControl(pfx1, 1, Vector(850, 10, 10))
		ParticleManager:SetParticleControl(pfx1, 3, self:GetCaster():GetAbsOrigin())
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			400,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
			0,
			false
		)
		__TS__ArrayForEach(enemies, function(____, item)
			caster:MonsterDamage({
				victim = item,
				damage_rate = 30,
				ability = self:GetAbility(),
			})
			item:KnockBack(caster, self:GetAbility(), {
				stunDuration = 1.5,
				stun = true,
				duration = 0.5,
				origin_pos = caster:GetAbsOrigin(),
				distance = 150,
				height = 0,
			})
		end)
	end)
end
function self_bomb_modifier.prototype.PlayEffect(self)
	local radius = 600
	local particle_cast2 = "particles/primal_beast_rock_throw_preview2.vpcf"
	local effect_cast2 = ParticleManager:CreateParticleForTeam(
		particle_cast2,
		PATTACH_CENTER_FOLLOW,
		self:GetCaster(),
		DOTA_TEAM_GOODGUYS
	)
	ParticleManager:SetParticleControl(effect_cast2, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast2, 1, Vector(radius, 0, -radius / 1))
	ParticleManager:SetParticleControl(effect_cast2, 2, Vector(radius, 0, 0))
	return effect_cast2
end
function self_bomb_modifier.prototype.PlayEffect2(self)
	local pfx = ParticleManager:CreateParticle(
		"particles/underlord_2021_immortal_portal_buildup_crimson_max.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	return pfx
end
self_bomb_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, self_bomb_modifier)
return ____exports