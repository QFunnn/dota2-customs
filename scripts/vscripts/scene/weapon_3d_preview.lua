--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/weapon_3d_preview"
data = Client:GetSceneEntityData("weapon_3d_preview")
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
	local e = KeyValues.portraits_weapon[default_config]
	if e == nil then
		e = KeyValues.portraits_weapon.default
	end
	local f = e
	local g = KeyValues.portraits_weapon[model]
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
		StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		add_modifier = "",
	}
	table.insert(l, m)
	local n = table.insert
	local o = l
	local p = camera
	local q = k.PortraitPosition
	local r = k.PortraitAngles
	local s = k.PortraitFOV
	local t = k.PortraitFar
	if t == nil then
		t = f.cameras.default.PortraitFar
	end
	n(
		o,
		{
			classname = "point_camera",
			targetname = p,
			origin = q,
			angles = r,
			fov = s,
			ZFar = t,
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
	local u = StringToVector
	local v = h.PortraitSpecularDirection
	if v == nil then
		v = f.PortraitSpecularDirection
	end
	local w = u(v) or vec3_zero
	local x = VectorToAngles(w)
	local y = StringToVector
	local z = h.PortraitAmbientDirection
	if z == nil then
		z = f.PortraitAmbientDirection
	end
	local A = y(z) or vec3_zero
	local B = VectorToAngles(A)
	local C = table.insert
	local D = l
	local E = h.PortraitLightPosition
	if E == nil then
		E = f.PortraitLightPosition
	end
	local F = h.PortraitLightAngles
	if F == nil then
		F = f.PortraitLightAngles
	end
	local G = h.PortraitLightFOV
	if G == nil then
		G = f.PortraitLightFOV
	end
	local H = h.PortraitLightDistance
	if H == nil then
		H = f.PortraitLightDistance
	end
	local I = h.PortraitLightColor
	if I == nil then
		I = f.PortraitLightColor
	end
	local J = h.PortraitShadowColor
	if J == nil then
		J = f.PortraitShadowColor
	end
	local K = h.PortraitShadowScale
	if K == nil then
		K = f.PortraitShadowScale
	end
	local L = h.PortraitAmbientColor
	if L == nil then
		L = f.PortraitAmbientColor
	end
	local M = h.PortraitAmbientScale
	if M == nil then
		M = f.PortraitAmbientScale
	end
	local N = h.PortraitSpecularColor
	if N == nil then
		N = f.PortraitSpecularColor
	end
	local O = h.PortraitSpecularPower
	if O == nil then
		O = f.PortraitSpecularPower
	end
	local P = x
	local Q = h.PortraitLightScale
	if Q == nil then
		Q = f.PortraitLightScale
	end
	local R = h.PortraitGroundShadowScale
	if R == nil then
		R = f.PortraitGroundShadowScale
	end
	C(
		D,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = E,
			angles = F,
			fov = G,
			nearz = H,
			Color = I,
			ambientcolor2 = J,
			ambientscale2 = K,
			ambientcolor1 = L,
			ambientscale1 = M,
			specularcolor = N,
			specularpower = O,
			specularangles = P,
			lightscale = Q,
			groundscale = R,
			ambientangles = B,
		}
	)
	SpawnEntityListFromTableSynchronous(l)
end