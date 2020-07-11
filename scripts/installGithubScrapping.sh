echo "making directory `pwd`/bin (making symbolic links to scripts and adding that directory to the path)"
echo "WARNING: You must run this as source if you want it to change the path, other wise you will have to add bin to the path separately"

if [ ! -d "scripts" ]; then
    echo "Needs to have a scripts subdirectory"
    exit 2
fi
rm -rf bin
mkdir bin
cd bin
bindir=`pwd`
find ../scripts -maxdepth 3 -type f  -name "*.sh" -exec ln -s {}  \;
sudo chmod u+x ../scripts
sudo chmod u+x .
export PATH="$bindir:$PATH"
