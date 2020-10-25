let map
let geocoder
var tokyo;


function initMap(){
  geocoder = new google.maps.Geocoder() //GoogleMapsAPIジオコーディングサービスにアクセス
  if(document.getElementById('map')){ //'map'というidを取得できたら実行
    map = new google.maps.Map(document.getElementById('map'), { //'map'というidを取得してマップを表示
      center: {lat: 35.6594666, lng: 139.7005536}, //初期値の設定
      zoom: 15,
    });
  }else{ //'map'が無かった時
  console.log(gon.lat_lng);
    map = new google.maps.Map(document.getElementById('show_map'), { //'show_map'を取得してマップを表示
      center: {lat: 35.6594666, lng: 139.7005536},
      zoom: 7,
    });
    var lat_lng ;
    for(var i = 0; i <  gon.lat_lng.length; i++){
      lat_lng = gon.lat_lng[i];
      console.log(lat_lng);
      console.log(lat_lng.latitude);
      var latlng = new google.maps.LatLng(parseFloat(lat_lng.latitude),parseFloat(lat_lng.longitude));
      console.log(latlng);
      var marker = new google.maps.Marker({ //GoogleMapにマーカーを落とす
        position:  latlng, //マーカーを落とす位置を決める（値はDBに入っている）
        map: map //マーカーを落とすマップを指定
      });
      console.log(marker);
     map.setCenter(latlng);

    }
  }
}



function codeAddress(){
  let inputAddress = document.getElementById('address').value;

  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
    if (status == 'OK') {
      let lat = results[0].geometry.location.lat();
            let lng = results[0].geometry.location.lng();
        document.getElementById('longitude').value=lng;
        document.getElementById('latitude').value=lat;
      let mark = {
          lat: lat, //緯度
          lng: lng  //経度
      };
      map.setCenter(results[0].geometry.location); //最も近い、判読可能な住所を取得したい場所の緯度・経度
      let marker = new google.maps.Marker({
          map: map, //マーカーを落とすマップを指定
          position: results[0].geometry.location //マーカーを落とす位置を決める
      });
    } else {
      alert('該当する結果がありませんでした');
    }
  });   
}