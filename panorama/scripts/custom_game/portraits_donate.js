--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var portrait_video_kill_cam = null
var selected_portrait = null
var killer_name = null
var similar_id = 
{
    4239: [4239, 4560, 4561],
    23097: [23097, 2309799],
    23096: [23096, 2309699],
    9784: [9784, 978499, 9784999], 
    9780: [9780, 978099, 9780999], 
    12229: [12229, 122291],
    12228: [12228, 122281],
    9052: [9052, 90521],
    9037: [9037, 90371],
    9774: [9774, 97741],
    9229: [9229, 92291],
    8471: [8471, 84711],
    9227: [9227, 92271],
    29029: [29029, 290291, 290292, 290293],
    14561: [14561, 145611, 145612],
    14560: [14560, 145601, 145602],
    26665: [26665, 29689, 296891],
    8547: [8547, 85471, 23217],
    7395: [7395, 7475],
    24762: [24762, 24763, 24764],
    9788: [9788, 97881],
    8008: [8008, 8036],
    23127: [23127, 29572],
    32929: [32929, 329291],
    32930: [32930, 329301],
    13752: [13752, 137521, 137522],
}


var first_timer_loading = -1
var first_timer_loading_killcam = -1
var last_hero_entity_camera_portrait = null
var last_hero_entity_camera_kill_cam = null

var unique_cameras_heroes_items = 
{
    "npc_dota_hero_juggernaut" :
    [
        [2059, 2111],
        [2059, 4484],
        [2059, 2096],
        [2059, 2105],
        [2059, 2098],
        [2059, 4504],
        [2059, 4505],
        [2059, 2097],
        [2059, 27481],
        [2068, 2111],
        [2068, 4484],
        [2068, 2096],
        [2068, 2105],
        [2068, 2098],
        [2068, 4504],
        [2068, 4505],
        [2068, 2097],
        [2068, 27481],
        [27483],
        [4482],
        [2040],
        [2049],
        [2052],
        [2064],
        [2067],
        [4507],
        [4508],
        [2059],
        [2068],
    ],
    "npc_dota_hero_phantom_assassin" :
    [
        [32985],
        [28320],
        [4480],
        [31081],
        [423988],
        [423987],
        [4239, 28171],
        [4239, 281711],
        [4239, 3357, 3379],
        [4239, 3357, 3384],
        [3357, 3379],
        [4239, 28637],
        [4239, 3367],
        [4239, 4487],
        [4239, 4491],
        [4239, 3357],
        [4239, 3379],
        [4239, 3384],
        [3357, 3384],
        [28171],
        [281711],
        [28637],
        [3367],
        [4487],
        [4491],
        [3357], // голова
        [3379], // плечи норм
        [3384], // плечи красные
        [4239],
    ],
    "npc_dota_hero_huskar" :
    [
        [2428, 2414],
        [2428, 2404],
        [2428, 22404],
        [2404, 2429],
        [2404, 2431],
        [2404, 2426],
        [2414, 2429],
        [2414, 2431],
        [2414, 2426],
        [22404, 2429],
        [22404, 2431],
        [22404, 2426],
        [30982],
        [2402],
        [2417],
        [5872],
        [2414],
        [2404],
        [22404],
        [4494],
        [2428],
        [14146],
    ],

    "npc_dota_hero_legion_commander":
    [
        [5810, 9236, 31100],
        [5810, 9236, 34335],
        [5810, 9236, 8821],
        [5810, 9236, 13052],
        [5810, 9236, 13986],
        [5810, 9236, 25759],
        [5810, 9236, 29256],
        [5810, 9236, 9780],
        [5810, 31105],
        [5810, 34339],
        [5810, 9236],
        [5810, 8824],
        [5810, 13050],
        [5810, 13988],
        [5810, 25761],
        [5810, 29254],
        [5810, 9784],
        [9236, 8821],
        [9236, 13052],
        [9236, 13986],
        [9236, 25759],
        [9236, 29256],
        [9236, 9780],
        [9236, 31100],
        [9236, 34335],
        [31105],
        [34339],
        [9784],
        [5810],
        [9236],
        [8824],
        [13050],
        [13988],
        [25761],
        [29254],
    ],

    "npc_dota_hero_nevermore":
    [
        [6996, 9020],
        [6996, 22844],
        [6996, 12677],
        [6996, 13507],
        [6996, 18036],
        [6996, 8259],
        [9021],
        [18035],
        [22845],
        [26218],
        [33212],
        [12678],
        [13505],
        [6996],
        [8259],
    ],

    "npc_dota_hero_razor":
    [
      //  [2309599, 6646, 14812],
     //   [2309599, 6646, 18132],
     //   [2309599, 6646, 19500],
    //    [2309599, 6646, 23097],
    //    [2309599, 6916, 14812],
      //  [2309599, 6916, 18132],
      //  [2309599, 6916, 19500],
     //   [2309599, 6916, 23097],
        [2309599, 14814],
        [2309599, 18130],
        [2309599, 19503],
        [2309599, 23096],
        [2309599, 6646],
        [2309599, 6916],
      //  [23095, 6646, 14812],
      //  [23095, 6646, 18132],
      //  [23095, 6646, 19500],
      //  [23095, 6646, 23097],
      //  [23095, 6916, 14812],
       // [23095, 6916, 18132],
      //  [23095, 6916, 19500],
     //   [23095, 6916, 23097],
        [23095, 14814],
        [23095, 18130],
        [23095, 19503],
        [23095, 23096],
        [23095, 6646],
        [23095, 6916],
       // [6916, 14812],
       // [6916, 18132],
       // [6916, 19500],
       // [6916, 23097],
       // [6646, 14812],
       // [6646, 18132],
       // [6646, 19500],
       // [6646, 23097],
        [23095],
        [2309599],
        [14814],
        [18130],
        [19503],
        [23096],
        [6646],
        [6916]
    ],
    "npc_dota_hero_queenofpain":
    [
        [1293001, 29615],
        [1293001, 296151],
        [1293001, 5157],
        [1293001, 8107],
        [1293001, 7755],
        [12930, 29615],
        [12930, 296151],
        [12930, 5157],
        [12930, 8107],
        [12930, 7755],
        [1293001],
        [12930],
        [29615],
        [296151],
        [7755],
        [8107],
        [5157],
    ],
    "npc_dota_hero_skeleton_king":
    [
        [13456],
        [1345601],
        [9601],
        [13497],
        [13036],
        [28629],
        [24231],
    ],
    "npc_dota_hero_monkey_king":
    [
        [905004],
        [905003],
        [905002],
        [905001],
        [25353],
        [31422],
        [12696],
        [13544],
    ],
    "npc_dota_hero_lina":
    [   
        [4794, 32930],
        [4794, 27550],
        [4794, 8003],
        [4794, 12228],
        [4794, 14250],
        [4794],
        [32929],
        [12229],
        [14251],
        [27551],
        [8003],
    ],
    "npc_dota_hero_zuus":
    [  
        [6914, 34328],
        [6914, 18563],
        [6914, 24680],
        [6914, 19112],
        [6914, 7952],
        [6914, 9037],
        [6914],
        [34326],
        [18563],
        [24680],
        [19112],
        [9052],
        [7954],
    ],
    "npc_dota_hero_pudge":
    [  
        [999251],
        [999252],
        [999253],
        [30385],
        [32876],
        [77561, 6007],
        [77561, 7363],
        [77561, 13513],
        [77561, 14036],
        [77561, 26084],
        [77561, 26784],
        [77561, 26091],

        [7756, 6007],
        [7756, 7363],
        [7756, 13513],
        [7756, 14036],
        [7756, 26084],
        [77561, 4734],
        [7756, 4734],
        [7756, 26784],
        [7756, 26091],
        [77561],
        [7756],

        [26091],
        [26784],
        [4734],
        [6007], //6115
        [7363], //7376
        [13513], //13511
        [14036], //14038
        [26084], //26082
    ],
    "npc_dota_hero_drow_ranger":
    [
        [190901, 7054],
        [190901, 13011],
        [190901, 13339],
        [190901, 17869],
        [190901, 29303],
        [190901, 293031],
        [190901, 6785],
        [190901],

        [19090, 7054],
        [19090, 13011],
        [19090, 13339],
        [19090, 17869],
        [19090, 29303],
        [19090, 293031],
        [19090, 6785],
        [19090],

        [6785],

        [7054],
        [13011],
        [13339],
        [17869],
        [29303],
        [293031],
    ],
    "npc_dota_hero_skywrath_mage":
    [
        [18539, 6973],
        [18539, 9774],
        [18539, 13936],
        [18539, 14920],
        [18539],

        [185391, 6973],
        [185391, 9774],
        [185391, 13936],
        [185391, 14920],
        [185391],

        [6973],
        [9774],
        [13936],
        [14920],
    ],
    "npc_dota_hero_antimage":
    [

        [13783],
        [27297],
        [29137],
        [29296],
        [28278],    
        [29126],

        [8732],
        [14509],
        [24924],
        [23780],
    ],
    "npc_dota_hero_axe":
    [
        [12964, 25826],
        [12964, 6605],
        [12964, 12954],
        [12964, 13543],
        [12964, 36150],

        [12964, 8471],
        [12964, 28502],
        [12964, 13930],

        [12964],

        [6605, 28500],
        [12954, 28500],
        [13543, 28500],

        [6605],
        [12954],
        [13543],

        [36150],
        [25826],
        [8471],
        [28502],
        [13930],
    ],
    "npc_dota_hero_ogre_magi":
    [
        [136701, 31207],
        [136701, 9229],
        [136701, 18098],
        [136701, 19373],

        [13670, 31207],
        [13670, 9229],
        [13670, 18098],
        [13670, 19373],

        [13670],
        [136701],

        [31207],
        [19373],
        [18098],
        [9229],
    ],
    "npc_dota_hero_invoker":
    [
        [30721],
        [30575],
        [23257],
        [25513],
        [21836],
        [13042],

        [8746, 29029],
        [8746, 9417],
        [8746, 7987],
        [8746],

        [8572],
        [7986],
        [9419],
        [29028],
        [290281],
        [290282],
        [290283],
    ],
    "npc_dota_hero_crystal_maiden":
    [
        [33507],
        [26559],
        [265591],
        [265592],
        [29578],

        [7385, 6686, 27562],
        [7385, 6686, 9205],
        [7385, 6686, 9628],
        [7385, 6686, 14561],

        [7385, 9205, 27561],
        [7385, 9205, 9626],
        [7385, 9205, 14560],

        [7385, 6686],
        [7385, 9205],

        [7385, 27561],
        [7385, 9626],
        [7385, 14560],

        [7385],

        [6686, 27562],
        [6686, 9205],
        [6686, 9628],
        [6686, 14561],

        [9205, 27561],
        [9205, 9626],
        [9205, 14560],

        [6686],
        [9205],

        [27561],
        [9626],
        [14560],
    ],
    "npc_dota_hero_terrorblade":
    [
       [5957, 26445],
       [5957, 14342],
       [5957],

       [9498],
       [14340],
       [26447], 
    ],
    "npc_dota_hero_troll_warlord":
    [
        [12560],
        [18494],
        [7875],
    ],
    "npc_dota_hero_void_spirit":
    [
        [26595],
        [26665],
        [18364],
        [24612],
        [34323],
    ],
    "npc_dota_hero_bane":
    [
        [14964, 7692],
        [14964],
        [7692],
        [12715],
        [28436],
        [8547],
    ],
    "npc_dota_hero_morphling":
    [
        [7603, 6833],
        [7603],
        [7560],
        [19164],
        [33035],
        [8806],
        [6833],
    ],
    "npc_dota_hero_abaddon":
    [   
        [28357],
        [28473],
        [6409],
        [13458],
        [28600],
        [19416],
        [13236],
    ],
    "npc_dota_hero_alchemist":
    [   
        [5104],
        [8532],
        [30368],
        [14193],
        [17939],
        [25595],
    ],
    "npc_dota_hero_life_stealer":
    [   
        [13787, 9199],
        [13818, 9215],
        [13787],
        [13818],

        [9105],
        [7395],
        [23451],
        [234511],
    ],
    "npc_dota_hero_arc_warden":
    [   
        [13826],
        [31354],
        [13356],
        [24762],
    ],
    "npc_dota_hero_tinker":
    [
        [7143, 7969],
        [7143, 34368],
        [7143, 26842],
        [7143, 9266],
        [7143, 14065],
        [7143],

        [34367],
        [14067],
        [9265],
        [26840],
        [7967],
    ],
    "npc_dota_hero_bloodseeker":
    [
        [9241],
        [13446],
        [9810],
        [12723],
        [8736], 
    ],
    "npc_dota_hero_bristleback":
    [
        [18500],
        [9788],
        [14515],
        [9150],
        [7994],
    ],
    "npc_dota_hero_centaur":
    [
        [8008, 23127],
        [8039, 23837],
        [8008],
        [8039],

        [8753],
        [23203],
        [12730],
        [8481],
        [12610],
        [32645],

        [23127],
        [23837],
    ],
    "npc_dota_hero_witch_doctor":
    [        
        [9679, 12328],
        [9679, 19152],
        [9679, 18553],
        [9679, 9934],
        [9679, 19659],
        [9679, 14316],

        [8267, 12328],
        [8267, 19152],
        [8267, 18553],
        [8267, 9934],
        [8267, 19659],
        [8267, 14316],

        [12328],
        [19152],
        [18553],
        [9934],
        [19659],
        [14316],

        [8267],
        [9679],
    ],
    "npc_dota_hero_ember_spirit":
    [
        [12261],
        [13381],
        [13299],
        [8879],
        [12486],

        [13007],
    ],
    "npc_dota_hero_nyx_assassin":
    [
        [9081],
        [17964],
        [28305],
        [9441],
        [13752],

        [12957],
        [13574],
    ],
    "npc_dota_hero_enigma":
    [
        [12332],
        [14749],
        [13021],
        [32988],
        [32861],
    ],
    "npc_dota_hero_hoodwink":
    [
        [22223],
        [29249],
        [26752],
        [23247],
    ],
    "npc_dota_hero_broodmother":
    [
        [19779],
        [13272],
        [33378],
        [17915],
        [9427],
        [22827],
    ],
}

var terrorblade_forms =
[
    7404,
    9501,
    14339,
    7033,
    8276,
    26446,
]

var allow_camera_change =
{
    "npc_dota_hero_juggernaut" : true,
    "npc_dota_hero_phantom_assassin" : true,
    "npc_dota_hero_huskar" : true,
    "npc_dota_hero_razor" : true,
    "npc_dota_hero_nevermore" : true,
    "npc_dota_hero_legion_commander" : true,
    "npc_dota_hero_queenofpain" : true,
    "npc_dota_hero_skeleton_king": true,
    "npc_dota_hero_monkey_king": true,
    "npc_dota_hero_lina": true,
    "npc_dota_hero_zuus": true,
    "npc_dota_hero_pudge": true,
    "npc_dota_hero_drow_ranger": true,
    "npc_dota_hero_skywrath_mage": true,
    "npc_dota_hero_antimage": true,
    "npc_dota_hero_axe": true,
    "npc_dota_hero_ogre_magi": true,
    "npc_dota_hero_invoker": true,
    "npc_dota_hero_crystal_maiden": true,
    "npc_dota_hero_terrorblade": true,
    "npc_dota_hero_troll_warlord": true,
    "npc_dota_hero_void_spirit": true,
    "npc_dota_hero_bane": true,
    "npc_dota_hero_morphling": true,
    "npc_dota_hero_abaddon": true,
    "npc_dota_hero_alchemist": true,
    "npc_dota_hero_life_stealer": true,
    "npc_dota_hero_arc_warden": true,
    "npc_dota_hero_tinker": true,
    "npc_dota_hero_bloodseeker": true,
    "npc_dota_hero_bristleback": true,
    "npc_dota_hero_centaur": true,
    "npc_dota_hero_witch_doctor": true,
    "npc_dota_hero_ember_spirit": true,
    "npc_dota_hero_nyx_assassin": true,
    "npc_dota_hero_enigma": true,
    "npc_dota_hero_hoodwink": true,
    "npc_dota_hero_broodmother": true,
}

var portraits_panels = {}

function UpdateMainHudHero(fast)
{
    let hero_current = Entities.GetUnitName( Players.GetLocalPlayerPortraitUnit() )
    let portraitHUDOverlay = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("portraitHUDOverlay");

    if ( (selected_portrait != hero_current) || fast)
    {
        if (allow_camera_change[hero_current] == null)
        {
            for (var i = 0; i <= Object.keys(portraits_panels).length; i++) 
            {
                if (portraits_panels[Object.keys(portraits_panels)[i]])
                {
                    portraits_panels[Object.keys(portraits_panels)[i]].style.visibility = "collapse"
                }
            }
        } 
        else
        {
            for (var i = 0; i <= Object.keys(portraits_panels).length; i++) 
            {
                if (portraits_panels[Object.keys(portraits_panels)[i]])
                {
                    portraits_panels[Object.keys(portraits_panels)[i]].style.visibility = "collapse"
                }
            }
            let player_id = Entities.GetPlayerOwnerID( Players.GetLocalPlayerPortraitUnit() )
            let camera_info = GetCameraInfo(hero_current, player_id)
            ChangeCamera(camera_info[0], camera_info[1], portraits_panels[hero_current], hero_current)  
        }
    }

    if (portraits_panels[hero_current] != null)
    {
        if (Entities.IsHexed( Players.GetLocalPlayerPortraitUnit() ))
        {
            portraits_panels[hero_current].style.visibility = "collapse"
        }
        else
        {
            portraits_panels[hero_current].style.visibility = "visible"
        }
        if (portraitHUDOverlay)
        {
            portraitHUDOverlay.style.visibility = "collapse"
        }
    }
    else
    {
        if (portraitHUDOverlay)
        {
            portraitHUDOverlay.style.visibility = "visible"
        }
    }

    selected_portrait = hero_current
}
 
function ChangeCamera(camera_name, light_name, scene_panel, hero_name)
{
    camera_name = UpdateMetaTerrorblade(hero_name, camera_name, light_name)[0]
    light_name = UpdateMetaTerrorblade(hero_name, camera_name, light_name)[1]

    let dotahud = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("portraitHUD");
    
    if (scene_panel == null)
    {
        dotahud.style.transform = "translateY( 30px ) translateX( -16px )";
        let portrait_video = $.CreatePanel("DOTAScenePanel", dotahud, "portrait_donate_hero", { class:"portrait_donate_hero", style: "width:100px;height:100px;", map: "portraits/"+hero_name, light:light_name, particleonly:"false", camera: camera_name, renderdeferred:"false", antialias:"false", renderwaterreflections:"false", deferredalpha:"false", environment:"default" })
        portrait_video.style.width = "143px"
        portrait_video.style.height = "175px"
        portrait_video.style.marginLeft = "14px"
        portraits_panels[hero_name] = portrait_video

        $.RegisterEventHandler("DOTAScenePanelSceneLoaded", portraits_panels[hero_name], function() 
        {
            $.Schedule(0.2, function () 
            {
                RemovedTimer()
                UpdateMainHudHero(true)
            });
        });
        
        ChangeUnitCamera(camera_name, hero_name)
    }
    else
    {
        scene_panel.style.visibility = "visible"
        scene_panel.LerpToCameraEntity( camera_name, 0 )
        $.Schedule(0.1, function()
        {   
            last_hero_entity_camera_portrait = camera_name + "_unit"
            scene_panel.FireEntityInput(last_hero_entity_camera_portrait, "Enable", "", 0.0);   
        }) 
    }
}
 
function ChangeUnitCamera(camera_name, hero_name)
{
    first_timer_loading = $.Schedule(0.1, function ()
    {
        first_timer_loading = -1
        last_hero_entity_camera_portrait = camera_name + "_unit"
        portraits_panels[hero_name].FireEntityInput(last_hero_entity_camera_portrait, "Enable", "", 0.0);
        ChangeUnitCamera(camera_name, hero_name)
    })
}

function RemovedTimer()
{
    if (first_timer_loading != -1)
    {
        $.CancelScheduled(first_timer_loading)
        first_timer_loading = -1
    }
}

function GetCameraInfo(hero_name, player_id)
{
    let camera_name = hero_name
    let light_name = hero_name + "_light"
    let heroes_items = GetHeroesItems(player_id, hero_name)

    if (unique_cameras_heroes_items[hero_name] != null)
    {
        for (var i = 0; i < Object.keys(unique_cameras_heroes_items[hero_name]).length; i++) 
        {
            let has_this_list = true
            let item_id_list = unique_cameras_heroes_items[hero_name][i]

            for (var d = 0; d < item_id_list.length; d++) 
            {
                if (similar_id[item_id_list[d]] != null)
                {
                    let has_double_check_item = false
                    for (var j = 0; j < Object.keys(similar_id[item_id_list[d]]).length; j++) 
                    {
                        if (heroes_items[similar_id[item_id_list[d]][j]] != null)
                        {
                            has_double_check_item = true
                        }
                    }
                    if (!has_double_check_item)
                    {
                        has_this_list = false
                    }
                }
                else
                {
                    if (heroes_items[item_id_list[d]] == null)
                    {
                        has_this_list = false
                    }
                }
            }
            if (has_this_list)
            {   
                for (var d = 0; d < item_id_list.length; d++) 
                {
                    camera_name = camera_name + "_" + item_id_list[d]
                    light_name = light_name + "_" + item_id_list[d]
                }
                break
            }
        }
    }

    return [camera_name, light_name]
}

function GetHeroesItems(player_id, hero)
{
    let fast_table = {}
	let player_table = CustomNetTables.GetTableValue("heroes_items_info", "portrait_items_" + String(player_id));
	if (player_table)
	{
        for (var i = 1; i <= Object.keys(player_table).length; i++) 
        {
            fast_table[player_table[i]] = true
        }
	}
    return fast_table
}

CustomNetTables.SubscribeNetTableListener( "heroes_items_info", UpdateSubDataPortraits );

function UpdateSubDataPortraits(table, key, data ) 
{
	if (table == "heroes_items_info") 
	{
		if (key == "portrait_items_"+Players.GetLocalPlayer()) 
        {
            let player_id = Entities.GetPlayerOwnerID( Players.GetLocalPlayerPortraitUnit() )
            if (player_id == Players.GetLocalPlayer())
            {
                let hero_name = Entities.GetUnitName( Players.GetLocalPlayerPortraitUnit())
                let camera_info = GetCameraInfo(hero_name, player_id)
                ChangeCamera(camera_info[0], camera_info[1], portraits_panels[hero_name], hero_name)
            }
		}
	}
}

function UpdateKillCam(data)
{
    var KillCam = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("KillCam");
    if (KillCam)
    {
        let KillCamHeroImageOrMovie = KillCam.FindChildTraverse("KillCamHeroImageOrMovie")
        if (KillCamHeroImageOrMovie)
        {
            let KillCamHeroRender = KillCamHeroImageOrMovie.GetChild(0)
            if (KillCamHeroRender)  
            { 
                ChangeKillCamCamera(data, KillCamHeroRender)
            }
        }
    }
}

function ChangeKillCamCamera(data, KillCamHeroRender, hero_name)
{
    let portrait_donate_hero = KillCamHeroRender.FindChildTraverse("portrait_donate_hero")
    if (data && data.heroname != null)
    {
        let hero_name = data.heroname
        let player_id = data.id
        let camera_info = GetCameraInfo(hero_name, player_id)
        let camera_name = camera_info[0]
        let camera_light = camera_info[1]
        if (portrait_donate_hero != null)
        {
            portrait_donate_hero.DeleteAsync(0)
            portrait_video_kill_cam = null
        }
        if (portrait_video_kill_cam == null)
        { 
            portrait_video_kill_cam = $.CreatePanel("DOTAScenePanel", KillCamHeroRender, "portrait_donate_hero", { class:"portrait_donate_hero", style: "width:100px;height:100px;", map: "portraits/"+hero_name, light: camera_light, particleonly:"false", camera: camera_name, renderdeferred:"false", antialias:"false", renderwaterreflections:"false" });
            portrait_video_kill_cam.style.width = "100%"
            portrait_video_kill_cam.style.height = "100%"
            portrait_video_kill_cam.style.visibility = "visible"
            $.RegisterEventHandler("DOTAScenePanelSceneLoaded", portrait_video_kill_cam, function () 
            {
                $.Schedule(0.2, function () 
                {
                    RemovedTimerKillCam()
                });
            });
            ChangeUnitCameraKillCam(camera_name)
        }
        else
        {
            let hero_name = data.heroname
            let player_id = data.id
            let camera_info = GetCameraInfo(hero_name, player_id)
            let camera_name = camera_info[0]
            let camera_light = camera_info[1]
            portrait_video_kill_cam.style.visibility = "visible"
            portrait_video_kill_cam.LerpToCameraEntity( camera_name, 0 )
            $.Schedule(0.1, function()
            { 

                last_hero_entity_camera_kill_cam = camera_name + "_unit"
                portrait_video_kill_cam.FireEntityInput(last_hero_entity_camera_kill_cam, "Enable", "", 0.0);   
            })
        }
    }
    else if (data == null || (data && data.heroname == null))
    {
        if (portrait_video_kill_cam != null)
        {
            portrait_donate_hero.DeleteAsync(0)
            portrait_video_kill_cam = null
        }
    }
}

CustomNetTables.SubscribeNetTableListener( "heroes_donate_portraits", UpdateKillCamData );

function UpdateKillCamData(table, key, data ) 
{
	if (table == "heroes_donate_portraits") 
	{
		if (key == "killer_" + Players.GetLocalPlayer()) 
        {
            UpdateKillCam(data)
		}
	}
} 

function RemovedTimerKillCam()
{
    if (first_timer_loading_killcam != -1)
    {
        $.CancelScheduled(first_timer_loading_killcam)
        first_timer_loading_killcam = -1
    }
}

function ChangeUnitCameraKillCam(camera_name)
{
    first_timer_loading_killcam = $.Schedule(0.1, function ()
    {
        first_timer_loading_killcam = -1
        last_hero_entity_camera_kill_cam = camera_name + "_unit"
        portrait_video_kill_cam.FireEntityInput(last_hero_entity_camera_kill_cam, "Enable", "", 0.0);    
        ChangeUnitCameraKillCam(camera_name)
    })
}

function UpdateMetaTerrorblade(hero_name, camera_name, light_name)
{   
    let unit = Players.GetLocalPlayerPortraitUnit()
    if (hero_name == "npc_dota_hero_terrorblade" && HasModifierItem(unit, "modifier_custom_terrorblade_metamorphosis") )
    {   
        let is_has_item = false
        let player_id = Entities.GetPlayerOwnerID( unit )
        let heroes_items = GetHeroesItems(player_id, hero_name)
        camera_name = hero_name
        light_name = hero_name + "_light"

        for (var i = 0; i < terrorblade_forms.length; i++)
        {
            if (heroes_items[terrorblade_forms[i]] != null)
            {
                camera_name = camera_name + "_" + terrorblade_forms[i]
                light_name = light_name + "_" + terrorblade_forms[i]
                is_has_item = true
            }
        }
        if (!is_has_item)
        {
            camera_name = camera_name + "_8056"
            light_name = light_name + "_8056"
        }
    }
    return [camera_name, light_name]
}

function HasModifierItem(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier){
            return true
        }
    }
    return false
}

GameEvents.Subscribe_custom("dota1x6_update_terrorblade_form", UpdateItemPortraitLua);

function UpdateItemPortraitLua() 
{
    $.Schedule(0.1, function () 
    {
        let player_id = Entities.GetPlayerOwnerID( Players.GetLocalPlayerPortraitUnit() )
        if (player_id == Players.GetLocalPlayer())
        {
            let hero_name = Entities.GetUnitName( Players.GetLocalPlayerPortraitUnit())
            let camera_info = GetCameraInfo(hero_name, player_id)
            ChangeCamera(camera_info[0], camera_info[1], portraits_panels[hero_name], hero_name)
        }
    });
}

GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "dota_player_update_query_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "m_event_dota_inventory_changed_query_unit", UpdateSelectionUnit );

function UpdateSelectionUnit(...args)
{
    UpdateMainHudHero()
}