--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_18"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 10,
		["17"] = 21,
		["18"] = 29,
		["19"] = 21,
		["20"] = 29,
		["22"] = 29,
		["23"] = 30,
		["24"] = 33,
		["25"] = 21,
		["26"] = 34,
		["27"] = 35,
		["28"] = 36,
		["29"] = 34,
		["30"] = 38,
		["31"] = 39,
		["32"] = 40,
		["33"] = 41,
		["34"] = 42,
		["35"] = 43,
		["36"] = 44,
		["37"] = 45,
		["38"] = 45,
		["41"] = 40,
		["43"] = 38,
		["44"] = 51,
		["45"] = 52,
		["46"] = 53,
		["47"] = 53,
		["48"] = 53,
		["49"] = 54,
		["50"] = 55,
		["52"] = 53,
		["53"] = 53,
		["55"] = 51,
		["56"] = 60,
		["57"] = 61,
		["58"] = 62,
		["59"] = 63,
		["60"] = 64,
		["61"] = 64,
		["62"] = 64,
		["63"] = 65,
		["64"] = 66,
		["65"] = 64,
		["66"] = 64,
		["67"] = 68,
		["68"] = 69,
		["69"] = 70,
		["70"] = 70,
		["71"] = 70,
		["72"] = 70,
		["73"] = 71,
		["74"] = 72,
		["75"] = 73,
		["76"] = 74,
		["77"] = 79,
		["78"] = 80,
		["79"] = 81,
		["80"] = 82,
		["81"] = 83,
		["83"] = 85,
		["84"] = 86,
		["85"] = 87,
		["86"] = 88,
		["87"] = 89,
		["88"] = 89,
		["89"] = 89,
		["90"] = 89,
		["91"] = 89,
		["92"] = 90,
		["93"] = 90,
		["94"] = 90,
		["95"] = 90,
		["96"] = 90,
		["98"] = 92,
		["100"] = 94,
		["102"] = 69,
		["104"] = 60,
		["105"] = 99,
		["106"] = 100,
		["107"] = 99,
		["108"] = 104,
		["109"] = 105,
		["110"] = 106,
		["111"] = 106,
		["112"] = 106,
		["113"] = 106,
		["114"] = 107,
		["115"] = 108,
		["116"] = 109,
		["117"] = 110,
		["118"] = 110,
		["119"] = 105,
		["120"] = 112,
		["121"] = 104,
		["122"] = 29,
		["123"] = 21,
		["124"] = 21,
		["125"] = 21,
		["126"] = 21,
		["127"] = 21,
		["128"] = 21,
		["129"] = 21,
		["130"] = 21,
		["131"] = 29,
		["133"] = 29,
		["135"] = 117,
		["136"] = 125,
		["137"] = 117,
		["138"] = 125,
		["139"] = 126,
		["140"] = 127,
		["141"] = 126,
		["142"] = 125,
		["143"] = 117,
		["144"] = 117,
		["145"] = 117,
		["146"] = 117,
		["147"] = 117,
		["148"] = 117,
		["149"] = 117,
		["150"] = 117,
		["151"] = 125,
		["153"] = 125,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
local n = {
	{
		particle = "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_midas_coinshower.vpcf",
		sound = "General.CoinsBig",
	},
}
local o = {
	{
		particle = "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_egg_run.vpcf",
		sound = "Hero_SkywrathMage.ChickenTauntClap",
	},
	{ particle = "particles/econ/events/new_bloom/pig_death.vpcf", sound = "SeasonalConsumable.Balloon.Pop" },
}
h.modifier_city_18 = c()
local p = h.modifier_city_18
p.name = "modifier_city_18"
d(p, m)
function p.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.modifierList = {}
	self.particleIDList = {}
end
function p.prototype.GetAbilitySpecialValue(self)
	self.min = self:GetAbilitySpecialValueFor("min")
	self.max = self:GetAbilitySpecialValueFor("max")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		PlayerData:eachPlayer(function(r, s)
			local t = PlayerResource:GetSelectedHeroEntity(s.playerID)
			if IsValid(t) then
				local u = t:AddNewModifier(t, nil, "modifier_city_18_buff", nil)
				if IsValid(u) then
					local v = self.modifierList
					v[#v + 1] = u
				end
			end
		end)
	end
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		e(self.modifierList, function(r, w)
			if IsValid(w) then
				w:Destroy()
			end
		end)
	end
end
function p.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		local x = RollPercentage(50)
		e(self.particleIDList, function(r, y)
			ParticleManager:DestroyParticle(y, false)
			ParticleManager:ReleaseParticleIndex(y)
		end)
		self.particleIDList = {}
		PlayerData:eachAlivePlayerHero(function(r, z, A)
			local B = GetGroundPosition(PlayerData:getPlayerHomeHeroPosition(A) + Vector(0, 400, 0), nil)
			EmitSoundOnLocationWithCaster(B, "Hero_Wisp.TeleportOut", z.hero)
			if x then
				PlayerData:modifyGold(A, self.max)
				Notification:combatToPlayer(
					A,
					{
						message = "notify_bonus_gold",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
						int_gold = self.max,
					}
				)
				CityEffect:modifyCityEffectExtraData(A, "bonus_gold", self.max)
				local C = n[RandomInt(0, #n - 1) + 1]
				local y = ParticleManager:CreateParticle(C.particle, PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(y, 0, B)
				EmitSoundOnLocationWithCaster(B, C.sound, z.hero)
			else
				local D = RandomInt(0, #o - 1)
				local C = o[D + 1]
				local y = ParticleManager:CreateParticle(C.particle, PATTACH_CUSTOMORIGIN, nil)
				if D == 1 then
					ParticleManager:SetParticleControl(y, 0, B + Vector(0, 0, 60))
					ParticleManager:SetParticleControl(y, 1, Vector(0, -90, 180))
				else
					ParticleManager:SetParticleControl(y, 0, B)
				end
				EmitSoundOnLocationWithCaster(B, C.sound, z.hero)
			end
		end)
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function p.prototype.OnRoundStart(self, q)
	PlayerData:eachAlivePlayerHero(function(r, z, A)
		local B = GetGroundPosition(PlayerData:getPlayerHomeHeroPosition(A) + Vector(0, 400, 0), nil)
		EmitSoundOnLocationWithCaster(B, "Hero_Wisp.TeleportOut.Arc", z.hero)
		local y = ParticleManager:CreateParticle(
			"particles/econ/items/wisp/wisp_relocate_marker_ti7_endpoint.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(y, 0, B)
		local E = self.particleIDList
		E[#E + 1] = y
	end)
	self:StartIntervalThink(1)
end
p = f(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	p
)
h.modifier_city_18 = p
h.modifier_city_18_buff = c()
local F = h.modifier_city_18_buff
F.name = "modifier_city_18_buff"
d(F, j)
function F.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES] = -CityEffect:GetSpecialValueFor(
		"city_18",
		"reduce"
	) }
end
F = f(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	F
)
h.modifier_city_18_buff = F
return h