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

function arrayWithValueRemoved(value, array) {
	var index = array.indexOf(value);
	if (index > -1) {
		array.splice(index, 1);
	}
	return array;
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