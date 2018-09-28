use Bio::SeqIO;
die "perl $0 fasta seqid(one line one seqid) outfile" if (@ARGV<1);
open A,$ARGV[1] ;
my @seqid ;
while (<A>){
chomp ;
push @seqid, $_;
}
my $out = $ARGV[2];
my $fastaF = $ARGV[0];
my $ina = Bio::SeqIO->new(-file => $fastaF, -format => 'fasta');
open B,">$out";
select B ;
while(my $obj = $ina->next_seq()){
    my $id = $obj->id;
    my $desc = $obj->desc;
    my $seq = $obj->seq;
    my $len = $obj->length;
    unless(grep /^$id$/, @seqid ){
        print ">$id"."\t$desc"."\n"."$seq"."\n";
    } 
}
