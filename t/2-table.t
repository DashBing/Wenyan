use utf8;
use wenyan qw();
use Test::More;

# kill UTF-8 warnings
my $builder = Test::More->builder;
binmode $builder->output,         ':utf8';
binmode $builder->failure_output, ':utf8';
binmode $builder->todo_output,    ':utf8';

%check = (
    火 => 'y',
    风 => 'z',
    秋 => 'Y',
    冬 => 'Z',
    万 => 10**4,
    亿 => '10000_0000',
    廿 => 20,
    卅 => 30,
    '８' => 8,
    '９' => 9,
    然 => ':',
    标 => ':',
    者 => '`',
    系 => '~',
    '‵' => '`',
    '～' => '~',
    之 => '->',
    宗 => '::',
    同 => 'eq ',
    否 => 'not ',
    列 => '"\\n"',
    主 => 'main ',
    察 => 'CHECK',
    灭 => 'DESTROY',
    双 => 'qq/',
    逆 => 'reverse ',
    厚 => 'ucfirst ',
    换 => 'y/',
    习 => 'study ',
    规 => 'qr/',
    根 => 'sqrt ',
    骚 => 'srand ',
    抽 => 'splice ',
    予 => 'unshift ',
    排 => 'sort ',
    启 => 'unpack ',
    键 => 'keys ',
    值 => 'values ',
    排 => 'format ',
    撷 => 'getc ',
    择 => 'select ',
    召 => 'syscall ',
    讯 => 'warn ',
    写 => 'write ',
    启 => 'unpack ',
    向 => 'vec ',
    开 => 'open ',
    展 => 'opendir ',
    松 => 'unlink ',
    刻 => 'utime ',
    副 => 'sub ',
    欲 => 'wantarray ',
    套 => 'package ',
    用 => 'use ',
    消 => 'undef ',
    欲 => 'wantarray ',
    杀 => 'kill ',
    重 => 'for ',
    候 => 'wait ',
    必 => 'require ',
    用 => 'use ',
    缚 => 'tied ',
    解 => 'untie ',
    收 => 'recv ',
    送 => 'send ',
    槽 => 'socket ',
    区 => 'localtime ',
    时 => 'time ',
    码 => 'encoding ',
    栏 => 'fields ',
    倭 => 'vmsish ',
    警 => 'warnings ',
    译 => 'wenyan::translate',
    表 => 'wenyan::Tab',
);
my @untranslated = qw(
    formline getppid getpriority waitpid dbmopen getsockopt socketpair shmwrite
    getgrnam setpwent gethostbyname getnetent getprotoent setservent
);

plan tests => keys(%check) + @untranslated;

is $wenyan::Tab{$_}, $check{$_},
  "sample keyword $_ == »$check{$_}«" for keys %check;
ok !exists $wenyan::Tab{$_},
  "untranslated keyword »$_« is not in the table" for @untranslated;
