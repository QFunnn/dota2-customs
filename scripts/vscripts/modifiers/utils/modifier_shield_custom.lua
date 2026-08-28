--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_shield_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 13,
		["16"] = 14,
		["17"] = 15,
		["19"] = 17,
		["20"] = 17,
		["21"] = 17,
		["22"] = 17,
		["23"] = 17,
		["24"] = 18,
		["25"] = 18,
		["26"] = 18,
		["27"] = 18,
		["28"] = 18,
		["29"] = 18,
		["30"] = 18,
		["31"] = 18,
		["32"] = 18,
		["33"] = 19,
		["34"] = 19,
		["35"] = 19,
		["36"] = 19,
		["37"] = 19,
		["38"] = 19,
		["39"] = 19,
		["40"] = 19,
		["41"] = 20,
		["43"] = 13,
		["44"] = 23,
		["45"] = 24,
		["46"] = 25,
		["48"] = 23,
		["49"] = 28,
		["50"] = 29,
		["51"] = 30,
		["52"] = 30,
		["53"] = 29,
		["54"] = 28,
		["55"] = 33,
		["56"] = 34,
		["57"] = 33,
		["58"] = 38,
		["59"] = 39,
		["60"] = 40,
		["61"] = 41,
		["62"] = 41,
		["63"] = 41,
		["64"] = 41,
		["65"] = 41,
		["66"] = 41,
		["67"] = 41,
		["68"] = 41,
		["69"] = 41,
		["72"] = 38,
		["73"] = 45,
		["74"] = 46,
		["75"] = 45,
		["76"] = 48,
		["77"] = 49,
		["78"] = 49,
		["79"] = 49,
		["80"] = 49,
		["81"] = 50,
		["83"] = 48,
		["84"] = 53,
		["85"] = 54,
		["86"] = 55,
		["87"] = 56,
		["88"] = 56,
		["89"] = 56,
		["90"] = 56,
		["91"] = 57,
		["92"] = 58,
		["93"] = 59,
		["94"] = 60,
		["96"] = 62,
		["98"] = 53,
		["99"] = 11,
		["100"] = 3,
		["101"] = 3,
		["102"] = 3,
		["103"] = 3,
		["104"] = 3,
		["105"] = 3,
		["106"] = 3,
		["107"] = 3,
		["108"] = 11,
		["110"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_shield_custom = c()
local k = g.modifier_shield_custom
k.name = "modifier_shield_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(l.iStackCount)
	else
		local m = ParticleManager:CreateParticle(
			"particles/sect/sect_shield_base.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			m,
			1,
			self:GetParent(),
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self:GetParent():GetAbsOrigin(),
			false
		)
		self:AddParticle(m, false, false, -1, false, false)
		self.iParticle = m
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:IncrementStackCount(l.iStackCount)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST] = { -1, self:GetParent() } }
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ADJUST_DAMAGE }
end
function k.prototype.OnStackCountChanged(self, n)
	if IsClient() then
		if self.iParticle then
			ParticleManager:SetParticleControl(
				self.iParticle,
				3,
				Vector(math.floor(self:GetStackCount() / 10), 255, 255)
			)
		end
	end
end
function k.prototype.EOM_GetModifierAdjustDamage(self)
	return self:GetStackCount()
end
function k.prototype.OnAdjust(self, l)
	if not HasState(self:GetParent(), EOMModifierStates.MODIFIER_STATE_STRONG_SHIELD) then
		self:ShieldAttenuation()
	end
end
function k.prototype.ShieldAttenuation(self)
	local o = self:GetParent()
	local p = math.ceil(self:GetStackCount() * SHIELD_ATTENUATION.Percentage) + SHIELD_ATTENUATION.Const
	p = math.max(
		0,
		math.ceil(
			p
				* (
					1
					+ GetModifierProperty(
							o,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_ATTENUATION_PERCENTAGE
						)
						* 0.01
				)
		)
	)
	if p > 0 then
		self:DecrementStackCount(p)
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS, { iCount = p }, o, nil)
	end
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_shield_custom = k
return g