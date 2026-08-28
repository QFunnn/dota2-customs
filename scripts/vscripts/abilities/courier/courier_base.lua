--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_base"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("modifiers.eom_modifier.eom_modifier")
local g = f.EOMModifier
e.CourierModifierBase = c()
local h = e.CourierModifierBase
h.name = "CourierModifierBase"
d(h, g)
function h.prototype.SyncHeroBuff(self, i)
	local j = self:GetBuffModifierName()
	local k = self:GetParent()
	local l = self:GetAbility()
	i:RemoveModifierByNameAndCaster(j, k)
	i:AddNewModifier(k, l, j, {})
end
function h.prototype.OnCreated(self, m)
	if IsServer() then
		local i = PlayerResource:GetSelectedHeroEntity(self:GetParent():GetPlayerOwnerID())
		if IsValid(i) then
			self.ownerHero = i
			self:SyncHeroBuff(i)
		end
	end
end
function h.prototype.OnRefresh(self, m)
	if IsServer() then
		local i = PlayerResource:GetSelectedHeroEntity(self:GetParent():GetPlayerOwnerID())
		if IsValid(i) then
			self.ownerHero = i
			self:SyncHeroBuff(i)
		end
	end
end
function h.prototype.OnDestroy(self)
	if IsServer() and IsValid(self.ownerHero) then
		self.ownerHero:RemoveModifierByNameAndCaster(self:GetBuffModifierName(), self:GetParent())
	end
end
e.CourierBuffConfig = {
	IsHidden = true,
	IsDebuff = false,
	IsPurgable = false,
	IsPurgeException = false,
	IsStunDebuff = false,
	AllowIllusionDuplicate = false,
	RemoveOnDeath = false,
}
e.CourierMainConfig = {
	IsHidden = false,
	IsDebuff = false,
	IsPurgable = false,
	IsPurgeException = false,
	IsStunDebuff = false,
	AllowIllusionDuplicate = false,
}
return e