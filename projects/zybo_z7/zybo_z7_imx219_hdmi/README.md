# ZYBO-Z7 で Raspberry Pi Camera Module V2 (Sony IMX219) をHDMIコネクタから表示

## 概要

ZYBO-Z7 で Raspberry Pi Camera Module V2 (Sony IMX219) をHDMIコネクタから表示するサンプルです。
なおコネクタはHDMIですが内部の電気的信号はDVIとなっております。



## 環境

このような環境で実施しております。

- Digilent社 [Zybo Z7-20](https://reference.digilentinc.com/reference/programmable-logic/zybo-z7/start) (試してないですが多分 Z7-10でも大丈夫と思います)
- Raspberry Pi Camera Module V2
- [Vivado 2019.2.1](https://japan.xilinx.com/support/download.html)
- [ikwzm氏](https://qiita.com/ikwzm) の [Debianブートイメージ](https://qiita.com/ikwzm/items/7e90f0ca2165dbb9a577)
- Debianイメージへの OpenCV など各種開発環境のインストール
- X-Window server となるPC (作者は Windows10 + [Xming](https://sourceforge.net/projects/xming/) で実施)

基本的な環境構築は[こちらのブログ](https://ryuz.qrunch.io/entries/jU8BkKu8bxqOeGAC)でも紹介しておりますので参考にしてください。

ソフトウェアは Debian イメージ上でセルフコンパイル可能ですので、ホストPC側は Vivado のみでも開発が可能です(Vitisなどもある方がよいですが)。


## 動かし方

### gitリポジトリ取得

```
git clone https://github.com/ryuz/jelly.git
```

で一式取得してください。

### Vivadoで bit ファイルを作る

projects/zybo_z7_imx219_hdmi/syn/vivado2019.2

に移動して Vivado から zybo_z7_imx219_hdmi.xpr を開いてください。

最初に BlockDesign を tcl から再構成する必要がります。

Vivado メニューの「Tools」→「Run Tcl Script」で、プロジェクトと同じディレクトリにある update_design.tcl を実行すると再構築を行うようにしています。

うまくいかない場合は、既に登録されている i_design_1 を手動で削除してから、design_1.tcl を実行しても同じことができるはずです。


design_1 が生成されたら「Flow」→「Run Implementation」で合成を行います。正常に合成できれば

zybo_z7_imx219_hdmi.runs/impl_1

に zybo_z7_imx219_hdmi.bit が出来上がります。

### Debian起動時のパラメータ設定(CMA領域増量)

今回の動作では、IMX219イメージセンサーからPL経由で画像を取り込みますが、その際に ikwzm氏の [udmabuf](https://qiita.com/ikwzm/items/cc1bb33ff43a491440ea) を用いて、CMA(DMA Contiguous Memory Allocator)領域から領域を割り当てます。
IMX219 は 3280x2464 という非常に大きな画像が取得できますので、領域を拡大する必要があります。

SDカードの起動パーティーション(Debianイメージからは /mnt/boot にマウントされているはず)の uEnv.txt の linux_boot_args に cma=128M を追加してください。

```
linux_boot_args=console=ttyPS0,115200 root=/dev/mmcblk0p2 rw rootwait uio_pdrv_genirq.of_id=generic-uio cma=128M
```

こんな感じになるはずです。


### ZYBO Z7 で実行

取付向きに注意して ZYBO-Z7 の MIPIコネクタ(J2) に、Camera Module V2 を接続します。フレキの接点が出ている側が基板の外側を向きます。
また HDMI TX 取付向きに注意して ZYBO-Z7 の MIPIコネクタ(J8) に、PCモニタなどを接続します(720pが表示出来れば大丈夫なはずです)。

次に projects/zybo_z7_imx219_hdmi/app の内容一式と先ほど合成した zybo_z7_imx219_hdmi.bit を、ZYBO の Debian で作業できる適当なディレクトリにコピーします。bitファイルも同じappディレクトリに入れてください。

ZYBO 側では Debian が起動済みで ssh などで接続ができている前提ですので scp や samba などでコピーすると良いでしょう。app に関しては ZYBO から git で clone することも可能です。

この時、

- OpenCV や bootgen など必要なツールがインストールできていること
- ssh ポートフォワーディングなどで、PCに X-Window が開く状態にしておくこと
- /dev/uio や /dev/i2c-0 などのデバイスのアクセス権が得られること
- sudo 権限のあるユーザーで実行すること

などの下準備がありますので、ブログなど参考に設定ください。

問題なければ、app をコピーしたディレクトリで

```
make all
```

と実行すれば zybo_z7_imx219_hdmi.out という実行ファイルが生成されます。

ここで

```
make run
```

とすると、Device Tree overlay によって、bit ファイルの書き込みなどを行った後にプログラムが起動し、ホストPCの方の X-Window に、カメラ画像が表示されるはずです。
画面で 'r' キーを押すことでメモリの許す範囲で最大100フレームまでの連続撮影を行えます(カレントディレクトリに連番静止画が出力されます)。

ない、Device Tree overlay のロード／アンロードは

```
make load
make unload
```

といったコマンドで実施可能です。

なお、デフォルトで 1280x720サイズでの撮影モードで起動しますが、

```
make load
./zybo_z7_imx219.out 1000fps
```

のようにすれば、640x132での 1000fps モードにも切り替わります(カメラが1000fpsで動くだけで、表示は間引かれて60fpsです)。

その他の細かいコマンドは main.cpp の中を確認ください。


## 参考情報

- 作者ブログ記事
    - [ZyboでDVI出力](http://ryuz.txt-nifty.com/blog/2015/02/zybodvi-19ac.html)
    - [続・ZyboでDVI出力](http://ryuz.txt-nifty.com/blog/2015/04/zybodvi-f103.html)
    - [続々・ZyboでDVI出力](http://ryuz.txt-nifty.com/blog/2015/04/zybodvi-d9d1.html)
    - [Zybo Z7 への Raspberry Pi Camera V2 接続(MIPI CSI-2受信)](http://ryuz.txt-nifty.com/blog/2018/04/zybo-z7-raspber.html)
    - [Zybo Z7 への Raspberry Pi Camera V2 接続 (1000fps動作)](http://ryuz.txt-nifty.com/blog/2018/05/zybo-z7-raspber.html)

- [Digital Visual InterfaceDVI](http://www.cs.unc.edu/Research/stc/FAQs/Video/dvi_spec-V1_0.pdf)

- [https://github.com/lvsoft/Sony-IMX219-Raspberry-Pi-V2-CMOS](https://github.com/lvsoft/Sony-IMX219-Raspberry-Pi-V2-CMOS)
    - Raspberry Pi Camera Module V2 の各種情報（IMX219のデータシートあり)
- [https://www.raspberrypi.org/forums/viewtopic.php?t=160611&start=25](https://www.raspberrypi.org/forums/viewtopic.php?t=160611&start=25)
    - 各種情報。[回路図](https://cdn.hackaday.io/images/5813621484631479007.jpg)の情報あり

