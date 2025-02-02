#!/bin/bash
declare -a programs=("cat" "echo" "head" "ls")
if [ -z $1 ]; then
	for i in "${programs[@]}"; do
		pushd "$i" > /dev/null
		printf "\e[93;1mBuilding %s\n" "$i"
		cargo build --release
		if [ $? == 0 ]; then
			if [ $i == "cat" ]; then
				cp "target/release/main" ../build/cat
			elif [ $i == "ls" ]; then
				cp "target/release/main" ../build/ls
			else
				cp "target/release/$i" ../build
			fi
		else
			popd > /dev/null
			printf "\e[91;1mOne or more programs failed to build\n" > /dev/stderr
			exit 1
		fi
		popd > /dev/null
	done
else
	for i in "${programs[@]}"; do
		if [ $i == $1 ]; then
			pushd "$i" > /dev/null
			printf "\e[93;1mBuilding %s\n" "$i"
			cargo build --release
			if [ $? == 0 ]; then
				if [ $i == "cat" ]; then
					cp "target/release/main" ../build/cat
				elif [ $i == "ls" ]; then
					cp "target/release/main" ../build/ls
				else
					cp "target/release/$i" ../build
				fi
			else
				popd > /dev/null
				printf "\e[91;1m%s failed to build\n" "$i" > /dev/stderr
				exit 1
			fi
			popd > /dev/null
			exit 0
		fi
	done
fi


