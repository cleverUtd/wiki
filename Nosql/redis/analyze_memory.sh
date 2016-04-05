#!/bin/bash
#set -x

## 结合redis-rdb-tools工具分析得出 redis中 每种类型的 key总数和大小
NOW="`date +%Y%m%d%H%M%S`"

##parse Redis dump.rdb files, analyze memory
function genReport(){
dir=""
if hash rdb; then
    echo "has rdb">/dev/null
else
    echo "it require rdbtools. plz install it first by command: [pip install rdbtools]"
    exit 1
fi

if [ "$1" != "" ]; then
    echo "begin to generate report..."
    dir="memory_${NOW}.csv"
    if [ "$2" != "" ]; then
        rdb -c memory --db $2 $1 > ${dir}
    else
        rdb -c memory $1 > ${dir}
    fi
    echo "generate memory report ${dir} done!"
else
    echo "please input rdb file path..."
    exit 1
fi
}

## summary count and size of every kind of key
function analyze(){
echo "analyzingi report..."
awk -F , 'BEGIN \
{ stringCount=0; stringSize=0; hashCount=0; hashSize=0; sortedsetCount=0; sortedsetSize=0; } \
{ if($2=="string") { stringCount++; stringSize=stringSize+$4; } 
  if($2=="hash"){ hashCount++; hashSize=hashSize+$4 } \ 
  if($2=="sortedset") { sortedsetCount++; sortedsetSize=sortedsetSize+$4 }} \
END{print "string", stringCount, stringSize, "\n" \
"hash", hashCount, hashSize, "\n" \
"sortedset", sortedsetCount, sortedsetSize}' memory_${NOW}.csv
echo "done!!!"
}


function main(){
genReport $1 $2
analyze
}

main $1 $2
