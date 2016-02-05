//ImageJ macro to open a timelapse dataset aquired on the EVOS. Specifically where each timepoint is a z-stack
//for a single beacon, with each timepoint in a subfolder. 
//Any movie length or number of z-stack slices supported



//Check there's nothing open
if ((nImages>0)){
      	print("Close any open windows first!");
      	exit;
  }

//Allow user to choose source directory.
SourceDir = getDirectory("Choose source directory, which contains the folders with measurements"); 
FolderList = getFileList(SourceDir); 

//some debug
print(SourceDir);

 for (j=0; j<FolderList.length; j++) {
	print(FolderList[j]);
	//run("Image Sequence...", "open=["+SourceDir+FolderList[j]+"] sort"); //but the images will not be opend 

	run("Image Sequence...", "open=["+SourceDir+FolderList[j]+"] file=[Stack TRANS] sort");
	//run("Images to Stack", "name=Stack title=[] use");
	
	print(SourceDir+FolderList[j]);
}

run("Concatenate...", "all_open title=[Concatenated Stacks] open");

