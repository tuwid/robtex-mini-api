use LWP::UserAgent;
use strict;


my $url = 'https://www.robtex.com/en/advisory/ip/';
my $ip;
my $ua = LWP::UserAgent->new;


defined($ARGV[0]) ? $ip = "$ARGV[0]" : die "Jepni IP-ne si parameter..\n";
if ($ip !~ m/^([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])$/){
	print "Invalid IP \n";
	exit(3);
}
else{
	print "IP seems valid.. Proceeding with the request \n";
}


$ua->agent("Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.9.0.2) Gecko/2008092313 Ubuntu/9.25 (jaunty) Firefox/3.8") ;
$ua->timeout(5);

$ip =~ s/\./\//g;
#my $url = 'http://ip.robtex.com/'.lc($ip).".html"; # old robtex
my $url .= $url.$ip.'/';

my $response = $ua->get($url);
	if($response->is_success){
		my $faqja = $response->content;
		print "$faqja\n\n";
			$faqja =~ s/\n//g;
			$faqja =~ s/\r//g;
			while($faqja =~ m/<div class="xsummary">(.*)<\/a> point to <a href/g){
			#while($faqja =~ m/<div id="h0">(.*)<\/div><\/div><\/div><\/div>/ig){
				my $data = $1;
				$data =~ s/<a href="\/\//\n/g;
					while($data =~ m/robtex.com\/(.*).html">(.*)/ig){
					#push(@te_dhanat,"$1 imp $2");
					print "$1\n";
				}
			}
	}
	else{
		if($response->status_line =~ m/403/){
			print "Weirdly the page wasnt found...\n";
		}
		else{
			print "Connectivity issues.. \n";	  
		}
	}
	
