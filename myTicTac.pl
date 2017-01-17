#TIC TAC TOE by Duaa Shemna


 
my $board = "1 | 2 | 3         4 | 5 | 6         7 | 8 | 9";
my @wins = qw/ 123 456 789 147 258 369 159 357 /; #Winning Possibilities
my $piece; #User's Piece
my $comppiece; #Computer's Piece
 
sub board {
 print "\n$_ " for ($board=~ /(.........)/g);#Displays the grid
 print "\n";
 if ($_ = shift) { print; exit; }
}
 
sub move { # Returns 0 for an invalid move, 1 for a valid move
my($piece,$move)=@_;
 return 0 if $piece !~ /^[XO]$/ or $move !~ /^[1-9]$/;
 return 0 unless $board =~ s/$move/$piece/;#match
  for (0..7) { #Substitutes the new value of grid[X or O] to BOARD and WINS
  board ("\n$piece wins!\n") if $wins[$_] =~ s/$move/$piece/ && $wins[$_] eq $piece x 3;
 }
 board ("\nTie!\n") if $board !~ /\d/;#not match
 return 1;
}
 
 #Checks if input is either X or O
 sub checkPiece {
 my($piece)=@_;
 if ($piece !~ /^[XO]$/){
  return 0;
 }
 else {
  return 1;
  }
}
 
 #returns array of all possible win conditions for the computer
sub checkMove {
 my($piece,$move)=@_;
 return 0 if $piece !~ /^[XO]$/ or $move !~ /^[1-9]$/;
 return grep { /$piece/ && /$move/ && /\d${piece}?\d/ } @wins;
}

sub player {
 my $retval = 0;
 my $move;
 until ( $retval ) {
  print "\nMove : ";
  chomp ($move = <>);
  $retval = move($piece, $move);
 }
}
 
#Computer plays
sub comp{ 
 return if move($comppiece, 5); #default position 5, best position
 my @open = ($board =~ /(\d)/g); #array of available positions
 #print "\n@open\n";
 my $compmove;
 #Checks for winning possibility (2 out of 3)
 foreach $compmove (@open) { return move($comppiece,$compmove) if grep {/$compmove/ && /$comppiece\d?$comppiece/} @wins; }
 #Checks for winning possibility (1 out of 3)
 foreach (@open) { return move($comppiece,$_) if ( checkMove($comppiece, $_) > 1 ); }
 $compmove=$open[rand @open];#int(rand(@open));
 #print "\n$compmove\n";
 move ($comppiece, $compmove);
}
 
 print "\n Enter 'X' or 'O' : ";
 chomp ($piece = <>);
 my $value=checkPiece($piece);
 if ($value != 0){
  if ($piece =~ /^[X]$/){
  $comppiece='O';
 }
 else{
  $comppiece='X';
 }
  while (1) {
   board;
   player;
   comp;
  }
 }
 else{
  print "\n Invalid Input!\n";
 }


