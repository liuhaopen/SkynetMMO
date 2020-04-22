# SkynetMMO
 a skynet implementation of MMO, server side of [UnityMMO](https://github.com/liuhaopen/UnityMMO "UnityMMO") 

# Usage
1. git clone https://github.com/liuhaopen/SkynetMMO.git --recurse
2. compile skynet : 
    cd SkynetMMO/skynet
    make linux
3. import database, assume the password is 123456, if not, you need to change password in main.lua:
    mysql -uroot -p
    create database UnityMMOAccount;
    use UnityMMOAccount;
    source data/UnityMMOAccount.sql;
    create database UnityMMOGame;
    use UnityMMOGame;
    source data/UnityMMOGame.sql;
4. ./run.sh