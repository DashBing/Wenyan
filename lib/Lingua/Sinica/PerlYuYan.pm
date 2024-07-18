package Lingua::Sinica::PerlYuYan;

use 5.008;
use utf8;
use strict;
use Filter::Simple::Compile;
use Encode ();

our $VERSION = 1257700140.47574; # 2009年11月 9日 周一 01时09分11秒 CST

=encoding utf8

=head1 NAME

Lingua::Sinica::PerlYuYan - 中书珨 - Perl in Classical Chinese in Perl

=head1 VERSION

our $VERSION = 1257700140.47574; # 2009年11月 9日 周一 01时09分11秒 CST

=head1 SYNOPSIS

    # The Sieve of Eratosthenes - 埃拉托斯芬筛法
    use Lingua::Sinica::PerlYuYan;

      用筹兮用严。井涸兮无碍
    。印曰最高矣  又道数然哉。
    。截起吾纯风  赋小入大合。
    。习予吾阵地  并二至纯风。
    。当起段赋取  加阵地合始。
    。阵地赋筛始  系系此杂段。
    。终阵地兮印  正道次标哉。
    。输空接段点  列终注泰来。

=head1 DESCRIPTION

This module makes it possible to write Perl programs in Classical Chinese poetry in Perl.

说此经者，能以珨文言文珨。

(If one I<has> to ask "Why?", please refer to L<Lingua::Romana::Perligata> for
related information.)

(阙译，以待来者。)

This module uses the single-character property of Chinese to disambiguate
between keywords, so one may elide whitespaces much like in real Chinese writings.

The vocabulary is in the 文言 (literary text) mode, not the common 白话
(spoken text) mode with multisyllabic words.

C<Lingua::Sinica::PerlYuYan::translate()> (or simply as C<译()>) translates a
string containing English programs into Chinese.

=cut

our %Tab;
while (<DATA>) {
    $_ = Encode::is_utf8($_) ? $_ : Encode::decode_utf8($_);

    next if /^\s*$/;
    my @eng = split ' ';
    my @chi = map {/\A [!-~]+ \z/msx ? $_ : split //, $_}
      # clusters of ASCII are untranslated keywords; keep them
      split ' ', <DATA>;
    for (my $i = 0; $i <= $#eng; $i++) {
        next if $chi[$i] eq $eng[$i];    # filter untranslated
        $Tab{$chi[$i]} =    # append space if keyword, but not single letter
        $eng[$i] =~ /\A [a-z]{2,} \z/msx ? $eng[$i] . ' ' : $eng[$i];
    }
}

@Tab{qw{ 资曰     乱曰    档曰     列曰     套曰        }}
   = qw{ __DATA__ __END__ __FILE__ __LINE__ __PACKAGE__ };

FILTER {
    $_ = Encode::is_utf8($_) ? $_ : Encode::decode_utf8($_);

    foreach my $key ( sort { length $b <=> length $a } keys %Tab ) {
        s/$key/$Tab{$key}/g;
    }

    return($_ = Encode::encode_utf8($_));
};

no warnings 'redefine';
sub translate {
    my $code = shift;

    for my $key (sort {length $Tab{$b} cmp length $Tab{$a}} keys %Tab) {
        $code =~ s/\Q$Tab{$key}\E/$key/g;
    }

    return $code;
}

1;

=head1 SEE ALSO

L<Filter::Simple::Compile>, L<Lingua::Romana::Perligata>

=head1 CC0 1.0 Universal

To the extent possible under law, 唐凤 has waived all copyright and related
or neighboring rights to Lingua-Sinica-PerlYuYan.

This work is published from Taiwan.

L<http://creativecommons.org/publicdomain/zero/1.0>

=begin html

<p xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/" style="text-decoration:none;">
    <img src="http://i.creativecommons.org/l/zero/1.0/88x31.png" border="0" alt="CC0" />
  </a>
  <br />
  To the extent possible under law, <a href="http://www.audreyt.org/" rel="dct:publisher"><span property="dct:title">唐凤</span></a>
  has waived all copyright and related or neighboring rights to
  <span property="dct:title">Lingua-Sinica-PerlYuYan</span>.
This work is published from
<span about="http://www.audreyt.org/" property="vcard:Country" datatype="dct:ISO3166" content="TW">Taiwan</span>.
</p>

=end html

=cut

__DATA__
a b c d e f g h i j k l m n o p q r s t u v w x y z
甲乙丙丁戊己庚辛壬癸子丑寅卯辰巳午未申酉戌亥地水火风
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
青心赤肝黄脾白肺黑肾鼠牛虎兔龙蛇马羊猴鸡狗猪春夏秋冬

0 1 2 3 4 5 6 7 8 9 10 100 1000 10000 10000_0000
零一二三四五六七八九十 百  千   万    亿
0 1 2 3 4 5 6 7 8 9 10 100 1000 20 30
零壹贰毵肆伍陆柒捌玖拾 佰  仟   廿 卅
0 1 2 3 4 5 6 7 8 9
０１２３４５６７８９

! @ # # $ % % ^ & * ( ) - = _ + + [ ] { } \ | ; : :
非阵井注纯杂模析和乘起合减赋底加正内外始终参联兮然标
' ' " " , , => < . . > / / ? ` ` ~
曰矣道哉又并与 小点接大除分欤行者系
! @ # $ % ^ & * ( ) - = _ + [ ] { } \ | ; ; : ' " , , < . > / ? ` ~
！＠＃＄％︿＆＊（）－＝＿＋〔〕｛｝╲｜；。：’”，、＜．＞╱？‵～

.. ... ** ++ -- -> ::
至 乃  幂 增 扣 之 宗

&& == || and or lt gt cmp eq not
及 等 许 且  或 前 后 较  同 否

=~ !~ x <=> ~~ //
=~ !~ x <=> ~~ //

<< >> <= >= le ge != ne xor
<< >> <= >= le ge != ne 抑

**= += *= &= <<= &&= -= /= |= >>= ||= .= %= ^= //= x=
**= += *= &= <<= &&= -= /= |= >>= ||= .= %= ^= //= x=

$/ $_ @_ "\x20" "\t" "\n" main
段 此 诸 空     格   列   主

STDIN STDOUT STDERR DATA BEGIN END INIT CHECK DESTROY
入    出     误     料   创    末  育   察    灭

chomp chop chr crypt hex index lc lcfirst length oct ord pack q/ qq/ reverse
截    斩   文  密    爻  索    纤 细      长     卦  序  包   引 双  逆
rindex sprintf substr tr/ uc ucfirst y/
检     编      部     转  壮 厚      换

m/ pos quotemeta s/ split study qr/
符 位  逸        代 切    习    规

abs atan2 cos exp hex int log oct rand sin sqrt srand
绝  角    余  阶  爻  整  对  卦  乱   弦  根   骚

pop push shift splice unshift
弹  推   取    抽     予

grep join map qw/ reverse sort unpack
筛   并   映  篇  逆      排   启

delete each exists keys values
删     每   存     键   值

binmode close closedir dbmclose dbmopen die eof fileno flock format getc
法      闭    关       合       揭      死  结  号     锁    排     撷
print printf read readdir rewinddir seek seekdir select syscall
印    输     读   览      回        搜   寻      择     召
sysread sysseek syswrite tell telldir truncate warn write
鉴      狩      敕       告   诉      缩       讯   写

pack read unpack vec
包   读   启     向

chdir chmod chown chroot fcntl glob ioctl link lstat mkdir open opendir
目    权    拥    迁     控    全   制    链   况    造    开   展
readlink rename rmdir stat symlink umask unlink utime
循       更     毁    态   征      蒙    松     刻

say if else elsif until while foreach given when default break
说  倘 匪   乃    迄    当    逐      设    若   预      折

caller continue die do dump eval exit goto last next redo return sub wantarray
唤     续       死  为 倾   执   离   跃   尾   次   再   回     副  欲

caller import local my our package use
唤     导     域    吾 咱  套      用

defined dump eval formline local my our reset scalar undef wantarray
定      倾   执   划       域    吾 咱  抹    量     消    欲

alarm exec fork getpgrp getppid getpriority kill
铃    生   殖   getpgrp getppid getpriority 杀

for
重

pipe qx/ setpgrp setpriority sleep system times wait waitpid
管   qx/ setpgrp setpriority 眠    作     计    候   waitpid

do no package require use
为 无 套      必      用

bless dbmclose dbmopen package ref tie tied untie
祝    dbmclose dbmopen 套      照  缠  缚   解

accept bind connect getpeername getsockname getsockopt listen recv send
受     束   连      getpeername getsockname getsockopt 聆     收   送

setsockopt shutdown sockatmark socket socketpair
setsockopt shutdown sockatmark 槽     槏

msgctl msgget msgrcv msgsnd semctl semget semop shmctl shmget shmread shmwrite
msgctl msgget msgrcv msgsnd semctl semget semop shmctl shmget shmread shmwrite

endgrent endhostent endnetent endpwent getgrent getgrgid getgrnam
endgrent endhostent endnetent endpwent getgrent getgrgid getgrnam

getlogin getpwent getpwnam getpwuid setgrent setpwent
getlogin getpwent getpwnam getpwuid setgrent setpwent

endprotoent endservent gethostbyaddr gethostbyname
endprotoent endservent gethostbyaddr gethostbyname

gethostent getnetbyaddr getnetbyname getnetent
gethostent getnetbyaddr getnetbyname getnetent

getprotobyname getprotobynumber getprotoent
getprotobyname getprotobynumber getprotoent

getservbyname getservbyport getservent sethostent
getservbyname getservbyport getservent sethostent

setnetent setprotoent setservent
setnetent setprotoent setservent

gmtime localtime time
准     区        时

attributes autouse base blib bytes charnames constant diagnostics encoding fields
性         活      基   括   字    名        常       诊          码       栏
filetest integer less locale overload sigtrap strict subs utf8 vars vmsish warnings
试       筹      少   国     载       号      严     式   通   变   倭     警
Lingua::Sinica::PerlYuYan::translate Lingua::Sinica::PerlYuYan::Tab
译                                   表
