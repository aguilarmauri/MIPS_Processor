var app = angular.module("app", []);

app.controller("appController", function ($scope, $http, $interval) {

  $scope.data = {
      clock: "00000001",
   };

   $scope.steps = [];
   $scope.json = [];

   $scope.leerJsons = function(){

     var i = $scope.steps.length;
     console.log("i vale "+i);
     var url = "http://localhost:9090/step";
     var pasos = 30;

     $http.get(url+i+'.json')
        .then(function(response) {
            console.log("json obtenido.");
            $scope.json[i] = response.data;
            $scope.data = response.data;
            $scope.steps.push(i);
            $scope.leerJsons(i+1);
        }, function(response) {
            console.log("error al obtener json.");
            return;
      });

   };

   $scope.leerJsons();
   $interval($scope.leerJsons, 5000);

   $scope.verStep = function(step){
      $scope.data = $scope.json[step];
   };

})
