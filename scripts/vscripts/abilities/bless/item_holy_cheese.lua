--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_cheese"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_holy_cheese"
d(m, k)
function m.prototype.OnCreated(self)
	local n = self:GetCaster()
	self:StartThink(0, function()
		if self:IsCooldownReady() and not n:HasModifier("modifier_item_holy_cheese") then
			n:AddNewModifier(n, self, "modifier_item_holy_cheese", {})
		end
	end)
end
m = e({ l(nil) }, m)
local o = c()
o.name = "modifier_item_holy_cheese"
d(o, h)
function o.prototype.OnCreated(self, p)
	if IsClient() then
		local q = ParticleManager:CreateParticle(
			"particles/units/passive_abilities/soap.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(q, false, false, -1, false, false)
	end
end
function o.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.AVOID_DAMAGE] = function(r, p)
			if p ~= nil and p.damage > 0 then
				self:Destroy()
				local s = self:GetAbility()
				if IsValid(s) then
					s:StartCooldown(self:GetAbilitySpecialValueFor("cooldown"))
				end
				return 1
			end
		end,
	}
end
o = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	o
)
return f