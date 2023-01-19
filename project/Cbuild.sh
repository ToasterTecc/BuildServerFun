#Shell script for building multiple C projects...
#DO NOT MANIPULATE text.txt, edge cases cannot be fixed due to time
#!/bin/bash
BOLDBLUE='\e[1;44m'
COLOROFF='\033[0m'
RED='\033[0;31m'
LBLUE='\e[44m'
YELLOW='\e[93m'
LGREY='\033[0;37m'
GREEN='\e[32m'
BGREEN='\e[1;42m'
LGREEN='\e[42m'
FILE="Makefile"

menuDisplay () {
	echo -e "\t[1] Fast Build\n
	[2] Wipe Save File\n
	[3] Exit Script"
}
memCheck() {
	if ! grep -q '[^[:space:]]' "test.txt"; then
		echo "Memory is empty"
    else
		echo -e -n $"${GREEN}[Memory of previous valid build paths detected. Use? (Y to use)]:${COLOROFF}" 
		read yn
		case $yn in
		[yY]) IFS=$'\n' read -d '' -r -a valid < test.txt #mem file, valid? eh
			#echo "${valid[@]}"
			validCheck #I didn't do check corrupted mem file, so DO NOT TOUCH test.txt
			;;
		[nN]) echo ok
			;;
		*) echo invalid response;;
		esac
	fi
}
fastBuild() {
	memCheck
	echo -e "${LBLUE}Note: In Fast Build, only valid entries will be built and saved. You can fix errors later.${COLOROFF}"
	echo -e "${YELLOW}Drag & drop OR type the path the folder(s) containing a Makefile${COLOROFF}:"
	IFS="" read -r input
	eval "path=( $input )"
	if [ -z "$path" ]; then
		exit 0;
	fi 
	#remove duplicates in initial entry, 4th command REWRAPS to single quotes
	#| sed -e "s/'/'\\\\''/g;s/\(.*\)/'\1'/"
	arr=$(printf '%s\n' "${path[@]}" | sed 's# /#\n/#g' | sort -u)
	
	mapfile -t StringArray <<< "${arr[@]}"
	echo "My array: ${arr[@]}"
	#echo "My array #: ${#StringArray[@]}"
	duplicates=${#StringArray[@]}
    
    #for val in "${StringArray[@]}"; do
    #echo "##: $val"
	#done
	
	duplicates="$((${#path[@]}-${#StringArray[@]}))"
	
	if [ "$duplicates" -gt 0 ]; then
		echo -e "${LBLUE}[${#StringArray[@]} projects loaded, removed $duplicates duplicates! Checking...]${COLOROFF}"
	else
		echo -e "${LBLUE}[${#StringArray[@]} projects loaded, checking...]${COLOROFF}"
	fi
	 
	validCheck
}

validCheck() { #checks if path list are valid enough to make the build list
	noerror=true
	for elem in "${StringArray[@]}"; do 
		if ! [ -d "$elem" ]; then #TO:DO ?Put Project number on errors for visual
			echo -e "${RED}error: $elem is not a path.${COLOROFF}"
			noerror=false
		elif [ ! -e "$elem/${FILE}" ]; then #check for Makefile presence
			echo -e "${RED}error: $elem has no Makefile.${COLOROFF}"
			noerror=false
		elif $(make -q -C "${elem}"); then #check if directory is up to date
			status=$?
			#echo $status
			if [ "$status" -eq "0" ]; then
			echo -e "${LGREY}notice: $elem is up-to-date and error-free. It does not need to be built.${COLOROFF}"
			fi		
		else
			echo $elem will be built.
			#echo it valid lol
			valid+=("$elem")
		fi
	done
	build
	echo emptying array...
	unset StringArray
}

build() { #will only build if has a makefile, is directory, is not up-to-date
	#remove duplicates pushed from memory + new entry
	#printf '%s\n' "${valid[@]}" | sed 's# /#\n/#g' | 
	uniqueArray=$(printf '%s\n' "${valid[@]}" | sed 's# /#\n/#g' | sort -u) 
	mapfile -t validBuild <<< "${uniqueArray[@]}"
	echo -e "${BGREEN}[⏳ Building ${#validBuild[@]} C projects...]${COLOROFF}"
	
	for file in "${validBuild[@]}"; do 
		echo -e ${LGREEN}"${file}"${COLOROFF}
		echo "${file}" >> test.txt 
		make -s -C "${file}" > logtest.txt 2>&1 #flag if has errors or success
		#redirect errors and standard output to 'logtest.txt'
		if [ "$?" -ne 0 ]; then
			echo -e "${RED}Build failure${COLOROFF}"
			sed -i -e '/<!-- insert here -->/a\'"<tr><td>$(date)</td><td class="'teaser-col'">$file</td><td><a class="'red'" href=""></a></td></tr>"'' ~/project/BuildServer.html
			cat logtest.txt
		else
			echo -e "${GREEN}Build success${COLOROFF}"
			sed -i -e '/<!-- insert here -->/a\'"<tr><td>$(date)</td><td class="'teaser-col'">$file</td><td><a class="'green'" href=""></a></td></tr>"'' ~/project/BuildServer.html
		fi
	done
	sort -u test.txt -o test.txt
	#insert to html
	#git 
	
	#echo "<b>$file</b>" >> /home/Toastertech/project/BuildServer.html
}

echo -e ${BOLDBLUE}"C Build Script v0.1 - Let's build C projects!"${COLOROFF}

while true; do
	menuDisplay
	read -p "Please type in a menu option [1-3]: " select       
	case $select in
	1)	fastBuild
		echo;;
	2)	truncate -s 0 test.txt
		echo -e "${GREEN}Memory wiped!${COLOROFF}"
		;;
	3)	echo Goodbye!
		exit 0;;
	*)
		echo -e "${RED}error: Not a number or valid option${COLOROFF}"
	esac
done



