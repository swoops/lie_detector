#!/bin/bash

ld=./stat_liar.so
detector=../lie_detector

if [[ ! -x ${ld} ]]; then
	echo "[**] ${ld} not found, attempting to make"
	make
	if [[ $? -ne 0 ]]; then
		echo "[!!] make failed, exiting"
		exit -1
	fi
fi

if [[ ! -x ${detector} ]]; then
	echo "[!!] ${detector} DNE, make it yourself!"
	exit -1
fi

test_file(){
	run_em="${detector} $1"
	echo
	echo "---------- testing ------------------"
	echo "$ LD_PRELOAD=${LD_PRELOAD}"
	echo "$ ${run_em}"
	${run_em}
	ret=$?
	echo "====================================="
	echo

	return $ret
}


echo "[**] runing positive test"
echo
if test_file "/etc/shadow"; then
	echo "[**] positive case passed!"
else
	echo "[!!] positive case failed! are you already rooted?"
	exit -1
fi



export LD_PRELOAD=${ld}
echo "[**] runing negative test"
echo
if ! test_file "/etc/shadow"; then
	echo "[**] negative case passed!"
	echo
else
	echo "[!!] negative case failed!"
	echo -e "\tcheck that preload file put output, otherwise preload may of failed"
	echo -e "\tif preload output then the ${detector} may of failed"
	exit -1
fi
unset LD_PRELOAD
