use strict; #this line ensures perl behaves itself.
use warnings; #tells perl to warn us if anything is amiss.


use Device::SerialPort;
my $port = Device::SerialPort->new("/dev/ttyACM0");#"/dev/ttyACM0" is the name of my serial port,
						   #yours might be different.  You can find out
						   #within the Arduino program - see web for details

# 9600, 81N on the USB ftdi driver
$port->baudrate(9600);  # you may change this value - make sure it matches
			# the 
$port->databits(8); # but not this and the two following
$port->parity("none");
$port->stopbits(1);

&catch_gremlins; #runs the catch_gremlins subroutine
&get_data; #runs the get_data subroutine

sub catch_gremlins{
	# now catch gremlins at start
	my $tEnd = time()+2; # 2 seconds in future
	while (time()< $tEnd) { # end latest after 2 seconds
	  my $c = $port->lookfor(); # char or nothing
	  next if $c eq ""; # restart if noting
	  # print $c; # uncomment if you want to see the gremlin
	  last;
	}
	while (1) { # and all the rest of the gremlins as they come in one piece
	  my $c = $port->lookfor(); # get the next one
	  last if $c eq ""; # or we're done
	  # print $c; # uncomment if you want to see the gremlin
	}
}


sub get_data{

	my $lastcheck = 0;
	my $now = 0;

	my $file = "readings.csv";
	open FLE, ">>$file" or die $!;
	while (1) {
	    # Poll to see if any data is coming in
	    my $char = $port->lookfor();
	
	    my $now = `date '+%Y%m%d%H%M%S'`;
	    chomp $now;
	#    print "now is $now\n lastcheck is $lastcheck\n";

	    # If we get data, then print it
	    # Send a number to the arduino
	    if ($char) {

		if ($now > $lastcheck + 20){
			my $date = `date '+%D'`;
			chomp $date;
			my $time = `date '+%T'`;
			chomp $time;
			print FLE "$date, $time, $char\n";
	    		$lastcheck = $now;
		}
	    }
	

	    # the following lines give slower reading, 
	    # but lower CPU usage, and to avoid 
	    # buffer overflow due to sleep function. 

	    $port->lookclear; 
	    sleep (1);
	}
	close FLE;
}

