--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "units/portraits/neu_3"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 2,
		["6"] = 4,
		["7"] = 5,
		["8"] = 5,
		["9"] = 5,
		["11"] = 5,
		["12"] = 6,
		["15"] = 7,
		["16"] = 7,
		["17"] = 7,
		["19"] = 7,
		["20"] = 9,
		["21"] = 9,
		["22"] = 9,
		["24"] = 9,
		["25"] = 10,
		["28"] = 11,
		["29"] = 13,
		["30"] = 21,
		["31"] = 21,
		["32"] = 21,
		["33"] = 21,
		["35"] = 16,
		["36"] = 16,
		["37"] = 16,
		["38"] = 16,
		["39"] = 16,
		["40"] = 16,
		["41"] = 16,
		["42"] = 16,
		["43"] = 16,
		["44"] = 16,
		["45"] = 16,
		["46"] = 16,
		["47"] = 16,
		["48"] = 16,
		["49"] = 16,
		["50"] = 16,
		["51"] = 16,
		["52"] = 16,
		["53"] = 16,
		["54"] = 16,
		["55"] = 16,
		["56"] = 16,
		["57"] = 16,
		["58"] = 16,
		["59"] = 16,
		["60"] = 16,
		["61"] = 16,
		["62"] = 16,
		["63"] = 16,
		["64"] = 16,
		["65"] = 16,
		["66"] = 16,
		["67"] = 16,
		["68"] = 16,
		["69"] = 16,
		["71"] = 53,
		["72"] = 53,
		["76"] = 53,
		["78"] = 53,
		["79"] = 53,
		["80"] = 53,
		["82"] = 53,
		["84"] = 55,
		["85"] = 55,
		["86"] = 56,
		["87"] = 57,
		["88"] = 58,
		["89"] = 58,
		["90"] = 58,
		["92"] = 58,
		["94"] = 58,
		["95"] = 58,
		["96"] = 58,
		["98"] = 58,
		["100"] = 58,
		["101"] = 59,
		["102"] = 59,
		["103"] = 59,
		["105"] = 59,
		["106"] = 60,
		["107"] = 61,
		["108"] = 62,
		["110"] = 64,
		["111"] = 65,
		["112"] = 66,
		["113"] = 67,
		["117"] = 55,
		["120"] = 72,
		["121"] = 75,
		["122"] = 75,
		["123"] = 75,
		["124"] = 75,
		["125"] = 75,
		["126"] = 75,
		["127"] = 75,
		["128"] = 75,
		["129"] = 75,
		["130"] = 75,
		["131"] = 75,
		["132"] = 75,
		["133"] = 75,
		["134"] = 75,
		["135"] = 75,
		["136"] = 75,
		["137"] = 75,
		["138"] = 75,
		["139"] = 75,
		["140"] = 75,
		["141"] = 75,
		["142"] = 75,
		["143"] = 75,
		["144"] = 75,
		["145"] = 100,
		["146"] = 100,
		["147"] = 100,
		["148"] = 100,
		["149"] = 100,
		["150"] = 100,
		["151"] = 100,
		["152"] = 100,
		["153"] = 100,
		["154"] = 100,
		["155"] = 100,
		["156"] = 100,
		["157"] = 100,
		["158"] = 100,
		["159"] = 100,
		["160"] = 100,
		["161"] = 100,
		["162"] = 100,
		["163"] = 100,
		["164"] = 119,
		["165"] = 121,
		["166"] = 122,
		["168"] = 2,
	}
)
function Spawn(self, e)
	local f = "neu_3"
	local g = KeyValues.UnitsKv[f]
	if g == nil then
		g = KeyValues.CosmeticsKV[f]
	end
	local h = g
	if h == nil then
		return
	end
	local i = h.Model
	if i == nil then
		i = h.resource
	end
	local j = i
	local k = KeyValues.Portrait[j]
	if k == nil then
		k = {}
	end
	local l = c(k, KeyValues.PortraitCustom[j])
	if l == nil then
		return
	end
	local m = l.cameras.default or l.cameras.Default
	local n = {}
	local o = tostring
	local p = h.Skin
	if p == nil then
		p = ""
	end
	local q = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = j,
		skin = o(p),
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
	local r
	if h ~= nil then
		r = h.Creature
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
			local y = h["wearable" .. tostring(v + 1)]
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
			local C = h[("wearable" .. tostring(v + 1)) .. "style"]
			if C == nil then
				C = 0
			end
			local D = C
			q[w] = B
			if D ~= 0 then
				q[x] = D
			else
				local E = KeyValues.ItemsGame[tostring(B)]
				if E ~= nil then
					if E.visuals and E.visuals.skin then
						q[x] = E.visuals.skin
					end
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
	SpawnEntityListFromTableSynchronous(n)
	if l.PortraitParticle ~= nil then
		local F = ParticleManager:CreateParticle(l.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end