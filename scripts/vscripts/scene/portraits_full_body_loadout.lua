--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
local f = data and data.camera
if f == nil then
	f = "camera_1"
end
camera = f
function Spawn(self, g)
	local h = KeyValues.units[unitName] ~= nil
	local i = KeyValues.heroes[unitName] ~= nil
	local j = KeyValues.units[unitName]
	if j == nil then
		j = KeyValues.heroes[unitName]
	end
	local k = j
	if k == nil then
		return
	end
	if h == false and i == false then
		return
	end
	local l = KeyValues.portrait_full_body_loadout.default_entity_replacement
	local m = KeyValues.portrait_full_body_loadout[unitName]
	if m == nil then
		m = l
	end
	local n = m
	if n == nil then
		return
	end
	local o = n.cameras[camera]
	if o == nil then
		o = n.cameras.default
	end
	local p = o
	if p == nil then
		p = n.cameras.Default
	end
	local q = p
	if not q then
		return
	end
	if k.Model2D == nil and k.Model == nil then
		return
	end
	local r = {}
	local s = k.Model2D
	if s == nil then
		s = k.Model
	end
	local t = {
		parentname = "root",
		classname = "prop_dynamic",
		origin = "0 0 0",
		angles = "0 0 0",
		scales = "1 1 1",
		model = s,
		StartingAnim = KeyValues.portrait_full_body_loadout.DefaultActivity,
		add_modifier = "",
	}
	if h then
		t = {
			parentname = "root",
			classname = "portrait_world_unit",
			origin = "0 0 0",
			angles = "0 0 0",
			scales = "1 1 1",
			model = k.Model,
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
		local u
		if k ~= nil then
			u = k.Creature
		end
		local v
		if u ~= nil then
			v = u.AttachWearables
		end
		local w = v
		if w ~= nil then
			local x = c(w)
			d(x, function(y, z, A)
				local B = toFiniteNumber(z, 0)
				local C = toFiniteNumber(A, 0)
				return B - C
			end)
			local D = 0
			do
				local E = 0
				while E < #x do
					do
						local F = w[x[E + 1]]
						if F == nil then
							goto G
						end
						local H = F.ItemDef
						if H == nil or H == "" then
							goto G
						end
						t["item_def" .. tostring(D)] = tostring(H)
						D = D + 1
					end
					::G::
					E = E + 1
				end
			end
		end
	end
	table.insert(r, t)
	local I = table.insert
	local J = r
	local K = q.PortraitPosition
	local L = q.PortraitAngles
	local M = q.PortraitFOV
	local N = q.PortraitFar
	if N == nil then
		N = l.cameras.default.PortraitFar
	end
	I(
		J,
		{
			classname = "point_camera",
			targetname = camera,
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
	local P = n.PortraitSpecularDirection
	if P == nil then
		P = l.PortraitSpecularDirection
	end
	local Q = O(P) or vec3_zero
	local R = VectorToAngles(Q)
	local S = StringToVector
	local T = n.PortraitAmbientDirection
	if T == nil then
		T = l.PortraitAmbientDirection
	end
	local U = S(T) or vec3_zero
	local V = VectorToAngles(U)
	local W = table.insert
	local X = r
	local Y = n.PortraitLightPosition
	if Y == nil then
		Y = l.PortraitLightPosition
	end
	local Z = n.PortraitLightAngles
	if Z == nil then
		Z = l.PortraitLightAngles
	end
	local _ = n.PortraitLightFOV
	if _ == nil then
		_ = l.PortraitLightFOV
	end
	local a0 = n.PortraitLightDistance
	if a0 == nil then
		a0 = l.PortraitLightDistance
	end
	local a1 = n.PortraitLightColor
	if a1 == nil then
		a1 = l.PortraitLightColor
	end
	local a2 = n.PortraitShadowColor
	if a2 == nil then
		a2 = l.PortraitShadowColor
	end
	local a3 = n.PortraitShadowScale
	if a3 == nil then
		a3 = l.PortraitShadowScale
	end
	local a4 = n.PortraitAmbientColor
	if a4 == nil then
		a4 = l.PortraitAmbientColor
	end
	local a5 = n.PortraitAmbientScale
	if a5 == nil then
		a5 = l.PortraitAmbientScale
	end
	local a6 = n.PortraitSpecularColor
	if a6 == nil then
		a6 = l.PortraitSpecularColor
	end
	local a7 = n.PortraitSpecularPower
	if a7 == nil then
		a7 = l.PortraitSpecularPower
	end
	local a8 = R
	local a9 = n.PortraitLightScale
	if a9 == nil then
		a9 = l.PortraitLightScale
	end
	local aa = n.PortraitGroundShadowScale
	if aa == nil then
		aa = l.PortraitGroundShadowScale
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
	SpawnEntityListFromTableSynchronous(r)
end