--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "units/full_body/5200009"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["4"] = 2,
		["5"] = 4,
		["6"] = 5,
		["7"] = 6,
		["10"] = 7,
		["13"] = 8,
		["14"] = 8,
		["15"] = 8,
		["17"] = 8,
		["18"] = 9,
		["21"] = 10,
		["22"] = 12,
		["23"] = 19,
		["24"] = 20,
		["25"] = 20,
		["26"] = 20,
		["27"] = 20,
		["29"] = 20,
		["30"] = 22,
		["31"] = 22,
		["32"] = 22,
		["34"] = 15,
		["35"] = 15,
		["36"] = 15,
		["37"] = 15,
		["38"] = 15,
		["39"] = 15,
		["40"] = 15,
		["41"] = 15,
		["42"] = 15,
		["43"] = 15,
		["44"] = 15,
		["45"] = 15,
		["46"] = 15,
		["47"] = 15,
		["48"] = 15,
		["49"] = 15,
		["50"] = 15,
		["51"] = 15,
		["52"] = 15,
		["53"] = 15,
		["54"] = 15,
		["55"] = 15,
		["56"] = 15,
		["57"] = 15,
		["58"] = 15,
		["59"] = 15,
		["60"] = 15,
		["61"] = 15,
		["62"] = 15,
		["63"] = 15,
		["64"] = 15,
		["65"] = 15,
		["66"] = 15,
		["67"] = 15,
		["68"] = 15,
		["70"] = 51,
		["71"] = 51,
		["75"] = 51,
		["77"] = 51,
		["78"] = 51,
		["79"] = 51,
		["81"] = 51,
		["83"] = 53,
		["84"] = 53,
		["85"] = 54,
		["86"] = 55,
		["87"] = 56,
		["88"] = 56,
		["89"] = 56,
		["91"] = 56,
		["93"] = 56,
		["94"] = 56,
		["95"] = 56,
		["97"] = 56,
		["99"] = 56,
		["100"] = 57,
		["101"] = 57,
		["102"] = 57,
		["104"] = 57,
		["105"] = 58,
		["106"] = 59,
		["107"] = 60,
		["109"] = 62,
		["110"] = 63,
		["111"] = 64,
		["112"] = 65,
		["116"] = 53,
		["119"] = 70,
		["120"] = 73,
		["121"] = 73,
		["122"] = 73,
		["123"] = 73,
		["124"] = 73,
		["125"] = 73,
		["126"] = 73,
		["127"] = 73,
		["128"] = 73,
		["129"] = 73,
		["130"] = 73,
		["131"] = 73,
		["132"] = 73,
		["133"] = 73,
		["134"] = 73,
		["135"] = 73,
		["136"] = 73,
		["137"] = 73,
		["138"] = 73,
		["139"] = 73,
		["140"] = 73,
		["141"] = 73,
		["142"] = 73,
		["143"] = 73,
		["144"] = 98,
		["145"] = 98,
		["146"] = 98,
		["147"] = 98,
		["148"] = 98,
		["149"] = 98,
		["150"] = 98,
		["151"] = 98,
		["152"] = 98,
		["153"] = 98,
		["154"] = 98,
		["155"] = 98,
		["156"] = 98,
		["157"] = 98,
		["158"] = 98,
		["159"] = 98,
		["160"] = 98,
		["161"] = 98,
		["162"] = 98,
		["163"] = 126,
		["164"] = 127,
		["165"] = 128,
		["167"] = 2,
	}
)
function Spawn(self, d)
	local e = "5200009"
	local f = KeyValues.CosmeticsKV[e]
	if f == nil then
		return
	end
	if f.resource == nil then
		return
	end
	local g = KeyValues.PortraitFullBody[e]
	if g == nil then
		g = KeyValues.PortraitFullBody.default
	end
	local h = g
	if h == nil then
		return
	end
	local i = h.cameras.default or h.cameras.Default
	local j = {}
	local k = f.resource
	local l = tostring
	local m = f.Skin
	if m == nil then
		m = ""
	end
	local n = l(m)
	local o = f.FullBodyModelScale
	if o == nil then
		o = 1
	end
	local p = {
		classname = "portrait_world_unit",
		parentname = "root",
		origin = "0 0 0",
		model = k,
		skin = n,
		EnableAutoStyles = 0,
		ModelScale = o,
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
	local q
	if f ~= nil then
		q = f.Creature
	end
	local r
	if q ~= nil then
		r = q.AttachWearables
	end
	local s = r
	if s == nil then
		s = {}
	end
	local t = s
	do
		local u = 0
		while u <= 9 do
			local v = "item_def" .. tostring(u)
			local w = "style_index" .. tostring(u)
			local x = f["wearable" .. tostring(u + 1)]
			if x == nil then
				local y = t[tostring(u + 1)]
				if y ~= nil then
					y = y.ItemDef
				end
				local z = y
				if z == nil then
					z = -1
				end
				x = z
			end
			local A = x
			local B = f[("wearable" .. tostring(u + 1)) .. "style"]
			if B == nil then
				B = 0
			end
			local C = B
			p[v] = A
			if C ~= 0 then
				p[w] = C
			else
				local D = KeyValues.ItemsGame[tostring(A)]
				if D ~= nil then
					if D.visuals and D.visuals.skin then
						p[w] = D.visuals.skin
					end
				end
			end
			u = u + 1
		end
	end
	table.insert(j, p)
	table.insert(
		j,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = i.PortraitPosition,
			angles = i.PortraitAngles,
			fov = i.PortraitFOV,
			ZFar = i.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		j,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = h.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = h.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = h.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = h.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = h.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = h.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = h.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = h.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = h.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = h.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = h.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = h.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = h.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = h.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = h.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	local E = SpawnEntityListFromTableSynchronous(j)
	if f.ambient ~= nil then
		ParticleManager:CreateParticle(f.ambient, PATTACH_ABSORIGIN_FOLLOW, E[1])
	end
end