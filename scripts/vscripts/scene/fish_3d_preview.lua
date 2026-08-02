--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/fish_3d_preview"
data = Client:GetSceneEntityData("fish_3d_preview")
local b = data and data.fishID
if b == nil then
	b = ""
end
fishID = b
local c = KeyValues.collection[fishID]
if c ~= nil then
	c = c.model
end
local d = c
if d == nil then
	d = ""
end
model = d
local e = data and data.default_config
if e == nil then
	e = ""
end
default_config = e
camera = "camera_1"
function Spawn(self, f)
	local g = KeyValues.portraits_fish[default_config]
	if g == nil then
		g = KeyValues.portraits_fish.default
	end
	local h = g
	local i = KeyValues.portraits_fish[model]
	if i == nil then
		i = h
	end
	local j = i
	if j == nil then
		return
	end
	local k = j.cameras[camera]
	if k == nil then
		k = j.cameras.default
	end
	local l = k
	if l == nil then
		l = j.cameras.Default
	end
	local m = l
	if not m then
		return
	end
	local n = {}
	local o = {
		parentname = "root",
		classname = "prop_dynamic",
		origin = "0 0 0",
		angles = "0 0 0",
		scales = "1 1 1",
		model = model,
		StartingAnim = "ACT_DOTA_LOADOUT",
		add_modifier = "",
	}
	table.insert(n, o)
	local p = table.insert
	local q = n
	local r = camera
	local s = m.PortraitPosition
	local t = m.PortraitAngles
	local u = m.PortraitFOV
	local v = m.PortraitFar
	if v == nil then
		v = h.cameras.default.PortraitFar
	end
	p(
		q,
		{
			classname = "point_camera",
			targetname = r,
			origin = s,
			angles = t,
			fov = u,
			ZFar = v,
			ZNear = 4,
			UseScreenAspectRatio = 0,
			aspectRatio = 0,
			fogEnable = 0,
			fogColor = "0 0 0",
			fogStart = 2048,
			fogEnd = 4096,
			fogMaxDensity = 1,
			rendercolor = "128 128 128",
			override_shadow_farz = 0,
			dof_enabled = 0,
			dof_near_blurry = 250,
			dof_near_crisp = 550,
			dac_dof_far_crisp = 1200,
			dac_dof_far_blurry = 1600,
			dac_dof_tilt_to_ground = 0.75,
		}
	)
	local w = StringToVector
	local x = j.PortraitSpecularDirection
	if x == nil then
		x = h.PortraitSpecularDirection
	end
	local y = w(x) or vec3_zero
	local z = VectorToAngles(y)
	local A = StringToVector
	local B = j.PortraitAmbientDirection
	if B == nil then
		B = h.PortraitAmbientDirection
	end
	local C = A(B) or vec3_zero
	local D = VectorToAngles(C)
	local E = table.insert
	local F = n
	local G = j.PortraitLightPosition
	if G == nil then
		G = h.PortraitLightPosition
	end
	local H = j.PortraitLightAngles
	if H == nil then
		H = h.PortraitLightAngles
	end
	local I = j.PortraitLightFOV
	if I == nil then
		I = h.PortraitLightFOV
	end
	local J = j.PortraitLightDistance
	if J == nil then
		J = h.PortraitLightDistance
	end
	local K = j.PortraitLightColor
	if K == nil then
		K = h.PortraitLightColor
	end
	local L = j.PortraitShadowColor
	if L == nil then
		L = h.PortraitShadowColor
	end
	local M = j.PortraitShadowScale
	if M == nil then
		M = h.PortraitShadowScale
	end
	local N = j.PortraitAmbientColor
	if N == nil then
		N = h.PortraitAmbientColor
	end
	local O = j.PortraitAmbientScale
	if O == nil then
		O = h.PortraitAmbientScale
	end
	local P = j.PortraitSpecularColor
	if P == nil then
		P = h.PortraitSpecularColor
	end
	local Q = j.PortraitSpecularPower
	if Q == nil then
		Q = h.PortraitSpecularPower
	end
	local R = z
	local S = j.PortraitLightScale
	if S == nil then
		S = h.PortraitLightScale
	end
	local T = j.PortraitGroundShadowScale
	if T == nil then
		T = h.PortraitGroundShadowScale
	end
	E(
		F,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = G,
			angles = H,
			fov = I,
			nearz = J,
			Color = K,
			ambientcolor2 = L,
			ambientscale2 = M,
			ambientcolor1 = N,
			ambientscale1 = O,
			specularcolor = P,
			specularpower = Q,
			specularangles = R,
			lightscale = S,
			groundscale = T,
			ambientangles = D,
		}
	)
	SpawnEntityListFromTableSynchronous(n)
end