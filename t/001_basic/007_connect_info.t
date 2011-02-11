use t::Utils;
use Mock::Basic;
use Test::More;

subtest 'basic' => sub {
    my $db = Mock::Basic->new( connect_info => [ 'dbi:SQLite:', '', '' ] );

    my $connect_info = $db->connect_info();
    is_deeply 
        $connect_info,
        [ 'dbi:SQLite:', '', '', { RaiseError => 1, AutoCommit => 1, PrintError => 0 } ],
        "connect_info is as expected",
    ;
};

=head1
subtest 'bad connect info' => sub {
    eval {
        my $db = Mock::Basic->new(
            connect_info => [ 'dbi:NoSuchDriver:' ] );
    };
    like $@, qr/Connection error: install_driver\(NoSuchDriver\) failed/;
};

subtest 'bad on_connect_do' => sub {
    eval {
        my $db = Mock::Basic->new(
            connect_info => [ 'dbi:SQLite:' ],
            on_connect_do => \1
        );
    };
    like $@, qr/Invalid on_connect_do: SCALAR/;
};
=cut

done_testing;
