package Email::Filter::SpamAssassin;
use version; $VERSION = qv('0.0.1');

=head1 NAME

Email::Filter::SpamAssassin - integrate Mail::SpamAssassin in Email::Filter

=head1 VERSION

This document describes Email::Filter::SpamAssassin version 0.0.1.

=head1 SYNOPSIS

  use Email::Filter::SpamAssassin;  # subclass of Email::Filter

  my $email  = Email::Filter::SpamAssassin->new;
  my $status = $email->spam_check;
  $email->ignore if $status->is_spam;

  # or supply a Mail::SpamAssassin object
  $status = $email->spam_check($spam_assassin);
  $email->accept('spam') if $status->is_spam;

=cut

use strict;
use warnings;

use base 'Email::Filter';
use Mail::SpamAssassin;

=head1 DESCRIPTION

This module is a subclass of L<Email::Filter> which integrates
L<Mail::SpamAssassin>. It has only one additional method.

=head1 METHODS

=head2 spam_check

Accepts an optional L<Mail::SpamAssassin> object. If nothing is supplied
it constructs one with the default parameters. Then it calls the method
C<check> on this object and returns an L<Mail::SpamAssassin::PerMsgStatus>
object (on which you can call C<is_spam>).

=cut

sub spam_check {
    my ($self, $spam_assassin) = @_;

    # construct own SpamAssassin object?
    $spam_assassin ||= Mail::SpamAssassin->new;

    my $mail = $spam_assassin->parse($self->simple->as_string);

    return $spam_assassin->check($mail);
}

=head1 CONFIGURATION AND ENVIRONMENT

You can influence the L<Mail::SpamAssassin> behaviour by passing an
object with your configuration to L<spam_check> as first parameter.

=head1 DEPENDENCIES

L<Email::Filter>, L<Mail::SpamAssassin>.

=head1 INCOMPATIBILITIES

=for author_to_fill_in
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-Email-Filter-SpamAssassin@rt.cpan.org>, or through the web interface
at L<http://rt.cpan.org>.

=head1 AUTHOR

Uwe Voelker, C<uwe.voelker@gmx.de>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2006, Uwe Voelker C<uwe.voelker@gmx.de>.
All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See C<perldoc perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE ''AS IS'' WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut

1;
