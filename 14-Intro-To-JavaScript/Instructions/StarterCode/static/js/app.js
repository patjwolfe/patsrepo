// from data.js
//var data = tableData;

// YOUR CODE HERE!

//var tbody = d3.select("tbody");

function buildTable(){
    //var table = d3.select("#summary-table");
    var tbody = d3.select("tbody");
    var trow;
  
    for (var i = 0; i < data.length; i++){
        trow = tbody.append("tr")
        trow.append("td").text(data[i].datetime);
        trow.append("td").text(data[i].city.charAt(0).toUpperCase() + data[i].city.slice(1));
        trow.append("td").text(data[i].state.toUpperCase());
        trow.append("td").text(data[i].country.toUpperCase());
        trow.append("td").text(data[i].shape.charAt(0).toUpperCase() + data[i].shape.slice(1));
        trow.append("td").text(data[i].durationMinutes);
        trow.append("td").text(data[i].comments);
    };


};

function refreshTable(date){
    d3.remove("td");
    var tbody = d3.select("tbody");
    var trow;
  
    for (var i = 0; i < data.length; i++){
        if ((data[i].datetime) == date){
            trow = tbody.append("tr");
            trow.append("td").text(data[i].datetime);
            trow.append("td").text(data[i].city.charAt(0).toUpperCase() + data[i].city.slice(1));
            trow.append("td").text(data[i].state.toUpperCase());
            trow.append("td").text(data[i].country.toUpperCase());
            trow.append("td").text(data[i].shape.charAt(0).toUpperCase() + data[i].shape.slice(1));
            trow.append("td").text(data[i].durationMinutes);
            trow.append("td").text(data[i].comments);
    

        };

    };


};

   
buildTable();

var inputDate = d3.select("#datetime").node.value;
console.log(inputDate);

d3.select("#filter-btn").on("click", refreshTable(inputDate));

   
//     var inputDate = d3.select("#datetime");
    
    
//     return inputDate == data[i].datetime;
    
    
//     console.log(inputDate); 
    
//     for (var i = 0; i < data.length; i++){
//         if (data[i].datetime == inputDate){
//             console.log(data[i].datetime)
//         }
//     }

//     // for (var i = 0; i < data.length; i++){
//     //     trow = tbody.append("tr")
   

//     // if inputDate == 
// });




// function updateTable(button){
//     var inputDate = d3.select("#datetime").form.id;
//     //ul = document.getElementById("myUL");
//     //td = getElementsByTagName('td');

//     for (i = 0; i < td.length; i++) {
//         dateColumn = d3.select("td")[0];
//         txtValue = dateColumn.textContent || dateColumn.innerText;
        
//         if (txtValue.indexOf(filter) > -1) {
//             li[i].style.display = "";
//         } 
//         else {
//             li[i].style.display = "none";
//         }
//     }
// };



