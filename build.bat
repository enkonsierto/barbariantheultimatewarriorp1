@echo off
cd /d %~dp0
..\skoolkit-9.6\sna2skool.py -c sources/barbariantheultimatewarriorp1.ctl barbariantheultimatewarriorp1.z80 > sources/barbariantheultimatewarriorp1.skool && make html HTML_OPTS="-T barbarian -T plum -T wide -toOa"
