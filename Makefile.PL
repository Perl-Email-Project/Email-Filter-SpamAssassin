
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'Email::Filter::SpamAssassin',
    AUTHOR          => 'Uwe Voelker <uwe.voelker@gmx.de>',
    VERSION_FROM    => 'lib/Email/Filter/SpamAssassin.pm',
    ABSTRACT_FROM   => 'lib/Email/Filter/SpamAssassin.pm',
    PL_FILES        => {},
    PREREQ_PM    => {
                     'Email::Filter'      => 0,
                     'Mail::SpamAssassin' => 0,
                     'Test::More'         => 0,
                     'version'            => 0,
    },
    dist            => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean           => { FILES => 'lib/Email/Filter/SpamAssassin.pm-*' },
);
