--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "scene/fish_rod_preview"
data = Client:GetSceneEntityData("fish_rod_preview")
local b = data and data.model
if b == nil then
	b = ""
end
model = b
local c = data and data.default_config
if c == nil then
	c = ""
end
default_config = c
camera = "camera_1"
function Spawn(self, d)
	local e = KeyValues.portraits_pod[default_config]
	if e == nil then
		e = KeyValues.portraits_pod.default
	end
	local f = e
	local g = KeyValues.portraits_pod[model]
	if g == nil then
		g = f
	end
	local h = g
	if h == nil then
		return
	end
	local i = h.cameras[camera]
	if i == nil then
		i = h.cameras.default
	end
	local j = i
	if j == nil then
		j = h.cameras.Default
	end
	local k = j
	if not k then
		return
	end
	local l = {}
	local m = {
		parentname = "root",
		classname = "prop_dynamic",
		origin = "0 0 0",
		angles = "0 0 0",
		scales = "1 1 1",
		model = model,
		StartingAnim = "ACT_DOTA_LOADOUT",
		add_modifier = "",
	}
	table.insert(l, m)
	local n = table.insert
	local o = l
	local p = k.PortraitPosition
	local q = k.PortraitAngles
	local r = k.PortraitFOV
	local s = k.PortraitFar
	if s == nil then
		s = f.cameras.default.PortraitFar
	end
	n(
		o,
		{
			classname = "point_camera",
			targetname = camera,
			origin = p,
			angles = q,
			fov = r,
			ZFar = s,
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
	local t = StringToVector
	local u = h.PortraitSpecularDirection
	if u == nil then
		u = f.PortraitSpecularDirection
	end
	local v = t(u) or vec3_zero
	local w = VectorToAngles(v)
	local x = StringToVector
	local y = h.PortraitAmbientDirection
	if y == nil then
		y = f.PortraitAmbientDirection
	end
	local z = x(y) or vec3_zero
	local A = VectorToAngles(z)
	local B = table.insert
	local C = l
	local D = h.PortraitLightPosition
	if D == nil then
		D = f.PortraitLightPosition
	end
	local E = h.PortraitLightAngles
	if E == nil then
		E = f.PortraitLightAngles
	end
	local F = h.PortraitLightFOV
	if F == nil then
		F = f.PortraitLightFOV
	end
	local G = h.PortraitLightDistance
	if G == nil then
		G = f.PortraitLightDistance
	end
	local H = h.PortraitLightColor
	if H == nil then
		H = f.PortraitLightColor
	end
	local I = h.PortraitShadowColor
	if I == nil then
		I = f.PortraitShadowColor
	end
	local J = h.PortraitShadowScale
	if J == nil then
		J = f.PortraitShadowScale
	end
	local K = h.PortraitAmbientColor
	if K == nil then
		K = f.PortraitAmbientColor
	end
	local L = h.PortraitAmbientScale
	if L == nil then
		L = f.PortraitAmbientScale
	end
	local M = h.PortraitSpecularColor
	if M == nil then
		M = f.PortraitSpecularColor
	end
	local N = h.PortraitSpecularPower
	if N == nil then
		N = f.PortraitSpecularPower
	end
	local O = w
	local P = h.PortraitLightScale
	if P == nil then
		P = f.PortraitLightScale
	end
	local Q = h.PortraitGroundShadowScale
	if Q == nil then
		Q = f.PortraitGroundShadowScale
	end
	B(
		C,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = D,
			angles = E,
			fov = F,
			nearz = G,
			Color = H,
			ambientcolor2 = I,
			ambientscale2 = J,
			ambientcolor1 = K,
			ambientscale1 = L,
			specularcolor = M,
			specularpower = N,
			specularangles = O,
			lightscale = P,
			groundscale = Q,
			ambientangles = A,
		}
	)
	SpawnEntityListFromTableSynchronous(l)
end