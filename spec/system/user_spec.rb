require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context 'ユーザ登録のテスト' do

      before do
        FactoryBot.create(:user)
      end

      it 'ユーザの新規登録ができること' do
        expect(User.all).to include User.all[0]
      end

      it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
        visit root_path
        expect(page).to have_content('ログインが必要です')
      end

    end
    context 'セッション機能のテスト' do

      before do
        FactoryBot.create(:user)
        FactoryBot.create(:user,name: 'test2', email: 'test2@outlook.jp')
        visit '/sessions/new'
        fill_in 'Email', with: 'test1@outlook.jp'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end

      it 'ログインができること' do
        expect(page).to have_content('test1のページ')
      end

      it '自分の詳細画面(マイページ)に飛べること' do
        click_link '投稿一覧'
        click_link 'Profile'
        expect(page).to have_content('test1のページ')
      end

      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        visit "/users/#{User.last.id}"
        expect(page).to have_content('ログインユーザーが違うのでプロフィールはみれません')
      end

      it 'ログアウトができること' do
        click_on 'Logout'
        expect(page).to have_content('ログアウトしました')
      end
    end
    context '管理画面のテスト' do

      before do
        FactoryBot.create(:user)
        FactoryBot.create(:user,name: 'test2', email: 'test2@outlook.jp', admin: "false")
        visit '/sessions/new'
        fill_in 'Email', with: 'test1@outlook.jp'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end

      it '管理ユーザは管理画面にアクセスできること' do
        click_link 'ユーザー管理画面'
        expect(page).to have_content('管理者の一覧画面だよ')
      end

      it '一般ユーザは管理画面にアクセスできないこと' do
        visit '/sessions/new'
        fill_in 'Email', with: 'test2@outlook.jp'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        click_link 'ユーザー管理画面'
        expect(page).to have_content('管理者以外はアクセスできないよ')
      end

      it '管理ユーザはユーザの新規登録ができること' do
        click_link 'ユーザー管理画面'
        click_link '新しいユーザを追加'
        fill_in '名前', with: 'test3'
        fill_in 'メールアドレス', with: 'test3@outlook.jp'
        fill_in 'パスワード', with: '111111'
        fill_in '確認用パスワード', with: '111111'
        click_on 'Create my account'
        expect(page).to have_content('test3')
      end

      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        click_link 'ユーザー管理画面'
        find(:xpath, '/html[1]/body[1]/table[1]/tbody[1]/tr[2]/td[5]/a[1]').click
        expect(page).to have_content('test1')
      end

      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        click_link 'ユーザー管理画面'
        find(:xpath, '/html[1]/body[1]/table[1]/tbody[1]/tr[3]/td[6]/a[1]').click
        fill_in '名前', with: 'test4'
        fill_in 'メールアドレス', with: 'test3@outlook.jp'
        fill_in 'パスワード', with: '111111'
        fill_in '確認用パスワード', with: '111111'
        check 'user_admin'
        click_on 'Create my account'
        expect(page).to have_content('test4')
      end

      it '管理ユーザはユーザの削除をできること' do
        click_link 'ユーザー管理画面'
        click_link '新しいユーザを追加'
        fill_in '名前', with: 'test3'
        fill_in 'メールアドレス', with: 'test3@outlook.jp'
        fill_in 'パスワード', with: '111111'
        fill_in '確認用パスワード', with: '111111'
        check 'user_admin'
        click_on 'Create my account'
        click_link 'ユーザー管理画面'
        find("#id0").click
        expect(User.all.count) .to eq 2
      end

    end

  end
end
