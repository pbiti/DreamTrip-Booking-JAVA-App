<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./css/plain.css" />
<link href="book5.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
   var city_hotel_id;
   var airport_exists = 0;
   var destination_airport;
   var flight_price; 
   var flight;
   var rooms_needed;
   var Total_Price;
   var room_description;
   var amenities_heading = [];
   var amenities_listHeadings = [];
   var amenities_list = [];
   var noflights = 0;
   var currency_symbol;
   var heading_size;
   var listHeading_size;
   var list_size = [];
   var final_hotel_id;
   var final_depart;
   var final_ret;
   var place1, place2; //origin(1) and destination(2)
   var total_pay;
   var DepartureDate, ReturnDate;
   var CarrierOut, CarrierIn;
   var OutOrigin_station, OutDes_station, InOrigin_station, InDes_station;
   var hotel_name, Address;
   var checkIn, checkOut; 
   var status = "less";
   

   function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
 
  function toggleText(){
	var HTML = `<center><table><tr><td><b>`+amenities_heading[0]+`</b></td></tr>`;
    if (status == "less") {
         	
        //document.getElementById("hotelinfo").innerHTML = `<hr>` +  amenities_heading[0] + `<br>`+ `<br>`;
       
        for(var j=0; j<listHeading_size; j++){         
          //document.getElementById("hotelinfo").innerHTML += amenities_listHeadings[j] + `<br>`+ `<br>`;
         HTML += `<tr><th><u><strong>`+ amenities_listHeadings[j] +`</strong></u></th></tr>`;
          var from =0;
          for(t=0; t<j; t++){
            from += list_size[t];
          }
          to = from + list_size[j];
          //listHeading_size = obj.data.body.amenities[i].listItems.length;
          for(k = from; k<to; k++){
            //document.getElementById("hotelinfo").innerHTML += amenities_list[k]+ `<br>`;
            HTML += `<tr><td>`+ amenities_list[k] +`</td></tr>`;
            //amenities_list[amenities_list.length] = obj.data.body.amenities[i].listItems[j].listItems[k];
          }          
        }
        HTML += `</table></center><br>`;
	    
        document.getElementById("hotelinfo").innerHTML = HTML;
        
        document.getElementById("hotelinfo").innerHTML += `<center><table><tr><td>NUMBER OF ROOMS: `+rooms_needed+`</td></tr><tr><td>`+room_description+`</td></tr></table></center>`;
        
        
        
        document.getElementById("toggleButton").innerText = "See Less";
        status = "more";
    } else if (status == "more") {
        document.getElementById("hotelinfo").innerHTML = "";
        document.getElementById("toggleButton").innerText = "See More";
        status = "less"
    }
}

  async function recommended_hotel_info(hotel_id, depart, ret, adults, kids){
    var total_people = parseInt(adults)+parseInt(kids);
    var url = "https://hotels4.p.rapidapi.com/properties/get-details?id=".concat(hotel_id,"&locale=en_US&currency=EUR&checkOut=",ret,"&adults1=1&checkIn=",depart);
    fetch(url, {
      "method": "GET",
      "headers": {
        "x-rapidapi-key": "b2ce1a0631mshf861676d5688768p15cd9ejsn8df6a0f41c58",
        "x-rapidapi-host": "hotels4.p.rapidapi.com"
  }
  })
    .then(response => {
          return response.json();
      })
    .then(function(obj){
      console.log(obj);

      final_hotel_id = hotel_id;
      final_depart = depart;
      final_ret = ret;
	 
      
      
      
      hotel_name = (JSON.stringify(obj.data.body.propertyDescription.name)).substring(1, (JSON.stringify(obj.data.body.propertyDescription.name)).length-1); 
      document.getElementById("hotel_name").value = hotel_name;
      document.getElementById("hotel_name2").value = hotel_name;
      checkIn = (JSON.stringify(obj.data.body.atAGlance.keyFacts.arrivingLeaving[0])).substring(1, (JSON.stringify(obj.data.body.atAGlance.keyFacts.arrivingLeaving[0])).length-1);
      document.getElementById("checkin").value = checkIn;
      document.getElementById("checkin2").value = checkIn;
      checkOut = (JSON.stringify(obj.data.body.atAGlance.keyFacts.arrivingLeaving[1])).substring(1, (JSON.stringify(obj.data.body.atAGlance.keyFacts.arrivingLeaving[1])).length-1);
      document.getElementById("checkout").value = checkOut;
      document.getElementById("checkout2").value = checkOut;
      heading_size = obj.data.body.amenities.length;
      amenities_heading[0] = obj.data.body.amenities[0].heading

        for(var j=0; j<obj.data.body.amenities[0].listItems.length; j++){         
          //document.getElementById("form").innerHTML += JSON.stringify(obj.data.body.amenities[i].listItems[j].heading) + `<br>`+ `<br>`;
          amenities_listHeadings[amenities_listHeadings.length] = obj.data.body.amenities[0].listItems[j].heading;
          listHeading_size = obj.data.body.amenities[0].listItems.length;
          for(var k=0; k<obj.data.body.amenities[0].listItems[j].listItems.length; k++){
            //document.getElementById("form").innerHTML += JSON.stringify(obj.data.body.amenities[0].listItems[j].listItems[k])+ `<br>`;
            amenities_list[amenities_list.length] = obj.data.body.amenities[0].listItems[j].listItems[k];
            list_size[j] = obj.data.body.amenities[0].listItems[j].listItems.length;
          }          
        }
        console.log(amenities_list);
        console.log(list_size);
      
      flight = flight_price * (parseInt(adults)+parseInt(kids));
      
      //document.getElementById("info").innerHTML += "TOTAL FLIGHT: " + flight + currency_symbol +  `<hr>`;
      
     // document.getElementById("info").innerHTML += "HOTEL NAME: "+ hotel_name + " ";
      var starRating = obj.data.body.propertyDescription.starRating;
      /*for(var stars=0; stars<Math.ceil(parseInt(starRating)); stars++){
      	document.getElementById("info").innerHTML += `<i class="fa fa-star checked"></i>` ;
      }*/
      //document.getElementById("info").innerHTML += `<br>`;
      //document.getElementById("info").innerHTML += "HOTEL NAME: " + hotel_name + "(" + starRating + ")" + `<br>`;

       Address = obj.data.body.propertyDescription.address.fullAddress;
       document.getElementById("hotel_address").value = Address;
       document.getElementById("hotel_address2").value = Address;
       //document.getElementById("info").innerHTML += "HOTEL ADDRESS: " + Address + `<br>`;
       //document.getElementById("info").innerHTML += "CHECK IN: " + checkIn + `<br>` + "CHECK OUT: " + checkOut + `<br>`; 
      
     //////////////////////////////////////////////
      var latitude = obj.data.body.pdpHeader.hotelLocation.coordinates.latitude;
      var longitude = obj.data.body.pdpHeader.hotelLocation.coordinates.longitude;
      
    //var maxOccupancy = Number(obj.data.body.roomsAndRates.rooms[0].maxOccupancy.total);
    var max = 0;
    var room;
    for(var k=0; k<obj.data.body.roomsAndRates.rooms.length; k++){
      if(parseInt(obj.data.body.roomsAndRates.rooms[k].ratePlans[0].occupancy.maxAdults) + parseInt(obj.data.body.roomsAndRates.rooms[k].ratePlans[0].occupancy.maxChildren) > max){
        max = 
          parseInt(obj.data.body.roomsAndRates.rooms[k].ratePlans[0].occupancy.maxAdults) + 
          parseInt(obj.data.body.roomsAndRates.rooms[k].ratePlans[0].occupancy.maxChildren); 
        room=k;
      }
    }
			  
     Total_Price = obj.data.body.roomsAndRates.rooms[room].ratePlans[0].price.totalPricePerStay;

      ////////////////////////////////////////////

      var position2;
      var position3;
      position2 = Total_Price.lastIndexOf("r");
      position2 += 2;
      position3 = Total_Price.lastIndexOf(" ");
     
      for(var i=9; i<Total_Price.length; i++){       
        if(Total_Price.charAt(i) == '<'){break;}     
      }

      var price = Total_Price.substring(9, i-1);
      price = price.replace(".", "");
      var nights = parseInt(Total_Price.substring(position2,position3));
      document.getElementById("nights2").value = nights;
      //document.getElementById("form").innerHTML += "INFO: " + price + `<br>` + nights;


    //document.getElementById("form").innerHTML += "OCCUPANCY: " + maxOccupancy +`<br>`;
    rooms_needed = Math.ceil((parseInt(adults)+parseInt(kids))/parseInt(max));
    //document.getElementById("form").innerHTML += "ROOMS NEEDED: " + rooms_needed + `<br>`;
    //var Total_Price = (Number(obj.data.body.roomsAndRates.rooms[0].ratePlans[0].price.unformattedCurrent) * rooms_needed);
    Total_Price = parseInt(price) * rooms_needed;
    
     total_pay = Total_Price + flight;
     document.getElementById("price").value = total_pay;
     document.getElementById("price2").value = total_pay;



    //document.getElementById("info").innerHTML +=  "TOTAL PRICE: " + Total_Price + currency_symbol + `<br>`;
    
    document.getElementById("info").innerHTML += `<br><br><center><table >
      <tr>
        <th><u>Departure Date</u></th>
        <th><u>Airline Company</u></th>
        <th><u>Origin Station</u></th>
        <th><u>Destination Station</u></th>
      </tr>
      <tr>
        <td>`+DepartureDate+`</td>
        <td>`+CarrierOut+`</td>
        <td>`+OutOrigin_station+`</td>
        <td>`+OutDes_station+`</td>
      </tr></table></center>`;
      
      document.getElementById("info").innerHTML += `<br><br><center><table >
      <tr>
        <th><u>Departure Date</u></th>
        <th><u>Airline Company</u></th>
        <th><u>Origin Station</u></th>
        <th><u>Destination Station</u></th>
      </tr>
      <tr>
        <td>`+ReturnDate+`</td>
        <td>`+CarrierIn+`</td>
        <td>`+InOrigin_station+`</td>
        <td>`+InDes_station+`</td>
      </tr></table></center><br><br>`;
      
      document.getElementById("info").innerHTML += 
    `<center><table>
      <tr>
      <th>Total  Flights  Price: ` + flight + currency_symbol+
      `</tr>
      </table></center><br>`;
      
      document.getElementById("info").innerHTML +=
    	  `<center><table >
          <tr>
          <th><u>Hotel Name</u></th>
          <th><u>Star Rating</u></th>
          <th><u>Hotel Address</u></th>
          <th><u>Check In</u></th>
          <th><u>Check Out</u></th>
        </tr>
        <tr>
          <td>`+hotel_name+`</td>
          <td>`+Math.ceil(starRating)+`<i class="fa fa-star checked"></i></td>
          <td>`+Address+`</td>
          <td>`+checkIn+`</td>
          <td>`+checkOut+`</td>
        </tr></table></center><br><br>`;
        
        var num_img;
        if(obj.data.body.roomsAndRates.rooms[room].images.length <= 4){
        	 num_img = obj.data.body.roomsAndRates.rooms[room].images.length;
        }else{
        	 num_img = 4;
        }
        for(i=0; i<num_img; i++){
        	src = obj.data.body.roomsAndRates.rooms[room].images[i].fullSizeUrl;
        	img = document.createElement('img');
            img.src = src;
            img.setAttribute("width", "300");
            img.setAttribute("height", "200");
            document.getElementById("info").appendChild(img);
            document.getElementById("info").innerHTML += `<br>`;
        }
        
        document.getElementById("info").innerHTML += 
        `<center><table>
          <tr>
          <th>Total  Hotel  Price: ` + Total_Price + currency_symbol+
          `</tr>
          </table></center><br><br>`;

    //document.getElementById("form").innerHTML += "PRICE FOR 1 ROOM " + JSON.stringify(obj.data.body.roomsAndRates.rooms[room].ratePlans[0].price.unformattedCurrent) + `<br>`;

    document.getElementById("pay").innerHTML +=
    `<br><br><center><table>
    <tr>
    <th>Total Price: ` + total_pay + currency_symbol+
    `</tr>
    </table></center><br><br>`;

    document.getElementById("info").innerHTML += `<button onclick="toggleText()" id="toggleButton" class="profilebtn" style="margin-left:7%"> Show More </button><br><br><br>`;
    document.getElementById("loader").innerHTML = "";

    //document.getElementById("form").innerHTML += "ROOM DESCRIPTION: " + obj.data.body.roomsAndRates.rooms[room].additionalInfo.description;
    room_description = obj.data.body.roomsAndRates.rooms[room].additionalInfo.description;

      //src = obj.data.body.propertyDescription.mapWidget.staticMapUrl;
      //img = document.createElement('img');

      //img.src = src;
      //document.body.appendChild(img);
       
    })
	await sleep(3000);
    document.getElementById("button").innerHTML += `<input class="profilebtn" type="submit" id="submit" value="BOOK" style="margin-left:7%"><br><br><br>`;
	document.getElementById("save_button").innerHTML += `<input class="profilebtn" type="submit" id="submit" value="SAVE" style="margin-left:7%"><br><br><br>`
  }

   function hotel_info(hotel_id, depart, ret, destination_airport){
    var url = "https://hotels4.p.rapidapi.com/properties/get-details?id=".concat(hotel_id,"&locale=en_US&currency=EUR&checkOut=",ret,"&adults1=1&checkIn=",depart);
    fetch(url, {
      "method": "GET",
      "headers": {
        "x-rapidapi-key": "b2ce1a0631mshf861676d5688768p15cd9ejsn8df6a0f41c58",
        "x-rapidapi-host": "hotels4.p.rapidapi.com"
  }
  })
  .then(response => {
          return response.json();
      })
    .then(function(obj){
      console.log(obj);
      if(obj.transportation.transportLocations.length > 0){
        for(var i=0; i<obj.transportation.transportLocations[0].locations.length; i++){
          if(JSON.stringify(obj.transportation.transportLocations[0].locations[i]).includes(destination_airport)){
            airport_exists = 1;
            break;
          }
        }
      }      
    })
   }

    function find_hotel(city_id,adults,kids,sortby, depart, ret,destination_airport){
     
      var url = "https://hotels4.p.rapidapi.com/properties/list?destinationId=".concat(city_id,"&pageNumber=1&checkIn=",depart,"&checkOut="
        ,ret,"&pageSize=25&adults1=",parseInt(adults)+parseInt(kids),"&currency=EUR&locale=en_US&sortOrder=",sortby);

      fetch(url, {
    "method": "GET",
    "headers": {
        "x-rapidapi-key": "b2ce1a0631mshf861676d5688768p15cd9ejsn8df6a0f41c58",
        "x-rapidapi-host": "hotels4.p.rapidapi.com"
    }
    })
    .then(response => {
        return response.json();
    })
    .then(async function(obj){
      console.log(obj);
      var size = obj.data.body.searchResults.results.length;
      //document.getElementById("form").innerHTML += "SIZE: " + size;
      var teams = Math.floor(size/5);
      var count=0;
      for(var f=0; f<5*teams; f=f+teams){        
        for(var k=0; k<teams; k++){
          var hotelid = JSON.stringify(obj.data.body.searchResults.results[k+count*teams].id);
          //document.getElementById("form").innerHTML += "COUNT: " + parseInt(k)+parseInt(count*teams);
          
          hotel_info(hotelid, depart, ret,destination_airport);
          //document.getElementById("form").innerHTML += k;
        }
        if(airport_exists){break;}
        await sleep(3000);
        count++;
      }
      //document.getElementById("form").innerHTML += "HOTEL ID:" + hotelid;
      recommended_hotel_info(hotelid, depart, ret,adults, kids);
    })
      
   }

   function hotel_id(dest, depart, ret, adults, kids, sortby,destination_airport){
    var dest_full = dest;
    for(var i=0; i<dest_full.length;i++) {
        if (dest_full[i] === " ") dest_full[i] = "%20";
    }

    var static_url = "https://hotels4.p.rapidapi.com/locations/search?query=";
    static_url = static_url.concat(dest_full,"&locale=en_US");

    fetch(static_url, {
      "method": "GET",
      "headers": {
        "x-rapidapi-key": "b2ce1a0631mshf861676d5688768p15cd9ejsn8df6a0f41c58",
        "x-rapidapi-host": "hotels4.p.rapidapi.com"
      }
    })
    .then(function(response){
      return response.json();
    
    })
    .then(function(data){
      console.log(data);
      city_hotel_id = JSON.stringify(data.suggestions[0].entities[0].destinationId);
      city_hotel_id = city_hotel_id.substring(1, city_hotel_id.length-1);
      find_hotel(city_hotel_id,adults,kids,sortby,depart,ret,destination_airport);
    }) 
   }

  function flight_api(origin, dest, dep, ret){
    var from = origin.substring(1, origin.length-1);
    var des = dest.substring(1, dest.length-1);
    
     from = "/".concat(from);
     des = "/".concat(des);

    //var depart = "/".concat(document.myForm.depart.value);
    //var ret = "/".concat(document.myForm.ret.value);
    var skyapi = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browseroutes/v1.0/US/EUR/en-US";
    var url = skyapi.concat(from,des,dep,ret);
    
    
    
    fetch(url, {
      "method": "GET",
      "headers": {
        "x-rapidapi-key": "f0fd86c811msh24d880730614e8dp1e1bb2jsn1a14098cf6e4",
        "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com"
      }
    })
    .then(function(response){
      return response.json();
    
    })
    .then(function(data){
      console.log(data);
      //document.getElementById("form").innerHTML += "<br/>" + "<li/>" + JSON.stringify(data.Quotes[0].OutboundLeg.DepartureDate); 
      //document.getElementById("form").innerHTML += "<br/>" + JSON.stringify(data.Quotes[0].MinPrice);
      if(data.Quotes.length ==0){document.getElementById("info").innerHTML = "NO FLIGHTS"; noflights=1;}
      else{/*document.getElementById("form").innerHTML += "<h1 class='bye'>Cheapest Flight</h1>" + "<h3/>" + JSON.stringify(data.Quotes[0].OutboundLeg.DepartureDate) + "<br/>"
          + "<h3/>" + JSON.stringify(data.Quotes[0].MinPrice) +"EUR";}*/
      document.getElementById("loader").innerHTML += 
    	  `<span style="--i: 1"></span>
          <span style="--i: 2"></span>
          <span style="--i: 3"></span>
          <span style="--i: 4"></span>
          <span style="--i: 5"></span>
          <span style="--i: 6"></span>
          <span style="--i: 7"></span>
          <span style="--i: 8"></span>
          <span style="--i: 9"></span>
          <span style="--i: 10"></span>
          <span style="--i: 11"></span>
          <span style="--i: 12"></span>
          <span style="--i: 13"></span>
          <span style="--i: 14"></span>
          <span style="--i: 15"></span>
          <span style="--i: 16"></span>
          <span style="--i: 17"></span>
          <span style="--i: 18"></span>
          <span style="--i: 19"></span>
          <span style="--i: 20"></span>
          <div class="rocket"></div>`;
          
      var directflight = 0;
      for(i=0; i<data.Quotes.length; i++){
        if(data.Quotes[i].Direct == true){
           directflight = 1;
           break;
        }
      }
      if(directflight==0 ){i=0;}        
          var Inboundcarrierid = JSON.stringify(data.Quotes[i].InboundLeg.CarrierIds);
          Inboundcarrierid =Inboundcarrierid.replace(']','');
          Inboundcarrierid =Inboundcarrierid.replace('[','');
          var InOriginId = JSON.stringify(data.Quotes[i].InboundLeg.OriginId);
          var InDesId = JSON.stringify(data.Quotes[i].InboundLeg.DestinationId);

          var Outboundcarrierid = JSON.stringify(data.Quotes[i].OutboundLeg.CarrierIds);
          Outboundcarrierid =Outboundcarrierid.replace(']','');
          Outboundcarrierid =Outboundcarrierid.replace('[','');
          var OutOriginId = JSON.stringify(data.Quotes[i].OutboundLeg.OriginId);
          var OutDesId = JSON.stringify(data.Quotes[i].OutboundLeg.DestinationId);               
      
      for (var j = 0; j<data.Carriers.length; j++) {
          
          if((JSON.stringify(data.Carriers[j].CarrierId)).localeCompare(Inboundcarrierid) == 0){
             CarrierIn = JSON.stringify(data.Carriers[j].Name);
             CarrierIn = CarrierIn.substring(1, CarrierIn.length-1);
             document.getElementById("carrier_ela").value = CarrierIn;
             document.getElementById("carrier_ela2").value = CarrierIn;
          }
          if((JSON.stringify(data.Carriers[j].CarrierId)).localeCompare(Outboundcarrierid) == 0){
             CarrierOut = JSON.stringify(data.Carriers[j].Name);
             CarrierOut = CarrierOut.substring(1, CarrierOut.length-1);
             document.getElementById("carrier_phgaine").value = CarrierOut;
             document.getElementById("carrier_phgaine2").value = CarrierOut;
          }
      }

      for(j=0; j<data.Places.length; j++){
        if(JSON.stringify(data.Places[j].PlaceId) == InOriginId){
           InOrigin_station = JSON.stringify(data.Places[j].Name);
          InOrigin_station = InOrigin_station.substring(1, InOrigin_station.length-1);
          document.getElementById("air_depart_2").value = InOrigin_station;
          document.getElementById("air_depart_2_2").value = InOrigin_station;
        }
        if(JSON.stringify(data.Places[j].PlaceId) == OutOriginId){
           OutOrigin_station = JSON.stringify(data.Places[j].Name);
          OutOrigin_station = OutOrigin_station.substring(1, OutOrigin_station.length-1);
          document.getElementById("air_depart_1").value = OutOrigin_station;
          document.getElementById("air_depart_1_2").value = OutOrigin_station;
        }
        if(JSON.stringify(data.Places[j].PlaceId) == InDesId){
            InDes_station = JSON.stringify(data.Places[j].Name);
           InDes_station = InDes_station.substring(1, InDes_station.length-1);
           document.getElementById("air_arrive_2").value = InDes_station;
           document.getElementById("air_arrive_2_2").value = InDes_station;
        }
        if(JSON.stringify(data.Places[j].PlaceId) == OutDesId){
            OutDes_station = JSON.stringify(data.Places[j].Name);
           destination_airport = JSON.stringify(data.Places[j].IataCode);
           OutDes_station = OutDes_station.substring(1, OutDes_station.length-1);
           document.getElementById("air_arrive_1").value = OutDes_station;
           document.getElementById("air_arrive_1_2").value = OutDes_station;

        }
      }
       DepartureDate = data.Quotes[0].OutboundLeg.DepartureDate;
       document.getElementById("departure").value = DepartureDate;
       document.getElementById("departure2").value = DepartureDate;

       ReturnDate = data.Quotes[0].InboundLeg.DepartureDate;
       document.getElementById("ret").value = ReturnDate;
       document.getElementById("ret2").value = ReturnDate;

      /*document.getElementById("form").innerHTML += "DIRECT : " + directflight;
       document.getElementById("form").innerHTML += DepartureDate + `<br>`+ InOrigin_station + `<br>` + InDes_station + `<br>` + ReturnDate + `<br>`+ OutOrigin_station +`<br>` + OutDes_station + `<br>` + CarrierOut +`<br>` + CarrierIn + `<br>`;*/

       //document.getElementById("info").innerHTML = "PHGAINE:" + `<br>`;
       //document.getElementById("info").innerHTML +=  CarrierOut +`<br>`+ OutOrigin_station +`<br>`+ OutDes_station + `<br><br>`;
       //document.getElementById("info").innerHTML += "DEPARTURE DATE: " + DepartureDate + `<br>`;

        //document.getElementById("form").innerHTML += "GURNA:" + `<br>`;
       //document.getElementById("info").innerHTML +=  CarrierIn +`<br>`+ InOrigin_station +`<br>`+ InDes_station + `<br><br>`;
       
       //document.getElementById("info").innerHTML += "RETURN DATE: " + ReturnDate + `<br>`;

        //document.getElementById("info").innerHTML += "PRICE PER PERSON: " + JSON.stringify(data.Quotes[i].MinPrice) + JSON.stringify(data.Currencies[0].Symbol).substring(1, JSON.stringify(data.Currencies[0].Symbol).length-1) + `<hr>`;
       currency_symbol = JSON.stringify(data.Currencies[0].Symbol).substring(1, JSON.stringify(data.Currencies[0].Symbol).length-1);
       flight_price = parseInt(data.Quotes[i].MinPrice);
     } 
  })
}

  function validate(){

    var id_url = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/UK/GBP/en-GB/?query=";
    var origin = document.myForm.from.value;
    var destination = document.myForm.des.value;
    var final_url_origin = id_url.concat(origin);
    var final_url_des = id_url.concat(destination);
    var d = document.myForm.depart.value;
    var r = document.myForm.ret.value;
    var depart = "/".concat(document.myForm.depart.value);
    var ret = "/".concat(document.myForm.ret.value);
    var adults = document.myForm.adults.value;
    var kids = document.myForm.kids.value;
    var sortby = document.myForm.sortby.value;
    
    document.getElementById("form").innerHTML = "";

    fetch(final_url_origin, {
      "method": "GET",
      "headers": {
        "x-rapidapi-key": "b224f16294mshd9aab121e05708bp1ce92bjsna50a03d64be2",
        "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com"
      }
    })
    .then(response => {
        return response.json();
    })
    .then(function(obj){
      console.log(obj);
      place1 = JSON.stringify(obj.Places[0].PlaceId);
      document.getElementById("origin").value = place1;
      document.getElementById("origin2").value = place1;

      
      fetch(final_url_des, {
      "method": "GET",
      "headers": {
        "x-rapidapi-key": "b224f16294mshd9aab121e05708bp1ce92bjsna50a03d64be2",
        "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com"
      }
    })
    .then(response => {
        return response.json();
    })
    .then(function(ob){
      console.log(ob);
      place2 = JSON.stringify(ob.Places[0].PlaceId);
      document.getElementById("destination").value = place2;
      document.getElementById("destination2").value = place2;

      //document.getElementById("form").innerHTML += malakia1;
      //document.getElementById("form").innerHTML += malakia2;  
      flight_api(place1, place2, depart, ret);
      if(noflights==0){hotel_id(destination, d, r, adults, kids, sortby);}    
    })

    })

  }
</script>
</head>

<body>

<% String uname = request.getParameter("username"); %>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/wishlist"
         user = "root"  password = "ksql4321!"/>
 
      <sql:query dataSource = "${snapshot}" var = "result">
         SELECT first_name FROM users WHERE username="${uname}";
      </sql:query>

<div class="navbar">

  <a href="#default" class="logo"><i class="fa fa-globe" style="color: LightYellow" size = "8px"></i> DREAM TRIP</a>
  
  <div class="icons">
    <a class="fa fa-phone" target="_blank" title="(+30)242100000" style="color: black"></a>
    <a class="fa fa-envelope" target="_blank" title="dreamtrip@gmail.com" style="color: black"></a>
    <a target="_blank" href="https://www.facebook.com/"><i class="fa fa-facebook" style="color: black"></i></a>
    <a target="_blank" href="https://www.facebook.com/"><i class="fa fa-instagram" style="color: black"></i></a>
    <a target="_blank" href="https://www.twitter.com/"><i class="fa fa-twitter" style="color: black"></i></a>
    <a target="_blank" href="https://www.youtube.com/"><i class="fa fa-youtube" style="color: black"></i></a>
  </div>


  <div class="header-right-nav">
  <form action="login-forward" method="post"><input type="submit" class="dropbtn_nav" value="HOME"></form>
  <form action="ourteam" method="post"><input type="submit" class="dropbtn_nav" value="OUR TEAM"></form>
  <form action="book" method="post"><input type="submit" class="dropbtn_nav" value="BOOK"></form>
  
  <form>
  <div class="dropdown_des">
    <button class="dropbtn_nav"><c:forEach var = "row" items = "${result.rows}">
	               <span style="text-transform: uppercase"><c:out value = "${row.first_name}"/></span>          
	          </c:forEach> 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content-nav">
        	<form action="submit_image" method="post" enctype="multipart/form-data">
		    <div class="profile-pic-div">
		    
		      <img src="data:image/jpg;base64,${pi.base64Image}" id="photo"/>
		      <input type="file" id="file" name="myFile" onchange="this.form.submit();">
		      <label for="file" id="uploadBtn">Choose Photo</label>
		     		     
		    </div>  		    
		 </form>
	
          <div class="column_des" style="width: 100%">
          <br><br><br>      
	          <form action="list" method="post"><button class="profilebtn">
    Dream Trips 
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button></form>
	          <form action="view_trips" method="post"><button class="profilebtn">
    Your Trips 
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button></form> 
	                                    
        </div>
        </div>
      </div>
</form>
  <form action="tools-forward" method="post"><input type="submit" class="dropbtn_nav" value="TOOLS"></form>
  <form action="main.html" method="post"><input type="submit" class="dropbtn_nav" value="LOGOUT"></form>
      </div>

  
  
  </div>
</div>  
<div id="info"></div>
<div id="hotelinfo">
	<div id="loader" class="loader">
	</div>
</div>
<div id="pay"></div>


<div id="form" class="forma">
<form onsubmit="return validate();" name="myForm" action="" method="post">
<div class="card shadow mb-5 bg-white rounded">
    <!--Card-Body-->
    <div id="card-body" class="card-body">
       
    
        <center>
        <p class="card-title text-center shadow mb-5 rounded">Travel Booking Form</p>
       
        <br><br>
    
             <div class="col-sm-6"> <input placeholder="From" type="text" id="from" class="form-control" required> </div>
             <br><br><br>

            <div class="col-sm-6"> 
                    <input placeholder="To" type="text" id="des" class="form-control" required>
              </div>
          <br><br><br>

       <div class="hotel_info">
          <div id="" class="space"> 
              <label style="color: black" for="depart">Depart:</label>
              <input class="datepicker" style="background-color: LightYellow" type="date" id="depart" name="depart" required>

              <label style="color: black" for="ret">Return:</label>
              <input class="datepicker" style="background-color: LightYellow" type="date" id="ret" name="ret" required>
          </div>
          <br><br>
          <label for="quantity">Adults Number:</label>
          <input style="background-color: LightYellow" type="number" id="adults" name="quantity" min="1" max="7" required>
          
          
          <label  for="quantity">Children Number:</label>
          <input style="background-color: LightYellow" type="number" id="kids" name="quantity" min="0" max="7" required>
          <br><br><br>
          
        </div> 
        
          <div class="col-sm-6"> <select class="form-control datepicker mb-4" id="sortby">
              <option value="" disabled="" selected="">Sort Hotels By</option>
              <option value="BEST_SELLER">Best Seller</option>
              <option value="STAR_RATING_HIGHEST_FIRST">Star Rating(Highest First)</option>
              <option value="GUEST_RATING">Guest Rating</option>
              <option value="PRICE">Price(Lowest First)</option>
              <option value="PRICE_HIGHEST_FIRST">Price(Highest First)</option>
            </select> </div>
            <br><br><h2><abbr title="We recommend the closest hotel to your airport based on your 'Sort Hotels By' choice." style="text-decoration: none;">
			<i class="fa fa-info-circle"></i></abbr></h2>
            </center>
        <div class="enjoybtn">
        <input class="enjoybtn" type="submit" id="submit" value="SEARCH">
        <br><br><br><br>
    </div>
   </div>
   
 </div>
  </form>  
  </div>
  <form method="post" action="getinfo">	
	 <input type="hidden" id="origin" name="origin" value="">
	 <input type="hidden" id="destination" name="destination" value="">
	 <input type="hidden" id="price" name="price" value="">
	 <input type="hidden" id="departure" name="departure" value="">
	 <input type="hidden" id="ret" name="ret" value="">
	 <input type="hidden" id="carrier_phgaine" name="carrier_phgaine" value="">
	 <input type="hidden" id="carrier_ela" name="carrier_ela" value="">
	 <input type="hidden" id="air_depart_1" name="air_depart_1" value="">
	 <input type="hidden" id="air_arrive_1" name="air_arrive_1" value="">
	 <input type="hidden" id="air_depart_2" name="air_depart_2" value="">
	 <input type="hidden" id="air_arrive_2" name="air_arrive_2" value="">
	 <input type="hidden" id="hotel_name" name="hotel_name" value="">
	 <input type="hidden" id="hotel_address" name="hotel_address" value="">
	 <input type="hidden" id="checkin" name="checkin" value="">
	 <input type="hidden" id="checkout" name="checkout" value="">
	 <div id="button"></div>
</form>  
<form method="post" action="savetodo">	
	 <input type="hidden" id="origin2" name="origin2" value="">
	 <input type="hidden" id="destination2" name="destination2" value="">
	 <input type="hidden" id="price2" name="price2" value="">
	 <input type="hidden" id="departure2" name="departure2" value="">
	 <input type="hidden" id="ret2" name="ret2" value="">
	 <input type="hidden" id="carrier_phgaine2" name="carrier_phgaine2" value="">
	 <input type="hidden" id="carrier_ela2" name="carrier_ela2" value="">
	 <input type="hidden" id="air_depart_1_2" name="air_depart_1_2" value="">
	 <input type="hidden" id="air_arrive_1_2" name="air_arrive_1_2" value="">
	 <input type="hidden" id="air_depart_2_2" name="air_depart_2_2" value="">
	 <input type="hidden" id="air_arrive_2_2" name="air_arrive_2_2" value="">
	 <input type="hidden" id="hotel_name2" name="hotel_name2" value="">
	 <input type="hidden" id="hotel_address2" name="hotel_address2" value="">
	 <input type="hidden" id="checkin2" name="checkin2" value="">
	 <input type="hidden" id="checkout2" name="checkout2" value="">
	 <input type="hidden" id="nights2" name="nights2" value="">
	 <div id="save_button"></div>
</form> 
</body>
</html>