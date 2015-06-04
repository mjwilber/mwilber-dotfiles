#!/bin/bash
sleep 20 && conky -c ~/.my_fave_conky/.conkyrc_clock;
sleep 1 && conky -c ~/.my_fave_conky/.conkyrc_sys;
sleep 1 && conky -c ~/.my_fave_conky/.conkyrc_cpu;
sleep 1 && conky -c ~/.my_fave_conky/.conkyrc_mem;
sleep 1 && conky -c ~/.my_fave_conky/.conkyrc_proc;
sleep 1 && conky -c ~/.my_fave_conky/.conkyrc_hd;
sleep 1 && conky -c ~/.my_fave_conky/.conkyrc_net;
