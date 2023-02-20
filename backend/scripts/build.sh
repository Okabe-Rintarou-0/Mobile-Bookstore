#rm -rf ../data/*

cd .. && docker build -t app_img .

cd ./build/mysql || exit
docker build -t mysql_img .


