はずむ虹の輪 v1.3
=================

四方八方から転がってくる虹の輪を観賞するアプリケーションです。
マウスとキーボードを使ってカメラを操作し、自由な距離・角度から観ることができます。
水の上をはねる虹の美しさ・面白さを感じていただければと思います。

描画にはd3moduleを、虹の輪や波紋・しぶきの管理はモジュール変数を利用しています。
スクリプトを公開しているので、ご自由にご利用ください。
d3moduleを利用しない2次元版のスクリプトは
http://rpen.blogspot.com/2007/07/blog-post_30.html
にあります。


※操作方法は画面に表示されます。


■ コメント返信

頂いたコメントの中で、返信を要すると判断したものだけをピックアップして
返信いたします。ここに書いていないコメントもすべて読ませていただいています。


> 幻想的で抽象的、しかしそれでいてどこかに現実味も帯びた美麗さを感じました。
> 波紋にジャギーが目立ってるがちょっともったいないかなぁ。と思いましたが、
> これはHSPの特性上仕方が無いことですかね。（08/05）

	コメントありがとうございます。
	v1.1からgpm.hspを利用して、アンチエイリアスをかけました。
	gpm.hspはとても簡単に利用できるモジュールですので、まだ使ったことがない方は
	一度使ってみてください。sprocketさんのサイト（http://sprocket.babyblue.jp/）で
	公開されています。


> 水面に映る輪が綺麗ですね。
> 欲を言えば、波紋の周囲では映る輪もゆがむと良いですが。（08/14）

	コメントありがとうございます。
	恐らく3D制御用のDLLを導入しないと実装は難しいと思われますので、
	今回は見送らせていただきます。


> 面白かったです。
> 水面下（？）に入ったときは鏡像を消したほうがいいのではないかと思います。（08/18）

	コメントありがとうございます。
	仰る通りですね。お恥ずかしいことに、指摘を受けるまで気づきませんでした。orz
	v1.2から修正させていただきました。


> これはこれは綺麗ですね。でも単調すぎます。
> 虹の輪がはずんで、そこからどうなの？っていう展開に欠けてます。
> 例えば虹の輪が弾んで他の輪にぶつかってお互いが弾かれるとか！！
> PC上の仮想世界ではありますが見るものは何かしら現実世界とリンクさせて物を見ます。
> 「弾む」という質量のあるものの現象が、地面にはぶつかって輪同士はぶつからないという矛盾で
> この虹の輪の説得力をかき消しています。そこらへんを詰めてみてください！（08/23）

	コメントありがとうございます。
	実は今回、「初心者にはHSPでこんなことができるということを見せ、中級者にはモジュール変数や
	d3moduleの使い方を例示する」という目的を持ってこの作品でコンテストに参加させていただいています。
	よってサンプルスクリプトとしての条件を満たすために、スクリプト自体はできるだけ簡素な状態に保ちたいのです。
	（結局読みづらいスクリプトになってしまったことは反省点ですが……）

	このため企画段階では「減速したら姿勢を保てずに倒れる」「輪同士が衝突して、欠片が舞い散る」といった
	処理も考えていましたが、すべてボツになりました。特に衝突のような相互作用は読みにくくなりがちですので、
	現段階では導入を考えておりません。
	提示していただいた問題点は次回以降の課題とさせていただきます。


■ 更新履歴

* v1.0 -> v1.1
 - gpmモジュールを利用し、波紋にアンチエイリアスをかけました。
 - 一時停止機能を追加。

* v1.1 -> v1.2
 - 水面下から観賞時、水面に映る像を描画しないように修正。
 - はずんだ時に回転速度が減速するように変更。

* v1.2 -> v1.3
 - 一時停止時にパーティクルが消える不具合を修正。
 - ソースコードを（やっと）公開。

作　者：eller（えらー）
サイト：http://skypencil.jp/