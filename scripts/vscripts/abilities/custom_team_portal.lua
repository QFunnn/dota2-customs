--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/custom_team_portal"
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
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 19,
		["16"] = 20,
		["17"] = 20,
		["18"] = 20,
		["19"] = 20,
		["20"] = 24,
		["21"] = 25,
		["22"] = 24,
		["23"] = 25,
		["25"] = 25,
		["26"] = 26,
		["27"] = 24,
		["28"] = 32,
		["29"] = 33,
		["30"] = 32,
		["31"] = 25,
		["32"] = 24,
		["33"] = 25,
		["35"] = 25,
		["36"] = 39,
		["37"] = 46,
		["38"] = 39,
		["39"] = 46,
		["41"] = 46,
		["42"] = 49,
		["43"] = 50,
		["44"] = 51,
		["45"] = 52,
		["46"] = 39,
		["47"] = 55,
		["48"] = 56,
		["49"] = 55,
		["50"] = 60,
		["51"] = 60,
		["52"] = 60,
		["54"] = 61,
		["55"] = 62,
		["56"] = 63,
		["58"] = 60,
		["59"] = 68,
		["60"] = 69,
		["61"] = 70,
		["62"] = 70,
		["63"] = 70,
		["64"] = 70,
		["65"] = 70,
		["66"] = 70,
		["67"] = 70,
		["68"] = 70,
		["69"] = 70,
		["70"] = 71,
		["71"] = 71,
		["72"] = 71,
		["73"] = 71,
		["74"] = 71,
		["75"] = 71,
		["76"] = 71,
		["77"] = 71,
		["78"] = 71,
		["79"] = 72,
		["80"] = 72,
		["81"] = 72,
		["82"] = 72,
		["83"] = 72,
		["84"] = 72,
		["85"] = 72,
		["86"] = 72,
		["87"] = 72,
		["88"] = 73,
		["89"] = 74,
		["90"] = 74,
		["91"] = 74,
		["92"] = 74,
		["93"] = 74,
		["95"] = 76,
		["96"] = 68,
		["97"] = 79,
		["98"] = 80,
		["99"] = 81,
		["101"] = 79,
		["102"] = 85,
		["103"] = 86,
		["104"] = 87,
		["105"] = 88,
		["107"] = 85,
		["108"] = 92,
		["109"] = 93,
		["112"] = 95,
		["113"] = 96,
		["116"] = 98,
		["117"] = 99,
		["118"] = 100,
		["119"] = 102,
		["120"] = 103,
		["121"] = 106,
		["122"] = 107,
		["123"] = 108,
		["125"] = 112,
		["126"] = 113,
		["127"] = 115,
		["128"] = 116,
		["129"] = 117,
		["130"] = 117,
		["131"] = 117,
		["132"] = 117,
		["133"] = 117,
		["134"] = 117,
		["135"] = 117,
		["136"] = 117,
		["137"] = 117,
		["139"] = 121,
		["140"] = 92,
		["141"] = 124,
		["142"] = 125,
		["143"] = 124,
		["144"] = 133,
		["145"] = 134,
		["146"] = 133,
		["147"] = 137,
		["148"] = 138,
		["149"] = 139,
		["151"] = 141,
		["152"] = 137,
		["153"] = 146,
		["154"] = 146,
		["155"] = 146,
		["157"] = 147,
		["158"] = 146,
		["159"] = 153,
		["160"] = 153,
		["161"] = 153,
		["163"] = 154,
		["164"] = 153,
		["165"] = 157,
		["166"] = 159,
		["167"] = 159,
		["168"] = 159,
		["169"] = 159,
		["170"] = 160,
		["171"] = 157,
		["172"] = 164,
		["173"] = 165,
		["174"] = 166,
		["175"] = 166,
		["177"] = 167,
		["178"] = 168,
		["179"] = 169,
		["181"] = 171,
		["182"] = 172,
		["183"] = 172,
		["184"] = 172,
		["186"] = 172,
		["188"] = 172,
		["189"] = 173,
		["190"] = 174,
		["192"] = 176,
		["193"] = 177,
		["195"] = 179,
		["197"] = 181,
		["198"] = 182,
		["199"] = 183,
		["200"] = 164,
		["201"] = 187,
		["202"] = 188,
		["203"] = 189,
		["206"] = 192,
		["209"] = 193,
		["210"] = 194,
		["211"] = 195,
		["212"] = 196,
		["213"] = 197,
		["214"] = 198,
		["215"] = 199,
		["216"] = 200,
		["217"] = 201,
		["219"] = 203,
		["221"] = 205,
		["222"] = 206,
		["223"] = 206,
		["224"] = 206,
		["225"] = 206,
		["226"] = 206,
		["227"] = 207,
		["228"] = 208,
		["229"] = 209,
		["230"] = 210,
		["231"] = 211,
		["232"] = 212,
		["233"] = 213,
		["235"] = 215,
		["237"] = 217,
		["238"] = 218,
		["239"] = 218,
		["240"] = 218,
		["241"] = 219,
		["242"] = 220,
		["243"] = 221,
		["244"] = 222,
		["245"] = 222,
		["246"] = 222,
		["247"] = 222,
		["248"] = 222,
		["249"] = 222,
		["250"] = 222,
		["251"] = 223,
		["252"] = 224,
		["254"] = 226,
		["256"] = 228,
		["257"] = 229,
		["258"] = 230,
		["260"] = 232,
		["261"] = 233,
		["262"] = 234,
		["263"] = 235,
		["264"] = 236,
		["266"] = 238,
		["268"] = 240,
		["271"] = 218,
		["272"] = 218,
		["273"] = 187,
		["274"] = 247,
		["275"] = 248,
		["278"] = 249,
		["279"] = 250,
		["280"] = 250,
		["281"] = 250,
		["282"] = 250,
		["283"] = 250,
		["284"] = 250,
		["285"] = 250,
		["286"] = 250,
		["287"] = 250,
		["288"] = 251,
		["289"] = 252,
		["290"] = 253,
		["291"] = 247,
		["292"] = 46,
		["293"] = 39,
		["294"] = 39,
		["295"] = 39,
		["296"] = 39,
		["297"] = 39,
		["298"] = 39,
		["299"] = 39,
		["300"] = 46,
		["302"] = 46,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = {
	[TEAM_PORTAL_STATE.ENABLE] = {
		ambient = "particles/base_static/team_portal_ambient.vpcf",
		activate = "particles/base_static/team_portal_active.vpcf",
		sequence = "team_portal_idle_reverse",
		skin = 0,
	},
	[TEAM_PORTAL_STATE.DISABLE] = {
		ambient = "particles/base_static/team_portal_ambient.vpcf",
		activate = "particles/base_static/team_portal_dire_active.vpcf",
		sequence = "team_portal_idle_reverse",
		skin = 1,
	},
}
local o = "particles/gameplay/custom_team_bless_light.vpcf"
local p = { equipment = Vector(255, 150, 100), ability = Vector(50, 200, 255) }
g.custom_team_portal = c()
local q = g.custom_team_portal
q.name = "custom_team_portal"
d(q, i)
function q.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.state_now = TEAM_PORTAL_STATE.ENABLE
end
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_custom_team_portal"
end
q = e({ j(nil) }, q)
g.custom_team_portal = q
g.modifier_custom_team_portal = c()
local r = g.modifier_custom_team_portal
r.name = "modifier_custom_team_portal"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.active_cd = false
	self.visible = true
	self.newVisible = true
	self.visibleChanging = false
end
function r.prototype.BuildStack(self, s, t)
	return s + (t and TEAM_PORTAL_STATE.ACTIVATE or 0)
end
function r.prototype.DestroyParticle(self, u, v)
	if v == nil then
		v = true
	end
	if u ~= nil then
		ParticleManager:DestroyParticle(u, v)
		ParticleManager:ReleaseParticleIndex(u)
	end
end
function r.prototype.CreatePortalParticle(self, w, s)
	local x = ParticleManager:CreateParticle(w, PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(
		x,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_portal",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		x,
		2,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_portal_reverse",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		x,
		3,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_portal",
		self.parent:GetAbsOrigin(),
		true
	)
	if s == TEAM_PORTAL_STATE.DISABLE then
		ParticleManager:SetParticleControl(x, 12, Vector(1, 0, 0))
	end
	return x
end
function r.prototype.OnCreated(self, y)
	if IsServer() then
		self:OnStackCountChanged()
	end
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		self.active_cd = false
		self:StartIntervalThink(-1)
	end
end
function r.prototype.OnStackCountChanged(self, z)
	if not IsServer() then
		return
	end
	local A = self:GetStackCount()
	if z == A then
		return
	end
	local B = z ~= nil and self:GetPortalState(z) or TEAM_PORTAL_STATE.DISABLE
	local C = self:GetPortalState(A)
	local D = self:IsPortalActivated(A)
	local E = n[B]
	local F = n[C]
	if B ~= C then
		self:DestroyParticle(self.ambient_id)
		self.ambient_id = self:CreatePortalParticle(F.ambient, C)
	end
	self:DestroyParticle(self.activating_id, false)
	self.activating_id = nil
	if D and F.activate then
		self.activating_id = ParticleManager:CreateParticle(F.activate, PATTACH_CUSTOMORIGIN, self.parent)
		ParticleManager:SetParticleControlEnt(
			self.activating_id,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_portal",
			self.parent:GetAbsOrigin(),
			true
		)
	end
	self.parent:SetSkin(F.skin)
end
function r.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function r.prototype.GetOverrideAnimation(self)
	if self:IsPortalActivated() then
		return ACT_DOTA_CHANNEL_ABILITY_1
	end
	return ACT_DOTA_IDLE
end
function r.prototype.GetPortalState(self, G)
	if G == nil then
		G = self:GetStackCount()
	end
	return bit.band(G, TEAM_PORTAL_STATE.DISABLE) == TEAM_PORTAL_STATE.DISABLE and TEAM_PORTAL_STATE.DISABLE
		or TEAM_PORTAL_STATE.ENABLE
end
function r.prototype.IsPortalActivated(self, G)
	if G == nil then
		G = self:GetStackCount()
	end
	return bit.band(G, TEAM_PORTAL_STATE.ACTIVATE) == TEAM_PORTAL_STATE.ACTIVATE
end
function r.prototype.ChangePortalState(self, C)
	self:SetStackCount(self:BuildStack(C, self:IsPortalActivated(self:GetStackCount())))
	return true
end
function r.prototype.ChangeActiveState(self, H, I)
	local J = self:GetStackCount()
	if not I and self.active_cd then
		return self:IsPortalActivated(J)
	end
	if not I then
		self.active_cd = true
		self:StartIntervalThink(0.2)
	end
	local s = self:GetPortalState(J)
	local K
	if H == nil then
		K = not self:IsPortalActivated(J)
	else
		K = H
	end
	local L = K
	if L == self:IsPortalActivated(J) then
		return L
	end
	if L then
		EmitSoundOn("Hero_Underlord.Portal.Spawn", self.parent)
	else
		StopSoundOn("Hero_Underlord.Portal.Spawn", self.parent)
	end
	local A = self:BuildStack(s, L)
	self:SetStackCount(A)
	return L
end
function r.prototype.SetPortalVisible(self, M)
	if self.visibleChanging then
		self.newVisible = M
		return
	end
	if self.visibleChanging or self.visible == M then
		return
	end
	self.visibleChanging = true
	self.newVisible = M
	self.visible = M
	local N = self.parent:GetAbsOrigin()
	local O = GetGroundPosition(N, self.parent)
	local P = O.z
	if not M then
		N = O
		P = P - 255
	else
		N = Vector(N.x, N.y, P - 255)
	end
	local Q =
		ParticleManager:CreateParticle("particles/gameplay/custom_team_portal_hide.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(Q, 0, GetGroundPosition(N, self.parent))
	local R = N.z
	local S = 0.5
	local T = 0
	local U = self.parent
	local V = self.parent:GetPlayerOwnerID()
	if not M then
		GroupTeam:SetTeamPortalVisible(V, self.visible)
	else
		U:RemoveNoDraw()
	end
	U:EmitSound("Hero_Tinker.Warp.Target")
	GameTimer(FRAME_TIME, function()
		if T < S then
			T = T + FRAME_TIME
			local W = 0
			W = Script_RemapValClamped(T / S, 0, 1, R, P)
			if IsValid(U) then
				U:SetAbsOrigin(Vector(N.x, N.y, W))
			end
			return FRAME_TIME
		else
			if Q then
				ParticleManager:DestroyParticle(Q, false)
				ParticleManager:ReleaseParticleIndex(Q)
			end
			if IsValid(U) then
				U:SetAbsOrigin(Vector(N.x, N.y, P))
				self.visibleChanging = false
				if M then
					GroupTeam:SetTeamPortalVisible(V, M)
				else
					U:AddNoDraw()
				end
				self:SetPortalVisible(self.newVisible)
			end
		end
	end)
end
function r.prototype.PlayBlessEffect(self, X)
	if not self.visible then
		return
	end
	local Q = ParticleManager:CreateParticle(o, PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(
		Q,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_portal",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(Q, 15, p[X])
	ParticleManager:ReleaseParticleIndex(Q)
	self.parent:EmitSound("Hero_Chen.TeleportOut")
end
r = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
g.modifier_custom_team_portal = r
return g