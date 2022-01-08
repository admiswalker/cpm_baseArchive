# swap の追加

gcc 8.4.0 の build には，32 GB 強のメモリを要する．
システムの RAM が 40 GB 未満の場合は，swap を追加しておく．

## 手順
1. 現状の swap のサイズを確認する
   ```
   free -h
   ```
2. 現状の swap の場所を確認する
   ```
   cat /proc/swaps
   ```
3. ディスク容量を確認する
   ```
   df -h
   ```
4. swap の無効化．(`$ free -h` で swap の無効化を確認する)
   ```
   sudo swapoff -a
   ```
5. swap ファイルの作成
   ```
   sudo fallocate -l 32G /swapfile
   sudo chmod 600 /swapfile
   ```
   ```
   ls -al -h /swapfile
   ```
6. swapfile をシステムに紐づける
   ```
   sudo mkswap /swapfile
   ```
7. swap の有効化
   ```
   sudo swapon /swapfile
   ```

## 参考
[Ubuntu 20.04にスワップ領域を追加する方法](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04-ja)







