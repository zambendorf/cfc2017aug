#!/bin/sh

ADR=ec2-255-255-255-255.ap-northeast-1.compute.amazonaws.com
MKP=~/.ssh/knitta-key-pair-tokyo.pem

ssh -i $MKP ec2-user@$ADR
