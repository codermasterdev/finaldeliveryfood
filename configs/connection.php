<?php
# -------------------------------------------------#
#¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤#
#	¤                                            ¤   #
#	¤         Puerto Premium Survey 1.0          ¤   #
#	¤--------------------------------------------¤   #
#	¤              By Khalid Puerto              ¤   #
#	¤--------------------------------------------¤   #
#	¤                                            ¤   #
#	¤  Facebook : fb.com/prof.puertokhalid       ¤   #
#	¤  Instagram : instagram.com/khalidpuerto    ¤   #
#	¤  Site : http://www.puertokhalid.com        ¤   #
#	¤  Whatsapp: +212 654 211 360                ¤   #
#	¤                                            ¤   #
#	¤--------------------------------------------¤   #
#	¤                                            ¤   #
#	¤  Last Update: 16/09/2020                   ¤   #
#	¤                                            ¤   #
#¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤#
# -------------------------------------------------#

$connect = [
    // Database Host Name
    'HOSTNAME' => 'ilicnea_restaaurantemaria',

    // Database Username
    'USERNAME' => 'restauranteus',

    // Database Password
    'PASSWORD' => 'Gui0307',

    // Database Name
    'DATABASE' => 'restaurantebd'
];

# Tables' Prefix
define('prefix', 'pl_');

# No need to change anything bellow this line
$db = new mysqli($connect['HOSTNAME'], $connect['USERNAME'], $connect['PASSWORD'], $connect['DATABASE']);
if($db->connect_errno){
    echo "Failed to connect to MySQL: (" . $db->connect_errno . ") " . $db->connect_error;
		exit;
}


$sql_mode = $db->query("SELECT @@GLOBAL.sql_mode;");
$rs_mode = $sql_mode->fetch_assoc();
if(!empty($rs_mode["@@GLOBAL.sql_mode"])) {
	$db->query("SET GLOBAL sql_mode='';");
}
