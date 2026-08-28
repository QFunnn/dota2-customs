--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier_public_area"
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
		["12"] = 5,
		["13"] = 13,
		["14"] = 5,
		["15"] = 13,
		["17"] = 13,
		["18"] = 16,
		["19"] = 19,
		["20"] = 21,
		["21"] = 22,
		["22"] = 5,
		["23"] = 28,
		["24"] = 29,
		["25"] = 30,
		["26"] = 31,
		["27"] = 32,
		["28"] = 33,
		["29"] = 34,
		["30"] = 35,
		["31"] = 36,
		["32"] = 37,
		["33"] = 38,
		["35"] = 40,
		["36"] = 41,
		["37"] = 42,
		["38"] = 43,
		["39"] = 44,
		["40"] = 46,
		["41"] = 46,
		["42"] = 46,
		["43"] = 46,
		["44"] = 46,
		["45"] = 47,
		["46"] = 48,
		["47"] = 52,
		["48"] = 53,
		["50"] = 55,
		["52"] = 55,
		["54"] = 55,
		["57"] = 58,
		["59"] = 28,
		["60"] = 62,
		["61"] = 63,
		["62"] = 64,
		["64"] = 62,
		["65"] = 69,
		["66"] = 70,
		["67"] = 71,
		["68"] = 72,
		["71"] = 75,
		["72"] = 76,
		["73"] = 77,
		["74"] = 78,
		["75"] = 79,
		["76"] = 80,
		["77"] = 81,
		["79"] = 83,
		["81"] = 85,
		["82"] = 87,
		["83"] = 87,
		["84"] = 87,
		["85"] = 87,
		["86"] = 87,
		["87"] = 87,
		["88"] = 87,
		["89"] = 87,
		["90"] = 87,
		["91"] = 88,
		["92"] = 88,
		["93"] = 88,
		["94"] = 88,
		["95"] = 88,
		["96"] = 88,
		["97"] = 88,
		["98"] = 88,
		["99"] = 88,
		["100"] = 89,
		["101"] = 89,
		["102"] = 89,
		["103"] = 89,
		["104"] = 89,
		["105"] = 90,
		["106"] = 90,
		["107"] = 90,
		["108"] = 90,
		["109"] = 90,
		["110"] = 91,
		["111"] = 92,
		["112"] = 92,
		["113"] = 92,
		["114"] = 92,
		["115"] = 92,
		["116"] = 92,
		["117"] = 92,
		["118"] = 92,
		["119"] = 93,
		["121"] = 69,
		["122"] = 96,
		["123"] = 97,
		["124"] = 98,
		["125"] = 99,
		["126"] = 100,
		["127"] = 101,
		["128"] = 102,
		["129"] = 103,
		["130"] = 104,
		["131"] = 105,
		["132"] = 106,
		["133"] = 107,
		["135"] = 109,
		["136"] = 110,
		["137"] = 111,
		["138"] = 112,
		["139"] = 113,
		["140"] = 114,
		["141"] = 115,
		["142"] = 116,
		["144"] = 118,
		["145"] = 119,
		["146"] = 120,
		["147"] = 121,
		["149"] = 123,
		["150"] = 124,
		["151"] = 125,
		["152"] = 126,
		["153"] = 127,
		["154"] = 128,
		["155"] = 129,
		["156"] = 130,
		["157"] = 131,
		["158"] = 132,
		["160"] = 132,
		["162"] = 132,
		["163"] = 133,
		["167"] = 96,
		["168"] = 140,
		["169"] = 141,
		["170"] = 143,
		["171"] = 144,
		["172"] = 146,
		["174"] = 148,
		["175"] = 149,
		["176"] = 150,
		["177"] = 151,
		["180"] = 140,
		["181"] = 155,
		["182"] = 156,
		["183"] = 157,
		["184"] = 158,
		["185"] = 159,
		["188"] = 162,
		["189"] = 163,
		["190"] = 164,
		["191"] = 165,
		["192"] = 166,
		["193"] = 167,
		["194"] = 168,
		["195"] = 169,
		["197"] = 171,
		["201"] = 175,
		["204"] = 155,
		["205"] = 179,
		["206"] = 180,
		["207"] = 181,
		["208"] = 182,
		["209"] = 183,
		["212"] = 186,
		["213"] = 187,
		["214"] = 188,
		["215"] = 189,
		["216"] = 190,
		["217"] = 191,
		["218"] = 192,
		["219"] = 193,
		["221"] = 195,
		["222"] = 196,
		["223"] = 196,
		["224"] = 196,
		["225"] = 196,
		["226"] = 196,
		["227"] = 196,
		["228"] = 196,
		["229"] = 196,
		["230"] = 196,
		["234"] = 200,
		["237"] = 179,
		["238"] = 13,
		["239"] = 5,
		["240"] = 5,
		["241"] = 5,
		["242"] = 5,
		["243"] = 5,
		["244"] = 5,
		["245"] = 5,
		["246"] = 5,
		["247"] = 13,
		["249"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_courier_public_area = c()
local k = g.modifier_courier_public_area
k.name = "modifier_courier_public_area"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.willHide = false
	self.distance = 100
	self.inited = false
	self.init_time = 0.05
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		local n = m:GetAbsOrigin()
		self.playerID = m:GetPlayerOwnerID()
		local o = PlayerData:getplayerData(self.playerID)
		if o then
			local p = o.hero
			if p then
				self.hero = p.hero
				self.hero:AddNoDraw()
			end
			local q = EntIndexToHScript(PlayerData.heroShowCameraEnt)
			self.centerPosititon = IsValid(q) and q:GetAbsOrigin() or vec3_zero
			local r = self.centerPosititon - n
			r.z = 0
			m:SetForwardVector(r:Normalized())
			FindClearSpaceForUnit(self.hero, n + r:Normalized() * -self.distance, false)
			self.hero:SetForwardVector(r:Normalized())
			executeOrder(self.hero, DOTA_UNIT_ORDER_MOVE_TO_TARGET, m)
			if IsCompetitionMode(nil) or IsKingsRankMode(nil) then
				self.willHide = true
			else
				local s = o.service_config
				if s ~= nil then
					s = s.hero_show_hidden
				end
				self.willHide = s == "1"
			end
		end
		self:StartIntervalThink(self.init_time)
	end
end
function k.prototype.isHeroWillHide(self)
	local t = GameState:getStateName()
	if t then
	end
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsValid(self.hero) then
			self:Destroy()
			return
		end
		self:StartIntervalThink(-1)
		local m = self:GetParent()
		local n = m:GetAbsOrigin()
		m:RemoveModifierByName("modifier_courier_show")
		self.inited = true
		if self.willHide then
			self:HideHero()
		else
			self:RevealHero(true)
		end
		local u = ParticleManager:CreateParticle("particles/eom/gameplay/generic_lasso.vpcf", PATTACH_CUSTOMORIGIN, m)
		ParticleManager:SetParticleControlEnt(u, 0, m, PATTACH_POINT_FOLLOW, "attach_hitloc", n, true)
		ParticleManager:SetParticleControlEnt(
			u,
			1,
			self.hero,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.hero:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControl(u, 60, Vector(139, 221, 255))
		ParticleManager:SetParticleControl(u, 61, Vector(1, 0, 0))
		self.lassoParticleID = u
		self:AddParticle(u, false, false, -1, false, false)
		executeOrder(self.hero, DOTA_UNIT_ORDER_MOVE_TO_TARGET, m)
	end
end
function k.prototype.OnChangeHeroOrnament(self)
	if IsServer() then
		local o = PlayerData:getplayerData(self.playerID)
		if o then
			local p = o.hero
			if p then
				local m = self:GetParent()
				local v
				local w
				if IsValid(p.hero) then
					v = p.hero:GetAbsOrigin()
					w = p.hero:GetForwardVector()
				else
					local n = m:GetAbsOrigin()
					local q = EntIndexToHScript(PlayerData.heroShowCameraEnt)
					self.centerPosititon = IsValid(q) and q:GetAbsOrigin() or vec3_zero
					local r = n - self.centerPosititon
					r.z = 0
					r = r * -1
					v = n + r:Normalized() * self.distance
					w = r:Normalized()
				end
				if self.lassoParticleID then
					ParticleManager:DestroyParticle(self.lassoParticleID, true)
					ParticleManager:ReleaseParticleIndex(self.lassoParticleID)
					self.lassoParticleID = nil
				end
				p:reset(true, false)
				self.inited = false
				self.isHeroHidden = nil
				self.playerID = m:GetPlayerOwnerID()
				self.hero = p.hero
				self.hero:AddNoDraw()
				FindClearSpaceForUnit(self.hero, v, false)
				self.hero:SetForwardVector(w)
				executeOrder(self.hero, DOTA_UNIT_ORDER_MOVE_TO_TARGET, m)
				local x = o.service_config
				if x ~= nil then
					x = x.hero_show_hidden
				end
				self.willHide = x == "1"
				self:StartIntervalThink(0.2)
			end
		end
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		if IsValid(self.hero) then
			self.hero:RemoveNoDraw()
			self.hero:RemoveModifierByName("modifier_hero_show_proficiency")
		end
		if self.hiddenParticleID then
			ParticleManager:DestroyParticle(self.hiddenParticleID, false)
			ParticleManager:ReleaseParticleIndex(self.hiddenParticleID)
			self.hiddenParticleID = nil
		end
	end
end
function k.prototype.RevealHero(self, y)
	if IsServer() then
		if self.inited then
			if self.isHeroHidden == nil or self.isHeroHidden == true then
				if
					not y
					and (
						GameState:getStateName() ~= "GameState_HeroSelection"
						or IsCompetitionMode(nil)
						or IsKingsRankMode(nil)
					)
				then
					return
				end
				if IsValid(self.hero) then
					self.isHeroHidden = false
					self.hero:RemoveNoDraw()
					self.hero:AddNewModifier(self.hero, nil, "modifier_hero_show_proficiency", {})
					if self.hiddenParticleID then
						ParticleManager:DestroyParticle(self.hiddenParticleID, false)
						ParticleManager:ReleaseParticleIndex(self.hiddenParticleID)
						self.hiddenParticleID = nil
					end
					ParticleManager:CreateParticle(
						"particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_end_core.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						self.hero
					)
				end
			end
		else
			self.willHide = false
		end
	end
end
function k.prototype.HideHero(self)
	if IsServer() then
		if self.inited then
			if self.isHeroHidden == nil or self.isHeroHidden == false then
				if GameState:getStateName() ~= "GameState_HeroSelection" then
					return
				end
				if IsValid(self.hero) then
					self.isHeroHidden = true
					self.hero:AddNoDraw()
					self.hero:RemoveModifierByName("modifier_hero_show_proficiency")
					if self.hiddenParticleID then
						ParticleManager:DestroyParticle(self.hiddenParticleID, false)
						ParticleManager:ReleaseParticleIndex(self.hiddenParticleID)
						self.hiddenParticleID = nil
					end
					self.hiddenParticleID = ParticleManager:CreateParticle(
						"particles/eom/gameplay/bubble_hide_hero.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControlEnt(
						self.hiddenParticleID,
						0,
						self.hero,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						self.hero:GetAbsOrigin(),
						true
					)
				end
			end
		else
			self.willHide = true
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
g.modifier_courier_public_area = k
return g