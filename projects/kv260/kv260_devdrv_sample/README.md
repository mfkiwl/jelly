# Kria KV260 で 自作デバイスドライバを試すサンプル


## 概要

RTL は [kv260_udmabuf_sample](../kv260_udmabuf_sample) とほぼ同じもので、DAMだけ流用して u-dma-buf ではなく自分でデバイスドライバを書いてみる実験です。

実験にあたり[こちらの記事](https://qiita.com/iwatake2222/items/1fdd2e0faaaa868a2db2)を大いに参考人させて頂きました。
この場を借りて御礼申し上げます。


## 事前準備

### 環境

環境は下記の通りです。

```
Description:    Ubuntu 22.04.4 LTS
kernel:         5.15.0-1031-xilinx-zynqmp
```


### KV260側の準備

bootgen を使うのでインストールしておきます。

```
git clone https://github.com/Xilinx/bootgen  
cd bootgen/  
make  
sudo cp bootgen /usr/local/bin/
```

他にも make や dtc など使うので、不足があれば随時 sudu apt install してください。


### ソースコードの取得

```
git clone https://github.com/ryuz/jelly
```

で取得できます。

/projects/kv260/kv260_devdrv_sample/

以下が今回のプロジェクトです。


## PL用bitstreamの作成

PS用のbitstreamは PC(WindowsやLinuxなど)で Vivado を使って行います。

Vivado のプロジェクトは

/projects/kv260/kv260_devdrv_sample/syn/vivado2022.2/kv260_devdrv_sample.xpr

にありますので Vivado で開いてください。

最初に BlockDesign を tcl から再構成する必要がります。

Vivado メニューの「Tools」→「Run Tcl Script」で、プロジェクトと同じディレクトリにある update_design.tcl を実行すると再構築を行うようにしています。

うまくいかない場合は、既に登録されている i_design_1 を手動で削除してから、design_1.tcl を実行しても同じことができるはずです。

design_1 が生成されたら「Flow」→「Run Implementation」で合成を行います。正常に合成できれば
kv260_devdrv_sample.bit が出来上がります。

このファイルを projects/kv260/kv260_devdrv_sample/app にコピーしておいてください。


なお、本PLは用の bitstream は

- テスト用簡易DMA0  0x00_A000_0000 - 0x00_A000_07FF
- テスト用簡易DMA1  0x00_A000_0800 - 0x00_A000_0FFF
- LED制御レジスタ   0x00_A000_8000 - 0x00_A000_87FF

というメモリマップになるようにサンプル回路を作っております。


## PSソフト側の作成と実行

  KV260側でのPSソフトのビルドです。
  projects/kv260/kv260_devdrv_sample/app を KV260 のどこか適当な箇所にコピーします。
  KV260側の作業は Linux起動したあと、常に起動したまま行うことが可能で、運用したままPLとソフトをアップデートすることも可能なのがこのブートイメージの素晴らしいところです。

  KV260 の Linux側で git clone する手もあります。

  （余談ですが、作者はVS code Remote Development を使ってセルフコンパイル開発してそのままpushしています。）

### 動かしてみる

sudoできるユーザーで app ディレクトリに移動してください。

```
make run
```

とすればひとまず動くように作っております。
途中、sudo コマンドを使っているのでパスワードを聞かれると思いますが入力ください。
DeviceTree overlay や uio へのアクセスの為にルート権限が必要なためです。

実行後に

```
sudo dmesg
```

とすると、デバイスドライバの中で printk とした動作内容が確認できます。



# 詳細解説

## Device Tree overlay

  今回は Device Tree overlay によって

- PS部がPLに供給する fabric clock の設定
- PS部とPL部を繋ぐAXIバスのバス幅などの設定
- bitfile のダウンロード

のなどの機能を担っています。

kv260_devdrv_sample.dts が Device Tree overlay のソースファイルとなります。

順にみていきたいと思います。
なお、dtsファイルのコンパイルは、実行環境で行うことが必要なようです(内部で既存のDevice Treeのシンボルを参照する為)。

### bitstream 指定

``` 
    fragment@0 {
        target = <&fpga_full>;
        overlay0: __overlay__ {
            #address-cells = <2>;
            #size-cells = <2>;
            firmware-name = "kv260_devdrv_sample.bit.bin";
        };
    };
```

上のように指定します。この時、 kv260_devdrv_sample.bit.bin は bitstream から bootgen で生成されたファイルであり、/lib/firmware に置かれている必要があります。

bootgen の使い方としては、下記のような kv260_devdrv_sample.bif に対して

```kv260_devdrv_sample.bif
all:
{
    kv260_devdrv_sample.bit
}
```

bootgenを用いて

```
bootgen -image kv260_devdrv_sample.bif -arch zynqmp -process_bitstream bin
```

と実行することによって得られます。
上書きを許可する場合にはさらに -w を付けます。


### クロックと AXIのバス幅

```
    fragment@1 {
        target = <&amba>;
        overlay1: __overlay__ {
            afi0: afi0 {
                compatible = "xlnx,afi-fpga";
                config-afi    = <0  0>,     // S_AXI_HPC0_FPD(read)  : 0:128bit, 1:64bit, 2:32bit
                                <1  0>,     // S_AXI_HPC0_FPD(write) : 0:128bit, 1:64bit, 2:32bit
                                <2  0>,     // S_AXI_HPC1_FPD(read)  : 0:128bit, 1:64bit, 2:32bit
                                <3  0>,     // S_AXI_HPC1_FPD(write) : 0:128bit, 1:64bit, 2:32bit
                                <4  0>,     // S_AXI_HP0_FPD(read)   : 0:128bit, 1:64bit, 2:32bit
                                <5  0>,     // S_AXI_HP0_FPD(write)  : 0:128bit, 1:64bit, 2:32bit
                                <6  0>,     // S_AXI_HP1_FPD(read)   : 0:128bit, 1:64bit, 2:32bit
                                <7  0>,     // S_AXI_HP1_FPD(write)  : 0:128bit, 1:64bit, 2:32bit
                                <8  0>,     // S_AXI_HP2_FPD(read)   : 0:128bit, 1:64bit, 2:32bit
                                <9  0>,     // S_AXI_HP2_FPD(write)  : 0:128bit, 1:64bit, 2:32bit
                                <10 0>,     // S_AXI_HP3_FPD(read)   : 0:128bit, 1:64bit, 2:32bit
                                <11 0>,     // S_AXI_HP3_FPD(write)  : 0:128bit, 1:64bit, 2:32bit
                                <12 0>,     // S_AXI_LPD(read)       : 0:128bit, 1:64bit, 2:32bit
                                <13 0>,     // S_AXI_LPD(write)      : 0:128bit, 1:64bit, 2:32bit
                                <14 0x0500>,// M_AXI_HPM0_FPD[9:8], M_AXI_HPM0_FPD[11:10] : 0:32bit, 1:64bit, 2:128bit
                                <15 0x100>; // M_AXI_HPM0_LPD        : 0x000:32bit, 0x100:64bit, 0x200:128bit
            };
        
            fclk0  {
                compatible    = "ikwzm,fclkcfg-0.10.a";
                clocks        = <&zynqmp_clk 72 &zynqmp_clk 0>;
                insert-rate   = "100000000";
                insert-enable = <1>;
                remove-rate   = "1000000";
                remove-enable = <0>;
            };
        };
    };
```

の config-afi の部分が AXI バスのバス幅の設定です。
これは[こちらの記事](https://qiita.com/ikwzm/items/a1ad7e22ed7c44940d88)を参考にさせて頂きました。

また、clocking0 の部分がクロックで、pclk0 を 100MHz に設定しています。
これは[こちらの記事]([https://qiita.com/ikwzm/items/74f7c5b8474198c8af3e)を参考にさせて頂きました。


### dtcでのコンパイル

```
dtc -I dts -O dtb -o kv260_devdrv_sample.dtbo kv260_devdrv_sample.dts
```

とすることで kv260_devdrv_sample.dtbo を得ることができます。

## Overlay

いよいよ overlay です

### configfs の mount

初めに configfs をマウントします。

```
sudo mkdir -p /configfs
sudo mount -t configfs configfs /configfs
```

詳しくは[こちら](https://qiita.com/ikwzm/items/ec514e955c16076327ce)や[こちら](https://dora.bk.tsukuba.ac.jp/~takeuchi/?%E9%9B%BB%E6%B0%97%E5%9B%9E%E8%B7%AF%2Fzynq%2FDevice%20Tree%20Overlay)を参考にさせて頂いております。


### ファームウェアのコピー

必要なものを  /lib/firmware にコピーします。

```
sudo mkdir -p /lib/firmware
sudo cp kv260_devdrv_sample.bit.bin /lib/firmware
sudo cp kv260_devdrv_sample.dtbo /lib/firmware
```

### overlay 

次に overlay を行います。

```
sudo sh -c "echo 0 > /sys/class/fpga_manager/fpga0/flags"
sudo mkdir /configfs/device-tree/overlays/full
sudo sh -c "echo -n kv260_devdrv_sample.dtbo > /configfs/device-tree/overlays/full/path"
```

この段階で bitstream は書き込まれ、動作を開始しています。


### 状態確認

状態を確認するには

```
cat /configfs/device-tree/overlays/full/status
```

でできるようで applied と表示されればよいようです。

役目を終えたファイルは削除してよいようです。

```
sudo rm /lib/firmware/kv260_devdrv_sample.dtbo
sudo rm /lib/firmware/kv260_devdrv_sample.bit.bin
```


## Device Tree Overlay の解除

```
sudo rmdir /configfs/device-tree/overlays/full
```

と削除すると、解除できるようです。



### デバイスドライバのロード

今回自作したデバイスドライバは app/devdrv の下にあります。

こちらは現時点では DeviceTree に加えておらず、個別に insmod や rmmod することで、実験しています。
