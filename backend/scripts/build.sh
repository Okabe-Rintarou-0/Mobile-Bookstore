go env -w GOOS=linux
go build -o ../build/app/app ../main.go

script_dir="$(pwd)"

rm -rf ../data/*

cd ../build/app || exit
docker build -t app_img .

cd "$script_dir" || exit

cd ../build/mysql || exit
docker build -t mysql_img .


