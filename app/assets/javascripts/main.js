var app = angular.module("eve-ore", ['restangular', 'ui.bootstrap', 'datatables', 'timer']);

app.config(function($httpProvider, RestangularProvider) {

    RestangularProvider.setBaseUrl('http://dev.eve-ore.com/api/v1');

    /*
     if(angular.mock){
     RestangularProvider.setBaseUrl('http://dev.esume.com/' + 'api/v1');
     }
     else{
     RestangularProvider.setBaseUrl('http://dev.esume.com/' + 'api/v1'); //$("#url-div").data("root-path") + 'api/v1');
     }
     */
});
