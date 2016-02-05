//Returns the maximum of an array
function maxOfArray(array) {
    min=0;
    for (a=0; a<lengthOf(array); a++) {
        min=minOf(array[a], min);
        }
    max=min;
    for (a=0; a<lengthOf(array); a++) {
        max=maxOf(array[a], max);
    }
    return max;
}

//Returns the position of a given value in an array
function maxOfArrayID(array,max) {
    for (a=0; a<lengthOf(array); a++) {
        if (array[a] == max){
        	pos = a;
        }
    }
    return pos;
}


//Macro to find the images with maximum STD value in a 4D stack

  macro "Measure Stack" {
       saveSettings;
       setOption("Stack position", true);

//Check we actually have a 4D stack open
      if (!is("hyperstack")){
      	print("Not a Hyperstack");
      	exit;
      }

       Stack.getDimensions(width, height, channels, slices, frames);

       rename("Stack4D");

       
       //Array to store the stdev values of your images as you go through the stack in time
       a1 = newArray(frames+1);



	  for(k=1;k<frames;k++){       
			       for (j=1; j<=slices; j++) {
			          Stack.setPosition(1, j, k);
			          run("Measure");
			          getStatistics(area, mean, min, max, std);
			          a1[j] = std;
			          print(j);
			      }
			   maxSTD = maxOfArray(a1);
			   print(maxSTD);
			
			   sliceID = maxOfArrayID(a1,maxSTD);
			   print(sliceID);
			
			   Stack.setPosition(1, sliceID, k);
			   run("Duplicate...", " ");
			   selectWindow("Stack4D");
  
	  }
	  close();
	  
	  //compile new stack with sutofocused images
	  run("Images to Stack", "name=Stack title=[] use");
	  
      restoreSettings;
      
  }
