use v5.14;
use warnings;

my $count = <> + 0;

my (@input,@words,@matches);
foreach (1 .. $count) {
   my $line = <>;
   chomp($line);
   push @input, $line;
}

my $tmp = <> + 0;
foreach (1 .. $tmp) {
   my $line = <>;
   chomp($line);
   push @words, $line;
}

my %o;
foreach my $sub (@words) {
   foreach my $string (@input) {
        find_word($string , $sub, \$o{$sub});
   }
}

foreach my $key (@words) {
   say "$o{$key}";
}
sub find_word {
  my $string = shift;
  my $char = shift;
  my $count=shift;
  my $c1=$$count;
  my $offset = 0;
  my $result = index($string, $char, $offset);
  my ($x1,$x2)=('','');
  while ($result != -1) {

    $x1=substr($string, $result-1,1) if $result;
    $x2=substr($string,$result+length($char),1);
    if($x1!~/\w/ and $x2!~/\w/) {
        $$count++;
    }
    $offset = $result+1 ;
    $result = index($string, $char, $offset);
  }
}

#Problem Statement

__DATA__
A word is defined as a set of characters; alphabets ( lower case and upper case ) and numbers (0-9) both included and an underscore '_' (ascii value 95). Given a series of sentences each of which contains valid ascii characters, find the total number of occurrences of a given word.

So, a word as a whole will be surrounded by 1 or more occurrences of characters which are neither alphabets, numbers or an underscore.

<non-letter, non-number or non-underscore ><letters, numbers or underscores><non-letter, non-number or non-underscore>
Input Format

The first line is an integer N. N lines follow. Each line is a sentence as per the definition given in the introductory paragraph. 
The Nth sentence is immediately followed by an integer T. T lines follow, with the tests. Each line has a word. You need to find the total number of occurrences of this word in the given sentences.

Constraints

1 <= N <= 100 
1 <= T <= 10

Output format

For every word, print the number of occurrences of the word in all the N sentences listed.

Sample Input

1
foo bar (foo) bar foo-bar foo_bar foo'bar bar-foo bar, foo.
1
foo
Sample Output

6
Explanation

foo is the first word
(foo) has non ascii '()' surrounding it and is the second word.
foo-bar are considered two words and has 'foo' in it; foo is followed by non-letter, non-underscore '-' (hyphen, minus)
bar-foo for the same reason mentioned above.
foo_bar is considered a single word and hence foo in it is not counted.
foo'bar are two words has 'foo' in it, foo is followed by a non-alphabet, non-underscore ''' apostrophe.
foo. as it is followed by a non-alphabet '.' full stop.
