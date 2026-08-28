--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/full_body/5200018"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
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
		["69"] = 53,
		["70"] = 53,
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
		["153"] = 123,
		["154"] = 124,
		["155"] = 125,
		["157"] = 5,
		["158"] = 5,
	}
)
local d = {}
local e = require("lib.dota_ts_adapter")
local f = e.registerEntityFunction
f(nil, "Spawn", function(g, h)
	local i = "5200018"
	local j = KeyValues.CosmeticsKV[i]
	if j == nil then
		return
	end
	if j.resource == nil then
		return
	end
	local k = KeyValues.PortraitFullBody[i]
	if k == nil then
		k = KeyValues.PortraitFullBody.default
	end
	local l = k
	if l == nil then
		return
	end
	local m = l.cameras.default or l.cameras.Default
	local n = {}
	local o = j.resource
	local p = j.FullBodyModelScale
	if p == nil then
		p = 1
	end
	local q = {
		classname = "portrait_world_unit",
		parentname = "root",
		origin = "0 0 0",
		model = o,
		EnableAutoStyles = 0,
		ModelScale = p,
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
	local r
	if j ~= nil then
		r = j.Creature
	end
	local s
	if r ~= nil then
		s = r.AttachWearables
	end
	local t = s
	if t == nil then
		t = {}
	end
	local u = t
	do
		local v = 0
		while v <= 9 do
			local w = "item_def" .. tostring(v)
			local x = "style_index" .. tostring(v)
			local y = j["wearable" .. tostring(v + 1)]
			if y == nil then
				local z = u[tostring(v + 1)]
				if z ~= nil then
					z = z.ItemDef
				end
				local A = z
				if A == nil then
					A = -1
				end
				y = A
			end
			local B = y
			q[w] = B
			local C = KeyValues.ItemsGame[tostring(B)]
			if C ~= nil then
				if C.visuals and C.visuals.skin then
					q[x] = C.visuals.skin
				end
			end
			v = v + 1
		end
	end
	table.insert(n, q)
	table.insert(
		n,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = m.PortraitPosition,
			angles = m.PortraitAngles,
			fov = m.PortraitFOV,
			ZFar = m.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		n,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = l.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = l.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = l.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = l.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = l.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = l.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = l.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = l.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = l.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = l.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = l.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = l.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = l.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = l.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = l.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	local D = SpawnEntityListFromTableSynchronous(n)
	if j.ambient ~= nil then
		ParticleManager:CreateParticle(j.ambient, PATTACH_ABSORIGIN_FOLLOW, D[1])
	end
end)
return d