#!/usr/bin/perl

my @data;

my $filename = 'sample_data';
if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
  @data = <$fh>; 
} else {
  warn "Could not open file '$filename' $!";
}
close($fh);


$total = join(' ',@data);

#print $total;
$total =~ s/\s+/ /g;

while($total =~ m/id="recordtable">(.*)<\/table>/g){
#while($faqja =~ m/<div id="h0">(.*)<\/div><\/div><\/div><\/div>/ig){
  print $1;
}