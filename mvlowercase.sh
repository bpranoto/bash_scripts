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

	for f in *; do
		# Jika regular file atau directory
		if [[ -f $f ]] || [[ -d $f ]] ; then

			# Jika directory
			if [[ -d $f ]]; then

				# masuk ke directory tsb
				#echo "cd $f"
				cd $f

				# proses
				scan

				# kembali
				cd ..
			fi

			# Jika filenamenya mengandung huruf besar
			if [[ "$f" =~ .*[A-Z].* ]] ; then

				# Convert nama file ke huruf kecil di variable l
				l=`echo $f|tr [:upper:] [:lower:]`


				# kalau file/directory l belum ada, maka rename
				if ( [[ -f $f ]] &&  [[ ! -f $l ]] ) || ( [[ -d $f ]] && [[ ! -d $l ]] ) ;then
					mv $f  $l
				else
					# file/directory l sudah ada
					# complain
					echo "Cannot rename $f to $l, $l already exists"
				fi
			fi
		fi	
	done
}

scan
