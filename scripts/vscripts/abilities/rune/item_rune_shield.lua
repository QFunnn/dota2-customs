--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_shield"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectAssign
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_ability")
local i = h.EOMItem
local j = h.registerEOMAbility
local k = c()
k.name = "item_rune_shield"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.lastShieldTime = -999999
end
function k.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function k.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function k.prototype.RefreshConfigData(self)
	self:RefreshBaseConfigData()
	self:RefreshUpgradeConfigData()
	self.config = e({}, self.baseConfig, self.upgrade1Config)
end
function k.prototype.RefreshBaseConfigData(self)
	self.baseConfig = {
		shield_value = self:GetSpecialValueFor("shield_value"),
		shield_interval = self:GetSpecialValueFor("shield_interval"),
	}
end
function k.prototype.RefreshUpgradeConfigData(self)
	local l = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_shield_upgrade1")
	self.upgrade1Config = l and l.upgrade1Config or { share_prop = 0, share_shield = 0 }
end
function k.prototype.EventListener(self)
	return {
		ability_cast_complete = function(m, n)
			if not self.config then
				return
			end
			local o = self:GetCaster()
			local p = n.ability
			if not IsValid(o) or o ~= n.caster then
				return
			end
			if not IsValid(p) or p:GetAbilityTag() ~= self.abilityTag then
				return
			end
			local q = GameRules:GetGameTime()
			if q - self.lastShieldTime < self.config.shield_interval then
				return
			end
			self.lastShieldTime = q
			o:AddShield(self.config.shield_value, "item_rune_shield", "add")
			self:TryShareShield(o)
		end,
	}
end
function k.prototype.TryShareShield(self, o)
	if self.config.share_prop <= 0 or self.config.share_shield <= 0 then
		return
	end
	if not RollPercentage(self.config.share_prop) then
		return
	end
	local r = {}
	local s = o:GetPlayerOwnerID()
	local t = o:GetTeamNumber()
	Game:EachPlayer(function(m, u)
		if u == s then
			return
		end
		local v = PlayerResource:GetSelectedHeroEntity(u)
		if not IsValid(v) or not v:IsRealHero() or not v:IsAlive() then
			return
		end
		if v:GetTeamNumber() ~= t then
			return
		end
		r[#r + 1] = v
	end)
	if #r <= 0 then
		return
	end
	local w = r[RandomInt(0, #r - 1) + 1]
	if IsValid(w) then
		w:AddShield(self.config.share_shield, "item_rune_shield_share", "add")
	end
end
k = f({ j(nil) }, k)
local x = c()
x.name = "item_rune_shield_upgrade1"
d(x, i)
function x.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function x.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function x.prototype.RefreshConfigData(self)
	self.upgrade1Config =
		{ share_prop = self:GetSpecialValueFor("share_prop"), share_shield = self:GetSpecialValueFor("share_shield") }
	local y = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_shield")
	if y ~= nil then
		y:RefreshConfigData()
	end
end
x = f({ j(nil) }, x)
return g