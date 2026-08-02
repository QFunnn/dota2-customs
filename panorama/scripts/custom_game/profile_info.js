--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('profile_info', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var Player = require('./Player.js');

const ProfileInfo = props => {
  const player_id = () => props.player_id ?? (props.steamID == undefined ? -1 : Players.GetLocalPlayer());
  const steamID = () => {
    return props.steamID ?? getPlayerData(player_id(), "steamID");
  };
  const [avatarBorder, setAvatarBorder] = libs.createSignal(5710000);
  const [avatarBackground, setAvatarBackground] = libs.createSignal(5720000);
  const [avatarDecoration, setAvatarDecoration] = libs.createSignal(5730000);
  const [decorationSuffix, setDecorationSuffix] = libs.createSignal("");
  const [equippedOrnamentData, setEquippedOrnamentData] = libs.createSignal({});
  libs.createEffect(() => {
    let avatar_decoration = props.avatar_decoration;
    const current_equippedOrnamentData = equippedOrnamentData();
    if (current_equippedOrnamentData != undefined && Object.keys(current_equippedOrnamentData).length > 0) {
      if (avatar_decoration == undefined && current_equippedOrnamentData[OrnamentType.AVATAR_DECORATION] != undefined) {
        avatar_decoration = finiteNumber(Number(Object.keys(current_equippedOrnamentData[OrnamentType.AVATAR_DECORATION.toString()] ?? {})[0]), 5730000);
      }
    }
    const language = $.Language().toLowerCase();
    const path = `file://{images}/custom_game/avatar_decoration/${avatar_decoration}_${language}.png`;
    if (language == "english" || language == "russian") {
      if ($.BImageFileExists(path)) {
        setDecorationSuffix(`_${language}`);
      } else {
        setDecorationSuffix("");
      }
    }
    setAvatarDecoration(avatar_decoration ?? 5730000);
  });
  libs.createEffect(() => {
    let avatar_background = props.avatar_background;
    const current_equippedOrnamentData = equippedOrnamentData();
    if (current_equippedOrnamentData != undefined && Object.keys(current_equippedOrnamentData).length > 0) {
      if (avatar_background == undefined && current_equippedOrnamentData[OrnamentType.AVATAR_BACKGROUND] != undefined) {
        avatar_background = finiteNumber(Number(Object.keys(current_equippedOrnamentData[OrnamentType.AVATAR_BACKGROUND.toString()] ?? {})[0]), 5720000);
      }
    }
    setAvatarBackground(avatar_background ?? 5720000);
  });
  libs.createEffect(() => {
    let avatar_border = props.avatar_border;
    const current_equippedOrnamentData = equippedOrnamentData();
    if (current_equippedOrnamentData != undefined && Object.keys(current_equippedOrnamentData).length > 0) {
      if (avatar_border == undefined && current_equippedOrnamentData[OrnamentType.AVATAR_BORDER] != undefined) {
        avatar_border = finiteNumber(Number(Object.keys(current_equippedOrnamentData[OrnamentType.AVATAR_BORDER.toString()] ?? {})[0]), 5710000);
      }
    }
    setAvatarBorder(avatar_border ?? 5710000);
  });
  libs.createEffect(libs.on(() => props.player_id, player_id => {
    let data = {};
    if (player_id != -1) {
      data = getServiceNetTable("player_equipped_ornament", player_id);
    }
    setEquippedOrnamentData(data ?? {});
  }));
  libs.onMount(() => {
    const id = useServiceNetTable("player_equipped_ornament", (data, playerID) => {
      if (props.player_id == playerID) {
        setEquippedOrnamentData(data);
      }
    }, -1);
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {}, null);
    libs.insert(_el$, libs.createComponent(GenericPanel.CImage, {
      id: "CardBG",
      get src() {
        return getSrcPath(`avatar_background/${avatarBackground()}.png`);
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.battle_position != undefined;
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          get className() {
            return libs.classNames("CardBorderOverlay", props.battle_position);
          }
        });
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "CardDEC",
      get backgroundImage() {
        return getImagePath(`avatar_decoration/${avatarDecoration()}${decorationSuffix()}.png`);
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "ProfileInfoContainer",
      get children() {
        return [libs.createComponent(Player.PlayerAvatar, {
          get steamID() {
            return steamID();
          },
          get playerID() {
            return player_id();
          },
          get ban() {
            return props.ban ?? isNameBan(player_id());
          },
          get avatar_border() {
            return avatarBorder();
          },
          get avatar_frame() {
            return props.avatar_frame;
          }
        }), libs.createComponent(Player.PlayerName, {
          get steamID() {
            return steamID();
          },
          get playerID() {
            return player_id();
          },
          get ban() {
            return props.ban ?? isNameBan(player_id());
          }
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "SteamID",
          get text() {
            return $.Localize("#DOTA_Friends_ID") + (steamID().indexOf("11111111111") != -1 ? "********" : steamID());
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return props.edit;
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_BaseButton, {
              id: "editBtn",
              onactivate: () => {
                ToggleWindows("MenuButton_cosmetics", true);
                clientSideEvent("jump_to_account", {});
              }
            });
          }
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("ProfileInfo", {
      battleMode: props.battle_position != undefined
    }), _$p));
    return _el$;
  })();
};

exports.ProfileInfo = ProfileInfo;