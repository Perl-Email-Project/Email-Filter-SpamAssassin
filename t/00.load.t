# -*- perl -*-

use strict;
use warnings;

use File::Spec;
use FindBin;
use Test::More tests => 6;

BEGIN {
    use_ok( 'Email::Filter::SpamAssassin' );
}

# test with spam from Mail::SpamAssassin package
{
    open(FH, File::Spec->catfile($FindBin::Bin, 'spam001')) or die $!;
    my $spam = join('', <FH>);
    close(FH);

    my $mail = Email::Filter::SpamAssassin->new(data => $spam);

    isa_ok($mail, 'Email::Filter::SpamAssassin', 'new() ok');
    can_ok($mail, 'spam_check');

    my $status = $mail->spam_check;

    isa_ok($status, 'Mail::SpamAssassin::PerMsgStatus', 'return object');

    ok($status->is_spam, 'spam is spam');
}

# test with nice from Mail::SpamAssassin package
{
    open(FH, File::Spec->catfile($FindBin::Bin, 'nice001')) or die $!;
    my $nice = join('', <FH>);
    close(FH);

    my $mail = Email::Filter::SpamAssassin->new(data => $nice);

    my $status = $mail->spam_check;

    ok(!$status->is_spam, 'nice is not spam');
}
