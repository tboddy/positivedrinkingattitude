#!/bin/bash
for file in ./src/*.fnl; do
	name=${file##*/}
	base=${name%.fnl}
	fennel --compile "${file}" > out/"${base}.lua"
done

love out