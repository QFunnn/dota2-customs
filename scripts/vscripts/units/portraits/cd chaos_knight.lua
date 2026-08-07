--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/units/portraits/cd chaos_knight.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__ObjectAssign
local e = c.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["6"] = 1,
		["7"] = 1,
		["8"] = 5,
		["9"] = 5,
		["10"] = 5,
		["11"] = 5,
		["12"] = 6,
		["13"] = 7,
		["14"] = 7,
		["15"] = 7,
		["17"] = 7,
		["18"] = 8,
		["21"] = 9,
		["22"] = 9,
		["23"] = 9,
		["25"] = 9,
		["26"] = 11,
		["27"] = 11,
		["28"] = 11,
		["30"] = 11,
		["31"] = 12,
		["34"] = 13,
		["35"] = 15,
		["36"] = 23,
		["37"] = 23,
		["38"] = 23,
		["39"] = 23,
		["41"] = 18,
		["42"] = 18,
		["43"] = 18,
		["44"] = 18,
		["45"] = 18,
		["46"] = 18,
		["47"] = 18,
		["48"] = 18,
		["49"] = 18,
		["50"] = 18,
		["51"] = 18,
		["52"] = 18,
		["53"] = 18,
		["54"] = 18,
		["55"] = 18,
		["56"] = 18,
		["57"] = 18,
		["58"] = 18,
		["59"] = 18,
		["60"] = 18,
		["61"] = 18,
		["62"] = 18,
		["63"] = 18,
		["64"] = 18,
		["65"] = 18,
		["66"] = 18,
		["67"] = 18,
		["68"] = 18,
		["69"] = 18,
		["70"] = 18,
		["71"] = 18,
		["72"] = 18,
		["73"] = 18,
		["74"] = 18,
		["75"] = 18,
		["76"] = 55,
		["77"] = 55,
		["78"] = 55,
		["80"] = 55,
		["81"] = 55,
		["82"] = 55,
		["84"] = 55,
		["85"] = 55,
		["86"] = 55,
		["88"] = 55,
		["90"] = 57,
		["91"] = 57,
		["92"] = 58,
		["93"] = 59,
		["94"] = 60,
		["95"] = 60,
		["96"] = 60,
		["97"] = 60,
		["98"] = 60,
		["100"] = 60,
		["101"] = 60,
		["102"] = 60,
		["104"] = 60,
		["106"] = 60,
		["107"] = 61,
		["108"] = 61,
		["109"] = 61,
		["111"] = 61,
		["112"] = 62,
		["113"] = 63,
		["114"] = 64,
		["116"] = 66,
		["117"] = 67,
		["118"] = 68,
		["119"] = 69,
		["123"] = 57,
		["126"] = 74,
		["127"] = 77,
		["128"] = 77,
		["129"] = 77,
		["130"] = 77,
		["131"] = 77,
		["132"] = 77,
		["133"] = 77,
		["134"] = 77,
		["135"] = 77,
		["136"] = 77,
		["137"] = 77,
		["138"] = 77,
		["139"] = 77,
		["140"] = 77,
		["141"] = 77,
		["142"] = 77,
		["143"] = 77,
		["144"] = 77,
		["145"] = 77,
		["146"] = 77,
		["147"] = 77,
		["148"] = 77,
		["149"] = 77,
		["150"] = 77,
		["151"] = 102,
		["152"] = 102,
		["153"] = 102,
		["154"] = 102,
		["155"] = 102,
		["156"] = 102,
		["157"] = 102,
		["158"] = 102,
		["159"] = 102,
		["160"] = 102,
		["161"] = 102,
		["162"] = 102,
		["163"] = 102,
		["164"] = 102,
		["165"] = 102,
		["166"] = 102,
		["167"] = 102,
		["168"] = 102,
		["169"] = 102,
		["170"] = 121,
		["171"] = 123,
		["172"] = 124,
		["174"] = 5,
		["175"] = 5,
	}
)
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerEntityFunction
h(nil, "Spawn", function(i, j)
	local k = "portrait_base"
	local l = KeyValues.UnitsKv[k]
	if l == nil then
		l = KeyValues.CosmeticsKV[k]
	end
	local m = l
	if m == nil then
		return
	end
	local n = m.Model
	if n == nil then
		n = m.resource
	end
	local o = n
	local p = KeyValues.Portrait[o]
	if p == nil then
		p = {}
	end
	local q = d(p, KeyValues.PortraitCustom[o])
	if q == nil then
		return
	end
	local r = q.cameras.default or q.cameras.Default
	local s = {}
	local t = tostring
	local u = m.Skin
	if u == nil then
		u = ""
	end
	local v = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = o,
		skin = t(u),
		EnableAutoStyles = 0,
		ModelScale = 1,
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
	local w = m
	if w ~= nil then
		w = w.Creature
	end
	local x = w
	if x ~= nil then
		x = x.AttachWearables
	end
	local y = x
	if y == nil then
		y = {}
	end
	local z = y
	do
		local A = 0
		while A <= 9 do
			local B = "item_def" .. tostring(A)
			local C = "style_index" .. tostring(A)
			local D = m["wearable" .. tostring(A + 1)]
			if D == nil then
				local E = z[tostring(A + 1)]
				if E ~= nil then
					E = E.ItemDef
				end
				local F = E
				if F == nil then
					F = -1
				end
				D = F
			end
			local G = D
			local H = m[("wearable" .. tostring(A + 1)) .. "style"]
			if H == nil then
				H = 0
			end
			local I = H
			v[B] = G
			if I ~= 0 then
				v[C] = I
			else
				local J = KeyValues.ItemsGame[tostring(G)]
				if J ~= nil then
					if J.visuals and J.visuals.skin then
						v[C] = J.visuals.skin
					end
				end
			end
			A = A + 1
		end
	end
	table.insert(s, v)
	table.insert(
		s,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = r.PortraitPosition,
			angles = r.PortraitAngles,
			fov = r.PortraitFOV,
			ZFar = r.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
			ZNear = 4,
			UseScreenAspectRatio = 0,
			aspectRatio = 1,
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
	table.insert(
		s,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = q.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = q.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = q.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = q.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = q.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = q.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = q.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = q.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = q.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = q.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = q.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = q.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = q.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = q.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = q.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(s)
	if q.PortraitParticle ~= nil then
		local K = ParticleManager:CreateParticle(q.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end)
return f