--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_030"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.eom_privilege")
local l = k.EOMPrivilege
local m = k.PrivilegeValue
local n = k.RegisterPrivilege
local o = c()
o.name = "privilege_myth_030"
d(o, l)
function o.prototype.OnCreated(self)
	local p = self:GetCaster()
	if IsValid(p) then
		self.timerKey = Timer:GameTimer(0.2, function()
			if p:GetManaPercent() == 100 and not p:HasModifier(g.name) then
				p:AddNewModifier(
					p,
					nil,
					g.name,
					{
						damagePct = self.value,
						radius = self:GetSpecialValueFor("radius"),
						interval = self:GetSpecialValueFor("interval"),
						consumeManaPct = self:GetSpecialValueFor("consume_mana_pct"),
						thresholdManaPct = self:GetSpecialValueFor("min_mana_pct"),
					}
				)
			end
			return 0.2
		end)
	end
end
function o.prototype.OnDestroy(self)
	local p = self:GetCaster()
	if IsValid(p) then
		p:RemoveModifierByName(g.name)
	end
	if self.timerKey ~= nil then
		Timer:StopTimer(self.timerKey)
	end
end
e({ m(nil) }, o.prototype, "value", nil)
o = e({ n(nil) }, o)
g = c()
g.name = "modifier_privilege_myth_030"
d(g, i)
function g.prototype.OnCreated(self, q)
	if IsServer() then
		self.radius = q.radius
		self.interval = q.interval
		self.consumeManaPct = q.consumeManaPct
		self.thresholdManaPct = q.thresholdManaPct
		self.damagePct = q.damagePct
		self:StartIntervalThink(q.interval)
	else
		if self.particleID == nil then
			self.particleID = ParticleManager:CreateParticle(
				"particles/abilities/ranshaonuhuo.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self.parent
			)
			self:AddParticle(self.particleID, false, false, -1, false, false)
		end
	end
end
function g.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	local s = r:GetManaPercent()
	if s <= self.thresholdManaPct then
		self:Destroy()
		return
	end
	local t = r:GetMaxMana() * self.consumeManaPct * 0.01
	local u = FindEnemiesInRadius(r, r:GetAbsOrigin(), self.radius, FIND_CLOSEST)
	r:SpendMana(t, CLIENT_ABILITY)
	if Privilege:HasPrivilege("privilege_myth_032", r:GetPlayerOwnerID()) then
		local v = Privilege:GetPrivilegeSpecialValue("privilege_myth_032", 1, "value", r)
		local w = t * v * 0.01
		r:AddShield(w)
	end
	local x = t * self.damagePct * 0.01
	r:DealDamage(u, nil, x, nil, EOM_DAMAGE_FLAGS.BURNING_DAMAGE)
end
g = e(
	{
		j(
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
	g
)
return f