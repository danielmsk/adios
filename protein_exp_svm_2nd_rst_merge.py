#!/usr/bin/env python
# -*- coding: utf-8 -*-
#### protein_exp_svm_2nd_rst_merge.py
#### made by Daniel Minseok Kwon
#### 2021-01-06 02:40:38
#########################
import sys
import os

from ims import file_util
from ims import proc_util


def protein_exp_svm_2nd_rst_merge():
    cont = ""
    flag = True
    for rstfile in file_util.walk('./rst_svm_2nd', '.txt'):
        print(rstfile)
        for line in open(rstfile):
            if flag:
                if 'protein_name' in line:
                    cont = line
                    flag = False
            else:
                if line.strip() != "":
                    cont += line
    file_util.fileSave("protein_exp_svm_2nd_rst.txt", cont, 'w')


if __name__ == "__main__":
    protein_exp_svm_2nd_rst_merge()
