LIE_DETECTOR

	This program just calls stat() on all the files it is given, it then calls
	stat() again but through a syscall written in ASM. The sizes are then compared
	for discrepancies. A discrepancy means someone lied to you!!!

* Why?
	Some backdoors are using LD_PRELOAD to hook stat, among other things. This lets
	them lie to "ls -l /etc/shadow" to make the file size consistent with the
	number of users you THINK you have on your computer. In reality a backdoor
	account exists.

* Usage
	Make the program then run something like: 

		find /etc/ -type f -print0 2>/dev/null |xargs -0 ./lie_detector

	If you want it to exit on the first failure use the -1 flag:

		find /etc/ -type f -print0 2>/dev/null |xargs -0 ./lie_detector -1

	If no output occurs and lie_detector exists with zero status code, then no
	discrepancies were found.

* TODO
	+ 32 bit architectures
	+ ARM architecture
	+ More check for other lies
	+ gcc inline assembly

* WARNING
	Use at your own risk! There is no warranty! My first attempt at this did
	not work at all. My 32bit asm skills are bad and my 64bit skills are worse.
	That said, I would like this program to work well, so if you find a problem
	or want something feel free to send a pull or contact me.

