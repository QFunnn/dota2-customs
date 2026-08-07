--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/courier"
data = Client:GetSceneEntityData("courier")
local b = tostring
local c = data and data.id
if c == nil then
	c = ""
end
courierID = b(c)
scale = toFiniteNumber(data and data.scale, 1)
camera = "camera_1"
function Spawn(self, d)
	local e = KeyValues.units[courierID]
	if e == nil then
		return
	end
	local f = e.Model
	local g = KeyValues.portrait_full_body_loadout.default_courier
	local h = KeyValues.portrait_full_body_loadout[f]
	if h == nil then
		h = g
	end
	local i = h
	if i == nil then
		return
	end
	local j = i.cameras[camera]
	if j == nil then
		j = i.cameras.default
	end
	local k = j
	if k == nil then
		k = i.cameras.Default
	end
	local l = k
	if not l then
		return
	end
	local m = {}
	local n = {
		parentname = "root",
		targetname = "courier",
		classname = "prop_dynamic",
		origin = "0 0 0",
		angles = "0 0 0",
		scales = (((tostring(scale) .. " ") .. tostring(scale)) .. " ") .. tostring(scale),
		model = f,
		rendertocubemaps = "1",
		lightmapstatic = "1",
		skin = tostring(e.Skin),
		add_modifier = "",
		StartingAnim = "ACT_DOTA_IDLE",
		StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
	}
	table.insert(m, n)
	local o = table.insert
	local p = m
	local q = l.PortraitPosition
	local r = l.PortraitAngles
	local s = l.PortraitFOV
	local t = l.PortraitFar
	if t == nil then
		t = g.cameras.default.PortraitFar
	end
	o(
		p,
		{
			classname = "point_camera",
			targetname = camera,
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
	local v = i.PortraitSpecularDirection
	if v == nil then
		v = g.PortraitSpecularDirection
	end
	local w = u(v) or vec3_zero
	local x = VectorToAngles(w)
	local y = StringToVector
	local z = i.PortraitAmbientDirection
	if z == nil then
		z = g.PortraitAmbientDirection
	end
	local A = y(z) or vec3_zero
	local B = VectorToAngles(A)
	local C = table.insert
	local D = m
	local E = i.PortraitLightPosition
	if E == nil then
		E = g.PortraitLightPosition
	end
	local F = i.PortraitLightAngles
	if F == nil then
		F = g.PortraitLightAngles
	end
	local G = i.PortraitLightFOV
	if G == nil then
		G = g.PortraitLightFOV
	end
	local H = i.PortraitLightDistance
	if H == nil then
		H = g.PortraitLightDistance
	end
	local I = i.PortraitLightColor
	if I == nil then
		I = g.PortraitLightColor
	end
	local J = i.PortraitShadowColor
	if J == nil then
		J = g.PortraitShadowColor
	end
	local K = i.PortraitShadowScale
	if K == nil then
		K = g.PortraitShadowScale
	end
	local L = i.PortraitAmbientColor
	if L == nil then
		L = g.PortraitAmbientColor
	end
	local M = i.PortraitAmbientScale
	if M == nil then
		M = g.PortraitAmbientScale
	end
	local N = i.PortraitSpecularColor
	if N == nil then
		N = g.PortraitSpecularColor
	end
	local O = i.PortraitSpecularPower
	if O == nil then
		O = g.PortraitSpecularPower
	end
	local P = x
	local Q = i.PortraitLightScale
	if Q == nil then
		Q = g.PortraitLightScale
	end
	local R = i.PortraitGroundShadowScale
	if R == nil then
		R = g.PortraitGroundShadowScale
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
	SpawnEntityListFromTableSynchronous(m)
end