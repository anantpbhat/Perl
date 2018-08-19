#!/usr/bin/perl -w

use strict;

sub getcpuinfo {
	open CPUINFO, "/proc/cpuinfo";
	foreach (<CPUINFO>) {
		print if s/^model name/CPU/;
		print if s/^cpu MHz/CURRENT SPEED MHz/;	
	}
	close CPUINFO;
}

sub getmeminfo {
	open MEMINFO, "/proc/meminfo";
	foreach (<MEMINFO>) {
		print if s/^MemTotal:/Total MEM:/;
		print if s/^MemFree/Free MEM:/;	
	}
	close MEMINFO;
}

sub getdmi {
	open DMIINFO, "/usr/sbin/dmidecode|";
	foreach (<DMIINFO>) {
		print ${^MATCH}, ${^POSTMATCH} if m?Manufacturer:?ip;
		print "Hardware Model:\t ThinkPad T43\n" if m?Thinkpad?i;
		print ${^MATCH}, ${^POSTMATCH} if m?Serial Number:?ip;
	}
	close DMIINFO;
}

print "HOSTNAME:\t";
system "/bin/hostname", "-s";
print "Kernel Version:\t"; 
system "/bin/uname", "-r";
getcpuinfo;
getmeminfo;
getdmi;

exit 0;
