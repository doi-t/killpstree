killpstree
==========

指定したプロセスIDのプロセスとその子孫全てを再帰的にkillするシェル関数とそれを試すためのサンプル

## 本体のシェル関数

```sh
killpstree(){
	local children=`ps --ppid $1 --no-heading | awk '{ print $1 }'`
	for child in $children
	do
		killpstree $child
	done
	kill $1
}
```

引数にプロセスIDを渡すと、再帰的に対象のプロセスツリーの葉から根に向かってkillをして回る.

## サンプル実行

例えば、kill対象のプロセスツリーを意図的に2つ生成してそれをkillする場合．

```sh
$ bash mkpstree.bash &
$ bash mkpstree.bash &
$ ps ax --forest
$ bash killpstree.bash "mkpstree.bash"
```

サンプルスクリプトkillpstree.bash自体は、"プロセス名"を指定して、ヒットしたプロセスのIDを再帰的にkillを行うkillpstreeに渡す.

**不用意にプロセス名を指定してしまうと、思わぬプロセスまでkillされるので注意**
