--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
CONTEXT.style.backgroundColor = "#1a2a3a"
CONTEXT.style.padding = "0"
CONTEXT.style.border = "2px solid #3a4a5a"

var decription_attributes = CustomNetTables.GetTableValue( "set_attributes", 'set_attributes')
var boost_attributes = CustomNetTables.GetTableValue( "boost_attributes", 'boost_attributes')
var can_use_sets = CustomNetTables.GetTableValue( "can_use_sets", 'can_use_sets')

function CheckFullSet(all_data) {
    var data = all_data.hero_enquip;
    var filledItems = 0;
    var setType = null;

    for (const itemKey in data) {
        const itemData = data[itemKey];
        if (itemData != null) {
            filledItems++;
            if (setType == null) {
                setType = itemData.set_type;
            } else if (setType !== itemData.set_type) {
                return false;
            }
        }
    }
    return filledItems === 6;
}

function setTooltip(){
	const item_data = CONTEXT.GetAttributeString(`item_data`, undefined);
	const all_data = CONTEXT.GetAttributeString(`all_data`, undefined);
	
	data = JSON.parse(item_data)

	if (data.level < 3){
		color = "#b0c3d9"
	}else if(data.level == 3 || data.level == 4){
		color = "#5e98d9"
	}else if(data.level == 5 || data.level == 6){
		color = "#4b69ff"
	}else if(data.level == 7 || data.level == 8){
		color = "#8847ff"
	}else if(data.level == 9 ){
		color = "#d32ce6"
	}else if(data.level == 10 ){
		color = "#e4ae39"
	}else if(data.level == 11 ){
		color = "#ed0c2e"
	}
	
    var percent = ['lifesteal', 'magic_lifesteal', 'reflect', 'spell_amplify', 'magic_desolator', 'hp_regen', 'legs', 'shield', 'manacost', 'hp_regen_amp', 'crit', 'multicast', 'magic_crit'];
    var int_num = ['head', 'legs', 'weapon'];
	
	if (percent.includes(data.item_type)){
		perc = '%'
	}else{
		perc = ''
	}
	if (int_num.includes(data.item_type)){
		num = 0
	}else{
		num = 1
	}
	if (CheckFullSet(all_data)){
		mult = 2
	}else{
		mult = 1
	}
	
	if (data.set_type == 'jewell'){
		$("#TooltipImage").SetImage('file://{resources}/images/sets/'+ data.item_type + '.png');
		$("#TooltipName").text = $.Localize("#"+data.set_type+"_"+data.item_type)
		$("#TooltipName").style.color = 'violet'
		$("#MainInfo").style.backgroundColor = "gradient(linear, 50% 0%, 50% 100%, from(" + "#8847ff" + "), to(transparent))";
		$("#BaseAttribute").text = $.Localize("#"+data.item_type+"_description") + ": " + data.level
		$("#Descr").visible = false
	}else{
		$("#TooltipImage").SetImage('file://{resources}/images/sets/' + data.set_type + '/' + data.item_type + '.png');
		$("#TooltipName").text = $.Localize("#"+data.set_type+"_"+data.item_type) + " " + data.level
		$("#TooltipName").style.color = 'white'
		$("#MainInfo").style.backgroundColor = "gradient(linear, 50% 0%, 50% 100%, from(" + color + "), to(transparent))";
		$("#BaseAttribute").text = $.Localize("#"+data.item_type+"_description") + " " + (decription_attributes[[data.item_type]] * data.level * data.set_number) + perc
		
		const minLevelToUse = can_use_sets[data.set_number.toString()].min
		if (minLevelToUse <= 0) {
			$("#Descr").visible = false
			CONTEXT.FindChildTraverse("DescrSourceValueLine").visible = false
		} else {
			$("#Descr").visible = true
			$("#Descr").text = $.Localize("#min_level_use") + " " + minLevelToUse
			CONTEXT.FindChildTraverse("DescrSourceValueLine").visible = true
		}
	}
	
	const bonus_attr = $("#BonusAttribute")
	bonus_attr.RemoveAndDeleteChildren()
	
	let lastHr
	
	for (const attrKey in data.bonus_attribute) {
		let label = $.CreatePanel("Label", bonus_attr, "")
		label.AddClass('bonus_label')
	
		if (percent.includes(attrKey)){
			perc = '%'
		}else{
			perc = ''
		}
		if (int_num.includes(attrKey)){
			num = 0
		}else{
			num = 1
		}

		label.text = $.Localize("#"+attrKey+"_description") + " " + (decription_attributes[attrKey] * data.set_number +  boost_attributes[attrKey][data.set_number] * (data.level - 1)).toFixed(num) + perc  
		lastHr = $.CreatePanel("Panel", bonus_attr, "hr") 
	}
	
	if (lastHr) {
		lastHr.DeleteAsync(0)
		bonus_attr.style.padding = "4px 9px"
		CONTEXT.FindChildTraverse("BonusSourceValueLine").visible = true
	} else {
		bonus_attr.style.padding = "0"
		CONTEXT.FindChildTraverse("BonusSourceValueLine").visible = false
	}
}