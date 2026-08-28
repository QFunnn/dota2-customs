--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/units/full_body/5800001.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 1,
		["6"] = 1,
		["7"] = 5,
		["8"] = 5,
		["9"] = 5,
		["10"] = 5,
		["11"] = 6,
		["12"] = 7,
		["13"] = 8,
		["16"] = 9,
		["19"] = 10,
		["20"] = 10,
		["21"] = 10,
		["23"] = 10,
		["24"] = 11,
		["27"] = 12,
		["28"] = 14,
		["29"] = 21,
		["30"] = 24,
		["31"] = 24,
		["32"] = 24,
		["34"] = 17,
		["35"] = 17,
		["36"] = 17,
		["37"] = 17,
		["38"] = 17,
		["39"] = 17,
		["40"] = 17,
		["41"] = 17,
		["42"] = 17,
		["43"] = 17,
		["44"] = 17,
		["45"] = 17,
		["46"] = 17,
		["47"] = 17,
		["48"] = 17,
		["49"] = 17,
		["50"] = 17,
		["51"] = 17,
		["52"] = 17,
		["53"] = 17,
		["54"] = 17,
		["55"] = 17,
		["56"] = 17,
		["57"] = 17,
		["58"] = 17,
		["59"] = 17,
		["60"] = 17,
		["61"] = 17,
		["62"] = 17,
		["63"] = 17,
		["64"] = 17,
		["65"] = 17,
		["66"] = 17,
		["67"] = 17,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["72"] = 53,
		["73"] = 53,
		["74"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 53,
		["80"] = 53,
		["82"] = 55,
		["83"] = 55,
		["84"] = 56,
		["85"] = 57,
		["86"] = 58,
		["87"] = 58,
		["88"] = 58,
		["89"] = 58,
		["90"] = 58,
		["92"] = 58,
		["93"] = 58,
		["94"] = 58,
		["96"] = 58,
		["98"] = 58,
		["99"] = 59,
		["100"] = 60,
		["101"] = 61,
		["102"] = 62,
		["103"] = 63,
		["106"] = 55,
		["109"] = 67,
		["110"] = 70,
		["111"] = 70,
		["112"] = 70,
		["113"] = 70,
		["114"] = 70,
		["115"] = 70,
		["116"] = 70,
		["117"] = 70,
		["118"] = 70,
		["119"] = 70,
		["120"] = 70,
		["121"] = 70,
		["122"] = 70,
		["123"] = 70,
		["124"] = 70,
		["125"] = 70,
		["126"] = 70,
		["127"] = 70,
		["128"] = 70,
		["129"] = 70,
		["130"] = 70,
		["131"] = 70,
		["132"] = 70,
		["133"] = 70,
		["134"] = 95,
		["135"] = 95,
		["136"] = 95,
		["137"] = 95,
		["138"] = 95,
		["139"] = 95,
		["140"] = 95,
		["141"] = 95,
		["142"] = 95,
		["143"] = 95,
		["144"] = 95,
		["145"] = 95,
		["146"] = 95,
		["147"] = 95,
		["148"] = 95,
		["149"] = 95,
		["150"] = 95,
		["151"] = 95,
		["152"] = 95,
		["153"] = 115,
		["154"] = 115,
		["155"] = 115,
		["156"] = 115,
		["157"] = 115,
		["158"] = 115,
		["159"] = 115,
		["160"] = 115,
		["161"] = 123,
		["162"] = 124,
		["163"] = 125,
		["165"] = 5,
		["166"] = 5,
	}
)
local e = {}
local f = require("lib.dota_ts_adapter")
local g = f.registerEntityFunction
g(nil, "Spawn", function(h, i)
	local j = "5800001"
	local k = KeyValues.CosmeticsKV[j]
	if k == nil then
		return
	end
	if k.resource == nil then
		return
	end
	local l = KeyValues.PortraitFullBody[j]
	if l == nil then
		l = KeyValues.PortraitFullBody.default
	end
	local m = l
	if m == nil then
		return
	end
	local n = m.cameras.default or m.cameras.Default
	local o = {}
	local p = k.resource
	local q = k.FullBodyModelScale
	if q == nil then
		q = 1
	end
	local r = {
		classname = "portrait_world_unit",
		targetname = "root",
		origin = "0 0 0",
		model = p,
		EnableAutoStyles = 0,
		ModelScale = q,
		suppress_intro_effects = 1,
		spawn_background_models = 0,
		rare_loadout_anim_chance = -1,
		suppress_anim_event_sounds = 0,
		skip_pet_spawn = 0,
		flying_courier = 0,
		spawn_wearable_item_defs = 1,
		activity = "ACT_DOTA_IDLE",
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
	local s = k
	if s ~= nil then
		s = s.Creature
	end
	local t = s
	if t ~= nil then
		t = t.AttachWearables
	end
	local u = t
	if u == nil then
		u = {}
	end
	local v = u
	do
		local w = 0
		while w <= 9 do
			local x = "item_def" .. tostring(w)
			local y = "style_index" .. tostring(w)
			local z = k["wearable" .. tostring(w + 1)]
			if z == nil then
				local A = v[tostring(w + 1)]
				if A ~= nil then
					A = A.ItemDef
				end
				local B = A
				if B == nil then
					B = -1
				end
				z = B
			end
			local C = z
			local D = KeyValues.ItemsGame[tostring(C)]
			if D ~= nil then
				r[x] = C
				if D.visuals and D.visuals.skin then
					r[y] = D.visuals.skin
				end
			end
			w = w + 1
		end
	end
	table.insert(o, r)
	table.insert(
		o,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = n.PortraitPosition,
			angles = n.PortraitAngles,
			fov = n.PortraitFOV,
			ZFar = n.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		o,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = m.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = m.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = m.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = m.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = m.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = m.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = m.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = m.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = m.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = m.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = m.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = m.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = m.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = m.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = m.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	table.insert(
		o,
		{
			classname = "prop_dynamic_clientside",
			parentname = "root",
			origin = "0 0 0",
			model = "models/eom/props/zhanshitai/zhanshitai.vmdl",
			scale = "0.6",
			rendertocubemaps = "1",
		}
	)
	local E = SpawnEntityListFromTableSynchronous(o)
	if k.ambient ~= nil then
		ParticleManager:CreateParticle(k.ambient, PATTACH_ABSORIGIN_FOLLOW, E[1])
	end
end)
return e