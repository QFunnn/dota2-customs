--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/portraits_full_body_loadout"
local b = require("lualib_bundle")
local c = b.__TS__ObjectKeys
local d = b.__TS__ArraySort
data = Client:GetSceneEntityData("portraits_full_body_loadout")
local e = data and data.unitname
if e == nil then
	e = ""
end
unitName = e
camera = data and data.camera or "camera_1"
function Spawn(self, f)
	local g = KeyValues.units[unitName] ~= nil
	local h = KeyValues.heroes[unitName] ~= nil
	local i = KeyValues.units[unitName]
	if i == nil then
		i = KeyValues.heroes[unitName]
	end
	local j = i
	if j == nil then
		return
	end
	if g == false and h == false then
		return
	end
	local k = KeyValues.portrait_full_body_loadout.default_entity_replacement
	local l = KeyValues.portrait_full_body_loadout[unitName]
	if l == nil then
		l = k
	end
	local m = l
	if m == nil then
		return
	end
	local n = m.cameras[camera]
	if n == nil then
		n = m.cameras.default
	end
	local o = n
	if o == nil then
		o = m.cameras.Default
	end
	local p = o
	if not p then
		return
	end
	if j.Model2D == nil and j.Model == nil then
		return
	end
	local q = {}
	local r = j.Model2D
	if r == nil then
		r = j.Model
	end
	local s = {
		parentname = "root",
		classname = "prop_dynamic",
		origin = "0 0 0",
		angles = "0 0 0",
		scales = "1 1 1",
		model = r,
		StartingAnim = KeyValues.portrait_full_body_loadout.DefaultActivity,
		add_modifier = "",
	}
	if g then
		s = {
			parentname = "root",
			classname = "portrait_world_unit",
			origin = "0 0 0",
			angles = "0 0 0",
			scales = "1 1 1",
			model = j.Model,
			EnableAutoStyles = 0,
			suppress_intro_effects = 1,
			spawn_background_models = 0,
			rare_loadout_anim_chance = -1,
			suppress_anim_event_sounds = 0,
			skip_pet_spawn = 0,
			flying_courier = 0,
			spawn_wearable_item_defs = 1,
			activity = "ACT_DOTA_CAPTURE",
			activity_modifier = "",
			item_def0 = 0,
			style_index0 = 0,
			item_def1 = 0,
			style_index1 = 0,
			item_def2 = 0,
			style_index2 = 0,
			item_def3 = 0,
			style_index3 = 0,
			item_def4 = 0,
			style_index4 = 0,
			item_def5 = 0,
			style_index5 = 0,
			item_def6 = 0,
			style_index6 = 0,
			item_def7 = 0,
			style_index7 = 0,
			rendercolor = "255 255 255",
		}
		local t
		if j ~= nil then
			t = j.Creature
		end
		local u
		if t ~= nil then
			u = t.AttachWearables
		end
		local v = u
		if v ~= nil then
			local w = c(v)
			d(w, function(x, y, z)
				local A = toFiniteNumber(y, 0)
				local B = toFiniteNumber(z, 0)
				return A - B
			end)
			local C = 0
			do
				local D = 0
				while D < #w do
					do
						local E = v[w[D + 1]]
						if E == nil then
							goto F
						end
						local G = E.ItemDef
						if G == nil or G == "" then
							goto F
						end
						s["item_def" .. tostring(C)] = tostring(G)
						C = C + 1
					end
					::F::
					D = D + 1
				end
			end
		end
	end
	table.insert(q, s)
	local H = table.insert
	local I = q
	local J = camera
	local K = p.PortraitPosition
	local L = p.PortraitAngles
	local M = p.PortraitFOV
	local N = p.PortraitFar
	if N == nil then
		N = k.cameras.default.PortraitFar
	end
	H(
		I,
		{
			classname = "point_camera",
			targetname = J,
			origin = K,
			angles = L,
			fov = M,
			ZFar = N,
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
	local O = StringToVector
	local P = m.PortraitSpecularDirection
	if P == nil then
		P = k.PortraitSpecularDirection
	end
	local Q = O(P) or vec3_zero
	local R = VectorToAngles(Q)
	local S = StringToVector
	local T = m.PortraitAmbientDirection
	if T == nil then
		T = k.PortraitAmbientDirection
	end
	local U = S(T) or vec3_zero
	local V = VectorToAngles(U)
	local W = table.insert
	local X = q
	local Y = m.PortraitLightPosition
	if Y == nil then
		Y = k.PortraitLightPosition
	end
	local Z = m.PortraitLightAngles
	if Z == nil then
		Z = k.PortraitLightAngles
	end
	local _ = m.PortraitLightFOV
	if _ == nil then
		_ = k.PortraitLightFOV
	end
	local a0 = m.PortraitLightDistance
	if a0 == nil then
		a0 = k.PortraitLightDistance
	end
	local a1 = m.PortraitLightColor
	if a1 == nil then
		a1 = k.PortraitLightColor
	end
	local a2 = m.PortraitShadowColor
	if a2 == nil then
		a2 = k.PortraitShadowColor
	end
	local a3 = m.PortraitShadowScale
	if a3 == nil then
		a3 = k.PortraitShadowScale
	end
	local a4 = m.PortraitAmbientColor
	if a4 == nil then
		a4 = k.PortraitAmbientColor
	end
	local a5 = m.PortraitAmbientScale
	if a5 == nil then
		a5 = k.PortraitAmbientScale
	end
	local a6 = m.PortraitSpecularColor
	if a6 == nil then
		a6 = k.PortraitSpecularColor
	end
	local a7 = m.PortraitSpecularPower
	if a7 == nil then
		a7 = k.PortraitSpecularPower
	end
	local a8 = R
	local a9 = m.PortraitLightScale
	if a9 == nil then
		a9 = k.PortraitLightScale
	end
	local aa = m.PortraitGroundShadowScale
	if aa == nil then
		aa = k.PortraitGroundShadowScale
	end
	W(
		X,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = Y,
			angles = Z,
			fov = _,
			nearz = a0,
			Color = a1,
			ambientcolor2 = a2,
			ambientscale2 = a3,
			ambientcolor1 = a4,
			ambientscale1 = a5,
			specularcolor = a6,
			specularpower = a7,
			specularangles = a8,
			lightscale = a9,
			groundscale = aa,
			ambientangles = V,
		}
	)
	SpawnEntityListFromTableSynchronous(q)
end