#!/bin/bash

########################################
# mvlowercase.sh
# By: Bambang Pranoto (bpranoto@gmail.com)
# Recursively rename files to lower case
#######################################


scan()
{
	local f
	local l

	# Scan current directory
	for f in *; do
		# if a regular file or directory
		if [[ -f $f ]] || [[ -d $f ]] ; then

			# if a  directory
			if [[ -d $f ]]; then

				# enter that directory
				cd "$f"

				# recursively process this directory
				scan

				# back to current directory
				cd ..
			fi

			# if the filename contains capital letter
			if [[ "$f" =~ .*[A-Z].* ]] ; then

				# Convert the file name to lower case
				# store in variable l
				l=`echo $f|tr [:upper:] [:lower:]`


				# check the existance of the lower case version
			        # of the file or directory doesn't exists 
				if ( [[ -f $f ]] &&  [[ ! -f $l ]] ) || ( [[ -d $f ]] && [[ ! -d $l ]] ) ;then
					# doesn't exist so rename
					mv "$f"  "$l"
				else
					# already exists, complain!
					echo "Cannot rename $f to $l, $l already exists"
				fi
			fi
		fi	
	done
}

scan
