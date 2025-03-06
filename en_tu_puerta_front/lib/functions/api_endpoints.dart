
  String urlBase(){
    return '10.0.2.2:8000';}

  String endpointStorePetition(){
    return 'api/v1/petitions';}

  String endpointServices(String inputSearchBar){

    return 'api/v1/services?filter[name]=*$inputSearchBar*';
  }

  String endpointUser(String inputSearchBar){

    return 'api/v1/users?filter[fullname]=*$inputSearchBar*';

  }

  //NO EXISTE SIGUIENTE SPRINT
  String endpointSearch(String inputSearchBar){

    return 'api/v1/users?filter[fullname]=*$inputSearchBar*';

  }
