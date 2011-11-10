use t::Utils;
use Test::More;
use Mock::Inflate;

my $dbh = t::Utils->setup_dbh;
my $db  = Mock::Inflate->new({ dbh => $dbh });
   $db->setup_test_db;
   $db->insert('mock_inflate', {
       id   => 1,
       name => 'perl',
   });

subtest "update() doesn't break inflation after called" => sub {
    my $row = $db->single(mock_inflate => { id => 1 });
    isa_ok $row->name, 'Mock::Inflate::Name';

    $row->update({ name => 'python' });
    isa_ok $row->name, 'Mock::Inflate::Name';
};

subtest "deflation called twice" => sub {
    my $row1 = $db->single(mock_inflate => { id => 1 });
       $row1->update({ name => 'python' });
    my $row2 = $row1->refetch;

    isa_ok $row2->name, 'Mock::Inflate::Name';
    is     $row2->name->name, 'python_deflate';
};

done_testing;
