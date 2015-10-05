/**
 * find the index of an array that contains the object
 */
function arrayObjectIndexOf(myArray, searchTerm, property) {
    for(var i = 0, len = myArray.length; i < len; i++) {
        if (myArray[i][property] === searchTerm) return i;
    }
    return -1;
}

// filter the array to another level based on the filterType and filterTerm
function filterArray(filterType, filterTerm, startingArray) {
	var finalArray = [];
	if (filterType == "relationship") {
		/* RELATIONSHIP_IDS FOR REFERENCE
		1: mother
		2: father
		3: sister
		4: brother
		5: male sig. other
		6: female sig. other
		7: male friend
		8: female friend
		9: grandmother
		10: grandfather
		11: mentor
		12: all
		13: son
		14: daughter
		 */
	switch (filterTerm) {
		case "All":
			finalArray = startingArray;
			break;
		case "Family":
			finalArray = startingArray.filter(function(recipient) {
					return recipient.relationship_id == 1 ||
								 recipient.relationship_id == 2 ||
								 recipient.relationship_id == 3 ||
								 recipient.relationship_id == 4 ||
								 recipient.relationship_id == 9 ||
								 recipient.relationship_id == 10 ||
								 recipient.relationship_id == 13 ||
								 recipient.relationship_id == 14;
				});
			break;
		case "Friends":
			finalArray = startingArray.filter(function(recipient) {
					return recipient.relationship_id == 7 ||
								 recipient.relationship_id == 8;
				})
			break;
		}
	} else if (filterType == "name") {
		if (filterTerm == "") {
			finalArray = startingArray;
		} else {
			searchLength = filterTerm.length;
			finalArray = startingArray.filter(function(recipient) {
				full_name = recipient.first_name + " " + recipient.last_name;
				
				return full_name.substring(0, searchLength).toLowerCase() == filterTerm;
			});

		}
	}
	return finalArray;
}

/**
 * Converts data uri to Blob. Necessary for uploading.
 * @see
 *   http://stackoverflow.com/questions/4998908/convert-data-uri-to-file-then-append-to-formdata
 * @param  {String} dataURI
 * @return {Blob}
 */
var dataURItoBlob = function(dataURI) {
  var binary = atob(dataURI.split(',')[1]);
  var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
  var array = [];
  for(var i = 0; i < binary.length; i++) {
    array.push(binary.charCodeAt(i));
  }
  return new Blob([new Uint8Array(array)], {type: mimeString});
};

// find index in array based on object property's value
function findWithAttr(array, attr, value) {
    for(var i = 0; i < array.length; i += 1) {
        if(array[i][attr] === value) {
            return i;
        }
    }
}

// is the value in array
function isInArray(value, array) {
  return array.indexOf(value) > -1;
}

function arrayWithValueRemoved(value, array) {
	var index = array.indexOf(value);
	if (index > -1) {
		array.splice(index, 1);
	}
	return array;
}

// this will always return the upcoming one of this, even if birthday of past is entered
function parseDateForNextOccasion(str) {
    
  if (str) {
  	str = str + "";
  	var ymd = str.split('-');
    var month = ymd[1]-1;
    var day = ymd[2];

    var today = new Date();
    var thisYear = today.getFullYear();
    var nextYear = today.getFullYear() + 1;

    var thisYearsOccasion = new Date(thisYear, month, day);
    var nextYearsOccasion = new Date(nextYear, month, day);

    if (today < thisYearsOccasion) {
    	return thisYearsOccasion;
    } else {
    	return nextYearsOccasion;
    }
  }
}

function daydiff(first, second) {
    return Math.round((second-first)/(1000*60*60*24)) + 1;
}



// potential new schema is to change "is_visible" property
// function filterArrayNewSchema(filterType, filterTerm, startingArray) {

// 	for (index = 0; index < startingArray.length; ++index) {
		
// 		recipient = startingArray[index];
// 		recipient.is_visible = 0;

// 		if (filterType == "All") {

// 		} else if (filterType == "Family") {

// 		} else if (filterType == "Friends") {

// 		}
		
// 		if (filterType == "relationship") {
// 			switch (filterTerm) {
// 				case "All":
// 					recipient.is_visible = 1;
// 					break;
// 				case "Family":
// 					if (recipient.relationship_id == 1 ||
// 						 recipient.relationship_id == 2 ||
// 						 recipient.relationship_id == 3 ||
// 						 recipient.relationship_id == 4 ||
// 						 recipient.relationship_id == 9 ||
// 						 recipient.relationship_id == 10 ||
// 						 recipient.relationship_id == 13 ||
// 						 recipient.relationship_id == 14) {
// 						recipient.is_visible = 1;
// 					}
// 				break;
// 				case "Friends":
// 					if (recipient.relationship_id == 7 ||
// 						 recipient.relationship_id == 8) {
// 						recipient.is_visible = 1;
// 					}
// 				break;
// 			}
// 		} else if (filterType == "name") {

// 			if (filterTerm != "") {
// 				searchLength = filterTerm.length;
// 				full_name = recipient.first_name + " " + recipient.last_name;
// 				search_substring = full_name.substring(0, searchLength).toLowerCase()
// 				if (search_substring == filterTerm) {
// 					recipient.is_visible = 0;
// 				}
// 			};
// 		}
// 	}
// 	console.log(startingArray);
// 	return startingArray;
// }
