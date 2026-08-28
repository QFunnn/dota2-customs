--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
	local r = m.PortraitPosition
	local s = m.PortraitAngles
	local t = m.PortraitFOV
	local u = m.PortraitFar
	if u == nil then
		u = h.cameras.default.PortraitFar
	end
	p(
		q,
		{
			classname = "point_camera",
			targetname = camera,
			origin = r,
			angles = s,
			fov = t,
			ZFar = u,
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
	local v = StringToVector
	local w = j.PortraitSpecularDirection
	if w == nil then
		w = h.PortraitSpecularDirection
	end
	local x = v(w) or vec3_zero
	local y = VectorToAngles(x)
	local z = StringToVector
	local A = j.PortraitAmbientDirection
	if A == nil then
		A = h.PortraitAmbientDirection
	end
	local B = z(A) or vec3_zero
	local C = VectorToAngles(B)
	local D = table.insert
	local E = n
	local F = j.PortraitLightPosition
	if F == nil then
		F = h.PortraitLightPosition
	end
	local G = j.PortraitLightAngles
	if G == nil then
		G = h.PortraitLightAngles
	end
	local H = j.PortraitLightFOV
	if H == nil then
		H = h.PortraitLightFOV
	end
	local I = j.PortraitLightDistance
	if I == nil then
		I = h.PortraitLightDistance
	end
	local J = j.PortraitLightColor
	if J == nil then
		J = h.PortraitLightColor
	end
	local K = j.PortraitShadowColor
	if K == nil then
		K = h.PortraitShadowColor
	end
	local L = j.PortraitShadowScale
	if L == nil then
		L = h.PortraitShadowScale
	end
	local M = j.PortraitAmbientColor
	if M == nil then
		M = h.PortraitAmbientColor
	end
	local N = j.PortraitAmbientScale
	if N == nil then
		N = h.PortraitAmbientScale
	end
	local O = j.PortraitSpecularColor
	if O == nil then
		O = h.PortraitSpecularColor
	end
	local P = j.PortraitSpecularPower
	if P == nil then
		P = h.PortraitSpecularPower
	end
	local Q = y
	local R = j.PortraitLightScale
	if R == nil then
		R = h.PortraitLightScale
	end
	local S = j.PortraitGroundShadowScale
	if S == nil then
		S = h.PortraitGroundShadowScale
	end
	D(
		E,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = F,
			angles = G,
			fov = H,
			nearz = I,
			Color = J,
			ambientcolor2 = K,
			ambientscale2 = L,
			ambientcolor1 = M,
			ambientscale1 = N,
			specularcolor = O,
			specularpower = P,
			specularangles = Q,
			lightscale = R,
			groundscale = S,
			ambientangles = C,
		}
	)
	SpawnEntityListFromTableSynchronous(n)
end