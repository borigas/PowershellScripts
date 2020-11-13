realpath $0
dirname $0

readoutput=$(readlink -f "$0")
echo $readoutput
dir=$(dirname $readoutput)
#dirPath=$(dirname "$readoutput")
#dirname "$(readlink -f "$0")"
#dirname "$(readlink -f "$0")"
echo "aoeu"
echo $dir

echo "$dir/z.sh"