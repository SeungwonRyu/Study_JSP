<%@ page language="java"
         import= "table.*"
         import= "java.util.ArrayList"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- chart.js cdn -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <!-- bootstrap cdn -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

  <style>
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
    }

    body {
      padding-top: 100px;
    }

    div * {
      overflow: auto;
    }

    .navbar {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
    }
  </style>

  <script>
    //setTimeout('location.reload()', 12000)

    setInterval(function() {
      $('#table').load(location.href + '#table > *' , '')
    }, 5000);


    setInterval(function() {
      $('#chart').load(location.href + '#chart > *' , '')
    }, 3000);
  </script>

  <%
    FeatureDAO featureDAO = new FeatureDAO();
    ArrayList<FeatureDTO> featureDTO = featureDAO.featureSelect();
  %>

  <title>DB TABLE</title>
</head>
<body class="p-3 mb-2 bg-secondary text-white bg-opacity-25">
<nav class="navbar navbar-light bg-light fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">SLIM Waveflow</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasNavbarLabel">SLIM</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="offcanvasNavbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Dropdown
            </a>
            <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown">
              <li><a class="dropdown-item" href="#">Action</a></li>
              <li><a class="dropdown-item" href="#">Another action</a></li>
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="#">Something else here</a></li>
            </ul>
          </li>
        </ul>
        <form class="d-flex">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
      </div>
    </div>
  </div>
</nav>

<div class= "container" style="margin-top: 20px;">
  <div class= "row">
    <div class= "col border rounded-3 shadow p-3 mb-5 bg-body rounded" id= "table">
      <table class= "table">
        <thead>
        <tr>
          <th scope= "col">#</th>
          <th scope= "col">Server Name</th>
          <th scope= "col">Feature</th>
          <th scope= "col">Max License</th>
        </tr>
        </thead>
        <tbody>
        <%
          ArrayList<String> featureList = new ArrayList<String>();
          ArrayList<Integer> licenseList = new ArrayList<Integer>();
          ArrayList<Integer> updateList = new ArrayList<Integer>();

          for(int i=0; i<featureDTO.size(); i++) {
            FeatureDTO fdto = featureDTO.get(i);
            int cnt = i+1;

            String serverName = fdto.getServerName();
            String feature = fdto.getFeature();
            int maxLicense = fdto.getMaxLicense();
            int updateLicense = fdto.getUpdateLicense();

            out.println("<tr>");
            out.println("<th scope= 'row'>" + cnt + "</th>");
            out.println("<td>" + serverName + "</td>");
            out.println("<td>" + feature + "</td>");
            out.println("<td>" + maxLicense + "</td>");
            out.println("</tr>");

            // javascript 배열로 변환
            featureList.add("'" + feature + "'");
            licenseList.add(maxLicense);
            updateList.add(updateLicense);
          }
        %>
        </tbody>
      </table>
    </div>

    <div class= "col border rounded-3 shadow p-3 mb-5 bg-body rounded" id= "chart" style="margin-left: 50px">
      <canvas id= "license-chart" width= "500px" height= "500px"></canvas>
    </div>

    <script>
      let feature = new Array()
      let license = new Array()

      <%for(int i=0; i<featureDTO.size(); i++) {
          FeatureDTO fdto = featureDTO.get(i);
      %>
      feature.push('<%= fdto.getFeature() %>')
      license.push('<%= fdto.getMaxLicense() %>')
      <%}%>

      new Chart(document.getElementById("license-chart"), {
        type: 'bar',
        data: {
          labels: feature,

          datasets: [
            {
              label: 'Max License',
              data: license,
              backgroundColor: '#46D0AC'
            }
          ]
        },
        options: {
          legend: { display: false },
          title: {
            display: true,
            text: 'License Chart'
          },
          responsive: true,
          maintainAspectRatio: false,
          pointHitRadius: 50,

          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true
              }
            }]
          }
        }
      })
    </script>

    <div class= "col-12 border rounded-3 shadow p-3 mb-5 bg-body rounded" id= "chart2">
      <canvas id= "license-chart-2" width= "500px" height= "500px"></canvas>
    </div>

    <script>
      let feature2 = new Array()
      let license2 = new Array()

      <%for(int i=0; i<featureDTO.size(); i++) {
          FeatureDTO fdto = featureDTO.get(i);
      %>
      feature2.push('<%= fdto.getFeature() %>')
      license2.push('<%= fdto.getUpdateLicense() %>')
      <%}%>

      new Chart(document.getElementById("license-chart-2"), {
        axis: 'y',
        type: 'line',
        data: {
          labels: feature2,

          datasets: [
            {
              label: 'Update License',
              data: license2,
              borderColor: '#FB3D6D'
            }
          ]
        },
        options: {
          legend: { display: false },
          title: {
            display: true,
            text: 'License Chart'
          },
          responsive: true,
          maintainAspectRatio: false,
          pointHitRadius: 50,

          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true
              }
            }]
          }
        }
      })
    </script>
  </div>
</div>
</body>
</html>