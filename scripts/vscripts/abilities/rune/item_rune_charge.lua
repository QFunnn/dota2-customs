--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_charge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectAssign
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.registerEOMModifier
local j = h.EOMModifier
local k = require("abilities.eom_ability")
local l = k.AbilityValue
local m = k.EOMItem
local n = k.registerEOMAbility
local o = c()
o.name = "item_rune_charge"
d(o, m)
function o.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.lastChargeTime = 0
end
function o.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function o.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function o.prototype.RefreshConfigData(self)
	self:RefreshBaseConfigData()
	self:RefreshUpgradeConfigData()
	self.config = e({}, self.baseConfig, self.upgrade1Config)
end
function o.prototype.RefreshBaseConfigData(self)
	self.baseConfig = {
		ability_charge = {
			[AbilityTag.Attack] = self:GetSpecialValueFor("attack_charge"),
			[AbilityTag.Skill] = self:GetSpecialValueFor("ability1_charge"),
			[AbilityTag.Dodge] = self:GetSpecialValueFor("ability2_charge"),
			[AbilityTag.Defense] = self:GetSpecialValueFor("ability3_charge"),
			[AbilityTag.Ultimate] = self:GetSpecialValueFor("ability4_charge"),
		},
		charge_interval = self:GetSpecialValueFor("charge_interval"),
		charge_max = self:GetSpecialValueFor("charge_max"),
	}
end
function o.prototype.RefreshUpgradeConfigData(self)
	local p = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_charge_upgrade1")
	self.upgrade1Config = p and p.upgrade1Config or { double_charge_prop = 0 }
end
function o.prototype.EventListener(self)
	return {
		ability_cast_complete = function(q, r)
			if not self.config then
				return
			end
			local s = r.abilityTag
			if s ~= nil and s ~= self.abilityTag then
				return
			end
			local t = self.config.ability_charge[s] or 0
			if t <= 0 then
				return
			end
			local u = r.caster
			if not u or not IsValidEntity(u) or u ~= self:GetCaster() then
				return
			end
			local v = GameRules:GetGameTime()
			if v - self.lastChargeTime < self.config.charge_interval then
				return
			end
			self.lastChargeTime = v
			local w = RollPercentage(self.config.double_charge_prop) and 2 or 1
			u:AddNewModifier(u, self, "modifier_rune_charge", { stack = t * w })
		end,
	}
end
o = f({ n(nil) }, o)
local x = c()
x.name = "item_rune_charge_upgrade1"
d(x, m)
function x.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function x.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function x.prototype.RefreshConfigData(self)
	self.upgrade1Config = { double_charge_prop = self:GetSpecialValueFor("double_charge_prop") }
	local y = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_charge")
	if y ~= nil then
		y:RefreshConfigData()
	end
end
x = f({ n(nil) }, x)
local z = c()
z.name = "modifier_rune_charge"
d(z, j)
function z.prototype.OnCreated(self, A)
	local B
	if A ~= nil then
		B = A.stack
	end
	local C = B or 0
	if IsServer() then
		self:SetStackCount(C)
	end
end
function z.prototype.OnRefresh(self, A)
	if IsServer() then
		local D
		if A ~= nil then
			D = A.stack
		end
		local E = D or 0
		self:SetStackCount(math.min(self:GetStackCount() + E, self.charge_max))
	end
end
function z.prototype.OnStackCountChanged(self, F)
	if IsServer() then
		print(
			string.format(
				"[modifier_rune_charge] Stack count changed: stackCountOld=%d, stackCountNew=%d",
				F,
				self:GetStackCount()
			)
		)
	end
end
f({ l(nil) }, z.prototype, "charge_max", nil)
f({ l(nil) }, z.prototype, "charge_interval", nil)
z = f(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	z
)
return g