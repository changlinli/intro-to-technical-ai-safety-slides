#!/usr/bin/env bash

pandoc -s --mathjax -i -t slidy slides.md -o slides.html
