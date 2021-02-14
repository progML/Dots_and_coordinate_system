<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Лабораторная работа №2</title>
  <link rel="stylesheet" type="text/css">
  <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
  <style type="text/css">
    h2{
      padding-left: 700px;
      padding-top: 100px;
    }
    header {
      margin: 0;
      background-color: cadetblue;
      padding: 1px;
      text-align: center;
      border: 3px solid black;
      font-family: sans-serif;
      font-size: 15px;
      border-radius: 9px;
    }

    iframe{

      border : 0px;
      float: right;
      margin-top: -300px;
      height: 700px;
    }

    .right_block{
      height: auto;
      width: 1024px;
      background-color: white;
      float:right;
    }

    .graphic{
      background-color: white;
    }

    /**/
    .left_block {
      height: 900px;
      width: 400px;
      background-color: white;
      float:left;
    }




    #submit {
      width: 165px;
      background-color: aliceblue;
      color: black;
      border-color: black;
      margin-top: 15px;
    }


    #submit:hover{
      background-color: cadetblue;
    }


  </style>
</head>
<body>
<header>
  <h1>Проверка поподания точки в закрашенную область</h1>
</header>


<div class="left_block">
  <div class="form">


    <form action="controller" method="get" target="graphics" onsubmit="return draw(this) && sendForm()  ">

      <h3>Выберите X:</h3>
      <table>

        <tr>
          <td><input type="radio" name="X" id="x1" value="-2" ><label>-2</label></td>
          <td> <input type="radio" name="X" id="x2" value="-1.5"><label>-1.5</label></td>
          <td><input type="radio" name="X" id="x3" value="-1"><label>-1</label></td>
        </tr>
        <tr>
          <td><input type="radio" name="X" id="x4" value="-0.5"><label>-0.5</label></td>
          <td><input type="radio" name="X" id="x5" value="0"><label>0</label></td>
          <td><input type="radio" name="X" id="x6" value="0.5"><label>0.5</label></td>
        </tr>
        <tr>

          <td><input type="radio" name="X" value="1"><label>1</label></td>
          <td><input type="radio" name="X" value="1.5"><label>1.5</label></td>
          <td><input type="radio" name="X" value="2"><label>2</label></td>

        </tr>
      </table>

      <h3>Выберите координату Y:</h3>
      <input id="SelectY" name="Y" type="Text" placeholder="От -3 до 3">


      <h3>Выберите радиус R:</h3>
      <input name="R" type="Text" id="r" placeholder="От 1 до 4 ">
      <p><input type="submit" id="submit" value="SUBMIT" onclick="onsubmit"></p>
      <div id="warm"></div>
    </form>
    <span id="incorrect"></span>
  </div>


  <%--<div class="graphic" >--%>
    <%--<canvas id="plot" width="300" height="300" ></canvas>--%>
  <%--</div>--%>

</div>



<div class="right_block">
  <div class="graphic" >
    <canvas id="plot" width="300" height="300" ></canvas>
  </div>
  <span id="results1"></span>
  <iframe  height="600" width="400" id="if" name = "graphics" allowtransparency="true" style="background: white;" >
  </iframe>
</div>


<script type="text/javascript">


    var plot_canvas = document.getElementById("plot");
    var plot_context = plot_canvas.getContext("2d");
    var rr = document.getElementById("r");
    plot_context.beginPath();
    plot_context.arc(150, 150, 100, 0 - Math.PI/2, 0); //Кружочек



    plot_context.lineTo(150, 150); //Прямоугольник
    plot_context.closePath();
    plot_context.rect(150, 150, 50, 100);
    plot_context.fillStyle = 'blue';
    plot_context.fill();

    plot_context.beginPath();  //Треугольник
    plot_context.moveTo(150,150);
    plot_context.lineTo(150, 100);
    plot_context.lineTo(50, 150);
    plot_context.closePath();
    plot_context.fillStyle = 'blue';
    plot_context.fill();

    plot_context.beginPath();


    //x
    plot_context.moveTo(30, 150);
    plot_context.lineTo(270, 150);
    plot_context.lineTo(260, 140);
    plot_context.moveTo(270, 150);
    plot_context.lineTo(260, 160);
    //y
    plot_context.moveTo(150, 30);
    plot_context.lineTo(140, 40);
    plot_context.moveTo(150, 30);
    plot_context.lineTo(160, 40);
    plot_context.moveTo(150, 30);
    plot_context.lineTo(150, 270);
    plot_context.moveTo(30, 150);
    plot_context.closePath();
    plot_context.stroke();




    var x;
    var y;
    rr.addEventListener("click", changeR, false);
    plot_canvas.addEventListener("click", drawPoint, false);

    function drawPoint(e) {
        var R = document.getElementById("r").value;
        $('#results1').hide();
        if (R == "") {
            document.getElementById("incorrect").innerHTML = "Не выбран радиус R";
        } else {
            document.getElementById("incorrect").innerHTML = "";
            var cell = getCursorPosition(e);
            plot_context.beginPath();
            plot_context.rect(x, y, 5, 5);
            x -= 150;
            y -= 150;
            y *= -1;
            x = x / 100 * R;
            y = y / 100 * R;
            alert(x + " " + y);
            $.ajax({
                type: 'get',//тип запроса: get,post либо head
                url: 'controller',//url адрес файла обработчика
                data: {'X': x, 'Y': y, 'R': R},//параметры запроса
                response: 'text',//тип возвращаемого ответа text либо xml
                error: function (message) {
                    console.log(message);
                },
                success: function (data) {//возвращаемый результат от сервера
                    console.log(data);
                    var ifr = document.getElementById('if').contentDocument;
                    ifr.open();
                    ifr.writeln(data);
                    ifr.close();
                    var stra = $('#results1').html(data);
                    stra = stra.text();

                   // var numy = stra.search("Miss");
                   //  console.log(de)

                    var numy = stra.search("Miss");
                    console.log(numy)
                    if (numy != -1) {
                        plot_context.fillStyle = 'red';
                    } else {
                        plot_context.fillStyle = 'green';
                    }
                    plot_context.fill();
                }
            });
        }
    }


    function getCursorPosition(e) {
        if (e.pageX != undefined && e.pageY != undefined) {
            x = e.pageX;
            y = e.pageY;
        }
        else {
            x = e.clientX + document.body.scrollLeft +
                document.documentElement.scrollLeft;
            y = e.clientY + document.body.scrollTop +
                document.documentElement.scrollTop;
        }
        x -= plot_canvas.offsetLeft ;
        y -= plot_canvas.offsetTop ;
    }
    function changeR(e) {
        if (document.getElementById('r').value.length != 0) {
            R = document.getElementById('r').value;
        }
    }

    function draw(form) {
        var R = document.getElementById("r").value;
        var x = form.X.value;
        var y = form.Y.value;
        x = x / R * 100 + 150;
        y = -1*(y / R * 100) + 150;

        plot_context.beginPath();
        plot_context.rect(x, y, 5, 5);
        plot_context.fillStyle = 'green';
        plot_context.fill();
        return true;
    }




     //   валидация

        function exepction(err_msg) {
            var warn = document.getElementById("warm");
            warn.innerHTML = err_msg;
        }


        function sendForm() {
            var er = " ";
            let res = false;
            let error = "Выберите X";
            let x_var = document.getElementsByName("X");
            for (let i = 0; i < x_var.length; i++)
                if (x_var[i].checked) {
                    res = true;
                    exepction(er);
                }
            if (!res) {
                exepction(error);
                return false;
            }

            res = false;
            error = "Вы вышли за ОДЗ";
            var y_var = parseFloat(document.getElementsByName("Y")[0].value);
            if (!isNaN(y_var) && y_var >= -3 && y_var <= 3) {
                res = true;
            }
            if (!res) {
                if (y_var <= -6 || y_var >= 4) {
                    exepction(error);
                } else if (isNaN(y_var)) {
                    exepction("Выберите Y <br> в приделах от -5 до 3");
                }
                return false;
            }


            res = false;
            error = "Вы вышли за ОДЗ";
            var r_var = parseFloat(document.getElementsByName("R")[0].value);
            if (!isNaN(r_var) && r_var >= 1 && r_var <= 4) {
                res = true;
            }
            if (!res) {
                if (isNaN(r_var)) {
                    exepction("Выберите R <br> в приделах от 1 до 4");
                } else if (r_var <= -1 || r_var >= 5) {
                    exepction(error);
                }
                return false;
            }

            return true;
        }

</script>
</body>

</html>
