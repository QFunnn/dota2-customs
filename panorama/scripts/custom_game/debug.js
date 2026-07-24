--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( 'NetTableDebugErrors', NetTableDebugErrors );

errorLabels = []

function NetTableDebugErrors( data ) {

	$.Msg('qqqqq')

	var data = CustomNetTables.GetTableValue("debug", "errors");
	$( "#DebugPanel" ).visible = true

	let i = 0

	for ( let k in data ) {
		if ( !errorLabels[i] ) {
			errorLabels[i] = $.CreatePanel( "Label", $( "#ErrorContainer" ), "" )
		}
			
		errorLabels[i].visible = true
		errorLabels[i].text = data[k]

		i++
	}

	while ( true ) {
		let err = errorLabels[i]

		if ( err ) {
			err.visible = false
		} else {
			break
		}

		i++
	}
}

$( "#DebugPanel" ).visible = false