#!/bin/bash
# script for moving files with a certain extension from the current directory (for now, may be expanded)
# to a given destination directory
# accepts 2 OR 3 input arguments
# for 2 inputs: first one is the destination directory for the files, 
#								second is the file extension to be looked for (WITH THE POINT BEFOREHAND)
# for 3 inputs: first one may optionally be --log, in that case TODO, argument 2 and 3 are the above mentioned

#function defining behaviour when given wrong amount of input arguments
fatal_args() {
	echo "$0: error:" "$@" >&2 #message passed to stderr
#	echo "$0: error: wrong argument number"
	exit 1
}
######### START OF SCRIPT ############

#number of allowed input parameters
MINPARAMS=2
MAXPARAMS=3

#check number of input parameters 
if [ $# -lt "$MINPARAMS" ]; #TODO: why are the quotes necessary here?
then
	fatal_args "$# arguments passed, at least $MINPARAMS required"
	exit
fi

if [ $# -gt "$MAXPARAMS" ];
then
	fatal_args "$# arguments passed, maximum $MAXPARAMS allowed"
	exit
fi

########### we are here if there were no mistakes ############

#parameters to be read from inputs
OUT_DIR="" #output directory to be created
FILE_SUF="" #file suffix to be looked for in the current script

###########check exact parameter number and for --log############
if [ $# -eq 3 ]; 
then #TODO: what if it is not --log?
	if [ "$1"="--log" ]; #check for --log
	then
		echo "detected --log as first argument"
	else
		echo "first argument not --log, TODO"
		echo #empty line
	fi
	OUT_DIR=$3
	FILE_SUF=$2
	echo -e "3 inputs received\nout_dir set to $OUT_DIR, file_suf set to $FILE_SUF\n"

else #last possibility are two parameters
	OUT_DIR=$1
	FILE_SUF=$2
	echo -e "2 inputs received\nout_dir set to $OUT_DIR, file_suf set to $FILE_SUF\n"
fi
#############################
#current directory for creation of a new one
#not mandatory, left in case the script is extended to include source_dir as an input param
CURRENT_DIR="$(pwd)"             
echo "working directory: $CURRENT_DIR"                                        
 NEW_DIR_PATH="${CURRENT_DIR}/$OUT_DIR"
echo -e  "Continuing with script... \n" # -e causes interpretation of "\n" as newline
############################

###### check directory existence  ##########
echo -e "looking for $NEW_DIR_PATH \n "
if [ ! -d "$NEW_DIR_PATH" ];
then
	echo "creating directory... "
else
	echo "directory existing"
fi

mkdir -p "$NEW_DIR_PATH" # -p no error if existing

########### go through file and look for pdfs #########
#files shall be moved from the current directory, therefore star is enough
FILENUM=0
for file in *   
do
	#echo $file
	if [[ $file == *$FILE_SUF ]];
	then
		echo "found pdf"
		FILENUM=$((FILENUM+1))
		echo "$FILENUM"
		###### move all files ending on FILE_SUF ####### 
		mv -v -- "$file" "$NEW_DIR_PATH"  # -v --- verbose
	fi 
done
#print result
echo "moved $FILENUM file(s) to $NEW_DIR_PATH"
echo "Done"
exit 0 
