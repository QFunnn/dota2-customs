--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_hero_show"
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
		["11"] = 4,
		["12"] = 13,
		["13"] = 4,
		["14"] = 13,
		["15"] = 18,
		["16"] = 19,
		["17"] = 20,
		["18"] = 21,
		["19"] = 22,
		["20"] = 23,
		["21"] = 24,
		["22"] = 25,
		["23"] = 25,
		["24"] = 25,
		["25"] = 25,
		["26"] = 25,
		["27"] = 27,
		["28"] = 28,
		["29"] = 28,
		["30"] = 29,
		["31"] = 30,
		["32"] = 32,
		["33"] = 33,
		["34"] = 34,
		["35"] = 35,
		["36"] = 37,
		["37"] = 37,
		["38"] = 37,
		["39"] = 37,
		["40"] = 37,
		["41"] = 38,
		["44"] = 18,
		["45"] = 43,
		["46"] = 44,
		["47"] = 45,
		["48"] = 46,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 51,
		["54"] = 52,
		["57"] = 43,
		["58"] = 57,
		["59"] = 58,
		["60"] = 59,
		["62"] = 57,
		["63"] = 63,
		["64"] = 64,
		["65"] = 65,
		["66"] = 66,
		["67"] = 67,
		["68"] = 68,
		["69"] = 69,
		["70"] = 69,
		["71"] = 69,
		["72"] = 69,
		["73"] = 69,
		["74"] = 70,
		["75"] = 70,
		["76"] = 70,
		["77"] = 70,
		["78"] = 70,
		["79"] = 70,
		["80"] = 70,
		["81"] = 70,
		["82"] = 70,
		["83"] = 71,
		["84"] = 71,
		["85"] = 71,
		["86"] = 71,
		["87"] = 71,
		["88"] = 71,
		["89"] = 71,
		["90"] = 71,
		["91"] = 71,
		["92"] = 73,
		["94"] = 75,
		["95"] = 76,
		["96"] = 77,
		["97"] = 78,
		["98"] = 79,
		["99"] = 81,
		["100"] = 82,
		["101"] = 83,
		["102"] = 84,
		["106"] = 63,
		["107"] = 13,
		["108"] = 4,
		["109"] = 4,
		["110"] = 4,
		["111"] = 4,
		["112"] = 4,
		["113"] = 4,
		["114"] = 4,
		["115"] = 4,
		["116"] = 13,
		["118"] = 13,
		["119"] = 91,
		["120"] = 99,
		["121"] = 91,
		["122"] = 99,
		["123"] = 99,
		["124"] = 91,
		["125"] = 91,
		["126"] = 91,
		["127"] = 91,
		["128"] = 91,
		["129"] = 91,
		["130"] = 91,
		["131"] = 91,
		["132"] = 99,
		["134"] = 99,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_hero_show = c()
local k = g.modifier_hero_show
k.name = "modifier_hero_show"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.createdFlag = false
		self.order = tonumber(l.order) or 0
		local m = self:GetParent()
		m:AddNoDraw()
		local n = PlayerData:getAlivePlayerCount()
		local o = Entities:FindByName(nil, "customer_hero_" .. tostring(self.order))
		local p = o and o:GetAbsOrigin() or vec3_zero
		FindClearSpaceForUnit(m, p, false)
		local q = Entities:FindByName(nil, "hero_show_camera_location")
		local r = q and q:GetAbsOrigin() or vec3_zero
		m:FaceTowards(r + HERO_SHOW_CONFIG.HERO_FACE_TOWARDS_POSITION)
		self:SetStackCount(math.max(n - (self.order - 1), 1))
		self.courier = PlayerResource:GetSelectedHeroEntity(m:GetPlayerOwnerID())
		if IsValid(self.courier) then
			self.courier:AddNoDraw()
			self.courier:SetForwardVector(HERO_SHOW_CONFIG.HERO_FACE_TOWARDS_POSITION)
			local s = Entities:FindByName(nil, "customer_courier_" .. tostring(self.order))
			local p = s and s:GetAbsOrigin() or vec3_zero
			FindClearSpaceForUnit(self.courier, p, false)
		end
	end
end
function k.prototype.OnRemoved(self, t)
	if IsServer() then
		local m = self:GetParent()
		m:RemoveNoDraw()
		m:RemoveModifierByName("modifier_hero_show_proficiency")
		m:RemoveGesture(HERO_SHOW_CONFIG.HERO_SHOW_ANIMATION)
		m:SetForwardVector(vec3_bottom)
		if IsValid(self.courier) then
			self.courier:RemoveModifierByName("modifier_courier_hide_name")
			self.courier:RemoveNoDraw()
		end
	end
end
function k.prototype.OnStackCountChanged(self, u)
	if u == 0 then
		self:StartIntervalThink(
			self:GetStackCount() * HERO_SHOW_CONFIG.HERO_SHOW_INTERVAL + HERO_SHOW_CONFIG.HERO_SHOW_DELAY
		)
	end
end
function k.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	if IsServer() then
		if not self.createdFlag then
			self.createdFlag = true
			local w =
				ParticleManager:CreateParticle("particles/gameplay/versus_meteor_near.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(w, 0, v:GetAbsOrigin() + Vector(0, 0, 1000))
			ParticleManager:SetParticleControlEnt(w, 1, v, PATTACH_ABSORIGIN, nil, v:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(w, 3, v, PATTACH_ABSORIGIN, nil, v:GetAbsOrigin(), true)
			self:StartIntervalThink(0.25)
		else
			EmitGlobalSound("Hero_Chen.TeleportOut")
			self:StartIntervalThink(-1)
			v:StartGestureWithFade(HERO_SHOW_CONFIG.HERO_SHOW_ANIMATION, 0, 0.2)
			v:RemoveNoDraw()
			v:AddNewModifier(v, nil, "modifier_hero_show_proficiency", {})
			if IsValid(self.courier) then
				self.courier:StartGestureWithFade(HERO_SHOW_CONFIG.HERO_SHOW_ANIMATION, 0, 0.2)
				self.courier:RemoveModifierByName("modifier_courier_hide_name")
				self.courier:RemoveNoDraw()
			end
		end
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
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_hero_show = k
g.modifier_hero_show_proficiency = c()
local x = g.modifier_hero_show_proficiency
x.name = "modifier_hero_show_proficiency"
d(x, i)
x = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	x
)
g.modifier_hero_show_proficiency = x
return g