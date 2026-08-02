--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_reverse_bayonet"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_reverse_bayonet"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.chance = self:GetSpecialValueFor("chance")
end
function j.prototype.EventListener(self)
	return {
		attack_event = function(k, l)
			if l.attacker == self:GetCaster() and self:PRD(self.chance) then
				local m = self:GetCaster()
				local n = m:GetAbsOrigin()
				local o = self:GetSpecialValueFor("angle")
				local p = self:GetSpecialValueFor("range")
				local q = self:GetSpecialValueFor("damage")
				local r = FindUnitsInSector(
					m:GetTeamNumber(),
					n,
					p,
					CalcDirection2D(l.position, m),
					o,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER
				)
				local s = ParticleManager:CreateParticle(
					"particles/econ/items/kunkka/kunkka_weapon_gunsword/kunkka_spell_tidebringer_gun.vpcf",
					PATTACH_ABSORIGIN,
					m
				)
				ParticleManager:SetParticleControl(s, 1, Vector(0, 0, #r))
				for t, u in ipairs(r) do
					ParticleManager:SetParticleControl(s, 1 + t, u:GetAbsOrigin())
					m:DealDamage(u, self, q)
				end
				ParticleManager:ReleaseParticleIndex(s)
				m:EmitSound("Hero_Kunkka.InverseBayonet")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f