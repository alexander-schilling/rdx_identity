fx_version 'adamant'

game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'Multi character support for redm_extended.'

version '1.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

    'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

files {
	'html/ui.html',

    'html/css/pure-min.css',
	'html/css/app.css',

	'html/js/jquery.js',
	'html/js/app.js',
	
	'html/config/config.json',
	'html/config/language.json',

    'html/img/charbg.png',
    'html/img/female.png',
	'html/img/male.png',
	'html/img/money.png',
    'html/img/bank.png',
    'html/img/gold.png',

	'html/fonts/RDR/HapnaSlabSerif-DemiBold.eot',
	'html/fonts/RDR/HapnaSlabSerif-DemiBold.ttf',
	'html/fonts/RDR/HapnaSlabSerif-DemiBold.woff',
	'html/fonts/RDR/HapnaSlabSerif-DemiBold.woff2',
	'html/fonts/RDR/RDRCatalogueBold-Bold.eot',
	'html/fonts/RDR/RDRCatalogueBold-Bold.ttf',
	'html/fonts/RDR/RDRCatalogueBold-Bold.woff',
	'html/fonts/RDR/RDRCatalogueBold-Bold.woff2',
	'html/fonts/RDR/RDRGothica-Regular.eot',
	'html/fonts/RDR/RDRGothica-Regular.ttf',
	'html/fonts/RDR/RDRGothica-Regular.woff',
	'html/fonts/RDR/RDRGothica-Regular.woff2',
	'html/fonts/RDR/RDRLino-Regular.eot',
	'html/fonts/RDR/RDRLino-Regular.ttf',
	'html/fonts/RDR/RDRLino-Regular.woff',
	'html/fonts/RDR/RDRLino-Regular.woff2',
	'html/fonts/RDR/Redemption.eot',
	'html/fonts/RDR/Redemption.ttf',
	'html/fonts/RDR/Redemption.woff',
	'html/fonts/RDR/Redemption.woff2'
}

ui_page {
	'html/ui.html'
}

dependencies {
	'mysql-async',
	'async',
	'redm_extended'
}
