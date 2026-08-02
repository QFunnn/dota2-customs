--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/courier"
data = Client:GetSceneEntityData("courier")
courierID = tostring(data and data.id or "")
scale = toFiniteNumber(data and data.scale, 1)
camera = "camera_1"
function Spawn(self, b)
	local c = KeyValues.units[courierID]
	if c == nil then
		return
	end
	local d = c.Model
	local e = KeyValues.portrait_full_body_loadout.default_courier
	local f = KeyValues.portrait_full_body_loadout[d]
	if f == nil then
		f = e
	end
	local g = f
	if g == nil then
		return
	end
	local h = g.cameras[camera]
	if h == nil then
		h = g.cameras.default
	end
	local i = h
	if i == nil then
		i = g.cameras.Default
	end
	local j = i
	if not j then
		return
	end
	local k = {}
	local l = {
		parentname = "root",
		targetname = "courier",
		classname = "prop_dynamic",
		origin = "0 0 0",
		angles = "0 0 0",
		scales = (((tostring(scale) .. " ") .. tostring(scale)) .. " ") .. tostring(scale),
		model = d,
		rendertocubemaps = "1",
		lightmapstatic = "1",
		skin = tostring(c.Skin),
		add_modifier = "",
		StartingAnim = "ACT_DOTA_IDLE",
		StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
	}
	table.insert(k, l)
	local m = table.insert
	local n = k
	local o = camera
	local p = j.PortraitPosition
	local q = j.PortraitAngles
	local r = j.PortraitFOV
	local s = j.PortraitFar
	if s == nil then
		s = e.cameras.default.PortraitFar
	end
	m(
		n,
		{
			classname = "point_camera",
			targetname = o,
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
	local u = g.PortraitSpecularDirection
	if u == nil then
		u = e.PortraitSpecularDirection
	end
	local v = t(u) or vec3_zero
	local w = VectorToAngles(v)
	local x = StringToVector
	local y = g.PortraitAmbientDirection
	if y == nil then
		y = e.PortraitAmbientDirection
	end
	local z = x(y) or vec3_zero
	local A = VectorToAngles(z)
	local B = table.insert
	local C = k
	local D = g.PortraitLightPosition
	if D == nil then
		D = e.PortraitLightPosition
	end
	local E = g.PortraitLightAngles
	if E == nil then
		E = e.PortraitLightAngles
	end
	local F = g.PortraitLightFOV
	if F == nil then
		F = e.PortraitLightFOV
	end
	local G = g.PortraitLightDistance
	if G == nil then
		G = e.PortraitLightDistance
	end
	local H = g.PortraitLightColor
	if H == nil then
		H = e.PortraitLightColor
	end
	local I = g.PortraitShadowColor
	if I == nil then
		I = e.PortraitShadowColor
	end
	local J = g.PortraitShadowScale
	if J == nil then
		J = e.PortraitShadowScale
	end
	local K = g.PortraitAmbientColor
	if K == nil then
		K = e.PortraitAmbientColor
	end
	local L = g.PortraitAmbientScale
	if L == nil then
		L = e.PortraitAmbientScale
	end
	local M = g.PortraitSpecularColor
	if M == nil then
		M = e.PortraitSpecularColor
	end
	local N = g.PortraitSpecularPower
	if N == nil then
		N = e.PortraitSpecularPower
	end
	local O = w
	local P = g.PortraitLightScale
	if P == nil then
		P = e.PortraitLightScale
	end
	local Q = g.PortraitGroundShadowScale
	if Q == nil then
		Q = e.PortraitGroundShadowScale
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
	SpawnEntityListFromTableSynchronous(k)
end