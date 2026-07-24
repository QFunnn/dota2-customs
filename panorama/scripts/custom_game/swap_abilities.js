--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


//此类危险技能删除可能会闪退
var unremovableAbilities = {
    "monkey_king_wukongs_command": true,
};

//互斥技能，保证玩家不会同时选到
var abilityExclusion={}
abilityExclusion["lone_druid_true_form"]= ["lone_druid_spirit_bear"]
abilityExclusion["lone_druid_spirit_bear"]= ["lone_druid_true_form"]


//模型互斥技能
var heroExclusion={}
heroExclusion["npc_dota_hero_silencer"]=["monkey_king_wukongs_command"]
heroExclusion["npc_dota_hero_razor"]=["monkey_king_wukongs_command"]
heroExclusion["npc_dota_hero_meepo"]=["arc_warden_tempest_double_lua"]
heroExclusion["npc_dota_hero_rattletrap"]=["phoenix_supernova"]


var selection_pair = {
	own: null,
	other: null,
};

var player_abilities = {};
var player_panels = {};
var current_cooldowns = {};
var panels_with_cooldown = {};

let proposal_container = $("#swap_proposal_container");

Abilities.swap_locked_abilities = {};

Abilities.IsLocked = function (player_id, ability_name) {
	if (this.swap_locked_abilities[player_id]) {
		return this.swap_locked_abilities[player_id].has(ability_name);
	}
	return false;
};

Abilities.UnlockAbility = function (player_id, ability_name) {
	if (this.swap_locked_abilities[player_id]) {
		this.swap_locked_abilities[player_id].delete(ability_name);
	}
};

Abilities.LockAbility = function (player_id, ability_name) {
	if (!this.swap_locked_abilities[player_id]) {
		this.swap_locked_abilities[player_id] = new Set();
	}
	this.swap_locked_abilities[player_id].add(ability_name);
};

function SendErrorMessage(message) {
	GameEvents.SendEventClientSide("dota_hud_error_message", {
		splitscreenplayer: 0,
		reason: 80,
		message: message,
	});
}

function ShowTooltip(panel, abilityName, index) {
	return () => {
		if (panel.GetParent().GetParent().BHasClass("SameAbilityLocked")) {
			return;
		}
		$.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", panel, abilityName, index);
	};
}

function HideTooltip(panel) {
	return () => {
		$.DispatchEvent("DOTAHideAbilityTooltip");
	};
}

function SelectAbility(ability_panel, player_id) {
	return () => {
		let local_player_id = Game.GetLocalPlayerID();
		let own_player_id = "player_" + local_player_id;
		let abilities_container = ability_panel.GetParent();
		let player_container = abilities_container.GetParent();
		let player_container_id = player_container.id;
		if (ability_panel.BHasClass("Locked")) {
			SendErrorMessage("#swap_locked");
			return;
		}
		if (ability_panel.BHasClass("swap_cooldown")) {
			SendErrorMessage("#swap_cooldown");
			return;
		}
		if (player_container.BHasClass("SameAbilityLocked")) {
			SendErrorMessage("#player_has_this_ability");
			return;
		}
		let ability_name = ability_panel.GetChild(0).abilityname;
		if (player_id != local_player_id && player_abilities[local_player_id][ability_name]) {
			SendErrorMessage("#already_have_this_ability");
			return;
		}

        var hero_name = Players.GetPlayerSelectedHero(local_player_id)
        if (heroExclusion[hero_name]) {
            for (var i = 0; i <=heroExclusion[hero_name].length-1 ; i++) {               
               var exclusion = heroExclusion[hero_name][i]
               
               if (player_id != local_player_id &&  ability_name==exclusion) {
				  SendErrorMessage("#conflict_hero");
				  return;
			   }
            }
        }

		for (var other_player_id in player_abilities) {
			if (other_player_id == player_id) {
				continue;
			}
			if (player_abilities[other_player_id] && player_panels[other_player_id]) {
				let player_panel = player_panels[other_player_id];
				let lock_state = Boolean(player_abilities[other_player_id][ability_name]);
				player_panel.SetHasClass("SameAbilityLocked", lock_state);			
				// reset selection only if selected ability belongs to this player
				if (
					lock_state && selection_pair.other &&
					selection_pair.other.GetParent().GetParent().id == "player_" + other_player_id
				) {
					selection_pair.other.SetHasClass("Selected", false);
					selection_pair.other = null;
				}
			}
		}

        //判断是否跟对手的技能冲突
        //如果选的是队友的技能
		if (player_container_id!=own_player_id)
		{    
			//如果 自己的技能与队友的某个技能冲突
            if (selection_pair.own)
            {
            	let own_ability_index = parseInt(selection_pair.own.id.split("_")[1]);
                let own_ability_name =  Abilities.GetAbilityName(own_ability_index)
                if (abilityExclusion[own_ability_name]) {
		            for (var i = 0; i <=abilityExclusion[own_ability_name].length-1 ; i++) {               
		               var exclusion = abilityExclusion[own_ability_name][i]

		               if (player_id != local_player_id &&  player_abilities[player_id][exclusion] && exclusion!=ability_name ) {
						  SendErrorMessage("#conflict_teammate_ability");
						  return;
					   }
		            }
		        }
                
                if (abilityExclusion[ability_name]) {
		            for (var i = 0; i <=abilityExclusion[ability_name].length-1 ; i++) {               
		               var exclusion = abilityExclusion[ability_name][i]
		               if (player_abilities[local_player_id][exclusion] && exclusion!=own_ability_name ) {
						  SendErrorMessage("#conflict_ability");
						  return;
					   }
		            }
		        }

                //检查模型互斥
		        var hero_name = Players.GetPlayerSelectedHero(player_id)
		        if (heroExclusion[hero_name]) {
		            for (var i = 0; i <=heroExclusion[hero_name].length-1 ; i++) {               
		               var exclusion = heroExclusion[hero_name][i]		               
		               if (own_ability_name==exclusion) {
						  SendErrorMessage("#conflict_teammate_model");
						  return;
					   }
		            }
		        }
            }                  
		}
        
        //如果选的是自己的技能
		if (player_container_id==own_player_id)
		{    
            if (selection_pair.other && selection_pair.other_player_id)
            {
            	//如果 自己的技能与队友的某个技能冲突
            	let other_ability_index = parseInt(selection_pair.other.id.split("_")[1]);
                let other_ability_name =  Abilities.GetAbilityName(other_ability_index);

                if (abilityExclusion[ability_name]) {
		            for (var i = 0; i <=abilityExclusion[ability_name].length-1 ; i++) {               
		               var exclusion = abilityExclusion[ability_name][i]
		               if (player_abilities[other_player_id][exclusion] && exclusion!=other_ability_name) {
						  SendErrorMessage("#conflict_teammate_ability");
						  return;
					   }
		            }
		        }
		        //如果 队友的技能与自己技能冲突
		        if (abilityExclusion[other_ability_name]) {
		            for (var i = 0; i <=abilityExclusion[other_ability_name].length-1 ; i++) {               
		               var exclusion = abilityExclusion[other_ability_name][i]
		               if (player_abilities[local_player_id][exclusion] && exclusion!=ability_name ) {
						  SendErrorMessage("#conflict_ability");
						  return;
					   }
		            }
		        }

            }
            //检查模型互斥
            var hero_name = Players.GetPlayerSelectedHero(selection_pair.other_player_id)
	        if (heroExclusion[hero_name]) {
	            for (var i = 0; i <=heroExclusion[hero_name].length-1 ; i++) {               
	               var exclusion = heroExclusion[hero_name][i]		               
	               if (ability_name==exclusion) {
					  SendErrorMessage("#conflict_teammate_model");
					  return;
				   }
	            }
	        }        
		}


		if (!player_container_id.includes("player")) {
			return;
		}
		if (own_player_id == player_container_id) {
			if (selection_pair.own == ability_panel)
			{
			   selection_pair.own.SetHasClass("Selected", false);
               selection_pair.own = null;
			} else {
              if (selection_pair.own) {
				selection_pair.own.SetHasClass("Selected", false);
			  }
			  selection_pair.own = ability_panel;
			  selection_pair.own.SetHasClass("Selected", true);
			}
		} else {
            
            if (selection_pair.other == ability_panel)
			{
			   selection_pair.other.SetHasClass("Selected", false);
			   selection_pair.other = null;
			   selection_pair.other_player_id = null;
            }
            else
            {
			   if (selection_pair.other) {
					selection_pair.other.SetHasClass("Selected", false);
			   }
			   selection_pair.other = ability_panel;
			   selection_pair.other_player_id = player_id;
			   selection_pair.other.SetHasClass("Selected", true);
		    }
		}
		Game.EmitSound("ui_learn_select");
	};
}

function accept_swap(data, panel) {
	return () => {
		Game.EmitSound("General.ButtonClick");
		panel.DeleteAsync(0.5);
		panel.SetHasClass("RemovingSwap", true);
		GameEvents.SendCustomGameEventToServer("AcceptTeammateSwap", data);
	};
}

function decline_swap(data, panel) {
	return () => {
		Game.EmitSound("General.ButtonClickRelease");
		panel.DeleteAsync(0.5);
		panel.SetHasClass("RemovingSwap", true);
		GameEvents.SendCustomGameEventToServer("DeclineTeammateSwap", data);
	};
}

function BindEvents(ability_panel, ability_name, index, player_id) {
	ability_panel.SetPanelEvent("onmouseover", ShowTooltip(ability_panel, ability_name, index));
	ability_panel.SetPanelEvent("onmouseout", HideTooltip(ability_panel));
	ability_panel.SetPanelEvent("onactivate", SelectAbility(ability_panel, player_id));
}

function BindPlayerPanelEvents(panel) {
	panel.SetPanelEvent("onmouseover", () => {
		if (panel.BHasClass("SameAbilityLocked")) {
			$.DispatchEvent("DOTAShowTextTooltip", panel, $.Localize("#player_has_this_ability"));
		}
	});
	panel.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideTextTooltip");
	});
}

function _CheckDeletedPanel(panel, player_id) {
	if (selection_pair.own && selection_pair.own === panel) {
		selection_pair.own.SetHasClass("Selected", false);
		selection_pair.own = null;
	}

	if (selection_pair.other && selection_pair.other === panel) {
		selection_pair.other.SetHasClass("Selected", false);
		selection_pair.other = null;
	}
	let ability_index = panel.GetChild(0).contextEntityIndex;
	if (!ability_index) {
		return;
	}
	let ability_name = Abilities.GetAbilityName(ability_index);
	if (!ability_name) {
		return;
	}
	if (panels_with_cooldown[ability_name]) {
		panels_with_cooldown[ability_name].delete(panel);
	}
	if (player_abilities[player_id][ability_name]) {
		player_abilities[player_id][ability_name] = null;
	}
}

function IsAbilityInnate(ability) {
	var abilityName = Abilities.GetAbilityName(ability);
    return false;
}

function UpdatePlayerAbilities(player_panel, hero_entindex, player_id) {
	let container = player_panel.GetChild(2);
	let abilities = [];
	let prev_panel;
	player_abilities[player_id] = {};
	for (var i = 0; i < 30; i++) {
		let ability = Entities.GetAbility(hero_entindex, i);
		if (!ability || Abilities.IsHidden(ability) || ability == -1) {
			continue;
		}

		let ability_name = Abilities.GetAbilityName(ability);

		if (IsAbilityInnate(ability)){
			continue;
		}

		if (ability_name.includes("special_bonus_")) {
			continue;
		}

		let list = GameUI.CustomUIConfig().SubAbislityKv
		for (const name in list) {
			if (name == ability_name) {
				continue;
			}
		}
		// let nettable_record = CustomNetTables.GetTableValue("subsidiary_list", ability_name);
		// if (nettable_record != undefined) {
		// 	continue;
		// }
        // 如果是不可移除的技能
		if (unremovableAbilities[ability_name]!= undefined)
		{
             continue;
		}
		
		let ability_panel_id = "ability_" + ability;

		abilities.push(ability_panel_id);

		let ability_panel = $("#" + ability_panel_id);

		if (!ability_panel) {
			ability_panel = $.CreatePanel("Panel", container, ability_panel_id);
			ability_panel.BLoadLayoutSnippet("ability_container");

			let ability_image = ability_panel.GetChild(0);
			ability_image.abilityname = ability_name;
			ability_image.contextEntityIndex = ability;

			ability_panel.SetHasClass("Activating", true);

			if (prev_panel) {
				container.MoveChildAfter(ability_panel, prev_panel);
			}

			ability_panel.SetHasClass("passive_ability", Abilities.IsPassive(ability));

			BindEvents(ability_panel, ability_name, hero_entindex, player_id);
		}

		Abilities.UnlockAbility(player_id, ability_name);

		player_abilities[player_id][ability_name] = ability_panel;

		prev_panel = ability_panel;
	}
	// since we are not recreating panels each time
	// and order of them may change
	// we need to reflect that, reordering them
	let ability_panels = container.Children();
	ability_panels.forEach((panel) => {
		if (!panel) {
			return;
		}
		let panel_index = abilities.indexOf(panel.id);
		let child_index = container.GetChildIndex(panel);
		if (panel_index == -1) {
			panel.SetHasClass("Removing", true);
			_CheckDeletedPanel(panel, player_id);
			panel.DeleteAsync(0.5);
		}
		if (panel_index != child_index) {
			let child_index_new = child_index + panel_index - child_index;
			if (panel_index > child_index) {
				container.MoveChildAfter(panel, container.GetChild(child_index_new));
				ability_panels = container.Children();
			} else {
				if (child_index_new >= 0) {
					container.MoveChildBefore(panel, container.GetChild(child_index_new));
					ability_panels = container.Children();
				}
			}
		}
	});
}

function UpdateTeamPlayers() {
	let container = $("#page_swap_players");
	let teamId = Players.GetTeam(Game.GetLocalPlayerID());
	let team = Game.GetTeamDetails(teamId);
	let teamPlayers = Game.GetPlayerIDsOnTeam(teamId);

	teamPlayers.forEach((player_id) => {
		let player_info = Game.GetPlayerInfo(player_id);
		let hero_entindex = Players.GetPlayerHeroEntityIndex(player_id);
		let steamid = player_info.player_steamid;

		let panel_id = "player_" + player_id;
		let player_panel = $("#" + panel_id);

		if (!player_panel) {
			player_panel = $.CreatePanel("Panel", container, panel_id);
			player_panel.BLoadLayoutSnippet("player_container");
		}

		player_panel.GetChild(0).heroname = Entities.GetUnitName(hero_entindex);
		player_panel.GetChild(1).steamid = steamid;
		player_panel.player_id = player_id;
		player_panels[player_id] = player_panel;

		BindPlayerPanelEvents(player_panel);
		UpdatePlayerAbilities(player_panel, hero_entindex, player_id);
	});
}

function UpdateTimer(panel, parent) {
	if (!panel) {
		return;
	}

	if (!parent.BHasClass("RemovingSwap")) {
		panel.value -= 0.4;
		if (panel.value <= 0.0) {
			Game.EmitSound("General.ButtonClickRelease");
			parent.DeleteAsync(0.5);
			parent.SetHasClass("RemovingSwap", true);
			return;
		}
		$.Schedule(0.4, function () {
			UpdateTimer(panel, parent);
		});
	}
}

function ShowSwap(keys) {
    if (keys.item_index)
    {
       $("#ProposeButton").enabled=true;
       $("#page_swap").item_index=keys.item_index;
    }

    $("#page_swap").ui_secret=keys.ui_secret;
	$("#page_swap").AddClass("Show");

	Game.EmitSound("ui_custom_lobby_drawer_slide_out");
}

function HideSwap() {
	$("#page_swap").RemoveClass("Show");
}

function ProposeSwap() {
	if (!selection_pair.own || !selection_pair.other) {
		return;
	}
	let own_ability_index = parseInt(selection_pair.own.id.split("_")[1]);
	let other_ability_index = parseInt(selection_pair.other.id.split("_")[1]);
	GameEvents.SendCustomGameEventToServer("ProposeTeammateSwap", {
		own: own_ability_index,
		other: other_ability_index,
		ui_secret:$("#page_swap").ui_secret,
		item_index:$("#page_swap").item_index
	});
	selection_pair.own.SetHasClass("Selected", false);
	selection_pair.other.SetHasClass("Selected", false);

	selection_pair.own = null;
	selection_pair.other = null;
	$("#ProposeButton").enabled=false

}

function SwapProposed(data) {
	let panel_id = "swap_proposal_" + data.own + "_" + data.other;
	swap_panel = $.CreatePanel("Panel", proposal_container, panel_id);
	swap_panel.BLoadLayoutSnippet("proposal_container");

	let proposer = Abilities.GetCaster(data.own);
	let receiver = Abilities.GetCaster(data.other);

	let proposer_id = Entities.GetPlayerOwnerID(proposer);
	let receiver_id = Entities.GetPlayerOwnerID(receiver);

	let proposer_game_info = Game.GetPlayerInfo(proposer_id);

	swap_panel.GetChild(1).steamid = proposer_game_info.player_steamid;

	let abilities_container = swap_panel.GetChild(2);

	let first_ability = abilities_container.GetChild(0);
	let ability_name = Abilities.GetAbilityName(data.own);
	first_ability.BLoadLayoutSnippet("ability_container");
	first_ability.GetChild(0).abilityname = ability_name;
	first_ability.GetChild(1).heroname = Entities.GetUnitName(proposer);
	first_ability.SetHasClass("caster_showcase", true);
	BindEvents(first_ability, ability_name, proposer, proposer_id);

	let second_ability = abilities_container.GetChild(2);
	ability_name = Abilities.GetAbilityName(data.other);
	second_ability.BLoadLayoutSnippet("ability_container");
	second_ability.GetChild(0).abilityname = Abilities.GetAbilityName(data.other);
	second_ability.GetChild(1).heroname = Entities.GetUnitName(receiver);
	second_ability.SetHasClass("caster_showcase", true);
	BindEvents(second_ability, ability_name, receiver, receiver_id);

	let accept_button = swap_panel.GetChild(3);
	let decline_button = swap_panel.GetChild(4);

	accept_button.SetPanelEvent("onactivate", accept_swap(data, swap_panel));
	decline_button.SetPanelEvent("onactivate", decline_swap(data, swap_panel));

	UpdateTimer(swap_panel.GetChild(5), swap_panel);

	Game.EmitSound("swap_popup_sound");
}

function LockAbilities(event) {
	let own = $("#ability_" + event.own);
	let other = $("#ability_" + event.other);

	if (!own || !other) {
		return;
	}

	own.SetHasClass("Locked", true);
	other.SetHasClass("Locked", true);

	own.GetChild(1).heroname = Entities.GetUnitName(Abilities.GetCaster(event.own));
	own.GetChild(2).heroname = Entities.GetUnitName(Abilities.GetCaster(event.other));

	other.GetChild(1).heroname = Entities.GetUnitName(Abilities.GetCaster(event.own));
	other.GetChild(2).heroname = Entities.GetUnitName(Abilities.GetCaster(event.other));
}

function UnlockAbilities(event) {

	let panel = $("#ability_" + event.own);

	if (panel) {
		panel.SetHasClass("Locked", false);
	}

	panel = $("#ability_" + event.other);

	if (panel) {
		panel.SetHasClass("Locked", false);
	}
	

	if (1==event.accepted) {
	   UpdateTeamPlayers();
	} else {
	   if (event.proposer_id == Game.GetLocalPlayerID())
	   {
	   	   SendErrorMessage("#swap_declined"); 
	   }
	}
    
    $.Schedule(0.7, function() {     
      HideSwap()
    });

}

function SwapNotValide(event) {

	let panel = $("#ability_" + event.own);

	if (panel) {
		panel.SetHasClass("Locked", false);
	}

	panel = $("#ability_" + event.other);

	if (panel) {
		panel.SetHasClass("Locked", false);
	}
	
    $.Schedule(0.7, function() {     
      HideSwap()
    });

}

function OnlyMutiPlayerWarn() {
  SendErrorMessage("#only_multi_player_map")
}

// function OnlyUseOneTime() {
//   SendErrorMessage("#only_use_one_time")
// }

// function CanNotCastDuringRage() {
//   SendErrorMessage("#can_not_cast_during_rage")
// }

// function CanNotCastDuringLil() {
//   SendErrorMessage("#can_not_cast_during_lil")
// }


function ConflictAbility() {
  SendErrorMessage("#conflict_ability");
}

function ConflictTeammateAbility() {
  SendErrorMessage("#conflict_teammate_ability");
}

function ConflictModel() {
  SendErrorMessage("#conflict_hero");
}

function ConflictTeammateModel() {
  SendErrorMessage("#conflict_teammate_model");
}



(function () {

    //展示换技能页面
	GameEvents.Subscribe("ShowSwap", ShowSwap);
	GameEvents.Subscribe("UpdateTeamPlayers", UpdateTeamPlayers);

	GameEvents.Subscribe("SwapProposed", SwapProposed);
	GameEvents.Subscribe("LockAbilities", LockAbilities);
	GameEvents.Subscribe("UnlockAbilities", UnlockAbilities);
	GameEvents.Subscribe("SwapNotValide", SwapNotValide);

	GameEvents.Subscribe("OnlyMutiPlayerWarn", OnlyMutiPlayerWarn);
	// GameEvents.Subscribe("CanNotCastDuringRage", CanNotCastDuringRage);
	// GameEvents.Subscribe("CanNotCastDuringLil", CanNotCastDuringLil);
	GameEvents.Subscribe("ConflictAbility", ConflictAbility);
	GameEvents.Subscribe("ConflictTeammateAbility", ConflictTeammateAbility);
    GameEvents.Subscribe("ConflictModel", ConflictModel);
    GameEvents.Subscribe("ConflictTeammateModel", ConflictTeammateModel);
})();