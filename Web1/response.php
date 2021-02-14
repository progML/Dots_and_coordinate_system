<!DOCTYPE html>
<html lang="en-us">
<html>
<head>
    <title>response page</title>
    <meta charset="utf-8">
    <style type="text/css">
        body {
            color: #fff;
            font-family: "Andale Mono", serif;
        }
        #time {
            text-align: right;
        }
        span {
            font-size: 120%;
        }
        table {
            border: 5px inset green;
            width: 400px;
            text-align: center;
        }
        tr td {
            border: 2px green;
        }
    </style>
</head>
<body>
<?php
if (session_id() === "") {
    session_start();
}
$start = microtime(true);

date_default_timezone_set("UTC");
$time = time() + 3 * 3600;
echo "<p id='time'>Текущее время: ".date("H:i:s", $time)."</p>";
$y=(float)$_POST['y'];
if($_POST['y'] == "-0.0" ||$_POST['y'] == "-0.00")$y = (int) 0;
$r=(int)$_POST['r'];
//if (empty($_POST['x1'])&empty($_POST['x2'])&empty($_POST['x3'])&empty($_POST['x4'])&empty($_POST['x6'])&(empty($_POST['x5'])&empty($_POST['x7'])&empty($_POST['x8'])&empty($_POST['x9']))) die ("Вы не выбрали переменную X");
//if(!empty($_POST['x1']) &  ($_POST['x1']<-2 or $_POST['x1']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x2']) &  ($_POST['x2']<-2 or $_POST['x2']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x3']) &  ($_POST['x3']<-2 or $_POST['x3']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x4']) &  ($_POST['x4']<-2 or $_POST['x4']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x5']) &  ($_POST['x5']<-2 or $_POST['x5']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x6']) &  ($_POST['x6']<-2 or $_POST['x6']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x7']) &  ($_POST['x7']<-2 or $_POST['x7']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x8']) &  ($_POST['x8']<-2 or $_POST['x8']>2)) die ("Получены неверные данные X");
//if(!empty($_POST['x9']) &  ($_POST['x9']<-2 or $_POST['x9']>2)) die ("Получены неверные данные X");
if(strlen($_POST['y']) == 0) die ("Вы не записали переменную Y");
if((strlen($_POST['y']) != 0) & ($_POST['y']<-5 or $_POST['y']>3)) die ("Получены неверные данные Y");
echo "Обработка данных: <br>";
if(!empty($_POST['r']) & ($_POST['r']<1 or $_POST['r']>5)) die ("Получены неверные данные R");
if(!empty($_POST['x1'])) fax($_POST['x1'], $y, $r);
if(!empty($_POST['x2'])) fax($_POST['x2'], $y, $r);
if(!empty($_POST['x3'])) fax($_POST['x3'], $y, $r);
if(!empty($_POST['x4'])) fax($_POST['x4'], $y, $r);
if(!empty($_POST['x6'])) fax($_POST['x6'], $y, $r);
//if(!(strlen($_POST['x5'])==0)) fax($_POST['x5'], $y, $r);
if(!empty($_POST['x7'])) fax($_POST['x7'], $y, $r);
if(!empty($_POST['x8'])) fax($_POST['x8'], $y, $r);
if(!empty($_POST['x9'])) fax($_POST['x9'], $y, $r);
if(!isset($_SESSION['x'])){
    $_SESSION['x'] = array();
}
if(!isset($_SESSION['y'])){
    $_SESSION['y'] = array();
}
if(!isset($_SESSION['r'])){
    $_SESSION['r'] = array();
}
if(!isset($_SESSION['getit'])){
    $_SESSION['getit'] = array();
}
echo "<table>";
echo "<tr>";
echo "<td>X";
echo "</td>";
foreach($_SESSION['x'] as $i => $base_value) {
    echo "<td>$base_value";
    echo "</td>";
}
echo "<tr>";
echo "</tr>";
echo "<td>Y";
echo "</td>";
foreach($_SESSION['y'] as $i => $base_value) {
    echo "<td>$base_value";
    echo "</td>";
}
echo "<tr>";
echo "</tr>";
echo "<td>R";
echo "</td>";
foreach($_SESSION['r'] as $i => $base_value) {
    echo "<td>$base_value";
    echo "</td>";
}
echo "<tr>";
echo "</tr>";
echo "<td>✓";
echo "</td>";
foreach($_SESSION['getit'] as $i => $base_value) {
    echo "<td>$base_value";
    echo "</td>";
}
echo "</tr>";
echo "</table>";

$t=(float)round((microtime(true)-$start), 4);
if($t==0)$t="менее 0.0001";
echo "Время работы скрипта: ".$t." сек<br>";

function fax($x, $y, $r) {
    if (($y<=($r-$x)&$x>=0&$y>=0)||($y>=(-$r)&$y<=0&$x>=0&$x<=$r)||((pow($x,2)+pow($y,2)<=(pow($r/2, 2)))&$y<=0&$x<=0))
    {
        echo "<p>Точка <span>(".$x.", ".$y.")</span> <b>входит</b> в закрашенную область графика с <span>R = ".$r."</span>!</p>";
        array_push($_SESSION['x'], $x);
        array_push($_SESSION['y'], $y);
        array_push($_SESSION['r'], $r);
        array_push($_SESSION['getit'], 1);
    } else {
        echo "<p>Точка <span>(".$x.", ".$y.")</span> <b>не входит</b> в закрашенную область графика с радиусом <span>R = ".$r."</span>!</p>";
    }

}

?>
</body>
</html>
