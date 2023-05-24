<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Bootstrap</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
      crossorigin="anonymous"
    />
    <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <style>
      .header-first {
        width: 40%;
      }
    </style>
  </head>
  <body>
    <form action="form-first" method="post">
      <header class="header-first border">
        <legend style="background-color: blue; color: aliceblue">
          Kiem tra tinh chan/le so nguyen
        </legend>
        <div class="container">
          <div class="row py-1">
            <div class="col">
                <label for="songuyen" class="form-lable">Nhap so nguyen:</label>
            </div>
            <div class="col">
              <input type="text" name="number" class="form-control">
            </div>
          </div>
          <div class="row py-1">
            <div class="col">
            <label for="songuyen" class="form-lable">Ket Qua:</label>
            </div>
            <div class="col">
              <input name="ketqua" class="form-control" value="<?php if($_POST["submit"]){  
                  $number = $_POST['number'];   
                  if(($number % 2) != 0){  
                      echo " $number là số lẻ";  
                  }else{  
                      echo " $number là số chẳn";  
                  }  
                  }   ?>" disabled />
            </div>
          </div>
          
        </div>
          <div class="row justify-content-center align-items-cneter">
            <div class="col-auto ">
              <input name="submit" class="btn btn-primary" type="submit"  value="SUBMIT">
            </div>
          </div>
      </header>
    </form>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  </body>
</html>

