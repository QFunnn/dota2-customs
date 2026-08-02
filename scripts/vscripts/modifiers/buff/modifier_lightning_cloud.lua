--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_lightning_cloud"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_lightning_cloud"
d(j, h)
function j.prototype.OnCreated(self)
	if IsServer() then
		self:StartIntervalThink(1)
		self.parent:EmitSound("Hero_Razor.Storm.Loop")
	else
		local k = ParticleManager:CreateParticle(
			"particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm_rain.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(k, false, false, -1, false, false)
	end
end
function j.prototype.OnIntervalThink(self)
	if not IsValid(self.caster) then
		self:Destroy()
		return
	end
	local l = 1 + GetLightningCloudHitCount(self.caster)
	local m = 5
	local n = m + m * GetLightningCloudDamage(self.caster) * 0.01
	local o = RandomElements(FindEnemiesInRadius(self.caster, self.caster:GetAbsOrigin(), 600, FIND_CLOSEST), l)
	if o then
		for p, q in ipairs(o) do
			local k = ParticleManager:CreateParticle(
				"particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm.vpcf",
				PATTACH_CUSTOMORIGIN,
				self.parent
			)
			ParticleManager:SetParticleControl(k, 0, self.parent:GetAbsOrigin() + Vector(0, 0, 420))
			ParticleManager:SetParticleControlEnt(
				k,
				1,
				q,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				q:GetAbsOrigin(),
				false
			)
			self.caster:DealDamage(q, nil, n, nil, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
		end
		if #o > 0 then
			self.parent:EmitSound("Ability.PlasmaFieldImpact")
		end
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local r = self:GetParent()
		r:StopSound("Hero_Razor.Storm.Loop")
		r:EmitSound("Hero_Razor.StormEnd")
	end
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	j
)
return f