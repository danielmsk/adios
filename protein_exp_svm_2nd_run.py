#!/usr/bin/env python
# -*- coding: utf-8 -*-
#### protein_exp_svm_2nd_run.py
#### made by Daniel Minseok Kwon
#### 2021-01-05 19:36:16
#########################
import sys
import os

from ims import file_util
from ims import proc_util


def protein_exp_svm_2nd_run():
    for k in range(5,1310):
        cmd = "Rscript protein_exp_svm_2nd.R " + str(k)
        print(cmd)


if __name__ == "__main__":
    protein_exp_svm_2nd_run()
