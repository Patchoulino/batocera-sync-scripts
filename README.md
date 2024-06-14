# sync-scripts
Scripts that can be run on the ports section to sync roms, saves and save states between devices

This has been tested only on batocera since the folder structure is great.
for other cfw you can probably modify the script to meet your needs.

# Log file
Once the script runs, it will generate a log file located in /tmp
```
[root@rg35xx-h /userdata/system]# ls -ltr /tmp/tmp*
-rw------- 1 root root 1375 Jun  9 19:07 /tmp/tmp.Nps1OHTJYH
-rw------- 1 root root 1139 Jun  9 19:14 /tmp/tmp.VS5PlxsQu5
-rw------- 1 root root 1146 Jun  9 19:20 /tmp/tmp.gAkgnUuDY0

[root@rg35xx-h /userdata/system]# cat /tmp/tmp.VS5PlxsQu5
[Sun Jun  9 07:14:31 PM CDT 2024] PUSH rg35xx-h.lan -> rg35xx-piojo.lan
sending incremental file list
bin/xsync-rg35.sh
          1,282 100%  568.36kB/s    0:00:00 (xfr#1, ir-chk=1205/1218)
saves/gba/Fire Emblem - The Binding Blade (T).srm
        131,072 100%  110.82kB/s    0:00:01 (xfr#2, to-chk=1027/19724)
saves/gba/Fire Emblem - The Binding Blade (T).state.auto
         87,607 100%    5.57MB/s    0:00:00 (xfr#3, to-chk=1025/19724)
saves/gba/Fire Emblem - The Binding Blade (T).state.auto.png
         39,087 100%    1.78MB/s    0:00:00 (xfr#4, to-chk=1024/19724)

sent 1,057,187 bytes  received 2,910 bytes  706,731.33 bytes/sec
total size is 50,839,405,554  speedup is 47,957.31
[Sun Jun  9 07:14:32 PM CDT 2024] PULL rg35xx-h.lan <- rg35xx-piojo.lan
receiving incremental file list

sent 707 bytes  received 929,338 bytes  372,018.00 bytes/sec
total size is 50,839,405,554  speedup is 54,663.38
```

# Examples
## Inside rg35xx
The script can also be called if you ssh into the device
```
[root@rg35xx-h /userdata/system]# /userdata/roms/ports/xsync-rg35.sh 
[Sun Jun  9 07:20:13 PM CDT 2024] PUSH rg35xx-h.lan -> rg35xx-piojo.lan
sending incremental file list
saves/nes/Dragon Warrior (USA) (Rev 1).srm
          8,192 100%    7.91kB/s    0:00:01 (xfr#2, to-chk=985/19724)
saves/nes/Dragon Warrior (USA) (Rev 1).state.auto
          2,203 100%    2.10MB/s    0:00:00 (xfr#3, to-chk=983/19724)
saves/nes/Dragon Warrior (USA) (Rev 1).state.auto.png
          2,823 100%    2.69MB/s    0:00:00 (xfr#4, to-chk=982/19724)

sent 936,647 bytes  received 2,360 bytes  626,004.67 bytes/sec
total size is 50,839,406,191  speedup is 54,141.67
[Sun Jun  9 07:20:15 PM CDT 2024] PULL rg35xx-h.lan <- rg35xx-piojo.lan
receiving incremental file list

sent 707 bytes  received 929,342 bytes  620,032.67 bytes/sec
total size is 50,839,406,191  speedup is 54,663.15
```


