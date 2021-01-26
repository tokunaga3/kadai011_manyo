*モデル名:task*  

|カラム名|データ型|
|:---|:---|
|id|--
|name|string|
|content|string|
|priority|integer|
|deadline|string|
|status|integer|
|label|string|
|user_id|--|

*モデル名:user*  

|カラム名|データ型
|:---|:---|
|id|--  
|name|string  
|email|string  
|password_digest|string


*デプロイの手順*  
1.アセットプリコンパイル  
>rails assets:precompile RAILS_ENV=production

2.コミットする  
>git add -A  
>git commit -m ""

3.herokuにアプケーションを作る。
>heroku create

4.Heroku buildpackを追加  
>heroku buildpacks:set heroku/ruby  
>heroku buildpacks:add --index 1 heroku/nodejs

5.herokuにデプロイする  
>git push heroku master

6.マイグレもしておく  
>heroku run rails db:migrate

7.アプリを確認  
>https://アプリ名.herokuapp.com/

アプリ名を確認する方法  
 >heroku config  
>>=== 「アプリ名」 Config Vars........
