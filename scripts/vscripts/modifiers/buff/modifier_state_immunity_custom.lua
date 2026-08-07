--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_state_immunity_custom"
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
		["12"] = 4,
		["13"] = 13,
		["14"] = 4,
		["15"] = 13,
		["16"] = 15,
		["17"] = 16,
		["18"] = 17,
		["19"] = 18,
		["21"] = 20,
		["22"] = 21,
		["23"] = 22,
		["24"] = 23,
		["25"] = 23,
		["26"] = 23,
		["27"] = 23,
		["28"] = 23,
		["29"] = 24,
		["30"] = 24,
		["31"] = 24,
		["32"] = 24,
		["33"] = 24,
		["34"] = 24,
		["35"] = 24,
		["36"] = 24,
		["37"] = 24,
		["38"] = 25,
		["39"] = 25,
		["40"] = 25,
		["41"] = 25,
		["42"] = 25,
		["43"] = 25,
		["44"] = 25,
		["45"] = 25,
		["46"] = 26,
		["49"] = 15,
		["50"] = 31,
		["51"] = 32,
		["52"] = 33,
		["53"] = 34,
		["54"] = 35,
		["55"] = 36,
		["56"] = 36,
		["57"] = 36,
		["58"] = 36,
		["59"] = 36,
		["60"] = 37,
		["61"] = 37,
		["62"] = 37,
		["63"] = 37,
		["64"] = 37,
		["65"] = 37,
		["66"] = 37,
		["67"] = 37,
		["68"] = 37,
		["69"] = 38,
		["70"] = 38,
		["71"] = 38,
		["72"] = 38,
		["73"] = 38,
		["74"] = 38,
		["75"] = 38,
		["76"] = 38,
		["77"] = 39,
		["80"] = 31,
		["81"] = 43,
		["82"] = 44,
		["83"] = 45,
		["84"] = 46,
		["85"] = 47,
		["86"] = 48,
		["90"] = 43,
		["91"] = 53,
		["92"] = 54,
		["93"] = 53,
		["94"] = 56,
		["95"] = 57,
		["96"] = 57,
		["97"] = 57,
		["98"] = 57,
		["99"] = 57,
		["100"] = 57,
		["101"] = 57,
		["102"] = 56,
		["103"] = 65,
		["104"] = 66,
		["105"] = 65,
		["106"] = 70,
		["107"] = 71,
		["108"] = 70,
		["109"] = 13,
		["110"] = 4,
		["111"] = 4,
		["112"] = 4,
		["113"] = 4,
		["114"] = 4,
		["115"] = 4,
		["116"] = 4,
		["117"] = 4,
		["118"] = 4,
		["119"] = 13,
		["121"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_state_immunity_custom = c()
local k = g.modifier_state_immunity_custom
k.name = "modifier_state_immunity_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		if self.parent:HasModifier("modifier_stun_custom") then
			CombatLog:recordState(self.parent, nil, "Stun", "loss")
		end
		self:StartIntervalThink(l.duration)
		if not self.particleAdded and not l.HideParticle then
			self:GetParent():EmitSound("DOTA_Item.BlackKingBar.Activate")
			local m = ParticleManager:CreateParticle(
				"particles/items_fx/black_king_bar_avatar.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self:GetParent()
			)
			ParticleManager:SetParticleControlEnt(
				m,
				1,
				self:GetParent(),
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				vec3_zero,
				true
			)
			self:AddParticle(m, false, false, -1, false, false)
			self.particleAdded = true
		end
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:StartIntervalThink(l.duration)
		if not self.particleAdded and not l.HideParticle then
			self:GetParent():EmitSound("DOTA_Item.BlackKingBar.Activate")
			local m = ParticleManager:CreateParticle(
				"particles/items_fx/black_king_bar_avatar.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self:GetParent()
			)
			ParticleManager:SetParticleControlEnt(
				m,
				1,
				self:GetParent(),
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				vec3_zero,
				true
			)
			self:AddParticle(m, false, false, -1, false, false)
			self.particleAdded = true
		end
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		if self.parent:HasModifier("modifier_stun_custom") then
			local n = self.parent:FindModifierByName("modifier_stun_custom")
			if n then
				CombatLog:recordState(self.parent, n.caster, "Stun", "add")
			end
		end
	end
end
function k.prototype.OnIntervalThink(self)
	self:Destroy()
end
function k.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = false,
		[MODIFIER_STATE_PASSIVES_DISABLED] = false,
		[MODIFIER_STATE_DISARMED] = false,
		[MODIFIER_STATE_SILENCED] = false,
		[MODIFIER_STATE_MUTED] = false,
	}
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function k.prototype.GetModifierModelScale(self)
	return 20
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_ULTRA,
				DestroyOnExpire = false,
			}
		),
	},
	k
)
g.modifier_state_immunity_custom = k
return g